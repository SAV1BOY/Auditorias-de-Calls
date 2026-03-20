"""Bidirectional sync between Google Drive and Supabase."""

from __future__ import annotations

import logging
import re
import uuid
from pathlib import Path

from src.config import Config
from src.db import DB
from src.drive.client import DriveClient
from src.drive.watcher import DriveFile, parse_filename
from src.storage import download_audio, upload_audio

logger = logging.getLogger(__name__)


class DriveSync:
    """Handles bidirectional sync between Drive and Supabase Storage."""

    def __init__(self, config: Config, db: DB, drive_client: DriveClient) -> None:
        self._config = config
        self._db = db
        self._drive = drive_client

    def sync_from_drive(self, file: DriveFile) -> str:
        """Sync a new file from Drive into Supabase (Flow B).

        Steps:
            1. Download bytes from Drive
            2. Find or skip closer by folder name
            3. Upload to Supabase Storage
            4. Create call_audits row
            5. Register in drive_sync (origin='drive')
            6. Create transcribe job

        Args:
            file: The DriveFile discovered by the watcher.

        Returns:
            The created audit_id.
        """
        logger.info("Syncing from Drive: %s (folder: %s)", file.name, file.folder_name)

        # 1. Download from Drive
        audio_bytes = self._drive.download_file(file.file_id)

        # 2. Find closer
        closer = self._db.find_closer_by_name(file.folder_name)
        closer_id = closer["id"] if closer else None
        if not closer:
            logger.warning("No closer found for folder '%s'", file.folder_name)

        # 3. Parse metadata from filename
        call_date, lead_name = parse_filename(file.name)

        # 4. Upload audio to Supabase first, then create audit with valid path
        #    This avoids orphaned audit rows if upload fails.
        temp_audit_id = str(uuid.uuid4())
        try:
            storage_path = upload_audio(self._db.client, temp_audit_id, file.name, audio_bytes)
        except Exception:
            logger.error("Failed to upload audio from Drive file %s to Supabase Storage", file.name)
            raise

        audit_id = self._db.create_audit_from_drive(
            closer_id=closer_id,
            lead_name=lead_name,
            call_date=call_date,
            audio_path=storage_path,
        )

        # 5. Register in drive_sync
        self._db.insert_drive_sync(
            drive_file_id=file.file_id,
            audit_id=audit_id,
            file_name=file.name,
            origin="drive",
            drive_folder_id=file.folder_id,
        )

        # 6. Create transcribe job
        self._db.create_job(audit_id, "transcribe")
        logger.info("Created audit %s and transcribe job from Drive file %s", audit_id, file.name)

        return audit_id

    def sync_to_drive(self, audit_id: str) -> str | None:
        """Copy audio from Supabase to the closer's Drive folder (Flow A).

        Called after transcription completes for frontend-uploaded files.

        Steps:
            1. Fetch audit data
            2. Download audio from Supabase Storage
            3. Build filename and find/create closer folder
            4. Upload to Drive
            5. Register in drive_sync (origin='frontend')
            6. Update audit with drive_file_id and drive_url

        Args:
            audit_id: The call_audit ID.

        Returns:
            The Drive file ID, or None if Drive is not configured.
        """
        if not self._drive.enabled or not self._config.google_drive_gravacoes_folder_id:
            logger.debug("Drive not configured, skipping sync_to_drive.")
            return None

        audit = self._db.get_audit(audit_id)
        if not audit:
            logger.error("Audit %s not found for Drive sync", audit_id)
            return None

        audio_path = audit.get("audio_path")
        if not audio_path:
            logger.error("Audit %s has no audio_path", audit_id)
            return None

        # Already synced?
        if audit.get("drive_file_id"):
            logger.debug("Audit %s already has drive_file_id, skipping.", audit_id)
            return audit["drive_file_id"]

        # 1. Download from Supabase
        audio_bytes = download_audio(self._db.client, audio_path)

        # 2. Build filename
        closer_name = "desconhecido"
        closers_data = audit.get("closers")
        if closers_data:
            if isinstance(closers_data, dict):
                closer_name = closers_data.get("name", closer_name)
            elif isinstance(closers_data, list) and closers_data:
                closer_name = closers_data[0].get("name", closer_name)

        lead_slug = re.sub(r"[^a-z0-9]+", "-", audit.get("lead_name", "unknown").lower()).strip("-")
        call_date = audit.get("call_date", "unknown")
        ext = Path(audio_path).suffix or ".ogg"
        filename = f"{call_date}_{lead_slug}{ext}"

        # 3. Get/create closer folder
        folder_name = closer_name.lower().replace(" ", "-")
        folder_id = self._drive.get_or_create_folder(
            self._config.google_drive_gravacoes_folder_id, folder_name
        )

        # 4. Upload to Drive
        mime_type = "audio/ogg"  # default
        ext_map = {".mp3": "audio/mpeg", ".mp4": "audio/mp4", ".webm": "audio/webm", ".wav": "audio/wav", ".m4a": "audio/x-m4a"}
        mime_type = ext_map.get(ext, mime_type)

        result = self._drive.upload_file(folder_id, filename, audio_bytes, mime_type)
        drive_file_id = result["id"]
        drive_url = result.get("webViewLink", "")

        # 5. Register in drive_sync
        self._db.insert_drive_sync(
            drive_file_id=drive_file_id,
            audit_id=audit_id,
            file_name=filename,
            origin="frontend",
            drive_folder_id=folder_id,
        )

        # 6. Update audit
        self._db.update_audit_status(audit_id, audit["status"], extra={
            "drive_file_id": drive_file_id,
            "drive_url": drive_url,
        })

        logger.info("Synced audit %s to Drive: %s", audit_id, drive_file_id)
        return drive_file_id
