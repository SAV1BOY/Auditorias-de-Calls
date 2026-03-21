"""Structured JSON logging configuration for the CallAudit worker.

Produces JSON-formatted log lines suitable for log aggregation
systems (CloudWatch, Datadog, Loki, etc.).
"""

from __future__ import annotations

import json
import logging
import sys
from datetime import datetime, timezone
from typing import Any


class JSONFormatter(logging.Formatter):
    """Formats log records as single-line JSON objects."""

    def format(self, record: logging.LogRecord) -> str:
        log_entry: dict[str, Any] = {
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "level": record.levelname,
            "logger": record.name,
            "message": record.getMessage(),
        }

        # Add exception info if present
        if record.exc_info and record.exc_info[2]:
            log_entry["exception"] = self.formatException(record.exc_info)

        # Add extra fields (job_id, audit_id, duration_ms, etc.)
        for key in ("job_id", "audit_id", "job_type", "duration_ms", "tokens", "cost"):
            value = getattr(record, key, None)
            if value is not None:
                log_entry[key] = value

        return json.dumps(log_entry, ensure_ascii=False)


def setup_logging(level: int = logging.INFO) -> None:
    """Configure root logger with JSON formatting.

    Args:
        level: The minimum logging level.
    """
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(JSONFormatter())

    root = logging.getLogger()
    root.setLevel(level)
    # Remove existing handlers to avoid duplicate output
    root.handlers.clear()
    root.addHandler(handler)
