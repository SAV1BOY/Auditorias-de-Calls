-- Migration 014: Fix job_type constraint to include all 6 types
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report', 'loss_pattern', 'supervisor_analyze'));
