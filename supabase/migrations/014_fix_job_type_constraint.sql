-- Migration 014: Fix job_type constraint + improve enqueue_job RPC
-- Fixes: AUDIT-0003 residual (loss_pattern missing from constraint)

-- Fix constraint to include ALL valid job types
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN (
    'transcribe', 'analyze', 'notify',
    'weekly_report', 'loss_pattern', 'supervisor_analyze'
  ));

-- Update enqueue_job with explicit type validation
CREATE OR REPLACE FUNCTION public.enqueue_job(
  p_audit_id UUID, p_job_type TEXT
) RETURNS UUID AS $$
DECLARE v_org_id UUID; v_job_id UUID;
BEGIN
  IF p_job_type NOT IN (
    'transcribe', 'analyze', 'notify',
    'weekly_report', 'loss_pattern', 'supervisor_analyze'
  ) THEN
    RAISE EXCEPTION 'Tipo de job invalido: %', p_job_type;
  END IF;

  SELECT organization_id INTO v_org_id FROM call_audits WHERE id = p_audit_id;
  IF v_org_id IS NULL THEN RAISE EXCEPTION 'Audit not found: %', p_audit_id; END IF;
  IF v_org_id != public.get_org_id() THEN RAISE EXCEPTION 'Access denied'; END IF;
  INSERT INTO job_queue (audit_id, job_type, status)
    VALUES (p_audit_id, p_job_type, 'pending') RETURNING id INTO v_job_id;
  RETURN v_job_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
