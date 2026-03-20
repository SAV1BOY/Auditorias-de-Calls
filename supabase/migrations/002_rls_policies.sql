-- CallAudit RLS Policies — MVP (single-tenant)
-- Version 1.0 | March 2026
-- Execute this in Supabase SQL Editor AFTER 001_initial_schema.sql

-- Allow authenticated users full access (single-tenant MVP)
-- When multi-tenant: replace (true) with (organization_id = auth.jwt()->>'organization_id')

-- call_audits
CREATE POLICY "authenticated_select" ON call_audits FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON call_audits FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON call_audits FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- closers
CREATE POLICY "authenticated_select" ON closers FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON closers FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON closers FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- job_queue
CREATE POLICY "authenticated_select" ON job_queue FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON job_queue FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON job_queue FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- notifications
CREATE POLICY "authenticated_select" ON notifications FOR SELECT TO authenticated USING (true);

-- profiles (RLS not yet enabled, but prepare for it)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users_read_own" ON profiles FOR SELECT TO authenticated USING (id = auth.uid());
CREATE POLICY "users_update_own" ON profiles FOR UPDATE TO authenticated USING (id = auth.uid()) WITH CHECK (id = auth.uid());

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (NEW.id, COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email), 'viewer');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
