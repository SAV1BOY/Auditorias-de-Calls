"""Supabase Storage operations for audio files."""

from __future__ import annotations

import logging

from supabase import Client

logger = logging.getLogger(__name__)

BUCKET = "audios"


def download_audio(client: Client, audio_path: str) -> bytes:
    """Download an audio file from Supabase Storage.

    Args:
        client: Supabase client instance.
        audio_path: Path within the audios bucket.

    Returns:
        Raw bytes of the audio file.
    """
    logger.info("Downloading audio from %s/%s", BUCKET, audio_path)
    response = client.storage.from_(BUCKET).download(audio_path)
    return response


def upload_audio(client: Client, audit_id: str, filename: str, data: bytes) -> str:
    """Upload an audio file to Supabase Storage.

    Args:
        client: Supabase client instance.
        audit_id: The audit ID (used as folder).
        filename: Original filename.
        data: Raw bytes of the audio.

    Returns:
        The storage path of the uploaded file.

    Raises:
        RuntimeError: If the upload fails.
    """
    path = f"{audit_id}/{filename}"
    logger.info("Uploading audio to %s/%s", BUCKET, path)
    try:
        client.storage.from_(BUCKET).upload(path, data)
    except Exception as exc:
        logger.error("Failed to upload %s/%s: %s", BUCKET, path, exc)
        raise RuntimeError(f"Storage upload failed for {path}") from exc
    return path
