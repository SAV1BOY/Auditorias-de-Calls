"""Tests for the Whisper API transcriber."""

from __future__ import annotations

from unittest.mock import MagicMock, patch, mock_open

import pytest

from src.db import DB
from src.pipeline.transcriber import Transcriber, TranscriptionResult, Segment


class TestTranscriberParseResponse:
    """Test _parse_response method."""

    def test_parse_returns_text(self, mock_db: DB, sample_whisper_response: MagicMock) -> None:
        transcriber = Transcriber("test-key", mock_db)
        result = transcriber._parse_response(sample_whisper_response)

        assert isinstance(result, TranscriptionResult)
        assert "Olá, tudo bem?" in result.text

    def test_parse_returns_segments_with_timestamps(self, mock_db: DB, sample_whisper_response: MagicMock) -> None:
        transcriber = Transcriber("test-key", mock_db)
        result = transcriber._parse_response(sample_whisper_response)

        assert len(result.segments) == 2
        assert result.segments[0].start == 0.0
        assert result.segments[0].end == 5.2
        assert "Olá" in result.segments[0].text
        assert result.segments[1].start == 5.2

    def test_parse_extracts_duration(self, mock_db: DB, sample_whisper_response: MagicMock) -> None:
        transcriber = Transcriber("test-key", mock_db)
        result = transcriber._parse_response(sample_whisper_response)

        assert result.duration_seconds == 1464.0

    def test_parse_detects_language(self, mock_db: DB, sample_whisper_response: MagicMock) -> None:
        transcriber = Transcriber("test-key", mock_db)
        result = transcriber._parse_response(sample_whisper_response)

        assert result.language == "pt"

    def test_parse_handles_empty_segments(self, mock_db: DB) -> None:
        response = MagicMock()
        response.text = "Some text"
        response.duration = 10.0
        response.language = "pt"
        response.segments = []

        transcriber = Transcriber("test-key", mock_db)
        result = transcriber._parse_response(response)

        assert result.text == "Some text"
        assert result.segments == []
        assert result.duration_seconds == 10.0


class TestTranscriberTranscribe:
    """Test the full transcribe flow."""

    @patch("src.pipeline.transcriber.download_audio")
    @patch("tempfile.NamedTemporaryFile")
    def test_transcribe_updates_status_flow(
        self,
        mock_tempfile: MagicMock,
        mock_download: MagicMock,
        mock_db: DB,
        sample_audit: dict,
        sample_whisper_response: MagicMock,
    ) -> None:
        """Verify status transitions: uploaded → transcribing → transcribed."""
        mock_download.return_value = b"fake-audio"

        # Mock temp file
        tmp = MagicMock()
        tmp.__enter__ = MagicMock(return_value=tmp)
        tmp.__exit__ = MagicMock(return_value=False)
        tmp.name = "/tmp/test.ogg"
        mock_tempfile.return_value = tmp

        # Mock DB methods
        mock_db.get_audit = MagicMock(return_value=sample_audit)
        mock_db.update_audit_status = MagicMock()
        mock_db.create_job = MagicMock(return_value="job-002")

        transcriber = Transcriber("test-key", mock_db)

        with patch.object(transcriber, "_call_whisper", return_value=sample_whisper_response):
            with patch("pathlib.Path.unlink"):
                result = transcriber.transcribe("audit-001")

        # Verify status flow
        status_calls = mock_db.update_audit_status.call_args_list
        assert status_calls[0][0] == ("audit-001", "transcribing")
        assert status_calls[1][0][0] == "audit-001"
        assert status_calls[1][0][1] == "transcribed"

    @patch("src.pipeline.transcriber.download_audio")
    @patch("tempfile.NamedTemporaryFile")
    def test_transcribe_creates_analyze_job(
        self,
        mock_tempfile: MagicMock,
        mock_download: MagicMock,
        mock_db: DB,
        sample_audit: dict,
        sample_whisper_response: MagicMock,
    ) -> None:
        mock_download.return_value = b"fake-audio"

        tmp = MagicMock()
        tmp.__enter__ = MagicMock(return_value=tmp)
        tmp.__exit__ = MagicMock(return_value=False)
        tmp.name = "/tmp/test.ogg"
        mock_tempfile.return_value = tmp

        mock_db.get_audit = MagicMock(return_value=sample_audit)
        mock_db.update_audit_status = MagicMock()
        mock_db.create_job = MagicMock(return_value="job-002")

        transcriber = Transcriber("test-key", mock_db)

        with patch.object(transcriber, "_call_whisper", return_value=sample_whisper_response):
            with patch("pathlib.Path.unlink"):
                transcriber.transcribe("audit-001")

        mock_db.create_job.assert_called_once_with("audit-001", "analyze")

    def test_transcribe_raises_on_missing_audit(self, mock_db: DB) -> None:
        mock_db.get_audit = MagicMock(return_value=None)
        mock_db.update_audit_status = MagicMock()

        transcriber = Transcriber("test-key", mock_db)

        with pytest.raises(ValueError, match="not found"):
            transcriber.transcribe("nonexistent-audit")

    def test_transcribe_raises_on_missing_audio_path(self, mock_db: DB) -> None:
        mock_db.get_audit = MagicMock(return_value={"id": "audit-001", "audio_path": None})
        mock_db.update_audit_status = MagicMock()

        transcriber = Transcriber("test-key", mock_db)

        with pytest.raises(ValueError, match="no audio_path"):
            transcriber.transcribe("audit-001")
