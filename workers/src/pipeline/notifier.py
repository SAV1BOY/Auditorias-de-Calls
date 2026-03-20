"""Notification orchestrator — sends WhatsApp and Email notifications."""

from __future__ import annotations

import logging
from datetime import datetime, timezone

from src.config import Config
from src.db import DB
from src.pipeline.evolution import EvolutionClient
from src.pipeline.email_sender import EmailSender

logger = logging.getLogger(__name__)


class Notifier:
    """Orchestrates sending notifications after analysis is complete."""

    def __init__(self, config: Config, db: DB) -> None:
        self._db = db
        self._evolution = EvolutionClient(
            config.evolution_api_url,
            config.evolution_api_token,
            config.evolution_instance_id,
        )
        self._email = EmailSender(
            config.resend_api_key,
            config.resend_from_email,
        )

    def notify(self, audit_id: str) -> None:
        """Send all notifications for a completed audit.

        Steps:
            1. Update status to 'notifying'
            2. Fetch audit data
            3. Fetch notification recipients from app_config
            4. Send WhatsApp messages (resumo_whatsapp)
            5. Send email reports (relatorio_completo)
            6. Record each notification in DB
            7. Update status to 'completed'
        """
        logger.info("Starting notifications for audit %s", audit_id)

        # 1. Update status
        self._db.update_audit_status(audit_id, "notifying")

        # 2. Fetch audit
        audit = self._db.get_audit(audit_id)
        if not audit:
            raise ValueError(f"Audit {audit_id} not found")

        resumo = audit.get("resumo_whatsapp", "")
        relatorio = audit.get("relatorio_completo", "")

        # Build metadata for email subject
        closer_name = "Desconhecido"
        closers_data = audit.get("closers")
        if closers_data:
            if isinstance(closers_data, dict):
                closer_name = closers_data.get("name", closer_name)
            elif isinstance(closers_data, list) and closers_data:
                closer_name = closers_data[0].get("name", closer_name)

        lead_name = audit.get("lead_name", "Desconhecido")
        call_date = audit.get("call_date", "")

        # 3. Fetch recipients
        recipients = self._db.get_notification_recipients()
        whatsapp_numbers = recipients.get("whatsapp_numbers", [])
        email_addresses = recipients.get("email_addresses", [])

        if not whatsapp_numbers and not email_addresses:
            logger.warning("No notification recipients configured for audit %s", audit_id)

        sent_count = 0

        # 4. Send WhatsApp
        if self._evolution.enabled and resumo and whatsapp_numbers:
            for number in whatsapp_numbers:
                try:
                    self._evolution.send_text(number, resumo)
                    self._db.insert_notification(audit_id, "whatsapp", number, resumo)
                    sent_count += 1
                except Exception as e:
                    logger.error("Failed to send WhatsApp to %s for audit %s: %s", number, audit_id, e)
        elif not self._evolution.enabled:
            logger.debug("Evolution API not configured, skipping WhatsApp notifications.")

        # 5. Send Email
        if self._email.enabled and relatorio and email_addresses:
            subject = f"Auditoria: {closer_name} x {lead_name} - {call_date}"
            for email in email_addresses:
                try:
                    self._email.send_report(email, subject, relatorio)
                    self._db.insert_notification(audit_id, "email", email)
                    sent_count += 1
                except Exception as e:
                    logger.error("Failed to send email to %s for audit %s: %s", email, audit_id, e)
        elif not self._email.enabled:
            logger.debug("Resend API not configured, skipping email notifications.")

        # 7. Update status to completed
        now = datetime.now(timezone.utc).isoformat()
        self._db.update_audit_status(audit_id, "completed", extra={
            "notified_at": now,
            "completed_at": now,
        })

        logger.info("Notifications complete for audit %s: %d sent", audit_id, sent_count)
