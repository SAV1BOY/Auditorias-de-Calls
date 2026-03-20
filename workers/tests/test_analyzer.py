"""Tests for the analyzer module (Claude API integration)."""

from __future__ import annotations

from typing import Any
from unittest.mock import MagicMock, patch, PropertyMock

import pytest

from src.config import Config
from src.db import DB
from src.pipeline.analyzer import Analyzer, MODEL
from src.pipeline.models import AnalysisResult
from src.pipeline.analyzer import COST_INPUT_PER_MTOK, COST_OUTPUT_PER_MTOK
from src.pipeline.parser import DIMENSION_WEIGHTS, calculate_weighted_score


@pytest.fixture
def mock_anthropic_client(mock_claude_response: MagicMock) -> MagicMock:
    """Create a mock Anthropic client."""
    client = MagicMock()
    client.messages.create.return_value = mock_claude_response
    return client


@pytest.fixture
def analyzer(
    config: Config,
    mock_db: DB,
    mock_anthropic_client: MagicMock,
) -> Analyzer:
    """Create an Analyzer with mocked dependencies."""
    drive_client = MagicMock()
    drive_client.enabled = False

    with patch("src.pipeline.analyzer.anthropic.Anthropic", return_value=mock_anthropic_client):
        a = Analyzer(config, mock_db, drive_client)

    a._client = mock_anthropic_client
    return a


