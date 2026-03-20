"""Configuration management for CallAudit Worker."""

import os
import json
from dataclasses import dataclass, field
from pathlib import Path

from dotenv import load_dotenv


def _load_env() -> None:
    """Load environment variables from .env file if present."""
    env_path = Path(__file__).parent.parent / ".env"
    if env_path.exists():
        load_dotenv(env_path)


@dataclass(frozen=True)
class Config:
    """Typed configuration loaded from environment variables."""

    # Supabase
    supabase_url: str
    supabase_service_role_key: str = field(repr=False)

    # OpenAI (Whisper)
    openai_api_key: str = field(repr=False)

    # Google Drive
    google_service_account_info: dict = field(repr=False)
    google_drive_gravacoes_folder_id: str = ""
    google_drive_relatorios_folder_id: str = ""

    # Polling intervals
    job_poll_interval_seconds: int = 30
    drive_poll_interval_seconds: int = 120


def load_config() -> Config:
    """Load and validate configuration from environment.

    Raises:
        ValueError: If required environment variables are missing.
    """
    _load_env()

    missing: list[str] = []
    for var in ("SUPABASE_URL", "SUPABASE_SERVICE_ROLE_KEY", "OPENAI_API_KEY"):
        if not os.getenv(var):
            missing.append(var)

    if missing:
        raise ValueError(f"Missing required environment variables: {', '.join(missing)}")

    # Parse Google service account JSON
    sa_json = os.getenv("GOOGLE_SERVICE_ACCOUNT_JSON", "")
    sa_info: dict = {}
    if sa_json:
        sa_path = Path(sa_json)
        if sa_path.exists():
            sa_info = json.loads(sa_path.read_text())
        else:
            try:
                sa_info = json.loads(sa_json)
            except json.JSONDecodeError:
                sa_info = {}

    return Config(
        supabase_url=os.environ["SUPABASE_URL"],
        supabase_service_role_key=os.environ["SUPABASE_SERVICE_ROLE_KEY"],
        openai_api_key=os.environ["OPENAI_API_KEY"],
        google_service_account_info=sa_info,
        google_drive_gravacoes_folder_id=os.getenv("GOOGLE_DRIVE_GRAVACOES_FOLDER_ID", ""),
        google_drive_relatorios_folder_id=os.getenv("GOOGLE_DRIVE_RELATORIOS_FOLDER_ID", ""),
        job_poll_interval_seconds=int(os.getenv("JOB_POLL_INTERVAL_SECONDS", "30")),
        drive_poll_interval_seconds=int(os.getenv("DRIVE_POLL_INTERVAL_SECONDS", "120")),
    )
