-- Migration 016: Fix v_supervisor_weakest_stages view
-- Uses MODE() for stage_name to handle GROUP BY correctly

CREATE OR REPLACE VIEW v_supervisor_weakest_stages AS
SELECT
  sss.stage_key,
  MODE() WITHIN GROUP (ORDER BY sss.stage_name) AS stage_name,
  ROUND(AVG(sss.score), 1) AS avg_score,
  COUNT(*) AS total_evaluations,
  COUNT(*) FILTER (WHERE sss.status = 'critical') AS critical_count,
  ROUND(AVG(sss.score) FILTER (WHERE sss.status = 'critical'), 1) AS avg_when_critical
FROM supervisor_stage_scores sss
JOIN supervisor_analyses sa ON sa.id = sss.analysis_id
WHERE sss.status <> 'skipped'
GROUP BY sss.stage_key
ORDER BY ROUND(AVG(sss.score), 1);