class TestAnalyzerCallClaude:
    """Tests for Claude API call behavior."""

    def test_analyze_includes_system_prompt(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Verify system prompt is passed to the API call."""
        # Setup DB to return the audit
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        analyzer.analyze("audit-001")

        call_kwargs = mock_anthropic_client.messages.create.call_args
        assert "ANALISTA DE CALLS" in call_kwargs.kwargs.get("system", "")

    def test_analyze_sends_metadata_in_prompt(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Verify closer name, lead name included in user message."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        analyzer.analyze("audit-001")

        call_kwargs = mock_anthropic_client.messages.create.call_args
        messages = call_kwargs.kwargs.get("messages", [])
        user_content = messages[0]["content"] if messages else ""
        assert "Evelyn" in user_content
        assert "Elane" in user_content

    def test_analyze_handles_long_transcription(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Long transcriptions (>100k chars) are sent without truncation."""
        long_transcription = "A" * 150_000
        sample_transcribed_audit["transcricao"] = long_transcription

        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        analyzer.analyze("audit-001")

        call_kwargs = mock_anthropic_client.messages.create.call_args
        messages = call_kwargs.kwargs.get("messages", [])
        user_content = messages[0]["content"] if messages else ""
        assert long_transcription in user_content

    def test_analyze_handles_api_error(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """APIError from Anthropic is re-raised after retries."""
        import anthropic

        mock_anthropic_client.messages.create.side_effect = anthropic.APIError(
            message="Internal Server Error",
            request=MagicMock(),
            body=None,
        )

        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        with pytest.raises(anthropic.APIError):
            analyzer.analyze("audit-001")


class TestAnalyzerResults:
    """Tests for analysis result extraction."""

    def test_analyze_returns_complete_report(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """raw_text is not empty and contains report content."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        assert isinstance(result, AnalysisResult)
        assert len(result.raw_text) > 1000

    def test_analyze_extracts_score_final(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Score is between 0 and 10."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        assert 0 <= result.score_final <= 10

    def test_analyze_extracts_classificacao(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Classification is one of the 4 valid values."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        assert result.classificacao in ("ELITE", "FORTE", "MEDIANA", "FRACA")

    def test_analyze_extracts_13_dimensions(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """All 13 dimensions are extracted."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        assert len(result.dimensions) == 13

    def test_analyze_score_matches_weighted_average(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Parsed score matches calculated weighted average within 0.5 tolerance."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        if result.dimensions:
            calculated = calculate_weighted_score(result.dimensions)
            assert abs(result.score_final - calculated) <= 0.5


class TestAnalyzerStatusFlow:
    """Tests for status update flow during analysis."""

    def test_analyze_updates_status_to_analyzing(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """First status update is 'analyzing'."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        analyzer.analyze("audit-001")

        # Check the first update call was 'analyzing'
        update_calls = analyzer._db._client.table.return_value.update.call_args_list
        first_update = update_calls[0][0][0] if update_calls else {}
        assert first_update.get("status") == "analyzing"

    def test_analyze_creates_notify_job(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """A 'notify' job is created after analysis."""
        # Use side_effect on get_audit to return the transcribed audit directly
        analyzer._db.get_audit = MagicMock(return_value=sample_transcribed_audit)
        analyzer._db.update_audit_status = MagicMock()
        analyzer._db.create_job = MagicMock(return_value="job-002")

        analyzer.analyze("audit-001")

        # Verify create_job was called with 'notify'
        analyzer._db.create_job.assert_called_once_with("audit-001", "notify")

    def test_analyze_raises_on_missing_audit(
        self,
        analyzer: Analyzer,
    ) -> None:
        """Raises ValueError when audit not found."""
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[])

        with pytest.raises(ValueError, match="not found"):
            analyzer.analyze("nonexistent-id")

    def test_analyze_raises_on_missing_transcription(
        self,
        analyzer: Analyzer,
        sample_audit: dict[str, Any],
    ) -> None:
        """Raises ValueError when audit has no transcription."""
        # sample_audit doesn't have transcricao field
        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_audit])

        with pytest.raises(ValueError, match="no transcription"):
            analyzer.analyze("audit-001")


class TestAnalyzerDriveReport:
    """Tests for Drive report save behavior."""

    def test_save_report_creates_md_in_drive(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Report is uploaded to Drive in Relatórios/{closer}/ folder."""
        analyzer._db.get_audit = MagicMock(return_value=sample_transcribed_audit)
        analyzer._db.update_audit_status = MagicMock()
        analyzer._db.create_job = MagicMock(return_value="job-002")

        # Enable Drive
        analyzer._drive.enabled = True
        analyzer._drive.get_or_create_folder = MagicMock(return_value="folder-relatorios")
        analyzer._drive.upload_file = MagicMock(return_value={
            "id": "drive-report-001",
            "webViewLink": "https://drive.google.com/file/d/drive-report-001",
        })

        analyzer.analyze("audit-001")

        # Verify Drive upload was called
        analyzer._drive.upload_file.assert_called_once()
        call_args = analyzer._drive.upload_file.call_args
        assert call_args[0][0] == "folder-relatorios"  # folder_id
        assert call_args[0][1].startswith("auditoria_")  # filename
        assert call_args[0][1].endswith(".md")  # markdown extension
        assert call_args[0][3] == "text/markdown"  # mime_type

    def test_drive_failure_is_non_fatal(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Drive upload failure does not prevent analysis from completing."""
        analyzer._db.get_audit = MagicMock(return_value=sample_transcribed_audit)
        analyzer._db.update_audit_status = MagicMock()
        analyzer._db.create_job = MagicMock(return_value="job-002")

        analyzer._drive.enabled = True
        analyzer._drive.get_or_create_folder = MagicMock(
            side_effect=Exception("Drive unavailable")
        )

        # Should not raise — Drive failure is non-fatal
        result = analyzer.analyze("audit-001")
        assert result.score_final >= 0  # Analysis succeeded


class TestAnalyzerCost:
    """Tests for cost calculation."""

    def test_cost_calculation(
        self,
        analyzer: Analyzer,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """Verify cost is calculated correctly from token counts."""
        analyzer._db.get_audit = MagicMock(return_value=sample_transcribed_audit)
        analyzer._db.update_audit_status = MagicMock()
        analyzer._db.create_job = MagicMock(return_value="job-002")

        analyzer.analyze("audit-001")

        # Find the 'analyzed' status update call with cost
        update_calls = analyzer._db.update_audit_status.call_args_list
        analyzed_call = [c for c in update_calls if c[0][1] == "analyzed"]
        assert len(analyzed_call) >= 1

        extra = analyzed_call[0].kwargs.get("extra") or analyzed_call[0][0][2] if len(analyzed_call[0][0]) > 2 else analyzed_call[0].kwargs.get("extra", {})
        expected_cost = round(
            (15000 * COST_INPUT_PER_MTOK + 8000 * COST_OUTPUT_PER_MTOK) / 1_000_000,
            4,
        )
        assert extra["custo_estimado"] == expected_cost


class TestAnalyzerRetry:
    """Tests for retry mechanism."""

    def test_retries_on_transient_api_error(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        mock_claude_response: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """API call retries on transient errors and succeeds."""
        import anthropic

        # First two calls fail, third succeeds
        mock_anthropic_client.messages.create.side_effect = [
            anthropic.APIError(message="Server Error", request=MagicMock(), body=None),
            anthropic.APIError(message="Server Error", request=MagicMock(), body=None),
            mock_claude_response,
        ]

        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        result = analyzer.analyze("audit-001")
        assert result.score_final >= 0
        assert mock_anthropic_client.messages.create.call_count == 3

    def test_empty_content_raises_runtime_error(
        self,
        analyzer: Analyzer,
        mock_anthropic_client: MagicMock,
        sample_transcribed_audit: dict[str, Any],
    ) -> None:
        """RuntimeError raised when Claude returns empty content."""
        empty_response = MagicMock()
        empty_response.content = []  # Empty content
        mock_anthropic_client.messages.create.return_value = empty_response

        analyzer._db._client.table.return_value.select.return_value \
            .eq.return_value.limit.return_value.execute.return_value = \
            MagicMock(data=[sample_transcribed_audit])

        with pytest.raises(RuntimeError, match="empty content"):
            analyzer.analyze("audit-001")
