"""Simple health check endpoint for monitoring."""

from __future__ import annotations

import json
import logging
import threading
import time
from http.server import HTTPServer, BaseHTTPRequestHandler
from typing import Any

logger = logging.getLogger(__name__)

_start_time = time.time()
_thread_status: dict[str, str] = {}


def register_thread(name: str, status: str = "running") -> None:
    """Register or update a thread's status."""
    _thread_status[name] = status


class HealthHandler(BaseHTTPRequestHandler):
    """Handle GET /health requests."""

    def do_GET(self) -> None:
        if self.path != "/health":
            self.send_response(404)
            self.end_headers()
            return

        body: dict[str, Any] = {
            "status": "ok",
            "uptime_seconds": round(time.time() - _start_time),
            "threads": dict(_thread_status),
        }
        payload = json.dumps(body).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def log_message(self, format: str, *args: Any) -> None:
        # Silence default request logs
        pass


def start_health_server(port: int = 8080) -> threading.Thread:
    """Start health check HTTP server in a daemon thread."""
    server = HTTPServer(("0.0.0.0", port), HealthHandler)
    thread = threading.Thread(target=server.serve_forever, name="health-server", daemon=True)
    thread.start()
    logger.info("Health check server listening on port %d", port)
    return thread
