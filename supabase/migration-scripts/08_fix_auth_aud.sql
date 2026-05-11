-- ═══════════════════════════════════════════════════════════════
-- Script 08: FIX — Set aud='authenticated' and clean up auth fields
--
-- ROOT CAUSE: The original 02_auth_migration.sql did NOT set the `aud`
-- column when inserting auth.users. Supabase's Auth API (GoTrue) checks
-- this column on every signInWithPassword and rejects users where it's
-- not 'authenticated'. This is why the bcrypt hash works in SQL but
-- the Auth API rejects login.
--
-- This script repairs all 5 migrated users in one shot.
-- ═══════════════════════════════════════════════════════════════

UPDATE auth.users SET
  aud = 'authenticated',
  role = 'authenticated',
  -- ensure email is confirmed
  email_confirmed_at = COALESCE(email_confirmed_at, NOW()),
  -- clear all pending tokens (must be empty strings, not NULL, per GoTrue contract)
  confirmation_token = '',
  recovery_token = '',
  email_change = '',
  email_change_token_new = '',
  email_change_token_current = '',
  email_change_confirm_status = 0,
  reauthentication_token = '',
  -- ensure account is active
  banned_until = NULL,
  deleted_at = NULL,
  is_sso_user = false,
  is_anonymous = false
WHERE email IN (
  'miguelgsaviotti29@gmail.com',
  'supervisor.teste@callaudit.app',
  'closer.teste@callaudit.app',
  'sandra.saviotti110772@gmail.com',
  'matheuslopezmedeiros@gmail.com'
);

-- Verify the fix
SELECT
  email,
  aud,
  role,
  email_confirmed_at IS NOT NULL AS confirmed,
  banned_until IS NULL AS not_banned,
  deleted_at IS NULL AS not_deleted,
  is_sso_user = false AS password_login_allowed
FROM auth.users
WHERE email IN (
  'miguelgsaviotti29@gmail.com',
  'supervisor.teste@callaudit.app',
  'closer.teste@callaudit.app',
  'sandra.saviotti110772@gmail.com',
  'matheuslopezmedeiros@gmail.com'
)
ORDER BY email;
