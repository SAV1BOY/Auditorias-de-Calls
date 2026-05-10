-- Migration 013: Fix Supervisor RLS + Channel webhook + Dequeue RPC
-- Replaces auth.org_id() with public.get_org_id() (avoids schema permission issues)
-- Adds 'webhook' channel to notifications
-- Creates enqueue_job and dequeue_job RPCs

-- ═══════════════════════════════════════
-- 1. Create public.get_org_id() to replace auth.org_id()
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.get_org_id()
RETURNS uuid
LANGUAGE sql
STABLE SECURITY DEFINER
AS $$
  SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$;

-- ═══════════════════════════════════════
-- 2. Update ALL RLS policies to use get_org_id() instead of auth.org_id()
-- ═══════════════════════════════════════

-- call_audits
DROP POLICY IF EXISTS "org_select" ON call_audits;
DROP POLICY IF EXISTS "org_insert" ON call_audits;
DROP POLICY IF EXISTS "org_update" ON call_audits;
CREATE POLICY "org_select" ON call_audits FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON call_audits FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON call_audits FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- closers
DROP POLICY IF EXISTS "org_select" ON closers;
DROP POLICY IF EXISTS "org_insert" ON closers;
DROP POLICY IF EXISTS "org_update" ON closers;
CREATE POLICY "org_select" ON closers FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON closers FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON closers FOR UPDATE TO authenticated USING (organization_id = get_org_id());

-- app_config
DROP POLICY IF EXISTS "org_select" ON app_config;
DROP POLICY IF EXISTS "org_insert" ON app_config;
DROP POLICY IF EXISTS "org_update" ON app_config;
CREATE POLICY "org_select" ON app_config FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON app_config FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON app_config FOR UPDATE TO authenticated USING (organization_id = get_org_id());

-- job_queue
DROP POLICY IF EXISTS "org_select_via_audit" ON job_queue;
CREATE POLICY "org_select_via_audit" ON job_queue FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- notifications
DROP POLICY IF EXISTS "org_select_via_audit" ON notifications;
CREATE POLICY "org_select_via_audit" ON notifications FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- drive_sync
DROP POLICY IF EXISTS "org_select_via_audit" ON drive_sync;
CREATE POLICY "org_select_via_audit" ON drive_sync FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- call_bookmarks
DROP POLICY IF EXISTS "org_select" ON call_bookmarks;
DROP POLICY IF EXISTS "org_insert" ON call_bookmarks;
DROP POLICY IF EXISTS "owner_update" ON call_bookmarks;
DROP POLICY IF EXISTS "owner_delete" ON call_bookmarks;
CREATE POLICY "org_select" ON call_bookmarks FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON call_bookmarks FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id() AND bookmarked_by = auth.uid());
CREATE POLICY "owner_update" ON call_bookmarks FOR UPDATE TO authenticated USING (bookmarked_by = auth.uid()) WITH CHECK (organization_id = get_org_id());
CREATE POLICY "owner_delete" ON call_bookmarks FOR DELETE TO authenticated USING (bookmarked_by = auth.uid());

-- call_comments
DROP POLICY IF EXISTS "org_select" ON call_comments;
DROP POLICY IF EXISTS "org_insert" ON call_comments;
DROP POLICY IF EXISTS "org_update" ON call_comments;
DROP POLICY IF EXISTS "author_delete" ON call_comments;
CREATE POLICY "org_select" ON call_comments FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON call_comments FOR INSERT TO authenticated
  WITH CHECK (author_id = auth.uid() AND audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "org_update" ON call_comments FOR UPDATE TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "author_delete" ON call_comments FOR DELETE TO authenticated USING (author_id = auth.uid());

-- weekly_reports
DROP POLICY IF EXISTS "org_select" ON weekly_reports;
DROP POLICY IF EXISTS "org_insert" ON weekly_reports;
CREATE POLICY "org_select" ON weekly_reports FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON weekly_reports FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());

-- goals
DROP POLICY IF EXISTS "org_select" ON goals;
DROP POLICY IF EXISTS "org_insert" ON goals;
DROP POLICY IF EXISTS "org_update" ON goals;
DROP POLICY IF EXISTS "org_delete" ON goals;
CREATE POLICY "org_select" ON goals FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON goals FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON goals FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_delete" ON goals FOR DELETE TO authenticated USING (organization_id = get_org_id());

-- competitions
DROP POLICY IF EXISTS "org_select" ON competitions;
DROP POLICY IF EXISTS "org_insert" ON competitions;
DROP POLICY IF EXISTS "org_update" ON competitions;
CREATE POLICY "org_select" ON competitions FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON competitions FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON competitions FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- loss_patterns
DROP POLICY IF EXISTS "org_select" ON loss_patterns;
CREATE POLICY "org_select" ON loss_patterns FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- profiles
DROP POLICY IF EXISTS "org_read_profiles" ON profiles;
CREATE POLICY "org_read_profiles" ON profiles FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- supervisor_analyses
DROP POLICY IF EXISTS "authenticated_all" ON supervisor_analyses;
CREATE POLICY "org_select" ON supervisor_analyses FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON supervisor_analyses FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON supervisor_analyses FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- supervisor_stage_scores
DROP POLICY IF EXISTS "authenticated_all" ON supervisor_stage_scores;
CREATE POLICY "org_select" ON supervisor_stage_scores FOR SELECT TO authenticated
  USING (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON supervisor_stage_scores FOR INSERT TO authenticated
  WITH CHECK (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = get_org_id()));

-- protocol_rules
DROP POLICY IF EXISTS "authenticated_all" ON protocol_rules;
CREATE POLICY "org_select" ON protocol_rules FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON protocol_rules FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON protocol_rules FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- negotiation_rules
DROP POLICY IF EXISTS "authenticated_all" ON negotiation_rules;
CREATE POLICY "org_select" ON negotiation_rules FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- closer_training_actions
DROP POLICY IF EXISTS "authenticated_all" ON closer_training_actions;
CREATE POLICY "org_select" ON closer_training_actions FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON closer_training_actions FOR INSERT TO authenticated
  WITH CHECK (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- closer_badges
DROP POLICY IF EXISTS "org_select_via_closer" ON closer_badges;
CREATE POLICY "org_select_via_closer" ON closer_badges FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- closer_streaks
DROP POLICY IF EXISTS "org_select_via_closer" ON closer_streaks;
CREATE POLICY "org_select_via_closer" ON closer_streaks FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- storage (update to use get_org_id)
DROP POLICY IF EXISTS "org_upload_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_read_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_delete_audios" ON storage.objects;
CREATE POLICY "org_upload_audios" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);
CREATE POLICY "org_read_audios" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);
CREATE POLICY "org_delete_audios" ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);

-- ═══════════════════════════════════════
-- 3. Add 'webhook' to notifications channel
-- ═══════════════════════════════════════
ALTER TABLE notifications DROP CONSTRAINT IF EXISTS notifications_channel_check;
ALTER TABLE notifications ADD CONSTRAINT notifications_channel_check
  CHECK (channel IN ('whatsapp', 'email', 'webhook'));

-- ═══════════════════════════════════════
-- 4. Update enqueue_job to use get_org_id()
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.enqueue_job(p_audit_id uuid, p_job_type text)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
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
$function$;

-- ═══════════════════════════════════════
-- 5. Create dequeue_job RPC
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.dequeue_job()
RETURNS TABLE(id uuid, audit_id uuid, job_type text, status text, attempts integer, max_attempts integer, error_message text, started_at timestamp with time zone, completed_at timestamp with time zone, created_at timestamp with time zone)
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
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
$function$;
