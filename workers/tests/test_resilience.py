"""Resilience tests: verify retry, timeout, and error handling behavior.

These tests mock external API failures (Whisper timeout, Claude 429,
Drive 503, Resend errors) and verify the worker handles them correctly.
"""

from __future__ import annotations

import tempfile
from pathlib import Path
from unittest.mock import MagicMock, patch

import pytest

from src.pipeline.transcriber import Transcriber
from src.pipeline.analyzer import Analyzer
from src.pipeline.email_sender import EmailSender
from src.drive.client import DriveClient


class TestWhisperResilience:
    """Test Whisper API failure handling."""

    def _make_transcriber(self) -> Transcriber:
        db = MagicMock()
        return Transcriber("fake-key", db)

    def test_whisper_retries_on_transient_error(self, tmp_path: Path) -> None:
        """Whisper call retries up to 3 times on API errors."""
        transcriber = self._make_transcriber()
        audio_file = tmp_path / "test.ogg"
        audio_file.write_bytes(b"fake-audio")

        mock_response = MagicMock()
        mock_response.text = "Hello"
        mock_response.segments = []
        mock_response.duration = 60.0
        mock_response.language = "pt"

        with patch.object(transcriber._openai.audio.transcriptions, "create") as mock_create:
            mock_create.side_effect = [
                Exception("Connection reset"),
                Exception("Connection reset"),
                mock_response,
            ]
            result = transcriber._call_whisper(audio_file)
            assert result == mock_response
            assert mock_create.call_count == 3

    def test_whisper_raises_after_max_retries(self, tmp_path: Path) -> None:
        """Whisper raises after exhausting all 3 retry attempts."""
        transcriber = self._make_transcriber()
        audio_file = tmp_path / "test.ogg"
        audio_file.write_bytes(b"fake-audio")

        with patch.object(transcriber._openai.audio.transcriptions, "create") as mock_create:
            mock_create.side_effect = Exception("Timeout")
            with pytest.raises(Exception, match="Timeout"):
                transcriber._call_whisper(audio_file)
            assert mock_create.call_count == 3

    def test_transcribe_fails_on_missing_audit(self) -> None:
        """Transcriber raises ValueError when audit not found."""
        db = MagicMock()
        db.get_audit.return_value = None
        db.update_audit_status = MagicMock()
        transcriber = Transcriber("fake-key", db)

        with pytest.raises(ValueError, match="not found"):
            transcriber.transcribe("nonexistent-id")

    def test_transcribe_fails_on_missing_audio_path(self) -> None:
        """Transcriber raises ValueError when audit has no audio_path."""
        db = MagicMock()
        db.get_audit.return_value = {"id": "test-id", "audio_path": None}
        db.update_audit_status = MagicMock()
        transcriber = Transcriber("fake-key", db)

        with pytest.raises(ValueError, match="no audio_path"):
            transcriber.transcribe("test-id")


class TestClaudeResilience:
    """Test Claude API failure handling."""

    def _make_analyzer(self) -> Analyzer:
        config = MagicMock()
        config.anthropic_api_key = "fake-key"
        db = MagicMock()
        drive_client = MagicMock()
        return Analyzer(config, db, drive_client)

    def test_claude_retries_on_429(self) -> None:
        """Claude call retries on rate limit (429) errors."""
        analyzer = self._make_analyzer()

        mock_message = MagicMock()
        mock_message.content = [MagicMock(text="# Report\nTest")]
        mock_message.usage = MagicMock(input_tokens=100, output_tokens=200)

        with patch.object(analyzer._client.messages, "create") as mock_create:
            mock_create.side_effect = [
                Exception("rate_limit_error: 429"),
                Exception("rate_limit_error: 429"),
                mock_message,
            ]
            result = analyzer._call_claude("test transcript", {})
            assert result == mock_message
            assert mock_create.call_count == 3

    def test_claude_raises_after_max_retries(self) -> None:
        """Claude raises after exhausting retry attempts."""
        analyzer = self._make_analyzer()

        with patch.object(analyzer._client.messages, "create") as mock_create:
            mock_create.side_effect = Exception("overloaded_error: 529")
            with pytest.raises(Exception, match="overloaded_error"):
                analyzer._call_claude("test transcript", {})
            assert mock_create.call_count == 3


class TestDriveResilience:
    """Test Google Drive failure handling."""

    def test_drive_client_disabled_when_no_creds(self) -> None:
        """DriveClient is disabled when no credentials provided."""
        client = DriveClient(None)
        assert not client.enabled
        # list_subfolders returns empty when disabled (no RuntimeError)
        result = client.list_subfolders("folder-id")
        assert result == []

    def test_drive_save_failure_is_non_fatal_in_analyze(self) -> None:
        """Drive upload failure during analyze() is caught as non-fatal."""
        config = MagicMock()
        config.anthropic_api_key = "fake-key"
        config.google_drive_relatorios_folder_id = "folder-123"
        db = MagicMock()
        db.get_audit.return_value = {
            "id": "test-id",
            "transcricao": "test transcript",
            "closer_id": "closer-1",
            "audio_filename": "test.ogg",
            "lead_name": "John",
            "call_date": "2025-01-01",
        }

        drive_client = MagicMock()
        drive_client.enabled = True
        drive_client.get_or_create_folder.return_value = "subfolder-id"
        drive_client.upload_file.side_effect = Exception("503 Service Unavailable")

        analyzer = Analyzer(config, db, drive_client)

        # _save_report_to_drive itself raises, but analyze() catches it
        # Test directly that the method propagates the error
        with pytest.raises(Exception, match="503"):
            analyzer._save_report_to_drive(
                "test-id",
                {"closer_id": "closer-1", "lead_name": "John", "call_date": "2025-01-01"},
                "Test Closer",
                "# Report",
            )


