-- ═══════════════════════════════════════════════════════════════
-- Script 00: RESET — Drop all migrated objects to start clean
-- Execute this FIRST in the new Supabase project if migration failed mid-way
-- ═══════════════════════════════════════════════════════════════

-- Drop all custom storage policies (only ours, system policies are safe)
DROP POLICY IF EXISTS "Auth users upload audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users read audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users delete audios" ON storage.objects;
DROP POLICY IF EXISTS "Service role full access audios" ON storage.objects;
DROP POLICY IF EXISTS "org_upload_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_read_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_delete_audios" ON storage.objects;
DROP POLICY IF EXISTS "Service role full access reports" ON storage.objects;
DROP POLICY IF EXISTS "Auth users read reports" ON storage.objects;

-- Drop migrated storage buckets (gracefully — Supabase blocks DELETE via
-- storage.protect_delete() trigger; the schema script will create fresh buckets)
DO $$ BEGIN
  DELETE FROM storage.objects WHERE bucket_id IN ('audios', 'reports');
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

DO $$ BEGIN
  DELETE FROM storage.buckets WHERE id IN ('audios', 'reports');
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

-- Drop the on_auth_user_created trigger if it exists (created by migration 002)
-- Note: this requires being owner of auth.users — may fail silently
DO $$ BEGIN
  DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

-- Delete any auth users we may have inserted (gracefully — may fail if not owner)
DO $$ BEGIN
  DELETE FROM auth.users WHERE email IN (
    'miguelgsaviotti29@gmail.com',
    'supervisor.teste@callaudit.app',
    'closer.teste@callaudit.app',
    'sandra.saviotti110772@gmail.com',
    'matheuslopezmedeiros@gmail.com'
  );
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

-- Nuke the entire public schema and recreate it fresh
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Restore default privileges (Supabase needs these)
GRANT USAGE ON SCHEMA public TO postgres, anon, authenticated, service_role;
GRANT ALL ON SCHEMA public TO postgres, anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres, anon, authenticated, service_role;

-- Verify clean state
SELECT 'Reset complete. Public schema has ' || count(*) || ' tables (should be 0).' AS status
FROM pg_tables WHERE schemaname = 'public';
