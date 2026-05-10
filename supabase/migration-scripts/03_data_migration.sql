-- ═══════════════════════════════════════════════════════════════
-- Script 03: Data Migration (small tables)
-- Execute AFTER 02_auth_migration.sql
-- NOTE: call_audits and supervisor data are in separate scripts
-- ═══════════════════════════════════════════════════════════════

-- Disable triggers that would interfere with data import
ALTER TABLE call_audits DISABLE TRIGGER ALL;
ALTER TABLE job_queue DISABLE TRIGGER ALL;
ALTER TABLE goals DISABLE TRIGGER ALL;

-- ═══════════════════════════════════════
-- 1. organizations (1 row)
-- ═══════════════════════════════════════
INSERT INTO organizations (id, name, slug, created_at) VALUES
('4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'CallAudit', 'callaudit', '2026-03-23T01:28:17.318575+00:00');

-- ═══════════════════════════════════════
-- 2. profiles (5 rows)
-- ═══════════════════════════════════════
INSERT INTO profiles (id, organization_id, full_name, role, avatar_url, created_at) VALUES
('fca79260-6922-4c01-b236-9b4c63b837e9', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Miguel Saviotti', 'admin', NULL, '2026-03-23T04:36:38.329865+00:00'),
('abac724d-6584-4339-831b-b20d501049ca', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Supervisor Teste', 'supervisor', NULL, '2026-03-26T17:46:20.921775+00:00'),
('54b58b00-d426-4306-b564-8eb1b81df408', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Closer Teste', 'closer', NULL, '2026-03-26T17:46:21.722573+00:00'),
('06f36375-1f73-4a25-9ae9-3503989d13a2', NULL, 'sandra.saviotti110772@gmail.com', 'viewer', NULL, '2026-03-26T17:47:13.094552+00:00'),
('34f787c5-f3db-4b7a-bed1-26c1d17d7b13', NULL, 'matheuslopezmedeiros@gmail.com', 'viewer', NULL, '2026-03-31T01:50:52.885053+00:00');

-- ═══════════════════════════════════════
-- 3. closers (1 row)
-- ═══════════════════════════════════════
INSERT INTO closers (id, organization_id, name, email, whatsapp, avatar_url, active, created_at, notification_emails) VALUES
('171a0543-1dde-4ba4-99f8-d396c6832b60', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'Evelyn', 'elane@teste.com', NULL, NULL, true, '2026-03-25T03:43:25.6802+00:00', '{}');

-- ═══════════════════════════════════════
-- 4. app_config (2 rows)
-- ═══════════════════════════════════════
INSERT INTO app_config (id, organization_id, key, value, updated_at) VALUES
('3aded9a4-4016-44f4-b039-39f29a1a7ca9', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'notification_recipients', '{"email_addresses": ["miguelgsaviotti29@gmail.com"], "whatsapp_numbers": []}', '2026-03-25T04:34:15.367772+00:00'),
('d72a79ac-b43d-4ace-b400-f0997efc0071', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', 'dimension_weights', '{"d01_frame": 8, "d06_ensino": 5, "d08_ancoragem": 10, "d11_promessas": 8, "d07_identidade": 5, "d09_isolamento": 10, "d13_fechamento": 3, "d12_checkpoints": 3, "d02_qualificacao": 10, "d05_consequencia": 10, "d10_proporcao_fala": 8, "d04_diag_qualitativo": 8, "d03_diag_quantitativo": 12}', '2026-03-31T01:43:00.809595+00:00');

-- ═══════════════════════════════════════
-- 5. notifications (5 rows)
-- ═══════════════════════════════════════
INSERT INTO notifications (id, audit_id, channel, recipient, content, status, sent_at) VALUES
('5784a8df-8d1c-43fd-9b63-59d9925b9b53', 'bef46d54-8c64-4403-9f59-d0eda47e0065', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:46.757972+00:00'),
('f5d7486c-b2b2-4025-8171-8bfb54198bcb', '94f54fba-e9e5-4756-9d2f-83af7e1d7a73', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:48.002557+00:00'),
('be5d0483-f985-487f-af12-e6690ed829c9', '35597e31-aa45-4026-b864-84d53f13a2cc', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:48.847046+00:00'),
('10781087-1818-4abc-8570-bb4ddc004bd5', 'e9a06962-8693-4977-b0aa-69d6df9552ed', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:49.542122+00:00'),
('a6441a77-07a2-44e2-84dd-98f990eb0d85', '2803799a-e97b-48f1-a144-078cf8a66124', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T10:09:11.377358+00:00');

-- ═══════════════════════════════════════
-- 6. job_queue (20 rows)
-- ═══════════════════════════════════════
INSERT INTO job_queue (id, audit_id, job_type, status, attempts, max_attempts, error_message, started_at, completed_at, created_at) VALUES
('9fcd61d2-8fb4-4309-be26-013684c78cbb', '35597e31-aa45-4026-b864-84d53f13a2cc', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-25T04:35:07.184543+00:00', '2026-03-25T04:24:44.819225+00:00'),
('186db177-73c1-4569-836d-1a9cb1acf381', '94f54fba-e9e5-4756-9d2f-83af7e1d7a73', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-25T04:35:07.184543+00:00', '2026-03-25T04:22:47.837312+00:00'),
('b077af3f-2e21-49fe-9618-0bfef957c566', 'bef46d54-8c64-4403-9f59-d0eda47e0065', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-25T04:35:07.184543+00:00', '2026-03-25T04:20:16.966515+00:00'),
('c34d7bd5-e05f-45a7-9c28-328ba512568d', 'e9a06962-8693-4977-b0aa-69d6df9552ed', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-25T04:35:07.184543+00:00', '2026-03-25T04:26:40.713217+00:00'),
('21f2023b-d71e-43d0-b9de-6fc11a57270f', '700a5a81-9324-448f-b2a8-8ffe57259645', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-28T19:38:53.269787+00:00', '2026-03-28T17:19:37.444615+00:00'),
('7ce8c32f-1a6c-4c27-bc18-4d095c6a77d1', '30b18ba9-fdc1-4f4d-b812-9eb667c2a54b', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-28T19:38:53.269787+00:00', '2026-03-28T17:22:41.981661+00:00'),
('8036c366-650b-4b11-80c8-95733d070dd3', '2803799a-e97b-48f1-a144-078cf8a66124', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-28T19:38:53.269787+00:00', '2026-03-28T17:25:27.803069+00:00'),
('0633b287-1eec-447d-b22b-859d5d6ff38e', '06cf2436-1314-417b-811e-c067dfdbf9f8', 'notify', 'completed', 0, 3, NULL, NULL, '2026-03-28T19:38:53.269787+00:00', '2026-03-28T17:27:45.252796+00:00'),
('3a9eac66-f764-4d84-8eb7-d160f80c2019', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'analyze', 'completed', 0, 3, NULL, '2026-03-29T23:22:05.429+00:00', '2026-03-29T23:23:33.328+00:00', '2026-03-29T23:22:04.870895+00:00'),
('6fa727c4-ffb2-46a9-b689-d407c1235e73', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:23:33.489+00:00', '2026-03-29T23:23:33.711+00:00', '2026-03-29T23:23:33.311111+00:00'),
('3360cb0b-eb2b-415e-9f8b-889045d6a904', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:30:12.694+00:00', '2026-03-29T23:30:12.918+00:00', '2026-03-29T23:30:12.5181+00:00'),
('26ed4198-1a8d-402a-b06f-3257057e5f0a', '5152361d-69e8-4188-bb97-a855c8227ac3', 'analyze', 'completed', 0, 3, NULL, '2026-03-29T23:29:38.694+00:00', '2026-03-29T23:31:11.841+00:00', '2026-03-29T23:29:38.240772+00:00'),
('4703a75c-756e-4c5d-937f-6e2bc88aa259', '5152361d-69e8-4188-bb97-a855c8227ac3', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:31:12.119+00:00', '2026-03-29T23:31:12.462+00:00', '2026-03-29T23:31:11.769688+00:00'),
('f14950a9-2d83-499e-83fc-76941a65dacd', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'analyze', 'completed', 0, 3, NULL, '2026-03-29T23:31:51.151+00:00', '2026-03-29T23:33:33.535+00:00', '2026-03-29T23:31:51.022046+00:00'),
('cbc77505-aefa-48c5-b736-5a54a4bda4f1', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:33:33.64+00:00', '2026-03-29T23:33:33.852+00:00', '2026-03-29T23:33:33.518031+00:00'),
('856d9407-99c4-4045-9f85-eb34b37b213a', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:36:22.155+00:00', '2026-03-29T23:36:22.394+00:00', '2026-03-29T23:36:21.711942+00:00'),
('cba5641f-8829-4762-828d-e36769494d7d', 'c110e38a-7b0b-4b90-910e-0222be95455f', 'notify', 'completed', 0, 3, NULL, '2026-03-29T23:40:15.945+00:00', '2026-03-29T23:40:16.155+00:00', '2026-03-29T23:40:15.497212+00:00'),
('281f40b6-7674-4b4d-8709-aca41fb8ccb4', 'bef46d54-8c64-4403-9f59-d0eda47e0065', 'analyze', 'completed', 0, 3, NULL, '2026-03-28T01:19:01.405+00:00', '2026-03-28T01:21:28.082+00:00', '2026-03-25T03:43:52.030036+00:00'),
('4e516b78-25ea-40c6-b6df-44c9b4559b58', 'bef46d54-8c64-4403-9f59-d0eda47e0065', 'notify', 'completed', 0, 3, NULL, '2026-03-28T01:21:28.499+00:00', '2026-03-28T01:21:28.67+00:00', '2026-03-28T01:21:28.026589+00:00'),
('de670ef2-fd67-498a-967d-8b7fd7840d54', '35597e31-aa45-4026-b864-84d53f13a2cc', 'supervisor_analyze', 'completed', 0, 3, NULL, '2026-03-28T01:30:34.207+00:00', '2026-03-28T01:34:37.77764+00:00', '2026-03-28T01:30:33.115285+00:00');

-- ═══════════════════════════════════════
-- 7. Delete seeded badges (schema creates them with new UUIDs, we need original UUIDs)
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

-- ═══════════════════════════════════════
-- Re-enable triggers
-- ═══════════════════════════════════════
ALTER TABLE call_audits ENABLE TRIGGER ALL;
ALTER TABLE job_queue ENABLE TRIGGER ALL;
ALTER TABLE goals ENABLE TRIGGER ALL;

-- ═══════════════════════════════════════
-- NOTE: call_audits, supervisor_analyses, supervisor_stage_scores,
-- and protocol_rules data must be migrated separately using pg_dump
-- (see 04_README_data_migration.md for instructions)
-- ═══════════════════════════════════════
