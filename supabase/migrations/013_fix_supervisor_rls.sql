-- Migration 013: Fix supervisor RLS + channel constraint + dequeue/enqueue RPCs
-- Fixes: AUDIT-0001 (P0), AUDIT-0006 (P2), AUDIT-0007 (P2)
-- Uses public.get_org_id() instead of auth.org_id() (schema auth is read-only on hosted Supabase)

-- 0. CREATE org_id helper in public schema
CREATE OR REPLACE FUNCTION public.get_org_id() RETURNS uuid AS $$
  SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 1. FIX SUPERVISOR RLS: Replace USING(true) with org-scoped policies

DROP POLICY IF EXISTS "authenticated_all" ON supervisor_analyses;
CREATE POLICY "org_select" ON supervisor_analyses FOR SELECT TO authenticated
  USING (organization_id = public.get_org_id());
CREATE POLICY "org_insert" ON supervisor_analyses FOR INSERT TO authenticated
  WITH CHECK (organization_id = public.get_org_id());
CREATE POLICY "org_update" ON supervisor_analyses FOR UPDATE TO authenticated
  USING (organization_id = public.get_org_id()) WITH CHECK (organization_id = public.get_org_id());

DROP POLICY IF EXISTS "authenticated_all" ON supervisor_stage_scores;
CREATE POLICY "org_select" ON supervisor_stage_scores FOR SELECT TO authenticated
  USING (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = public.get_org_id()));
CREATE POLICY "org_insert" ON supervisor_stage_scores FOR INSERT TO authenticated
  WITH CHECK (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = public.get_org_id()));

DROP POLICY IF EXISTS "authenticated_all" ON protocol_rules;
CREATE POLICY "org_select" ON protocol_rules FOR SELECT TO authenticated
  USING (organization_id = public.get_org_id());
CREATE POLICY "org_insert" ON protocol_rules FOR INSERT TO authenticated
  WITH CHECK (organization_id = public.get_org_id());
CREATE POLICY "org_update" ON protocol_rules FOR UPDATE TO authenticated
  USING (organization_id = public.get_org_id()) WITH CHECK (organization_id = public.get_org_id());

DROP POLICY IF EXISTS "authenticated_all" ON negotiation_rules;
CREATE POLICY "org_select" ON negotiation_rules FOR SELECT TO authenticated
  USING (organization_id = public.get_org_id());

DROP POLICY IF EXISTS "authenticated_all" ON closer_training_actions;
CREATE POLICY "org_select" ON closer_training_actions FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = public.get_org_id()));
CREATE POLICY "org_insert" ON closer_training_actions FOR INSERT TO authenticated
  WITH CHECK (closer_id IN (SELECT id FROM closers WHERE organization_id = public.get_org_id()));

-- 2. EXPAND notifications.channel CHECK constraint
ALTER TABLE notifications DROP CONSTRAINT IF EXISTS notifications_channel_check;
ALTER TABLE notifications ADD CONSTRAINT notifications_channel_check
  CHECK (channel IN ('whatsapp', 'email', 'webhook'));

-- 3. ATOMIC DEQUEUE RPC (FOR UPDATE SKIP LOCKED)
CREATE OR REPLACE FUNCTION public.dequeue_job()
RETURNS TABLE (
  id UUID, audit_id UUID, job_type TEXT, status TEXT,
  attempts INT, max_attempts INT, error_message TEXT,
  started_at TIMESTAMPTZ, completed_at TIMESTAMPTZ, created_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  UPDATE job_queue jq SET status = 'processing', started_at = NOW()
  WHERE jq.id = (
    SELECT jq2.id FROM job_queue jq2
    WHERE jq2.status = 'pending'
    ORDER BY jq2.created_at ASC LIMIT 1
    FOR UPDATE SKIP LOCKED
  )
  RETURNING jq.id, jq.audit_id, jq.job_type, jq.status,
            jq.attempts, jq.max_attempts, jq.error_message,
            jq.started_at, jq.completed_at, jq.created_at;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. ENQUEUE JOB RPC (for frontend server actions)
CREATE OR REPLACE FUNCTION public.enqueue_job(
  p_audit_id UUID, p_job_type TEXT
) RETURNS UUID AS $$
DECLARE v_org_id UUID; v_job_id UUID;
BEGIN
  SELECT organization_id INTO v_org_id FROM call_audits WHERE id = p_audit_id;
  IF v_org_id IS NULL THEN RAISE EXCEPTION 'Audit not found: %', p_audit_id; END IF;
  IF v_org_id != public.get_org_id() THEN RAISE EXCEPTION 'Access denied'; END IF;
  INSERT INTO job_queue (audit_id, job_type, status)
    VALUES (p_audit_id, p_job_type, 'pending') RETURNING id INTO v_job_id;
  RETURN v_job_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
