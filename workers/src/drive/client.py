"""Google Drive API client wrapper."""

from __future__ import annotations

import io
import logging
from typing import Any

from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build, Resource
from googleapiclient.http import MediaIoBaseDownload, MediaIoBaseUpload

logger = logging.getLogger(__name__)

SCOPES = ["https://www.googleapis.com/auth/drive"]
AUDIO_MIME_TYPES = [
    "audio/ogg",
    "audio/mpeg",
    "audio/mp4",
    "audio/webm",
    "audio/wav",
    "audio/x-m4a",
]


class DriveClient:
    """Wrapper around the Google Drive v3 API."""

    def __init__(self, service_account_info: dict[str, Any]) -> None:
        """Initialize with service account credentials.

        Args:
            service_account_info: Parsed JSON of the service account key file.
        """
        if not service_account_info:
            logger.warning("No Google service account info provided; Drive operations will fail.")
            self._service: Resource | None = None
            return

        creds = Credentials.from_service_account_info(
            service_account_info, scopes=SCOPES
        )
        self._service = build("drive", "v3", credentials=creds)

    @property
    def enabled(self) -> bool:
        """Whether the Drive client is properly configured."""
        return self._service is not None

    def list_subfolders(self, parent_id: str) -> list[dict[str, str]]:
        """List immediate child folders of a parent folder.

        Returns:
            List of dicts with 'id' and 'name' keys.
        """
        if not self._service:
            return []

        query = (
            f"'{parent_id}' in parents "
            "and mimeType = 'application/vnd.google-apps.folder' "
            "and trashed = false"
        )
        results = (
            self._service.files()
            .list(q=query, fields="files(id, name)", pageSize=100)
            .execute()
        )
        return results.get("files", [])

    def list_audio_files(self, folder_id: str) -> list[dict[str, Any]]:
        """List audio files in a folder.

        Returns:
            List of dicts with 'id', 'name', 'mimeType', 'createdTime'.
        """
        if not self._service:
            return []

        mime_conditions = " or ".join(
            f"mimeType = '{mt}'" for mt in AUDIO_MIME_TYPES
        )
        query = (
            f"'{folder_id}' in parents "
            f"and ({mime_conditions}) "
            "and trashed = false"
        )
        results = (
            self._service.files()
            .list(
                q=query,
                fields="files(id, name, mimeType, createdTime)",
                pageSize=100,
            )
            .execute()
        )
        return results.get("files", [])

    def download_file(self, file_id: str) -> bytes:
        """Download a file's content by its ID.

        Returns:
            Raw bytes of the file.
        """
        if not self._service:
            raise RuntimeError("Drive client is not configured.")

        request = self._service.files().get_media(fileId=file_id)
        buffer = io.BytesIO()
        downloader = MediaIoBaseDownload(buffer, request)

        done = False
        while not done:
            _, done = downloader.next_chunk()

        return buffer.getvalue()

    def upload_file(
        self,
        folder_id: str,
        name: str,
        data: bytes,
        mime_type: str = "audio/ogg",
    ) -> dict[str, str]:
        """Upload a file to a specific Drive folder.

        Returns:
            Dict with 'id' and 'webViewLink'.
        """
        if not self._service:
            raise RuntimeError("Drive client is not configured.")

        file_metadata = {
            "name": name,
            "parents": [folder_id],
        }
        media = MediaIoBaseUpload(io.BytesIO(data), mimetype=mime_type)
        result = (
            self._service.files()
            .create(
                body=file_metadata,
                media_body=media,
                fields="id, webViewLink",
            )
            .execute()
        )
        logger.info("Uploaded %s to Drive folder %s → %s", name, folder_id, result.get("id"))
        return {"id": result["id"], "webViewLink": result.get("webViewLink", "")}

    def get_or_create_folder(self, parent_id: str, folder_name: str) -> str:
        """Find a subfolder by name, or create it if it doesn't exist.

        Returns:
            The folder ID.
        """
        if not self._service:
            raise RuntimeError("Drive client is not configured.")

        # Check if folder exists
        query = (
            f"'{parent_id}' in parents "
            f"and name = '{folder_name}' "
            "and mimeType = 'application/vnd.google-apps.folder' "
            "and trashed = false"
        )
        results = (
            self._service.files()
            .list(q=query, fields="files(id)", pageSize=1)
            .execute()
        )
        files = results.get("files", [])
        if files:
            return files[0]["id"]

        # Create folder
        metadata = {
            "name": folder_name,
            "mimeType": "application/vnd.google-apps.folder",
            "parents": [parent_id],
        }
        folder = self._service.files().create(body=metadata, fields="id").execute()
        logger.info("Created Drive folder '%s' under %s → %s", folder_name, parent_id, folder["id"])
        return folder["id"]
