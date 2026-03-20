"""Evolution API client for WhatsApp messaging."""

from __future__ import annotations

import logging

import httpx
from tenacity import retry, stop_after_attempt, wait_exponential

logger = logging.getLogger(__name__)


class EvolutionClient:
    """Sends WhatsApp messages via Evolution API."""

    def __init__(self, api_url: str, api_token: str, instance_id: str) -> None:
        self._api_url = api_url.rstrip("/")
        self._api_token = api_token
        self._instance_id = instance_id

    @property
    def enabled(self) -> bool:
        return bool(self._api_url and self._api_token and self._instance_id)

    @retry(stop=stop_after_attempt(2), wait=wait_exponential(min=2, max=30), reraise=True)
    def send_text(self, number: str, text: str) -> dict:
        """Send a text message via Evolution API.

        POST {api_url}/message/sendText/{instance_id}
        Headers: { "apikey": token }
        Body: { "number": number, "text": text }
        """
        url = f"{self._api_url}/message/sendText/{self._instance_id}"
        headers = {"apikey": self._api_token, "Content-Type": "application/json"}
        payload = {"number": number, "text": text}

        with httpx.Client(timeout=30.0) as client:
            response = client.post(url, json=payload, headers=headers)
            response.raise_for_status()
            result = response.json()

        logger.info("WhatsApp message sent to %s via Evolution API", number)
        return result
