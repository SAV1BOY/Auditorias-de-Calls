"""Shared test fixtures for the CallAudit Worker."""

from __future__ import annotations

from pathlib import Path
from typing import Any
from unittest.mock import MagicMock, patch

import pytest

from src.config import Config
from src.db import DB, Job


@pytest.fixture
def config() -> Config:
    """Create a test configuration with dummy values."""
    return Config(
        supabase_url="https://test.supabase.co",
        supabase_service_role_key="test-service-role-key",
        openai_api_key="test-openai-key",
        anthropic_api_key="test-anthropic-key",
        google_service_account_info={},
        google_drive_gravacoes_folder_id="test-gravacoes-folder-id",
        google_drive_relatorios_folder_id="test-relatorios-folder-id",
        job_poll_interval_seconds=1,
        drive_poll_interval_seconds=1,
    )


@pytest.fixture
def mock_supabase_client() -> MagicMock:
    """Create a mock Supabase client."""
    client = MagicMock()

    # Setup chaining for table operations
    def _make_table_chain() -> MagicMock:
        chain = MagicMock()
        chain.select.return_value = chain
        chain.insert.return_value = chain
        chain.update.return_value = chain
        chain.delete.return_value = chain
        chain.eq.return_value = chain
        chain.ilike.return_value = chain
        chain.order.return_value = chain
        chain.limit.return_value = chain
        chain.execute.return_value = MagicMock(data=[])
        return chain

    client.table.return_value = _make_table_chain()

    # Storage mock
    storage_bucket = MagicMock()
    storage_bucket.download.return_value = b"fake-audio-bytes"
    storage_bucket.upload.return_value = None
    client.storage.from_.return_value = storage_bucket

    return client


@pytest.fixture
def mock_db(mock_supabase_client: MagicMock) -> DB:
    """Create a DB instance with a mocked Supabase client."""
    with patch("src.db.create_client", return_value=mock_supabase_client):
        db = DB(Config(
            supabase_url="https://test.supabase.co",
            supabase_service_role_key="test-key",
            openai_api_key="test-key",
            anthropic_api_key="test-key",
            google_service_account_info={},
        ))
    db._client = mock_supabase_client
    return db


@pytest.fixture
def sample_job() -> Job:
    """Create a sample job for testing."""
    return Job(
        id="job-001",
        audit_id="audit-001",
        job_type="transcribe",
        status="processing",
        attempts=0,
        max_attempts=3,
        error_message=None,
        started_at="2026-03-20T12:00:00Z",
        completed_at=None,
        created_at="2026-03-20T11:59:00Z",
    )


@pytest.fixture
def sample_audit() -> dict[str, Any]:
    """Create a sample audit record."""
    return {
        "id": "audit-001",
        "closer_id": "closer-001",
        "lead_name": "Elane Lima",
        "call_date": "2026-03-02",
        "status": "uploaded",
        "audio_path": "audit-001/call.ogg",
        "closers": {"name": "Evelyn"},
    }


@pytest.fixture
def sample_whisper_response() -> MagicMock:
    """Create a mock Whisper API verbose_json response."""
    response = MagicMock()
    response.text = "Olá, tudo bem? Meu nome é Evelyn e estou ligando para falar sobre..."
    response.duration = 1464.0  # ~24 minutes
    response.language = "pt"

    seg1 = MagicMock()
    seg1.start = 0.0
    seg1.end = 5.2
    seg1.text = " Olá, tudo bem?"

    seg2 = MagicMock()
    seg2.start = 5.2
    seg2.end = 12.8
    seg2.text = " Meu nome é Evelyn e estou ligando para falar sobre..."

    response.segments = [seg1, seg2]
    return response


@pytest.fixture
def sample_transcribed_audit(sample_audit: dict[str, Any]) -> dict[str, Any]:
    """Create a sample audit that has been transcribed (ready for analysis)."""
    return {
        **sample_audit,
        "status": "transcribed",
        "transcricao": (
            "Olá, tudo bem? Meu nome é Evelyn e estou ligando para falar sobre "
            "a assessoria para a sua clínica. Eu estava dando uma olhada no seu "
            "Instagram e vi que você é muito bem posicionada na área de cirurgia..."
        ),
        "duration_minutes": 164.0,
        "audio_duration_seconds": 9840.0,
    }


@pytest.fixture
def sample_analysis_report() -> str:
    """Load sample analysis markdown report from fixtures."""
    fixture_path = Path(__file__).parent / "fixtures" / "sample_analysis_report.md"
    return fixture_path.read_text()


@pytest.fixture
def mock_claude_response(sample_analysis_report: str) -> MagicMock:
    """Create a mock Anthropic Claude API response."""
    response = MagicMock()
    content_block = MagicMock()
    content_block.text = sample_analysis_report
    response.content = [content_block]
    response.usage = MagicMock()
    response.usage.input_tokens = 15000
    response.usage.output_tokens = 8000
    return response
