"""Tests for the notification pipeline (Evolution, EmailSender, Notifier)."""

from unittest.mock import MagicMock, patch, call
import pytest

from src.pipeline.evolution import EvolutionClient
from src.pipeline.email_sender import EmailSender
from src.pipeline.notifier import Notifier


# ─────────────── EvolutionClient ───────────────


class TestEvolutionClient:
    """Tests for the Evolution API WhatsApp client."""

    def test_enabled_when_all_configured(self) -> None:
        client = EvolutionClient("https://api.example.com", "token123", "instance1")
        assert client.enabled is True

    def test_disabled_when_url_missing(self) -> None:
        client = EvolutionClient("", "token123", "instance1")
        assert client.enabled is False

    def test_disabled_when_token_missing(self) -> None:
        client = EvolutionClient("https://api.example.com", "", "instance1")
        assert client.enabled is False

    def test_disabled_when_instance_missing(self) -> None:
        client = EvolutionClient("https://api.example.com", "token123", "")
        assert client.enabled is False

    @patch("src.pipeline.evolution.httpx.Client")
    def test_send_text_calls_correct_endpoint(self, mock_client_cls: MagicMock) -> None:
        mock_instance = MagicMock()
        mock_response = MagicMock()
        mock_response.json.return_value = {"status": "sent"}
        mock_instance.post.return_value = mock_response
        mock_client_cls.return_value = mock_instance

        client = EvolutionClient("https://api.example.com", "mytoken", "inst1")
        result = client.send_text("5511999999999", "Hello!")

        mock_instance.post.assert_called_once()
        args, kwargs = mock_instance.post.call_args
        assert args[0] == "https://api.example.com/message/sendText/inst1"
        assert kwargs["headers"]["apikey"] == "mytoken"
        assert kwargs["json"]["number"] == "5511999999999"
        assert kwargs["json"]["text"] == "Hello!"
        assert result == {"status": "sent"}


# ─────────────── EmailSender ───────────────


class TestEmailSender:
    """Tests for the Resend email sender."""

    def test_enabled_when_api_key_set(self) -> None:
        sender = EmailSender("re_123", "noreply@test.com")
        assert sender.enabled is True

    def test_disabled_when_api_key_empty(self) -> None:
        sender = EmailSender("", "noreply@test.com")
        assert sender.enabled is False

    @patch("src.pipeline.email_sender.resend.Emails.send")
    def test_send_report_calls_resend(self, mock_send: MagicMock) -> None:
        mock_send.return_value = {"id": "email_123"}
        sender = EmailSender("re_apikey", "noreply@callaudit.app")
        result = sender.send_report(
            "supervisor@test.com",
            "Auditoria: João x Lead",
            "# Report content"
        )

        mock_send.assert_called_once()
        call_args = mock_send.call_args[0][0]
        assert call_args["from"] == "noreply@callaudit.app"
        assert call_args["to"] == ["supervisor@test.com"]
        assert call_args["subject"] == "Auditoria: João x Lead"
        assert call_args["text"] == "# Report content"
        assert result == {"id": "email_123"}


# ─────────────── Notifier ───────────────


