"""Email sender via Resend API."""

from __future__ import annotations

import logging

import resend

logger = logging.getLogger(__name__)


class EmailSender:
    """Sends email reports via Resend API."""

    def __init__(self, api_key: str, from_email: str) -> None:
        self._api_key = api_key
        self._from_email = from_email

    @property
    def enabled(self) -> bool:
        return bool(self._api_key)

    def send_report(self, to: str, subject: str, report_text: str) -> dict:
        """Send an email with the audit report.

        Uses Resend API to send the relatorio_completo as plain text.
        """
        resend.api_key = self._api_key

        result = resend.Emails.send({
            "from": self._from_email,
            "to": [to],
            "subject": subject,
            "text": report_text,
        })

        logger.info("Email sent to %s: subject=%s", to, subject)
        return result
