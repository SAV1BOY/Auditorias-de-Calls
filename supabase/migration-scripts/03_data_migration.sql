-- ═══════════════════════════════════════════════════════════════
-- Script 03: Data Migration (FIXED)
-- Execute AFTER 02_auth_migration.sql
--
-- Notes:
-- * organizations was already inserted in 02_auth_migration.sql
-- * profiles were auto-created by handle_new_user trigger; we UPSERT correct data
-- * Triggers on call_audits only fire on UPDATE, no need to disable for INSERT
-- * job_queue trigger on_job_inserted only fires WHEN status='pending'; our data is 'completed'
-- ═══════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════
-- 1. organizations (1 row) - idempotent
-- ═══════════════════════════════════════
INSERT INTO organizations (id, name, slug, created_at) VALUES
('4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'CallAudit', 'callaudit', '2026-03-23T01:28:17.318575+00:00')
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════
-- 2. profiles (5 rows) - UPSERT (overwrite trigger-created defaults)
-- ═══════════════════════════════════════
INSERT INTO profiles (id, organization_id, full_name, role, avatar_url, created_at) VALUES
('fca79260-6922-4c01-b236-9b4c63b837e9', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Miguel Saviotti', 'admin', NULL, '2026-03-23T04:36:38.329865+00:00'),
('abac724d-6584-4339-831b-b20d501049ca', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Supervisor Teste', 'supervisor', NULL, '2026-03-26T17:46:20.921775+00:00'),
('54b58b00-d426-4306-b564-8eb1b81df408', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Closer Teste', 'closer', NULL, '2026-03-26T17:46:21.722573+00:00'),
('06f36375-1f73-4a25-9ae9-3503989d13a2', NULL, 'sandra.saviotti110772@gmail.com', 'viewer', NULL, '2026-03-26T17:47:13.094552+00:00'),
('34f787c5-f3db-4b7a-bed1-26c1d17d7b13', NULL, 'matheuslopezmedeiros@gmail.com', 'viewer', NULL, '2026-03-31T01:50:52.885053+00:00')
ON CONFLICT (id) DO UPDATE SET
  organization_id = EXCLUDED.organization_id,
  full_name = EXCLUDED.full_name,
  role = EXCLUDED.role,
  avatar_url = EXCLUDED.avatar_url,
  created_at = EXCLUDED.created_at;

-- ═══════════════════════════════════════
-- 3. closers (1 row)
-- ═══════════════════════════════════════
INSERT INTO closers (id, organization_id, name, email, whatsapp, avatar_url, active, created_at, notification_emails) VALUES
('171a0543-1dde-4ba4-99f8-d396c6832b60', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Evelyn', 'elane@teste.com', NULL, NULL, true, '2026-03-25T03:43:25.6802+00:00', '{}')
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════
-- 4. app_config (2 rows)
-- ═══════════════════════════════════════
INSERT INTO app_config (id, organization_id, key, value, updated_at) VALUES
('3aded9a4-4016-44f4-b039-39f29a1a7ca9', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'notification_recipients', '{"email_addresses": ["miguelgsaviotti29@gmail.com"], "whatsapp_numbers": []}', '2026-03-25T04:34:15.367772+00:00'),
('d72a79ac-b43d-4ace-b400-f0997efc0071', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'dimension_weights', '{"d01_frame": 8, "d06_ensino": 5, "d08_ancoragem": 10, "d11_promessas": 8, "d07_identidade": 5, "d09_isolamento": 10, "d13_fechamento": 3, "d12_checkpoints": 3, "d02_qualificacao": 10, "d05_consequencia": 10, "d10_proporcao_fala": 8, "d04_diag_qualitativo": 8, "d03_diag_quantitativo": 12}', '2026-03-31T01:43:00.809595+00:00')
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════
-- 5. badges - DELETE seeded + INSERT with original UUIDs
-- ═══════════════════════════════════════
DELETE FROM badges;
INSERT INTO badges (id, organization_id, slug, name, description, icon, category, criteria, created_at) VALUES
('f33340ad-b4bf-458e-8599-c20d37ada9ad', NULL, 'first_elite', 'Primeira ELITE', 'Primeira call classificada como ELITE', 'award', 'score', '{"type": "classificacao", "count": 1, "value": "ELITE"}', '2026-03-23T01:24:06.92182+00:00'),
('cca98a48-9e4b-4ba2-9100-e7f578a2d3e5', NULL, 'triple_elite', 'Trifecta ELITE', '3 calls ELITE consecutivas', 'trophy', 'score', '{"type": "classificacao", "count": 3, "value": "ELITE"}', '2026-03-23T01:24:06.92182+00:00'),
('2f0a29f7-0c5a-4e02-9cb4-b09d91af9abe', NULL, 'ten_elite', 'Clube ELITE', '10 calls classificadas como ELITE', 'crown', 'score', '{"type": "classificacao", "count": 10, "value": "ELITE"}', '2026-03-23T01:24:06.92182+00:00'),
('a008ebd5-67dc-4f3f-b0e9-3b47232f9fd1', NULL, 'perfect_dimension', 'Dimensão Perfeita', 'Qualquer dimensão com nota 10.0', 'star', 'dimension', '{"type": "dimension_perfect", "value": 10.0}', '2026-03-23T01:24:06.92182+00:00'),
('ba416bf5-4904-42e2-9bfd-0e520c0d4c33', NULL, 'streak_3', 'Sequência de 3', '3 calls consecutivas acima de 7.0', 'flame', 'streak', '{"type": "streak_above", "count": 3, "threshold": 7.0}', '2026-03-23T01:24:06.92182+00:00'),
('4c462cd5-763d-4a06-8b7c-54bb9a434788', NULL, 'streak_5', 'Sequência de 5', '5 calls consecutivas acima de 7.0', 'flame', 'streak', '{"type": "streak_above", "count": 5, "threshold": 7.0}', '2026-03-23T01:24:06.92182+00:00'),
('103b6ffb-7ee5-4d8c-9b46-9a32b29ff772', NULL, 'streak_10', 'Imbatível', '10 calls consecutivas acima de 7.0', 'zap', 'streak', '{"type": "streak_above", "count": 10, "threshold": 7.0}', '2026-03-23T01:24:06.92182+00:00'),
('e11d3e61-54c6-437c-bac1-48ec8f6f9360', NULL, 'first_fechamento', 'Primeiro Fechamento', 'Primeira call com resultado "fechamento"', 'check-circle', 'volume', '{"type": "resultado", "count": 1, "value": "fechamento"}', '2026-03-23T01:24:06.92182+00:00'),
('50c3606c-b9f9-45ac-a497-bb9f08506a76', NULL, 'improvement_20pct', 'Evolução 20%', 'Score médio melhorou 20% em 30 dias', 'trending-up', 'special', '{"pct": 20, "days": 30, "type": "improvement"}', '2026-03-23T01:24:06.92182+00:00'),
('9d51ce17-4272-44c4-a7a3-71c41581ba8d', NULL, 'closer_of_week', 'Closer da Semana', 'Maior média semanal entre closers', 'medal', 'special', '{"type": "weekly_best"}', '2026-03-23T01:24:06.92182+00:00');

SELECT 'Data migration step complete. Run 05_call_audits_data.sql next.' AS status;