class TestNotifier:
    """Tests for the Notifier orchestrator."""

    def _make_config(self, **kwargs: str) -> MagicMock:
        config = MagicMock()
        config.evolution_api_url = kwargs.get("evo_url", "")
        config.evolution_api_token = kwargs.get("evo_token", "")
        config.evolution_instance_id = kwargs.get("evo_instance", "")
        config.resend_api_key = kwargs.get("resend_key", "")
        config.resend_from_email = kwargs.get("resend_from", "noreply@test.com")
        return config

    def _make_db(self, audit: dict | None = None, recipients: dict | None = None) -> MagicMock:
        db = MagicMock()
        db.get_audit.return_value = audit or {
            "id": "audit-1",
            "resumo_whatsapp": "Summary text",
            "relatorio_completo": "# Full Report",
            "closers": {"name": "João"},
            "lead_name": "Maria",
            "call_date": "2026-03-20",
        }
        db.get_notification_recipients.return_value = recipients or {
            "whatsapp_numbers": [],
            "email_addresses": [],
        }
        db.insert_notification.return_value = "notif-1"
        return db

    def test_notify_updates_status_to_notifying_then_completed(self) -> None:
        db = self._make_db()
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        calls = db.update_audit_status.call_args_list
        assert calls[0][0] == ("audit-1", "notifying")
        assert calls[1][0][0] == "audit-1"
        assert calls[1][0][1] == "completed"
        assert "notified_at" in calls[1][1]["extra"]
        assert "completed_at" in calls[1][1]["extra"]

    def test_notify_raises_if_audit_not_found(self) -> None:
        db = self._make_db()
        db.get_audit.return_value = None
        config = self._make_config()
        notifier = Notifier(config, db)

        with pytest.raises(ValueError, match="not found"):
            notifier.notify("missing-audit")

    @patch("src.pipeline.evolution.httpx.Client")
    def test_notify_sends_whatsapp_when_configured(self, mock_httpx: MagicMock) -> None:
        mock_client = MagicMock()
        mock_response = MagicMock()
        mock_response.json.return_value = {"status": "sent"}
        mock_client.post.return_value = mock_response
        mock_httpx.return_value.__enter__ = MagicMock(return_value=mock_client)
        mock_httpx.return_value.__exit__ = MagicMock(return_value=False)

        db = self._make_db(recipients={
            "whatsapp_numbers": ["5511999999999"],
            "email_addresses": [],
        })
        config = self._make_config(evo_url="https://api.test.com", evo_token="tok", evo_instance="inst")
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        db.insert_notification.assert_called_once_with("audit-1", "whatsapp", "5511999999999", "Summary text")

    @patch("src.pipeline.email_sender.resend.Emails.send")
    def test_notify_sends_email_when_configured(self, mock_resend: MagicMock) -> None:
        mock_resend.return_value = {"id": "email-1"}

        db = self._make_db(recipients={
            "whatsapp_numbers": [],
            "email_addresses": ["supervisor@test.com"],
        })
        config = self._make_config(resend_key="re_key", resend_from="noreply@test.com")
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        db.insert_notification.assert_called_once_with("audit-1", "email", "supervisor@test.com")

    def test_notify_completes_even_without_recipients(self) -> None:
        db = self._make_db(recipients={"whatsapp_numbers": [], "email_addresses": []})
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        # Should still mark as completed
        last_call = db.update_audit_status.call_args_list[-1]
        assert last_call[0][1] == "completed"

    @patch("src.pipeline.evolution.httpx.Client")
    def test_notify_continues_on_whatsapp_failure(self, mock_httpx: MagicMock) -> None:
        mock_client = MagicMock()
        mock_client.post.side_effect = Exception("Connection failed")
        mock_httpx.return_value.__enter__ = MagicMock(return_value=mock_client)
        mock_httpx.return_value.__exit__ = MagicMock(return_value=False)

        db = self._make_db(recipients={
            "whatsapp_numbers": ["5511999999999"],
            "email_addresses": [],
        })
        config = self._make_config(evo_url="https://api.test.com", evo_token="tok", evo_instance="inst")
        notifier = Notifier(config, db)

        # Should not raise — failure is logged and continues
        notifier.notify("audit-1")

        # Should still mark as completed
        last_call = db.update_audit_status.call_args_list[-1]
        assert last_call[0][1] == "completed"

    def test_notify_db_methods_integration(self) -> None:
        """Test that get_notification_recipients and insert_notification are called correctly."""
        db = self._make_db()
        config = self._make_config()
        notifier = Notifier(config, db)

        notifier.notify("audit-1")

        db.get_audit.assert_called_once_with("audit-1")
        db.get_notification_recipients.assert_called_once()
