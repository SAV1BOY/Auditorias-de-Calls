"""CallAudit Worker — Main entry point.

Runs two parallel loops:
  1. Job Runner: polls job_queue every 30s for pending jobs
  2. Drive Watcher: polls Google Drive every 120s for new audio files

Usage:
    cd workers
    python -m src.main
"""

from __future__ import annotations

import logging
import signal
import sys
import threading
import time

from src.config import load_config, Config
from src.db import DB
from src.drive.client import DriveClient
from src.drive.sync import DriveSync
from src.drive.watcher import DriveWatcher
from src.pipeline.transcriber import Transcriber

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
logger = logging.getLogger(__name__)

# Global shutdown flag
_shutdown = threading.Event()


def _job_runner_loop(config: Config, db: DB, transcriber: Transcriber, drive_sync: DriveSync) -> None:
    """Poll job_queue for pending jobs and process them."""
    logger.info("Job runner started (interval: %ds)", config.job_poll_interval_seconds)

    while not _shutdown.is_set():
        try:
            job = db.fetch_pending_job()
            if job:
                logger.info("Processing job %s (type=%s, audit=%s, attempt=%d/%d)",
                            job.id, job.job_type, job.audit_id, job.attempts + 1, job.max_attempts)
                try:
                    _process_job(job, transcriber, drive_sync)
                    db.complete_job(job.id)
                    logger.info("Job %s completed successfully", job.id)
                except Exception as e:
                    error_msg = f"{type(e).__name__}: {e}"
                    logger.error("Job %s failed: %s", job.id, error_msg)
                    db.fail_job(job.id, error_msg, job.attempts, job.max_attempts)

                    # If max retries exceeded, mark audit as error
                    if job.attempts + 1 >= job.max_attempts:
                        db.update_audit_status(job.audit_id, "error", extra={
                            "error_message": error_msg,
                        })
                        logger.error("Job %s exceeded max attempts, audit %s marked as error",
                                     job.id, job.audit_id)
        except Exception as e:
            logger.exception("Unexpected error in job runner: %s", e)

        _shutdown.wait(timeout=config.job_poll_interval_seconds)


def _process_job(job, transcriber: Transcriber, drive_sync: DriveSync) -> None:
    """Route a job to the appropriate handler."""
    if job.job_type == "transcribe":
        result = transcriber.transcribe(job.audit_id)
        # After transcription, sync audio to Drive
        try:
            drive_sync.sync_to_drive(job.audit_id)
        except Exception as e:
            logger.warning("Drive sync failed for audit %s (non-fatal): %s", job.audit_id, e)
    elif job.job_type == "analyze":
        logger.info("Analyze job for audit %s — not yet implemented (Sprint 3)", job.audit_id)
    elif job.job_type == "notify":
        logger.info("Notify job for audit %s — not yet implemented (Sprint 6)", job.audit_id)
    else:
        raise ValueError(f"Unknown job type: {job.job_type}")


def _drive_watcher_loop(config: Config, watcher: DriveWatcher, drive_sync: DriveSync) -> None:
    """Poll Google Drive for new audio files."""
    if not watcher.enabled:
        logger.info("Drive watcher disabled (not configured). Thread exiting.")
        return

    logger.info("Drive watcher started (interval: %ds)", config.drive_poll_interval_seconds)

    while not _shutdown.is_set():
        try:
            new_files = watcher.check_new_files()
            for file in new_files:
                try:
                    drive_sync.sync_from_drive(file)
                except Exception as e:
                    logger.error("Failed to sync Drive file %s: %s", file.name, e)
        except Exception as e:
            logger.exception("Unexpected error in Drive watcher: %s", e)

        _shutdown.wait(timeout=config.drive_poll_interval_seconds)


def _signal_handler(signum: int, frame) -> None:
    """Handle SIGINT/SIGTERM for graceful shutdown."""
    sig_name = signal.Signals(signum).name
    logger.info("Received %s — shutting down gracefully...", sig_name)
    _shutdown.set()


def main() -> None:
    """Initialize components and start worker threads."""
    logger.info("CallAudit Worker starting...")

    # Load config
    try:
        config = load_config()
    except ValueError as e:
        logger.error("Configuration error: %s", e)
        sys.exit(1)

    # Initialize components
    db = DB(config)
    drive_client = DriveClient(config.google_service_account_info)
    transcriber = Transcriber(config.openai_api_key, db)
    drive_sync = DriveSync(config, db, drive_client)
    watcher = DriveWatcher(config, db, drive_client)

    # Register signal handlers
    signal.signal(signal.SIGINT, _signal_handler)
    signal.signal(signal.SIGTERM, _signal_handler)

    # Start threads
    job_thread = threading.Thread(
        target=_job_runner_loop,
        args=(config, db, transcriber, drive_sync),
        name="job-runner",
        daemon=True,
    )
    drive_thread = threading.Thread(
        target=_drive_watcher_loop,
        args=(config, watcher, drive_sync),
        name="drive-watcher",
        daemon=True,
    )

    job_thread.start()
    drive_thread.start()

    logger.info("Worker running. Press Ctrl+C to stop.")

    # Wait for shutdown signal
    try:
        while not _shutdown.is_set():
            _shutdown.wait(timeout=1)
    except KeyboardInterrupt:
        _shutdown.set()

    # Wait for threads to finish
    job_thread.join(timeout=10)
    drive_thread.join(timeout=10)

    logger.info("Worker stopped.")


if __name__ == "__main__":
    main()
