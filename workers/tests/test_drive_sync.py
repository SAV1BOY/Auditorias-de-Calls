"""Tests for the Drive watcher and sync modules."""

from __future__ import annotations

from datetime import date
from unittest.mock import MagicMock, patch

import pytest

from src.config import Config
from src.db import DB
from src.drive.client import DriveClient
from src.drive.sync import DriveSync
from src.drive.watcher import DriveFile, DriveWatcher, parse_filename


class TestParseFilename:
    """Test filename parsing for Drive files."""

    def test_standard_filename(self) -> None:
        call_date, lead_name = parse_filename("2026-03-02_elane-lima.ogg")
        assert call_date == "2026-03-02"
        assert lead_name == "Elane Lima"

    def test_filename_with_underscores_in_lead(self) -> None:
        call_date, lead_name = parse_filename("2026-01-15_joao-carlos-silva.mp3")
        assert call_date == "2026-01-15"
        assert lead_name == "Joao Carlos Silva"

    def test_malformed_filename_no_date(self) -> None:
        call_date, lead_name = parse_filename("gravacao-qualquer.ogg")
        assert call_date == date.today().isoformat()
        assert lead_name == "Gravacao Qualquer"

    def test_malformed_filename_no_extension(self) -> None:
        call_date, lead_name = parse_filename("no-extension")
        assert call_date == date.today().isoformat()
        assert lead_name == "No Extension"

    def test_filename_with_mp4(self) -> None:
        call_date, lead_name = parse_filename("2026-06-10_maria-santos.mp4")
        assert call_date == "2026-06-10"
        assert lead_name == "Maria Santos"


class TestDriveWatcher:
    """Test the DriveWatcher.check_new_files method."""

    def test_detect_new_file_in_closer_folder(self, config: Config, mock_db: DB) -> None:
        drive_client = MagicMock(spec=DriveClient)
        drive_client.enabled = True
        drive_client.list_subfolders.return_value = [
            {"id": "folder-evelyn", "name": "evelyn"},
        ]
        drive_client.list_audio_files.return_value = [
            {"id": "file-001", "name": "2026-03-02_elane-lima.ogg", "mimeType": "audio/ogg"},
        ]

        mock_db.check_drive_sync_exists = MagicMock(return_value=False)

        watcher = DriveWatcher(config, mock_db, drive_client)
        new_files = watcher.check_new_files()

        assert len(new_files) == 1
        assert new_files[0].file_id == "file-001"
        assert new_files[0].folder_name == "evelyn"

    def test_ignores_already_synced_files(self, config: Config, mock_db: DB) -> None:
        drive_client = MagicMock(spec=DriveClient)
        drive_client.enabled = True
        drive_client.list_subfolders.return_value = [
            {"id": "folder-evelyn", "name": "evelyn"},
        ]
        drive_client.list_audio_files.return_value = [
            {"id": "file-001", "name": "2026-03-02_elane-lima.ogg", "mimeType": "audio/ogg"},
        ]

        # File already synced (anti-loop)
        mock_db.check_drive_sync_exists = MagicMock(return_value=True)

        watcher = DriveWatcher(config, mock_db, drive_client)
        new_files = watcher.check_new_files()

        assert len(new_files) == 0

    def test_ignores_files_from_frontend(self, config: Config, mock_db: DB) -> None:
        """Files uploaded via frontend are registered with origin='frontend'
        and should be ignored by the watcher (anti-loop via drive_sync check)."""
        drive_client = MagicMock(spec=DriveClient)
        drive_client.enabled = True
        drive_client.list_subfolders.return_value = [
            {"id": "folder-evelyn", "name": "evelyn"},
        ]
        drive_client.list_audio_files.return_value = [
            {"id": "file-frontend", "name": "2026-03-02_elane-lima.ogg", "mimeType": "audio/ogg"},
        ]

        # This file was synced from frontend
        mock_db.check_drive_sync_exists = MagicMock(return_value=True)

        watcher = DriveWatcher(config, mock_db, drive_client)
        new_files = watcher.check_new_files()

        assert len(new_files) == 0

    def test_disabled_when_not_configured(self, mock_db: DB) -> None:
        config = Config(
            supabase_url="https://test.supabase.co",
            supabase_service_role_key="key",
            openai_api_key="key",
            google_service_account_info={},
            google_drive_gravacoes_folder_id="",  # Not configured
        )
        drive_client = MagicMock(spec=DriveClient)
        drive_client.enabled = False

        watcher = DriveWatcher(config, mock_db, drive_client)
        assert not watcher.enabled
        assert watcher.check_new_files() == []


class TestDriveSync:
    """Test sync_from_drive and sync_to_drive."""

    def test_sync_from_drive_creates_audit_and_job(self, config: Config, mock_db: DB) -> None:
        drive_client = MagicMock(spec=DriveClient)
        drive_client.download_file.return_value = b"audio-bytes"

        mock_db.find_closer_by_name = MagicMock(return_value={"id": "closer-001", "name": "Evelyn"})
        mock_db.create_audit_from_drive = MagicMock(return_value="audit-new")
        mock_db.insert_drive_sync = MagicMock()
        mock_db.create_job = MagicMock(return_value="job-new")

        file = DriveFile(
            file_id="file-001",
            name="2026-03-02_elane-lima.ogg",
            folder_id="folder-evelyn",
            folder_name="evelyn",
            mime_type="audio/ogg",
        )

        sync = DriveSync(config, mock_db, drive_client)
        with patch("src.drive.sync.upload_audio", return_value="audit-new/2026-03-02_elane-lima.ogg"):
            audit_id = sync.sync_from_drive(file)

        assert audit_id == "audit-new"
        mock_db.create_audit_from_drive.assert_called_once()
        mock_db.insert_drive_sync.assert_called_once()
        assert mock_db.insert_drive_sync.call_args[1]["origin"] == "drive"
        mock_db.create_job.assert_called_once_with("audit-new", "transcribe")

    def test_sync_to_drive_uploads_and_registers(self, config: Config, mock_db: DB) -> None:
        drive_client = MagicMock(spec=DriveClient)
        drive_client.enabled = True
        drive_client.get_or_create_folder.return_value = "folder-evelyn"
        drive_client.upload_file.return_value = {"id": "drive-file-001", "webViewLink": "https://drive.google.com/file/d/drive-file-001"}

        mock_db.get_audit = MagicMock(return_value={
            "id": "audit-001",
            "closer_id": "closer-001",
            "lead_name": "Elane Lima",
            "call_date": "2026-03-02",
            "status": "transcribed",
            "audio_path": "audit-001/call.ogg",
            "drive_file_id": None,
            "closers": {"name": "Evelyn"},
        })
        mock_db.insert_drive_sync = MagicMock()
        mock_db.update_audit_status = MagicMock()

        sync = DriveSync(config, mock_db, drive_client)
        with patch("src.drive.sync.dl_audio", return_value=b"audio-bytes", create=True):
            with patch("src.storage.download_audio", return_value=b"audio-bytes"):
                result = sync.sync_to_drive("audit-001")

        assert result == "drive-file-001"
        mock_db.insert_drive_sync.assert_called_once()
        assert mock_db.insert_drive_sync.call_args[1]["origin"] == "frontend"
