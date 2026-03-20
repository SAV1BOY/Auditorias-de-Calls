"""Whisper API transcription pipeline step."""

from __future__ import annotations

import logging
import tempfile
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

from openai import OpenAI
from tenacity import retry, stop_after_attempt, wait_exponential

from src.db import DB
from src.storage import download_audio

logger = logging.getLogger(__name__)


@dataclass
class Segment:
    """A timestamped segment of a transcription."""

    start: float
    end: float
    text: str


@dataclass
class TranscriptionResult:
    """Result from the Whisper API transcription."""

    text: str
    segments: list[Segment]
    duration_seconds: float
    language: str


class Transcriber:
    """Handles audio transcription via OpenAI Whisper API."""

    def __init__(self, openai_api_key: str, db: DB) -> None:
        self._openai = OpenAI(api_key=openai_api_key)
        self._db = db

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=2, min=2, max=30),
        reraise=True,
    )
    def _call_whisper(self, audio_path: Path) -> dict:
        """Call Whisper API with retry logic.

        Args:
            audio_path: Path to the temporary audio file.

        Returns:
            Raw response dict from the API.
        """
        with open(audio_path, "rb") as f:
            response = self._openai.audio.transcriptions.create(
                model="whisper-1",
                file=f,
                response_format="verbose_json",
                language="pt",
            )
        return response

    def _parse_response(self, response: dict) -> TranscriptionResult:
        """Parse the Whisper API verbose_json response into our dataclass."""
        segments: list[Segment] = []
        raw_segments = getattr(response, "segments", []) or []
        for seg in raw_segments:
            segments.append(Segment(
                start=seg.get("start", 0.0) if isinstance(seg, dict) else getattr(seg, "start", 0.0),
                end=seg.get("end", 0.0) if isinstance(seg, dict) else getattr(seg, "end", 0.0),
                text=(seg.get("text", "") if isinstance(seg, dict) else getattr(seg, "text", "")).strip(),
            ))

        text = getattr(response, "text", "") or ""
        duration = getattr(response, "duration", 0.0) or 0.0
        language = getattr(response, "language", "pt") or "pt"

        return TranscriptionResult(
            text=text,
            segments=segments,
            duration_seconds=float(duration),
            language=language,
        )

    def transcribe(self, audit_id: str) -> TranscriptionResult:
        """Run the full transcription pipeline for an audit.

        Steps:
            1. Update status to 'transcribing'
            2. Download audio from Supabase Storage
            3. Send to Whisper API
            4. Parse response
            5. Update audit with transcription data
            6. Create 'analyze' job for Sprint 3
            7. Return result

        Args:
            audit_id: The call_audit ID to transcribe.

        Returns:
            The transcription result.
        """
        logger.info("Starting transcription for audit %s", audit_id)

        # 1. Update status
        self._db.update_audit_status(audit_id, "transcribing")

        # 2. Fetch audit and download audio
        audit = self._db.get_audit(audit_id)
        if not audit:
            raise ValueError(f"Audit {audit_id} not found")

        audio_path = audit.get("audio_path")
        if not audio_path:
            raise ValueError(f"Audit {audit_id} has no audio_path")

        audio_bytes = download_audio(self._db.client, audio_path)

        # 3. Write to temp file and call Whisper
        suffix = Path(audio_path).suffix or ".ogg"
        with tempfile.NamedTemporaryFile(suffix=suffix, delete=False) as tmp:
            tmp.write(audio_bytes)
            tmp_path = Path(tmp.name)

        try:
            response = self._call_whisper(tmp_path)
        finally:
            tmp_path.unlink(missing_ok=True)

        # 4. Parse
        result = self._parse_response(response)
        logger.info(
            "Transcription complete: %d chars, %.1fs, %d segments",
            len(result.text),
            result.duration_seconds,
            len(result.segments),
        )

        # 5. Update audit
        now = datetime.now(timezone.utc).isoformat()
        duration_minutes = round(result.duration_seconds / 60, 2) if result.duration_seconds else None

        self._db.update_audit_status(audit_id, "transcribed", extra={
            "transcricao": result.text,
            "audio_duration_seconds": result.duration_seconds,
            "duration_minutes": duration_minutes,
            "modelo_transcricao": "whisper-1",
            "transcribed_at": now,
        })

        # 6. Create analyze job (will be processed in Sprint 3)
        self._db.create_job(audit_id, "analyze")
        logger.info("Created 'analyze' job for audit %s", audit_id)

        return result
