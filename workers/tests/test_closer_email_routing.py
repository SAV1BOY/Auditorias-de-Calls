"""Tests for closer-specific email routing in notifier pipeline."""

from unittest.mock import MagicMock, patch
import pytest

from src.pipeline.notifier import Notifier


class TestCloserEmailRouting:
    """Tests that the notifier routes emails to closer-specific recipients when configured."""

    def _make_config(self, **kwargs: str) -> MagicMock:
        config = MagicMock()
        config.evolution_api_url = kwargs.get("evo_url", "")
        config.evolution_api_token = kwargs.get("evo_token", "")
        config.evolution_instance_id = kwargs.get("evo_instance", "")
        config.resend_api_key = kwargs.get("resend_key", "re_test")
        config.resend_from_email = kwargs.get("resend_from", "noreply@test.com")
        return config

    def _make_db(
        self,
        audit: dict | None = None,
        global_recipients: dict | None = None,
        closer_emails: list[str] | None = None,
    ) -> MagicMock:
        db = MagicMock()
        db.get_audit.return_value = audit or {
            "id": "audit-1",
            "closer_id": "closer-1",
            "resumo_whatsapp": "Summary text",
            "relatorio_completo": "# Full Report",
            "closers": {"name": "João", "notification_emails": closer_emails or []},
            "lead_name": "Maria",
            "call_date": "2026-03-20",
        }
        db.get_notification_recipients.return_value = global_recipients or {
            "whatsapp_numbers": [],
            "email_addresses": ["global@test.com"],
        }
        db.get_closer_notification_emails.return_value = closer_emails or []
        db.insert_notification.return_value = "notif-1"
        return db

    @patch("src.pipeline.email_sender.resend.Emails.send")
    def test_uses_closer_emails_when_configured(self, mock_resend: MagicMock) -> None:
        """When closer has notification_emails, send to those instead of global."""
        mock_resend.return_value = {"id": "email-1"}

        closer_emails = ["supervisor-a@test.com", "supervisor-b@test.com"]
        db = self._make_db(closer_emails=closer_emails)
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        # Should send to closer-specific emails, not global
        calls = db.insert_notification.call_args_list
        email_calls = [c for c in calls if c[0][1] == "email"]
        assert len(email_calls) == 2
        assert email_calls[0][0][2] == "supervisor-a@test.com"
        assert email_calls[1][0][2] == "supervisor-b@test.com"

    @patch("src.pipeline.email_sender.resend.Emails.send")
    def test_falls_back_to_global_when_no_closer_emails(self, mock_resend: MagicMock) -> None:
        """When closer has no notification_emails, use global config."""
        mock_resend.return_value = {"id": "email-1"}

        db = self._make_db(closer_emails=[])
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        # Should send to global email
        calls = db.insert_notification.call_args_list
        email_calls = [c for c in calls if c[0][1] == "email"]
        assert len(email_calls) == 1
        assert email_calls[0][0][2] == "global@test.com"

    @patch("src.pipeline.email_sender.resend.Emails.send")
    def test_closer_emails_from_join_data(self, mock_resend: MagicMock) -> None:
        """Reads notification_emails from closers join in audit data."""
        mock_resend.return_value = {"id": "email-1"}

        audit = {
            "id": "audit-1",
            "closer_id": "closer-1",
            "resumo_whatsapp": "Summary",
            "relatorio_completo": "# Report",
            "closers": {"name": "Ana", "notification_emails": ["ana-sup@test.com"]},
            "lead_name": "Carlos",
            "call_date": "2026-03-21",
        }
        db = self._make_db(audit=audit)
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        email_calls = [c for c in db.insert_notification.call_args_list if c[0][1] == "email"]
        assert len(email_calls) == 1
        assert email_calls[0][0][2] == "ana-sup@test.com"

    def test_no_closer_id_uses_global(self) -> None:
        """When audit has no closer_id, always use global recipients."""
        audit = {
            "id": "audit-1",
            "closer_id": None,
            "resumo_whatsapp": "",
            "relatorio_completo": "",
            "closers": None,
            "lead_name": "Lead",
            "call_date": "2026-03-21",
        }
        db = self._make_db(audit=audit)
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        # Should not call get_closer_notification_emails
        db.get_closer_notification_emails.assert_not_called()


class TestDBCloserNotificationEmails:
    """Tests for DB.get_closer_notification_emails method."""

    def test_returns_emails_when_configured(self) -> None:
        from src.db import DB

        mock_client = MagicMock()
        mock_result = MagicMock()
        mock_result.data = [{"notification_emails": ["a@test.com", "b@test.com"]}]

        chain = MagicMock()
        chain.select.return_value = chain
        chain.eq.return_value = chain
        chain.limit.return_value = chain
        chain.execute.return_value = mock_result

        mock_client.table.return_value = chain

        db = DB.__new__(DB)
        db._client = mock_client

        result = db.get_closer_notification_emails("closer-1")

        assert result == ["a@test.com", "b@test.com"]
        mock_client.table.assert_called_with("closers")

    def test_returns_empty_list_when_not_configured(self) -> None:
        from src.db import DB

        mock_client = MagicMock()
        mock_result = MagicMock()
        mock_result.data = [{"notification_emails": None}]

        chain = MagicMock()
        chain.select.return_value = chain
        chain.eq.return_value = chain
        chain.limit.return_value = chain
        chain.execute.return_value = mock_result

        mock_client.table.return_value = chain

        db = DB.__new__(DB)
        db._client = mock_client

        result = db.get_closer_notification_emails("closer-2")

        assert result == []

    def test_returns_empty_list_when_no_data(self) -> None:
        from src.db import DB

        mock_client = MagicMock()
        mock_result = MagicMock()
        mock_result.data = []

        chain = MagicMock()
        chain.select.return_value = chain
        chain.eq.return_value = chain
        chain.limit.return_value = chain
        chain.execute.return_value = mock_result

        mock_client.table.return_value = chain

        db = DB.__new__(DB)
        db._client = mock_client

        result = db.get_closer_notification_emails("nonexistent")

        assert result == []
