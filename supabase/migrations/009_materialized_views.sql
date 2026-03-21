-- ═══════════════════════════════════════════════════════════════
-- Migration 009: Materialized Views for Dashboard Performance
-- Replaces regular views with materialized views + refresh logic
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. Drop regular views ───
DROP VIEW IF EXISTS v_dashboard_stats;
DROP VIEW IF EXISTS v_closer_performance;

-- ─── 2. Create materialized views ───

CREATE MATERIALIZED VIEW mv_dashboard_stats AS
SELECT
  organization_id,
  COUNT(*) as total_calls,
  COUNT(*) FILTER (WHERE status = 'completed') as calls_completas,
  COUNT(*) FILTER (WHERE status IN ('uploaded','transcribing','transcribed','analyzing','analyzed','notifying')) as calls_em_processamento,
  ROUND(AVG(score_final) FILTER (WHERE score_final IS NOT NULL), 1) as media_score,
  COUNT(*) FILTER (WHERE resultado = 'fechamento') as total_fechamentos,
  ROUND(
    COUNT(*) FILTER (WHERE resultado = 'fechamento')::NUMERIC /
    NULLIF(COUNT(*) FILTER (WHERE resultado IS NOT NULL), 0) * 100, 1
  ) as taxa_fechamento_pct,
  COUNT(*) FILTER (WHERE classificacao = 'ELITE') as calls_elite,
  COUNT(*) FILTER (WHERE classificacao = 'FORTE') as calls_forte,
  COUNT(*) FILTER (WHERE classificacao = 'MEDIANA') as calls_mediana,
  COUNT(*) FILTER (WHERE classificacao = 'FRACA') as calls_fraca
FROM call_audits
GROUP BY organization_id;

CREATE UNIQUE INDEX idx_mv_dashboard_stats_org ON mv_dashboard_stats(organization_id);

CREATE MATERIALIZED VIEW mv_closer_performance AS
SELECT
  c.id as closer_id,
  c.name as closer_name,
  c.organization_id,
  COUNT(ca.id) as total_calls,
  ROUND(AVG(ca.score_final), 1) as media_score,
  ROUND(MIN(ca.score_final), 1) as pior_score,
  ROUND(MAX(ca.score_final), 1) as melhor_score,
  COUNT(*) FILTER (WHERE ca.resultado = 'fechamento') as fechamentos,
  ROUND(AVG(ca.d01_frame), 1) as avg_d01,
  ROUND(AVG(ca.d02_qualificacao), 1) as avg_d02,
  ROUND(AVG(ca.d03_diag_quantitativo), 1) as avg_d03,
  ROUND(AVG(ca.d04_diag_qualitativo), 1) as avg_d04,
  ROUND(AVG(ca.d05_consequencia), 1) as avg_d05,
  ROUND(AVG(ca.d06_ensino), 1) as avg_d06,
  ROUND(AVG(ca.d07_identidade), 1) as avg_d07,
  ROUND(AVG(ca.d08_ancoragem), 1) as avg_d08,
  ROUND(AVG(ca.d09_isolamento), 1) as avg_d09,
  ROUND(AVG(ca.d10_proporcao_fala), 1) as avg_d10,
  ROUND(AVG(ca.d11_promessas), 1) as avg_d11,
  ROUND(AVG(ca.d12_checkpoints), 1) as avg_d12,
  ROUND(AVG(ca.d13_fechamento), 1) as avg_d13
FROM closers c
LEFT JOIN call_audits ca ON ca.closer_id = c.id AND ca.status = 'completed'
GROUP BY c.id, c.name, c.organization_id;

CREATE UNIQUE INDEX idx_mv_closer_performance_closer ON mv_closer_performance(closer_id);

-- ─── 3. Create backward-compatible regular views ───
-- These point to the materialized views so existing queries don't break

CREATE OR REPLACE VIEW v_dashboard_stats AS
  SELECT * FROM mv_dashboard_stats;

CREATE OR REPLACE VIEW v_closer_performance AS
  SELECT * FROM mv_closer_performance;

-- ─── 4. Refresh function ───

CREATE OR REPLACE FUNCTION refresh_dashboard_views()
RETURNS void AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY mv_dashboard_stats;
  REFRESH MATERIALIZED VIEW CONCURRENTLY mv_closer_performance;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─── 5. Auto-refresh trigger ───
-- Refresh views when an audit reaches completed status

CREATE OR REPLACE FUNCTION trigger_refresh_on_audit_complete()
RETURNS TRIGGER AS $$
BEGIN
  -- Only refresh when status changes to 'completed' or 'analyzed'
  IF NEW.status IN ('completed', 'analyzed') AND (OLD.status IS DISTINCT FROM NEW.status) THEN
    PERFORM refresh_dashboard_views();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trigger_audit_refresh_views
  AFTER UPDATE OF status ON call_audits
  FOR EACH ROW EXECUTE FUNCTION trigger_refresh_on_audit_complete();

-- ─── 6. Initial refresh ───
SELECT refresh_dashboard_views();