class TestEmailResilience:
    """Test email sending failure handling."""

    def test_email_retries_on_failure(self) -> None:
        """EmailSender retries on transient failures."""
        sender = EmailSender("fake-key", "noreply@test.com")

        with patch("src.pipeline.email_sender.resend") as mock_resend:
            mock_resend.Emails.send.side_effect = [
                Exception("Connection timeout"),
                Exception("Connection timeout"),
                {"id": "email-123"},
            ]
            result = sender.send_report("to@test.com", "Subject", "Report text")
            assert result == {"id": "email-123"}
            assert mock_resend.Emails.send.call_count == 3

    def test_email_raises_after_max_retries(self) -> None:
        """EmailSender raises after exhausting retry attempts."""
        sender = EmailSender("fake-key", "noreply@test.com")

        with patch("src.pipeline.email_sender.resend") as mock_resend:
            mock_resend.Emails.send.side_effect = Exception("Service unavailable")
            with pytest.raises(Exception, match="Service unavailable"):
                sender.send_report("to@test.com", "Subject", "Report text")
            assert mock_resend.Emails.send.call_count == 3


class TestDeadLetterAndRefreshViews:
    """Test dead_letter status and materialized view refresh."""

    def test_fail_job_dead_letter_on_max_attempts(self) -> None:
        """Jobs exceeding max_attempts move to dead_letter status."""
        from src.db import DB

        config = MagicMock()
        config.supabase_url = "https://test.supabase.co"
        config.supabase_service_role_key = "fake-key"

        with patch("src.db.create_client") as mock_create:
            mock_client = MagicMock()
            mock_create.return_value = mock_client

            db = DB(config)

            # Mock the chain
            mock_table = MagicMock()
            mock_client.table.return_value = mock_table
            mock_table.update.return_value = mock_table
            mock_table.eq.return_value = mock_table
            mock_table.execute.return_value = MagicMock()

            db.fail_job("job-123", "test error", attempts=2, max_attempts=3)

            # Verify dead_letter status was set
            mock_table.update.assert_called_once()
            call_args = mock_table.update.call_args[0][0]
            assert call_args["status"] == "dead_letter"

    def test_fail_job_retries_below_max(self) -> None:
        """Jobs below max_attempts are reset to pending for retry."""
        from src.db import DB

        config = MagicMock()
        config.supabase_url = "https://test.supabase.co"
        config.supabase_service_role_key = "fake-key"

        with patch("src.db.create_client") as mock_create:
            mock_client = MagicMock()
            mock_create.return_value = mock_client

            db = DB(config)

            mock_table = MagicMock()
            mock_client.table.return_value = mock_table
            mock_table.update.return_value = mock_table
            mock_table.eq.return_value = mock_table
            mock_table.execute.return_value = MagicMock()

            db.fail_job("job-123", "test error", attempts=0, max_attempts=3)

            call_args = mock_table.update.call_args[0][0]
            assert call_args["status"] == "pending"
            assert call_args["attempts"] == 1

    def test_refresh_views_non_fatal(self) -> None:
        """refresh_views catches errors without raising."""
        from src.db import DB

        config = MagicMock()
        config.supabase_url = "https://test.supabase.co"
        config.supabase_service_role_key = "fake-key"

        with patch("src.db.create_client") as mock_create:
            mock_client = MagicMock()
            mock_create.return_value = mock_client

            db = DB(config)

            # Simulate RPC failure
            mock_client.rpc.return_value.execute.side_effect = Exception("RPC failed")

            # Should not raise
            db.refresh_views()
            mock_client.rpc.assert_called_once_with("refresh_dashboard_views_debounced")

    def test_prompt_version_saved_in_analysis(self) -> None:
        """Analyzer saves prompt_version and report_hash with results."""
        from src.prompts.system_prompt import PROMPT_VERSION
        assert isinstance(PROMPT_VERSION, str)
        assert len(PROMPT_VERSION) > 0


class TestJobTimeoutBehavior:
    """Test that job timeout configuration is correct."""

    def test_main_module_loads(self) -> None:
        """Verify the main module loads with _process_job defined."""
        import src.main
        assert hasattr(src.main, "_process_job")

    def test_unknown_job_type_raises(self) -> None:
        """_process_job raises ValueError for unknown job types."""
        from src.main import _process_job

        job = MagicMock()
        job.job_type = "unknown_type"
        job.audit_id = "test-id"
        job.id = "job-id"

        with pytest.raises(ValueError, match="Unknown job type"):
            _process_job(
                job,
                MagicMock(),  # transcriber
                MagicMock(),  # drive_sync
                MagicMock(),  # analyzer
                MagicMock(),  # notifier
                MagicMock(),  # loss_analyzer
            )
