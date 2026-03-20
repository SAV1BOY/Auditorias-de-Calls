-- ═══════════════════════════════════════
-- Migration 003: Goals / OKRs
-- ═══════════════════════════════════════

CREATE TABLE goals (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  title TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('individual', 'team', 'dimension')),
  metric TEXT NOT NULL CHECK (metric IN ('score_avg', 'score_min', 'classificacao_count', 'taxa_fechamento', 'dimension_avg')),
  target_value NUMERIC(5,2) NOT NULL,
  dimension_id TEXT,
  closer_id UUID REFERENCES closers(id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'failed')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_goals_status ON goals(status) WHERE status = 'active';
CREATE INDEX idx_goals_closer ON goals(closer_id);

ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_select" ON goals FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON goals FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON goals FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete" ON goals FOR DELETE TO authenticated USING (true);

CREATE TRIGGER trigger_goals_updated
  BEFORE UPDATE ON goals FOR EACH ROW EXECUTE FUNCTION update_updated_at();
