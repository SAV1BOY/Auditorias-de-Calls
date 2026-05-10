-- ═══════════════════════════════════════════════════════════════
-- Script 02: Auth Users Migration
-- Execute AFTER 01_full_schema.sql in the new Supabase project
-- This must be run BEFORE data migration (profiles depend on auth.users)
-- ═══════════════════════════════════════════════════════════════

-- Disable the handle_new_user trigger (we're importing profiles separately)
ALTER TABLE auth.users DISABLE TRIGGER on_auth_user_created;

-- Insert 5 auth users with preserved UUIDs and password hashes
INSERT INTO auth.users (
  id, instance_id, email, encrypted_password, email_confirmed_at,
  invited_at, confirmation_token, recovery_token, recovery_sent_at,
  last_sign_in_at, raw_user_meta_data, raw_app_meta_data,
  is_super_admin, created_at, updated_at, phone,
  phone_change, phone_change_token, email_change_token_new, email_change,
  email_change_token_current, email_change_confirm_status,
  banned_until, reauthentication_token, is_sso_user, deleted_at, role, is_anonymous
) VALUES
-- 1. Admin: miguelgsaviotti29@gmail.com
(
  'fca79260-6922-4c01-b236-9b4c63b837e9',
  '00000000-0000-0000-0000-000000000000',
  'miguelgsaviotti29@gmail.com',
  '$2a$10$MFAWcrdvXi2iDAfO4cyx5eua1f3tZDa6sEPcx3GBMAH4EBaYoJ6fC',
  '2026-03-23 04:36:38.350539+00',
  NULL, '', '', '2026-03-26 17:50:14.843356+00',
  '2026-04-01 04:11:58.935543+00',
  '{"email_verified": true}'::jsonb,
  '{"provider": "email", "providers": ["email"]}'::jsonb,
  NULL, '2026-03-23 04:36:38.331395+00', '2026-04-01 20:41:06.071184+00', NULL,
  '', '', '', '', '', 0, NULL, '', false, NULL, 'authenticated', false
),
-- 2. Supervisor Teste
(
  'abac724d-6584-4339-831b-b20d501049ca',
  '00000000-0000-0000-0000-000000000000',
  'supervisor.teste@callaudit.app',
  '$2a$10$W9OAygDueVx1..Wdmft34OFRZIvGr9RD7kFmaKxjz80DwsLH4/RJy',
  '2026-03-26 17:46:20.965055+00',
  NULL, '', '', NULL,
  NULL,
  '{"full_name": "Supervisor Teste", "email_verified": true}'::jsonb,
  '{"provider": "email", "providers": ["email"]}'::jsonb,
  NULL, '2026-03-26 17:46:20.922155+00', '2026-03-26 17:46:20.968856+00', NULL,
  '', '', '', '', '', 0, NULL, '', false, NULL, 'authenticated', false
),
-- 3. Closer Teste
(
  '54b58b00-d426-4306-b564-8eb1b81df408',
  '00000000-0000-0000-0000-000000000000',
  'closer.teste@callaudit.app',
  '$2a$10$nobcPga17.BVImxC827/JuvDrdy8pdNVNr6SSa5zwEfyfYy1.p55S',
  '2026-03-26 17:46:21.728815+00',
  NULL, '', '', NULL,
  NULL,
  '{"full_name": "Closer Teste", "email_verified": true}'::jsonb,
  '{"provider": "email", "providers": ["email"]}'::jsonb,
  NULL, '2026-03-26 17:46:21.722898+00', '2026-03-26 17:46:21.729471+00', NULL,
  '', '', '', '', '', 0, NULL, '', false, NULL, 'authenticated', false
),
-- 4. Sandra Saviotti
(
  '06f36375-1f73-4a25-9ae9-3503989d13a2',
  '00000000-0000-0000-0000-000000000000',
  'sandra.saviotti110772@gmail.com',
  '$2a$10$uJz2OMZfC9jCjCn65uzG2ellCbBv53lU1wlM5UVsogArX1E2YqIyi',
  '2026-03-26 17:48:48.767912+00',
  '2026-03-26 17:47:13.124351+00', '', '', NULL,
  '2026-03-26 17:48:48.780523+00',
  '{"email_verified": true}'::jsonb,
  '{"provider": "email", "providers": ["email"]}'::jsonb,
  NULL, '2026-03-26 17:47:13.096495+00', '2026-03-26 17:48:48.803989+00', NULL,
  '', '', '', '', '', 0, NULL, '', false, NULL, 'authenticated', false
),
-- 5. Matheus Lopez
(
  '34f787c5-f3db-4b7a-bed1-26c1d17d7b13',
  '00000000-0000-0000-0000-000000000000',
  'matheuslopezmedeiros@gmail.com',
  '$2a$10$v5NDCu.T6eZ0n697JR4UiOOg52nyLoHZMsMDbFshg.VmJDElRCjj6',
  '2026-03-31 01:50:52.934365+00',
  NULL, '', '', NULL,
  NULL,
  '{"email_verified": true}'::jsonb,
  '{"provider": "email", "providers": ["email"]}'::jsonb,
  NULL, '2026-03-31 01:50:52.887417+00', '2026-03-31 01:50:52.935771+00', NULL,
  '', '', '', '', '', 0, NULL, '', false, NULL, 'authenticated', false
);

-- Insert auth identities (required for email/password login)
INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at) VALUES
(
  'e1dc684e-4811-42e6-a104-edee77057b49',
  'fca79260-6922-4c01-b236-9b4c63b837e9',
  '{"sub": "fca79260-6922-4c01-b236-9b4c63b837e9", "email": "miguelgsaviotti29@gmail.com", "email_verified": false, "phone_verified": false}'::jsonb,
  'email',
  'fca79260-6922-4c01-b236-9b4c63b837e9',
  '2026-03-23 04:36:38.346068+00',
  '2026-03-23 04:36:38.346126+00',
  '2026-03-23 04:36:38.346126+00'
),
(
  '73c1253d-6198-4e44-a4cd-d088ca75d4b8',
  'abac724d-6584-4339-831b-b20d501049ca',
  '{"sub": "abac724d-6584-4339-831b-b20d501049ca", "email": "supervisor.teste@callaudit.app", "email_verified": false, "phone_verified": false}'::jsonb,
  'email',
  'abac724d-6584-4339-831b-b20d501049ca',
  '2026-03-26 17:46:20.959565+00',
  '2026-03-26 17:46:20.960185+00',
  '2026-03-26 17:46:20.960185+00'
),
(
  '89493e94-5c76-4e86-a46d-d650bf52ddde',
  '54b58b00-d426-4306-b564-8eb1b81df408',
  '{"sub": "54b58b00-d426-4306-b564-8eb1b81df408", "email": "closer.teste@callaudit.app", "email_verified": false, "phone_verified": false}'::jsonb,
  'email',
  '54b58b00-d426-4306-b564-8eb1b81df408',
  '2026-03-26 17:46:21.725534+00',
  '2026-03-26 17:46:21.725584+00',
  '2026-03-26 17:46:21.725584+00'
),
(
  '3b775ddf-f0b0-40d7-827f-4e98436133b3',
  '06f36375-1f73-4a25-9ae9-3503989d13a2',
  '{"sub": "06f36375-1f73-4a25-9ae9-3503989d13a2", "email": "sandra.saviotti110772@gmail.com", "email_verified": true, "phone_verified": false}'::jsonb,
  'email',
  '06f36375-1f73-4a25-9ae9-3503989d13a2',
  '2026-03-26 17:47:13.119427+00',
  '2026-03-26 17:47:13.120166+00',
  '2026-03-26 17:47:13.120166+00'
),
(
  '9b6b8106-b2e9-4cf4-a31b-5d443a8778b7',
  '34f787c5-f3db-4b7a-bed1-26c1d17d7b13',
  '{"sub": "34f787c5-f3db-4b7a-bed1-26c1d17d7b13", "email": "matheuslopezmedeiros@gmail.com", "email_verified": false, "phone_verified": false}'::jsonb,
  'email',
  '34f787c5-f3db-4b7a-bed1-26c1d17d7b13',
  '2026-03-31 01:50:52.929304+00',
  '2026-03-31 01:50:52.929375+00',
  '2026-03-31 01:50:52.929375+00'
);

-- Re-enable the trigger
ALTER TABLE auth.users ENABLE TRIGGER on_auth_user_created;
