-- Migration 005: Gamification tables (badges, streaks, competitions)
-- Sprint 11 — Gamificação e Ranking

-- Definições de badges
CREATE TABLE badges (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  icon TEXT NOT NULL DEFAULT 'trophy',
  category TEXT NOT NULL CHECK (category IN ('score','streak','volume','dimension','special')),
  criteria JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Badges conquistados por closers
CREATE TABLE closer_badges (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  closer_id UUID NOT NULL REFERENCES closers(id) ON DELETE CASCADE,
  badge_id UUID NOT NULL REFERENCES badges(id) ON DELETE CASCADE,
  audit_id UUID REFERENCES call_audits(id),
  earned_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(closer_id, badge_id, audit_id)
);

-- Streaks (sequências) de closers
CREATE TABLE closer_streaks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  closer_id UUID NOT NULL REFERENCES closers(id) ON DELETE CASCADE,
  streak_type TEXT NOT NULL CHECK (streak_type IN ('daily_above_7','consecutive_elite','consecutive_forte','weekly_improvement')),
  current_count INTEGER NOT NULL DEFAULT 0,
  best_count INTEGER NOT NULL DEFAULT 0,
  last_audit_id UUID REFERENCES call_audits(id),
  last_updated TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(closer_id, streak_type)
);

-- Competições entre closers
CREATE TABLE competitions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  title TEXT NOT NULL,
  description TEXT,
  metric TEXT NOT NULL CHECK (metric IN ('score_avg','score_count_above','taxa_fechamento','volume','improvement')),
  metric_params JSONB DEFAULT '{}',
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('upcoming','active','completed')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX idx_closer_badges_closer ON closer_badges(closer_id);
CREATE INDEX idx_closer_badges_badge ON closer_badges(badge_id);
CREATE INDEX idx_closer_streaks_closer ON closer_streaks(closer_id);
CREATE INDEX idx_competitions_status ON competitions(status) WHERE status = 'active';

-- RLS
ALTER TABLE badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE closer_badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE closer_streaks ENABLE ROW LEVEL SECURITY;
ALTER TABLE competitions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated_read_badges" ON badges FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_all_badges" ON badges FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all_closer_badges" ON closer_badges FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all_closer_streaks" ON closer_streaks FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all_competitions" ON competitions FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Seed: badges iniciais
INSERT INTO badges (slug, name, description, icon, category, criteria) VALUES
  ('first_elite', 'Primeira ELITE', 'Primeira call classificada como ELITE', 'award', 'score', '{"type":"classificacao","value":"ELITE","count":1}'),
  ('triple_elite', 'Trifecta ELITE', '3 calls ELITE consecutivas', 'trophy', 'score', '{"type":"classificacao","value":"ELITE","count":3}'),
  ('ten_elite', 'Clube ELITE', '10 calls classificadas como ELITE', 'crown', 'score', '{"type":"classificacao","value":"ELITE","count":10}'),
  ('perfect_dimension', 'Dimensão Perfeita', 'Qualquer dimensão com nota 10.0', 'star', 'dimension', '{"type":"dimension_perfect","value":10.0}'),
  ('streak_3', 'Sequência de 3', '3 calls consecutivas acima de 7.0', 'flame', 'streak', '{"type":"streak_above","threshold":7.0,"count":3}'),
  ('streak_5', 'Sequência de 5', '5 calls consecutivas acima de 7.0', 'flame', 'streak', '{"type":"streak_above","threshold":7.0,"count":5}'),
  ('streak_10', 'Imbatível', '10 calls consecutivas acima de 7.0', 'zap', 'streak', '{"type":"streak_above","threshold":7.0,"count":10}'),
  ('first_fechamento', 'Primeiro Fechamento', 'Primeira call com resultado "fechamento"', 'check-circle', 'volume', '{"type":"resultado","value":"fechamento","count":1}'),
  ('improvement_20pct', 'Evolução 20%', 'Score médio melhorou 20% em 30 dias', 'trending-up', 'special', '{"type":"improvement","pct":20,"days":30}'),
  ('closer_of_week', 'Closer da Semana', 'Maior média semanal entre closers', 'medal', 'special', '{"type":"weekly_best"}');
