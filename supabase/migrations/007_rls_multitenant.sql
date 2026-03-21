-- ═══════════════════════════════════════════════════════════════
-- Migration 007: Multi-tenant RLS + Storage Isolation + Job Queue Lockdown
-- Replaces all USING (true) policies with organization_id filtering
-- ═══════════════════════════════════════════════════════════════

-- ─── Helper function: extract org_id from authenticated user's profile ───
-- Uses a subquery on profiles rather than JWT claims for reliability
-- (JWT claims require custom hook setup in Supabase)
CREATE OR REPLACE FUNCTION auth.org_id() RETURNS uuid AS $$
  SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- ═══════════════════════════════════════
-- 1. call_audits — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON call_audits;
DROP POLICY IF EXISTS "authenticated_insert" ON call_audits;
DROP POLICY IF EXISTS "authenticated_update" ON call_audits;

CREATE POLICY "org_select" ON call_audits FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON call_audits FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON call_audits FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 2. closers — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON closers;
DROP POLICY IF EXISTS "authenticated_insert" ON closers;
DROP POLICY IF EXISTS "authenticated_update" ON closers;

CREATE POLICY "org_select" ON closers FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON closers FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON closers FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 3. job_queue — LOCKDOWN: no direct authenticated access
-- Worker uses service_role. Frontend uses enqueue_job() stored procedure.
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON job_queue;
DROP POLICY IF EXISTS "authenticated_insert" ON job_queue;
DROP POLICY IF EXISTS "authenticated_update" ON job_queue;

-- Authenticated users can only read jobs for their org's audits
CREATE POLICY "org_select_via_audit" ON job_queue FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- No INSERT/UPDATE for authenticated users — use stored procedure instead

-- Stored procedure for enqueuing jobs (called from server actions)
CREATE OR REPLACE FUNCTION public.enqueue_job(
  p_audit_id UUID,
  p_job_type TEXT
) RETURNS UUID AS $$
DECLARE
  v_org_id UUID;
  v_job_id UUID;
BEGIN
  -- Verify the audit belongs to the user's organization
  SELECT organization_id INTO v_org_id
    FROM call_audits WHERE id = p_audit_id;

  IF v_org_id IS NULL THEN
    RAISE EXCEPTION 'Audit not found: %', p_audit_id;
  END IF;

  IF v_org_id != auth.org_id() THEN
    RAISE EXCEPTION 'Access denied: audit belongs to another organization';
  END IF;

  -- Insert the job
  INSERT INTO job_queue (audit_id, job_type, status)
    VALUES (p_audit_id, p_job_type, 'pending')
    RETURNING id INTO v_job_id;

  RETURN v_job_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ═══════════════════════════════════════
-- 4. notifications — org isolation via audit
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON notifications;

CREATE POLICY "org_select_via_audit" ON notifications FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- ═══════════════════════════════════════
-- 5. app_config — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON app_config;
DROP POLICY IF EXISTS "authenticated_insert" ON app_config;
DROP POLICY IF EXISTS "authenticated_update" ON app_config;

CREATE POLICY "org_select" ON app_config FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON app_config FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON app_config FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 6. drive_sync — org isolation via audit
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON drive_sync;

CREATE POLICY "org_select_via_audit" ON drive_sync FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- ═══════════════════════════════════════
-- 7. call_bookmarks — org isolation + ownership
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON call_bookmarks;

CREATE POLICY "org_select" ON call_bookmarks FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON call_bookmarks FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id() AND bookmarked_by = auth.uid());
CREATE POLICY "owner_update" ON call_bookmarks FOR UPDATE TO authenticated
  USING (bookmarked_by = auth.uid()) WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "owner_delete" ON call_bookmarks FOR DELETE TO authenticated
  USING (bookmarked_by = auth.uid());

-- ═══════════════════════════════════════
-- 8. call_comments — org isolation + ownership for delete
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON call_comments;

-- Everyone in org can read comments
CREATE POLICY "org_select" ON call_comments FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Authenticated users can create comments on their org's audits
CREATE POLICY "org_insert" ON call_comments FOR INSERT TO authenticated
  WITH CHECK (
    author_id = auth.uid()
    AND audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Anyone in org can update (resolve/unresolve) — RBAC enforced at app level
CREATE POLICY "org_update" ON call_comments FOR UPDATE TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Only author can delete their own comments
CREATE POLICY "author_delete" ON call_comments FOR DELETE TO authenticated
  USING (author_id = auth.uid());

-- ═══════════════════════════════════════
-- 9. weekly_reports — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON weekly_reports;

CREATE POLICY "org_select" ON weekly_reports FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON weekly_reports FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 10. badges — global read (badges are shared), org-scoped write
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_read_badges" ON badges;
DROP POLICY IF EXISTS "authenticated_all_badges" ON badges;

-- Badges are global definitions — everyone can read
CREATE POLICY "authenticated_read" ON badges FOR SELECT TO authenticated
  USING (true);
-- Only service_role (worker) writes badges

-- ═══════════════════════════════════════
-- 11. closer_badges — org isolation via closer
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_closer_badges" ON closer_badges;

CREATE POLICY "org_select_via_closer" ON closer_badges FOR SELECT TO authenticated
  USING (
    closer_id IN (
      SELECT id FROM closers WHERE organization_id = auth.org_id()
    )
  );
-- Only service_role (worker) writes closer_badges

-- ═══════════════════════════════════════
-- 12. closer_streaks — org isolation via closer
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_closer_streaks" ON closer_streaks;

CREATE POLICY "org_select_via_closer" ON closer_streaks FOR SELECT TO authenticated
  USING (
    closer_id IN (
      SELECT id FROM closers WHERE organization_id = auth.org_id()
    )
  );
-- Only service_role (worker) writes closer_streaks

-- ═══════════════════════════════════════
-- 13. competitions — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_competitions" ON competitions;

CREATE POLICY "org_select" ON competitions FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON competitions FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON competitions FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 14. goals — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON goals;
DROP POLICY IF EXISTS "authenticated_insert" ON goals;
DROP POLICY IF EXISTS "authenticated_update" ON goals;
DROP POLICY IF EXISTS "authenticated_delete" ON goals;

CREATE POLICY "org_select" ON goals FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON goals FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON goals FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_delete" ON goals FOR DELETE TO authenticated
  USING (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 15. loss_patterns — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_loss_patterns" ON loss_patterns;

CREATE POLICY "org_select" ON loss_patterns FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
-- Only service_role (worker) writes loss_patterns

-- ═══════════════════════════════════════
-- 16. profiles — keep strict self-access + add org read
-- ═══════════════════════════════════════
-- Existing: users_read_own, users_update_own (keep these)
-- Add: users in same org can see each other's basic info
CREATE POLICY "org_read_profiles" ON profiles FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 17. Storage: org-scoped path isolation
-- ═══════════════════════════════════════
-- Audio files are stored under: {org_id}/{closer_id}/{filename}
-- This policy ensures users can only access their org's files

DROP POLICY IF EXISTS "Auth users upload audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users read audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users delete audios" ON storage.objects;

CREATE POLICY "org_upload_audios" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

CREATE POLICY "org_read_audios" ON storage.objects FOR SELECT TO authenticated
  USING (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

CREATE POLICY "org_delete_audios" ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

-- Service role (worker) retains full access (policy already exists from migration 003)

-- ═══════════════════════════════════════
-- 18. Update profile trigger to assign organization_id from signup metadata
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role, organization_id)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'role', 'viewer'),
    (NEW.raw_user_meta_data->>'organization_id')::uuid
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
