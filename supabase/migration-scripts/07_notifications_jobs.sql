-- ═══════════════════════════════════════════════════════════════
-- Script 07: Notifications and Job Queue
-- Execute AFTER 05_call_audits_data.sql (FK references call_audits.id)
-- ═══════════════════════════════════════════════════════════════

-- Disable the on_job_inserted trigger to prevent calling Edge Function during migration
-- (Note: trigger has WHEN status='pending' filter; our data is 'completed', so it wouldn't fire anyway)
ALTER TABLE job_queue DISABLE TRIGGER on_job_inserted;

-- ═══════════════════════════════════════
-- notifications (5 rows)
-- ═══════════════════════════════════════
INSERT INTO notifications (id, audit_id, channel, recipient, content, status, sent_at) VALUES
('5784a8df-8d1c-43fd-9b63-59d9925b9b53', 'bef46d54-8c64-4403-9f59-d0eda47e0065', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:46.757972+00:00'),
('f5d7486c-b2b2-4025-8171-8bfb54198bcb', '94f54fba-e9e5-4756-9d2f-83af7e1d7a73', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:48.002557+00:00'),
('be5d0483-f985-487f-af12-e6690ed829c9', '35597e31-aa45-4026-b864-84d53f13a2cc', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:48.847046+00:00'),
('10781087-1818-4abc-8570-bb4ddc004bd5', 'e9a06962-8693-4977-b0aa-69d6df9552ed', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T04:34:49.542122+00:00'),
('a6441a77-07a2-44e2-84dd-98f990eb0d85', '2803799a-e97b-48f1-a144-078cf8a66124', 'email', 'miguelgsaviotti29@gmail.com', NULL, 'sent', '2026-03-25T10:09:11.377358+00:00')
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════
-- job_queue (20 rows)
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
('de670ef2-fd67-498a-967d-8b7fd7840d54', '35597e31-aa45-4026-b864-84d53f13a2cc', 'supervisor_analyze', 'completed', 0, 3, NULL, '2026-03-28T01:30:34.207+00:00', '2026-03-28T01:34:37.77764+00:00', '2026-03-28T01:30:33.115285+00:00')
ON CONFLICT (id) DO NOTHING;

-- Re-enable trigger
ALTER TABLE job_queue ENABLE TRIGGER on_job_inserted;

-- Refresh materialized views with the new data
REFRESH MATERIALIZED VIEW mv_dashboard_stats;
REFRESH MATERIALIZED VIEW mv_closer_performance;

-- Final verification
SELECT 'organizations' as tbl, COUNT(*) AS rows FROM organizations
UNION ALL SELECT 'profiles', COUNT(*) FROM profiles
UNION ALL SELECT 'closers', COUNT(*) FROM closers
UNION ALL SELECT 'call_audits', COUNT(*) FROM call_audits
UNION ALL SELECT 'job_queue', COUNT(*) FROM job_queue
UNION ALL SELECT 'notifications', COUNT(*) FROM notifications
UNION ALL SELECT 'supervisor_analyses', COUNT(*) FROM supervisor_analyses
UNION ALL SELECT 'supervisor_stage_scores', COUNT(*) FROM supervisor_stage_scores
UNION ALL SELECT 'protocol_rules', COUNT(*) FROM protocol_rules
UNION ALL SELECT 'app_config', COUNT(*) FROM app_config
UNION ALL SELECT 'badges', COUNT(*) FROM badges
UNION ALL SELECT 'auth.users', COUNT(*) FROM auth.users
ORDER BY tbl;
