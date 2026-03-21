-- Migration 006: Sentiment analysis columns + Loss patterns table
-- Sprint 11 — Análise de Sentimento + Padrões de Perda

-- Sentimento do lead (colunas novas em call_audits)
ALTER TABLE call_audits
  ADD COLUMN IF NOT EXISTS sentiment_overall TEXT CHECK (sentiment_overall IN ('positive','neutral','negative','mixed')),
  ADD COLUMN IF NOT EXISTS sentiment_timeline JSONB DEFAULT '[]',
  ADD COLUMN IF NOT EXISTS sentiment_score NUMERIC(3,2),
  ADD COLUMN IF NOT EXISTS engagement_level TEXT CHECK (engagement_level IN ('high','medium','low')),
  ADD COLUMN IF NOT EXISTS objections_detected JSONB DEFAULT '[]';

-- Padrões de perda
CREATE TABLE loss_patterns (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  total_lost_calls INTEGER NOT NULL,
  patterns JSONB NOT NULL DEFAULT '[]',
  common_objections JSONB DEFAULT '[]',
  weakest_phases JSONB DEFAULT '[]',
  report_markdown TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_loss_patterns_period ON loss_patterns(period_start DESC);

ALTER TABLE loss_patterns ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all_loss_patterns" ON loss_patterns FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Atualizar constraint de job_type para incluir novos tipos
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe','analyze','notify','weekly_report','loss_pattern'));
