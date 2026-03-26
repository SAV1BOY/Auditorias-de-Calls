"""Supabase database wrapper for the CallAudit Worker."""

from __future__ import annotations

import logging
from dataclasses import dataclass
from datetime import datetime, timezone
from typing import Any

from supabase import create_client, Client

from src.config import Config

logger = logging.getLogger(__name__)


@dataclass
class Job:
    """Represents a row from the job_queue table."""

    id: str
    audit_id: str
    job_type: str  # 'transcribe' | 'analyze' | 'notify'
    status: str  # 'pending' | 'processing' | 'completed' | 'failed'
    attempts: int
    max_attempts: int
    error_message: str | None
    started_at: str | None
    completed_at: str | None
    created_at: str


class DB:
    """Database operations wrapper using Supabase service role client."""

    def __init__(self, config: Config) -> None:
        self._client: Client = create_client(
            config.supabase_url,
            config.supabase_service_role_key,
        )

    @property
    def client(self) -> Client:
        """Expose the raw Supabase client for direct queries."""
        return self._client

    def fetch_pending_job(self) -> Job | None:
        """Fetch the oldest pending job and atomically mark it as processing.

        Uses an atomic UPDATE with status check to prevent TOCTOU race
        conditions when multiple workers are running.

        Returns:
            The job if found, None otherwise.
        """
        now = datetime.now(timezone.utc).isoformat()

        # Atomic: only update if still pending, preventing race conditions
        result = (
            self._client.table("job_queue")
            .update({"status": "processing", "started_at": now})
            .eq("status", "pending")
            .order("created_at", desc=False)
            .limit(1)
            .execute()
        )

        if not result.data:
            return None

        row = result.data[0]

        return Job(
            id=row["id"],
            audit_id=row["audit_id"],
            job_type=row["job_type"],
            status="processing",
            attempts=row["attempts"],
            max_attempts=row["max_attempts"],
            error_message=row.get("error_message"),
            started_at=now,
            completed_at=row.get("completed_at"),
            created_at=row["created_at"],
        )

    def complete_job(self, job_id: str) -> None:
        """Mark a job as completed."""
        now = datetime.now(timezone.utc).isoformat()
        self._client.table("job_queue").update({
            "status": "completed",
            "completed_at": now,
        }).eq("id", job_id).execute()

    def refresh_views(self) -> None:
        """Trigger debounced refresh of materialized views via RPC.

        Calls refresh_dashboard_views_debounced() which uses advisory locks
        and a 30s cooldown to prevent excessive refreshes.
        Non-fatal: logs warning on failure.
        """
        try:
            self._client.rpc("refresh_dashboard_views_debounced").execute()
            logger.debug("Materialized views refresh requested")
        except Exception as e:
            logger.warning("Materialized views refresh failed (non-fatal): %s", e)

    def fail_job(self, job_id: str, error: str, attempts: int, max_attempts: int) -> None:
        """Mark a job as failed/dead_letter or reset to pending for retry.

        Jobs that exceed max_attempts are moved to dead_letter status
        for manual investigation. Otherwise, they are reset to pending.
        """
        if attempts + 1 >= max_attempts:
            self._client.table("job_queue").update({
                "status": "dead_letter",
                "error_message": error,
                "attempts": attempts + 1,
                "completed_at": datetime.now(timezone.utc).isoformat(),
            }).eq("id", job_id).execute()
            logger.warning("Job %s moved to dead_letter after %d attempts", job_id, attempts + 1)
        else:
            self._client.table("job_queue").update({
                "status": "pending",
                "error_message": error,
                "attempts": attempts + 1,
                "started_at": None,
            }).eq("id", job_id).execute()

    def update_audit_status(
        self,
        audit_id: str,
        status: str,
        extra: dict[str, Any] | None = None,
    ) -> None:
        """Update the status (and optional extra fields) of a call_audit."""
        data: dict[str, Any] = {"status": status}
        if extra:
            data.update(extra)
        self._client.table("call_audits").update(data).eq("id", audit_id).execute()

    def get_audit(self, audit_id: str) -> dict[str, Any] | None:
        """Fetch a single call_audit by id, including closer notification_emails."""
        result = (
            self._client.table("call_audits")
            .select("*, closers(name, notification_emails)")
            .eq("id", audit_id)
            .limit(1)
            .execute()
        )
        return result.data[0] if result.data else None

    def get_closer_notification_emails(self, closer_id: str) -> list[str]:
        """Fetch notification_emails for a specific closer.

        Returns:
            List of email addresses, or empty list if not configured.
        """
        result = (
            self._client.table("closers")
            .select("notification_emails")
            .eq("id", closer_id)
            .limit(1)
            .execute()
        )
        if result.data and result.data[0].get("notification_emails"):
            return result.data[0]["notification_emails"]
        return []

    def create_job(self, audit_id: str, job_type: str) -> str:
        """Insert a new job into the queue. Returns the job id."""
        result = (
            self._client.table("job_queue")
            .insert({"audit_id": audit_id, "job_type": job_type, "status": "pending"})
            .execute()
        )
        return result.data[0]["id"]

    def check_drive_sync_exists(self, drive_file_id: str) -> bool:
        """Check if a drive file has already been synced."""
        result = (
            self._client.table("drive_sync")
            .select("id")
            .eq("drive_file_id", drive_file_id)
            .limit(1)
            .execute()
        )
        return len(result.data) > 0

    def insert_drive_sync(
        self,
        drive_file_id: str,
        audit_id: str,
        file_name: str,
        origin: str,
        drive_folder_id: str | None = None,
    ) -> None:
        """Register a synced file in the drive_sync table."""
        self._client.table("drive_sync").insert({
            "drive_file_id": drive_file_id,
            "audit_id": audit_id,
            "file_name": file_name,
            "origin": origin,
            "drive_folder_id": drive_folder_id,
        }).execute()

    def find_closer_by_name(self, name: str) -> dict[str, Any] | None:
        """Find a closer by name (case-insensitive)."""
        result = (
            self._client.table("closers")
            .select("*")
            .ilike("name", name)
            .limit(1)
            .execute()
        )
        return result.data[0] if result.data else None

    def get_app_config(self, key: str) -> Any | None:
        """Fetch a config value from app_config by key."""
        result = self._client.table("app_config").select("value").eq("key", key).limit(1).execute()
        if result.data:
            return result.data[0]["value"]
        return None

    def get_notification_recipients(self) -> dict:
        """Get notification recipients. Returns { 'whatsapp_numbers': [...], 'email_addresses': [...] }"""
        value = self.get_app_config("notification_recipients")
        if isinstance(value, dict):
            return {
                "whatsapp_numbers": value.get("whatsapp_numbers", []),
                "email_addresses": value.get("email_addresses", []),
            }
        return {"whatsapp_numbers": [], "email_addresses": []}

    def insert_notification(self, audit_id: str, channel: str, recipient: str, content: str | None = None) -> str:
        """Insert a notification record. Returns the notification ID."""
        result = self._client.table("notifications").insert({
            "audit_id": audit_id,
            "channel": channel,
            "recipient": recipient,
            "content": content,
            "status": "sent",
        }).execute()
        return result.data[0]["id"]

    def create_audit_from_drive(
        self,
        closer_id: str | None,
        lead_name: str,
        call_date: str,
        audio_path: str,
    ) -> str:
        """Create a call_audit row for a file that came from Drive."""
        result = (
            self._client.table("call_audits")
            .insert({
                "closer_id": closer_id,
                "lead_name": lead_name,
                "call_date": call_date,
                "status": "uploaded",
                "audio_path": audio_path,
            })
            .execute()
        )
        return result.data[0]["id"]
