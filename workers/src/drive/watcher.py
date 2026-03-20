"""Google Drive watcher — polls for new audio files in closer folders."""

from __future__ import annotations

import logging
import re
from dataclasses import dataclass
from datetime import date

from src.config import Config
from src.db import DB
from src.drive.client import DriveClient

logger = logging.getLogger(__name__)

# Pattern: YYYY-MM-DD_lead-name.ext
FILENAME_PATTERN = re.compile(r"^(\d{4}-\d{2}-\d{2})_(.+)\.\w+$")


@dataclass
class DriveFile:
    """Represents a new audio file discovered in Google Drive."""

    file_id: str
    name: str  # e.g. "2026-03-02_elane-lima.ogg"
    folder_id: str
    folder_name: str  # e.g. "evelyn" (closer name)
    mime_type: str


def parse_filename(name: str) -> tuple[str, str]:
    """Extract call_date and lead_name from a Drive filename.

    Expected format: YYYY-MM-DD_lead-name.ext
    Falls back to today's date and the full filename (without extension)
    if the pattern doesn't match.

    Args:
        name: The filename (e.g. "2026-03-02_elane-lima.ogg").

    Returns:
        Tuple of (call_date, lead_name).
    """
    match = FILENAME_PATTERN.match(name)
    if match:
        call_date = match.group(1)
        raw_lead = match.group(2)
        # "elane-lima" → "Elane Lima"
        lead_name = raw_lead.replace("-", " ").replace("_", " ").title()
        return call_date, lead_name

    # Fallback for malformed filenames
    stem = name.rsplit(".", 1)[0] if "." in name else name
    lead_name = stem.replace("-", " ").replace("_", " ").title()
    return date.today().isoformat(), lead_name


class DriveWatcher:
    """Watches Google Drive for new audio files and triggers sync."""

    def __init__(self, config: Config, db: DB, drive_client: DriveClient) -> None:
        self._config = config
        self._db = db
        self._drive = drive_client
        self._gravacoes_folder_id = config.google_drive_gravacoes_folder_id

    @property
    def enabled(self) -> bool:
        """Whether the watcher is properly configured."""
        return self._drive.enabled and bool(self._gravacoes_folder_id)

    def check_new_files(self) -> list[DriveFile]:
        """Scan all closer subfolders for new (unsynced) audio files.

        Returns:
            List of DriveFile objects that haven't been synced yet.
        """
        if not self.enabled:
            logger.debug("Drive watcher not configured, skipping.")
            return []

        new_files: list[DriveFile] = []

        # List closer subfolders (Gravações/evelyn/, Gravações/gustavo/, etc.)
        subfolders = self._drive.list_subfolders(self._gravacoes_folder_id)
        logger.info("Found %d closer folders in Gravações", len(subfolders))

        for folder in subfolders:
            folder_id = folder["id"]
            folder_name = folder["name"]

            audio_files = self._drive.list_audio_files(folder_id)
            for f in audio_files:
                drive_file_id = f["id"]

                # Anti-loop: skip files already in drive_sync
                if self._db.check_drive_sync_exists(drive_file_id):
                    continue

                new_files.append(DriveFile(
                    file_id=drive_file_id,
                    name=f["name"],
                    folder_id=folder_id,
                    folder_name=folder_name,
                    mime_type=f.get("mimeType", "audio/ogg"),
                ))

        if new_files:
            logger.info("Found %d new files to sync from Drive", len(new_files))

        return new_files
