-- CallAudit Initial Schema
-- Version 1.0 | March 2026
-- Execute this in Supabase SQL Editor

-- Organizações (para futuro multi-tenant)
CREATE TABLE organizations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Usuários (extends Supabase Auth)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  full_name TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'viewer', -- 'admin', 'supervisor', 'closer', 'viewer'
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Closers
CREATE TABLE closers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  name TEXT NOT NULL,
  email TEXT,
  whatsapp TEXT,
  avatar_url TEXT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Auditorias de Calls
CREATE TABLE call_audits (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  closer_id UUID REFERENCES closers(id),
  
  -- Identificação
  lead_name TEXT NOT NULL,
  call_date DATE NOT NULL,
  duration_minutes INTEGER,
  resultado TEXT CHECK (resultado IN ('fechamento', 'nao_fechou', 'reagendar', 'outro')),
  valor_fechamento NUMERIC(12,2),
  
  -- Status do pipeline
  status TEXT NOT NULL DEFAULT 'uploaded' 
    CHECK (status IN ('uploaded', 'transcribing', 'transcribed', 'analyzing', 'analyzed', 'notifying', 'completed', 'error')),
  error_message TEXT,
  
  -- Scores (13 dimensões)
  score_final NUMERIC(3,1),
  classificacao TEXT CHECK (classificacao IN ('ELITE', 'FORTE', 'MEDIANA', 'FRACA')),
  d01_frame NUMERIC(3,1),
  d02_qualificacao NUMERIC(3,1),
  d03_diag_quantitativo NUMERIC(3,1),
  d04_diag_qualitativo NUMERIC(3,1),
  d05_consequencia NUMERIC(3,1),
  d06_ensino NUMERIC(3,1),
  d07_identidade NUMERIC(3,1),
  d08_ancoragem NUMERIC(3,1),
  d09_isolamento NUMERIC(3,1),
  d10_proporcao_fala NUMERIC(3,1),
  d11_promessas NUMERIC(3,1),
  d12_checkpoints NUMERIC(3,1),
  d13_fechamento NUMERIC(3,1),
  
  -- Conteúdo
  transcricao TEXT,
  relatorio_completo TEXT,
  resumo_whatsapp TEXT,
  
  -- Estruturado (JSONB)
  top_erros JSONB DEFAULT '[]',
  top_acertos JSONB DEFAULT '[]',
  plano_acao JSONB DEFAULT '[]',
  frases_proibidas JSONB DEFAULT '[]',
  reescrita_falas JSONB DEFAULT '[]',
  mapa_frameworks JSONB DEFAULT '{}',
  fases_analise JSONB DEFAULT '[]',
  
  -- Storage
  audio_path TEXT, -- path no Supabase Storage
  audio_duration_seconds NUMERIC,
  drive_file_id TEXT, -- ID do arquivo no Google Drive
  drive_url TEXT, -- URL de acesso no Drive
  drive_report_url TEXT, -- URL do relatório no Drive
  
  -- Meta
  modelo_transcricao TEXT DEFAULT 'whisper-1',
  modelo_analise TEXT DEFAULT 'claude-sonnet-4',
  tokens_input INTEGER,
  tokens_output INTEGER,
  custo_estimado NUMERIC(8,4),
  
  -- Timestamps
  uploaded_at TIMESTAMPTZ DEFAULT NOW(),
  transcribed_at TIMESTAMPTZ,
  analyzed_at TIMESTAMPTZ,
  notified_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Fila de Jobs (processamento assíncrono)
CREATE TABLE job_queue (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID REFERENCES call_audits(id) ON DELETE CASCADE,
  job_type TEXT NOT NULL CHECK (job_type IN ('transcribe', 'analyze', 'notify')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'failed')),
  attempts INTEGER DEFAULT 0,
  max_attempts INTEGER DEFAULT 3,
  error_message TEXT,
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Configurações
CREATE TABLE app_config (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  key TEXT NOT NULL,
  value JSONB NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(organization_id, key)
);

-- Notificações enviadas
CREATE TABLE notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID REFERENCES call_audits(id),
  channel TEXT NOT NULL CHECK (channel IN ('whatsapp', 'email')),
  recipient TEXT NOT NULL,
  content TEXT,
  status TEXT DEFAULT 'sent',
  sent_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sync bidirecional Google Drive <-> Supabase (anti-loop)
CREATE TABLE drive_sync (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  drive_file_id TEXT NOT NULL UNIQUE, -- ID do arquivo no Google Drive
  drive_folder_id TEXT,               -- ID da pasta (identifica o closer)
  audit_id UUID REFERENCES call_audits(id),
  file_name TEXT NOT NULL,
  origin TEXT NOT NULL CHECK (origin IN ('frontend', 'drive')),
    -- 'frontend': arquivo subiu pelo app e foi copiado pro Drive
    -- 'drive': arquivo subiu pelo Drive e foi copiado pro Supabase
  synced_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX idx_call_audits_org ON call_audits(organization_id);
CREATE INDEX idx_call_audits_closer ON call_audits(closer_id);
CREATE INDEX idx_call_audits_status ON call_audits(status);
CREATE INDEX idx_call_audits_date ON call_audits(call_date DESC);
CREATE INDEX idx_call_audits_score ON call_audits(score_final DESC);
CREATE INDEX idx_job_queue_status ON job_queue(status) WHERE status = 'pending';
CREATE INDEX idx_job_queue_audit ON job_queue(audit_id);
CREATE INDEX idx_drive_sync_file_id ON drive_sync(drive_file_id);
CREATE INDEX idx_drive_sync_audit ON drive_sync(audit_id);

-- Triggers
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_call_audits_updated
  BEFORE UPDATE ON call_audits
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Views
CREATE OR REPLACE VIEW v_dashboard_stats AS
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

CREATE OR REPLACE VIEW v_closer_performance AS
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

-- RLS Policies (ativar quando multi-tenant)
ALTER TABLE call_audits ENABLE ROW LEVEL SECURITY;
ALTER TABLE closers ENABLE ROW LEVEL SECURITY;
ALTER TABLE job_queue ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Storage Buckets
-- Criar via Supabase Dashboard:
-- Bucket: audios (private, max 500MB per file, allowed: audio/*)
-- Bucket: reports (private, max 10MB per file, allowed: application/pdf, text/*)
-- CallAudit RLS Policies — MVP (single-tenant)
-- Version 1.0 | March 2026
-- Execute this in Supabase SQL Editor AFTER 001_initial_schema.sql

-- Allow authenticated users full access (single-tenant MVP)
-- When multi-tenant: replace (true) with (organization_id = auth.jwt()->>'organization_id')

-- call_audits
CREATE POLICY "authenticated_select" ON call_audits FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON call_audits FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON call_audits FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- closers
CREATE POLICY "authenticated_select" ON closers FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON closers FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON closers FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- job_queue
CREATE POLICY "authenticated_select" ON job_queue FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON job_queue FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON job_queue FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- notifications
CREATE POLICY "authenticated_select" ON notifications FOR SELECT TO authenticated USING (true);

-- app_config
ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_select" ON app_config FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert" ON app_config FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update" ON app_config FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- drive_sync
ALTER TABLE drive_sync ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_select" ON drive_sync FOR SELECT TO authenticated USING (true);

-- profiles (RLS not yet enabled, but prepare for it)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users_read_own" ON profiles FOR SELECT TO authenticated USING (id = auth.uid());
CREATE POLICY "users_update_own" ON profiles FOR UPDATE TO authenticated USING (id = auth.uid()) WITH CHECK (id = auth.uid());

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role)
  VALUES (NEW.id, COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email), 'viewer');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
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
-- Migration 003: Create Storage bucket for audio files
-- Execute via Supabase Dashboard (SQL Editor) or CLI

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'audios',
  'audios',
  false,
  524288000, -- 500 MB
  ARRAY['audio/ogg', 'audio/mpeg', 'audio/mp4', 'audio/webm', 'audio/wav', 'audio/x-m4a']
);

-- Authenticated users can upload and read audios
CREATE POLICY "Auth users upload audios"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'audios');

CREATE POLICY "Auth users read audios"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'audios');

-- Authenticated users can delete their own audios
CREATE POLICY "Auth users delete audios"
  ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'audios');

-- Service role (worker) has full access
CREATE POLICY "Service role full access audios"
  ON storage.objects FOR ALL TO service_role
  USING (bucket_id = 'audios');
-- Sprint 9: Coaching e Treinamento
-- Tabelas: call_bookmarks, call_comments, weekly_reports
-- Atualização: job_type na job_queue

-- ============================================================
-- 1. call_bookmarks (Biblioteca de Calls Modelo)
-- ============================================================
CREATE TABLE call_bookmarks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  organization_id UUID REFERENCES organizations(id),
  bookmarked_by UUID REFERENCES profiles(id),
  tags TEXT[] DEFAULT '{}',
  highlight_timestamps JSONB DEFAULT '[]',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_call_bookmarks_audit ON call_bookmarks(audit_id);
CREATE INDEX idx_call_bookmarks_org ON call_bookmarks(organization_id);
CREATE INDEX idx_call_bookmarks_tags ON call_bookmarks USING GIN(tags);

ALTER TABLE call_bookmarks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON call_bookmarks
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- 2. call_comments (Coaching Assíncrono)
-- ============================================================
CREATE TABLE call_comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES profiles(id),
  parent_id UUID REFERENCES call_comments(id) ON DELETE CASCADE,
  timestamp_sec NUMERIC(8,1),
  content TEXT NOT NULL,
  resolved BOOLEAN DEFAULT FALSE,
  resolved_by UUID REFERENCES profiles(id),
  resolved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_call_comments_audit ON call_comments(audit_id);
CREATE INDEX idx_call_comments_parent ON call_comments(parent_id);
CREATE INDEX idx_call_comments_author ON call_comments(author_id);

ALTER TABLE call_comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON call_comments
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE TRIGGER trigger_call_comments_updated
  BEFORE UPDATE ON call_comments FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 3. weekly_reports (Resumo Executivo Semanal)
-- ============================================================
CREATE TABLE weekly_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  week_start DATE NOT NULL,
  week_end DATE NOT NULL,
  report_markdown TEXT NOT NULL,
  stats JSONB NOT NULL DEFAULT '{}',
  sent_whatsapp BOOLEAN DEFAULT FALSE,
  sent_email BOOLEAN DEFAULT FALSE,
  sent_at TIMESTAMPTZ,
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_weekly_reports_week ON weekly_reports(organization_id, week_start);

ALTER TABLE weekly_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON weekly_reports
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- 4. Atualizar job_type na job_queue
-- ============================================================
ALTER TABLE job_queue DROP CONSTRAINT job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report'));
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
-- ═══════════════════════════════════════════════════════════════
-- Migration 007: Multi-tenant RLS + Storage Isolation + Job Queue Lockdown
-- Replaces all USING (true) policies with organization_id filtering
-- ═══════════════════════════════════════════════════════════════

-- ─── Helper function: extract org_id from authenticated user's profile ───
-- Uses a subquery on profiles rather than JWT claims for reliability
-- (JWT claims require custom hook setup in Supabase)
CREATE OR REPLACE FUNCTION auth.org_id() RETURNS uuid AS $$
  SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- ═══════════════════════════════════════
-- 1. call_audits — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON call_audits;
DROP POLICY IF EXISTS "authenticated_insert" ON call_audits;
DROP POLICY IF EXISTS "authenticated_update" ON call_audits;

CREATE POLICY "org_select" ON call_audits FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON call_audits FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON call_audits FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 2. closers — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON closers;
DROP POLICY IF EXISTS "authenticated_insert" ON closers;
DROP POLICY IF EXISTS "authenticated_update" ON closers;

CREATE POLICY "org_select" ON closers FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON closers FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON closers FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 3. job_queue — LOCKDOWN: no direct authenticated access
-- Worker uses service_role. Frontend uses enqueue_job() stored procedure.
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON job_queue;
DROP POLICY IF EXISTS "authenticated_insert" ON job_queue;
DROP POLICY IF EXISTS "authenticated_update" ON job_queue;

-- Authenticated users can only read jobs for their org's audits
CREATE POLICY "org_select_via_audit" ON job_queue FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- No INSERT/UPDATE for authenticated users — use stored procedure instead

-- Stored procedure for enqueuing jobs (called from server actions)
CREATE OR REPLACE FUNCTION public.enqueue_job(
  p_audit_id UUID,
  p_job_type TEXT
) RETURNS UUID AS $$
DECLARE
  v_org_id UUID;
  v_job_id UUID;
BEGIN
  -- Verify the audit belongs to the user's organization
  SELECT organization_id INTO v_org_id
    FROM call_audits WHERE id = p_audit_id;

  IF v_org_id IS NULL THEN
    RAISE EXCEPTION 'Audit not found: %', p_audit_id;
  END IF;

  IF v_org_id != auth.org_id() THEN
    RAISE EXCEPTION 'Access denied: audit belongs to another organization';
  END IF;

  -- Insert the job
  INSERT INTO job_queue (audit_id, job_type, status)
    VALUES (p_audit_id, p_job_type, 'pending')
    RETURNING id INTO v_job_id;

  RETURN v_job_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ═══════════════════════════════════════
-- 4. notifications — org isolation via audit
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON notifications;

CREATE POLICY "org_select_via_audit" ON notifications FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- ═══════════════════════════════════════
-- 5. app_config — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON app_config;
DROP POLICY IF EXISTS "authenticated_insert" ON app_config;
DROP POLICY IF EXISTS "authenticated_update" ON app_config;

CREATE POLICY "org_select" ON app_config FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON app_config FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON app_config FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 6. drive_sync — org isolation via audit
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON drive_sync;

CREATE POLICY "org_select_via_audit" ON drive_sync FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );

-- ═══════════════════════════════════════
-- 7. call_bookmarks — org isolation + ownership
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON call_bookmarks;

CREATE POLICY "org_select" ON call_bookmarks FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON call_bookmarks FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id() AND bookmarked_by = auth.uid());
CREATE POLICY "owner_update" ON call_bookmarks FOR UPDATE TO authenticated
  USING (bookmarked_by = auth.uid()) WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "owner_delete" ON call_bookmarks FOR DELETE TO authenticated
  USING (bookmarked_by = auth.uid());

-- ═══════════════════════════════════════
-- 8. call_comments — org isolation + ownership for delete
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON call_comments;

-- Everyone in org can read comments
CREATE POLICY "org_select" ON call_comments FOR SELECT TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Authenticated users can create comments on their org's audits
CREATE POLICY "org_insert" ON call_comments FOR INSERT TO authenticated
  WITH CHECK (
    author_id = auth.uid()
    AND audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Anyone in org can update (resolve/unresolve) — RBAC enforced at app level
CREATE POLICY "org_update" ON call_comments FOR UPDATE TO authenticated
  USING (
    audit_id IN (
      SELECT id FROM call_audits WHERE organization_id = auth.org_id()
    )
  );
-- Only author can delete their own comments
CREATE POLICY "author_delete" ON call_comments FOR DELETE TO authenticated
  USING (author_id = auth.uid());

-- ═══════════════════════════════════════
-- 9. weekly_reports — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all" ON weekly_reports;

CREATE POLICY "org_select" ON weekly_reports FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON weekly_reports FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 10. badges — global read (badges are shared), org-scoped write
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_read_badges" ON badges;
DROP POLICY IF EXISTS "authenticated_all_badges" ON badges;

-- Badges are global definitions — everyone can read
CREATE POLICY "authenticated_read" ON badges FOR SELECT TO authenticated
  USING (true);
-- Only service_role (worker) writes badges

-- ═══════════════════════════════════════
-- 11. closer_badges — org isolation via closer
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_closer_badges" ON closer_badges;

CREATE POLICY "org_select_via_closer" ON closer_badges FOR SELECT TO authenticated
  USING (
    closer_id IN (
      SELECT id FROM closers WHERE organization_id = auth.org_id()
    )
  );
-- Only service_role (worker) writes closer_badges

-- ═══════════════════════════════════════
-- 12. closer_streaks — org isolation via closer
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_closer_streaks" ON closer_streaks;

CREATE POLICY "org_select_via_closer" ON closer_streaks FOR SELECT TO authenticated
  USING (
    closer_id IN (
      SELECT id FROM closers WHERE organization_id = auth.org_id()
    )
  );
-- Only service_role (worker) writes closer_streaks

-- ═══════════════════════════════════════
-- 13. competitions — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_competitions" ON competitions;

CREATE POLICY "org_select" ON competitions FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON competitions FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON competitions FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 14. goals — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_select" ON goals;
DROP POLICY IF EXISTS "authenticated_insert" ON goals;
DROP POLICY IF EXISTS "authenticated_update" ON goals;
DROP POLICY IF EXISTS "authenticated_delete" ON goals;

CREATE POLICY "org_select" ON goals FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
CREATE POLICY "org_insert" ON goals FOR INSERT TO authenticated
  WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_update" ON goals FOR UPDATE TO authenticated
  USING (organization_id = auth.org_id()) WITH CHECK (organization_id = auth.org_id());
CREATE POLICY "org_delete" ON goals FOR DELETE TO authenticated
  USING (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 15. loss_patterns — org isolation
-- ═══════════════════════════════════════
DROP POLICY IF EXISTS "authenticated_all_loss_patterns" ON loss_patterns;

CREATE POLICY "org_select" ON loss_patterns FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());
-- Only service_role (worker) writes loss_patterns

-- ═══════════════════════════════════════
-- 16. profiles — keep strict self-access + add org read
-- ═══════════════════════════════════════
-- Existing: users_read_own, users_update_own (keep these)
-- Add: users in same org can see each other's basic info
CREATE POLICY "org_read_profiles" ON profiles FOR SELECT TO authenticated
  USING (organization_id = auth.org_id());

-- ═══════════════════════════════════════
-- 17. Storage: org-scoped path isolation
-- ═══════════════════════════════════════
-- Audio files are stored under: {org_id}/{closer_id}/{filename}
-- This policy ensures users can only access their org's files

DROP POLICY IF EXISTS "Auth users upload audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users read audios" ON storage.objects;
DROP POLICY IF EXISTS "Auth users delete audios" ON storage.objects;

CREATE POLICY "org_upload_audios" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

CREATE POLICY "org_read_audios" ON storage.objects FOR SELECT TO authenticated
  USING (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

CREATE POLICY "org_delete_audios" ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'audios'
    AND (storage.foldername(name))[1] = auth.org_id()::text
  );

-- Service role (worker) retains full access (policy already exists from migration 003)

-- ═══════════════════════════════════════
-- 18. Update profile trigger to assign organization_id from signup metadata
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, role, organization_id)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'role', 'viewer'),
    (NEW.raw_user_meta_data->>'organization_id')::uuid
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
-- ═══════════════════════════════════════════════════════════════
-- Migration 008: Data Integrity Constraints
-- Score ranges, job dedup, status transitions, prompt versioning
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. Score range CHECK constraints (0-10) ───

ALTER TABLE call_audits
  ADD CONSTRAINT chk_score_final CHECK (score_final IS NULL OR (score_final >= 0 AND score_final <= 10)),
  ADD CONSTRAINT chk_d01_frame CHECK (d01_frame IS NULL OR (d01_frame >= 0 AND d01_frame <= 10)),
  ADD CONSTRAINT chk_d02_qualificacao CHECK (d02_qualificacao IS NULL OR (d02_qualificacao >= 0 AND d02_qualificacao <= 10)),
  ADD CONSTRAINT chk_d03_diag_quantitativo CHECK (d03_diag_quantitativo IS NULL OR (d03_diag_quantitativo >= 0 AND d03_diag_quantitativo <= 10)),
  ADD CONSTRAINT chk_d04_diag_qualitativo CHECK (d04_diag_qualitativo IS NULL OR (d04_diag_qualitativo >= 0 AND d04_diag_qualitativo <= 10)),
  ADD CONSTRAINT chk_d05_consequencia CHECK (d05_consequencia IS NULL OR (d05_consequencia >= 0 AND d05_consequencia <= 10)),
  ADD CONSTRAINT chk_d06_ensino CHECK (d06_ensino IS NULL OR (d06_ensino >= 0 AND d06_ensino <= 10)),
  ADD CONSTRAINT chk_d07_identidade CHECK (d07_identidade IS NULL OR (d07_identidade >= 0 AND d07_identidade <= 10)),
  ADD CONSTRAINT chk_d08_ancoragem CHECK (d08_ancoragem IS NULL OR (d08_ancoragem >= 0 AND d08_ancoragem <= 10)),
  ADD CONSTRAINT chk_d09_isolamento CHECK (d09_isolamento IS NULL OR (d09_isolamento >= 0 AND d09_isolamento <= 10)),
  ADD CONSTRAINT chk_d10_proporcao_fala CHECK (d10_proporcao_fala IS NULL OR (d10_proporcao_fala >= 0 AND d10_proporcao_fala <= 10)),
  ADD CONSTRAINT chk_d11_promessas CHECK (d11_promessas IS NULL OR (d11_promessas >= 0 AND d11_promessas <= 10)),
  ADD CONSTRAINT chk_d12_checkpoints CHECK (d12_checkpoints IS NULL OR (d12_checkpoints >= 0 AND d12_checkpoints <= 10)),
  ADD CONSTRAINT chk_d13_fechamento CHECK (d13_fechamento IS NULL OR (d13_fechamento >= 0 AND d13_fechamento <= 10));

-- Sentiment score: -1 to 1
ALTER TABLE call_audits
  ADD CONSTRAINT chk_sentiment_score CHECK (sentiment_score IS NULL OR (sentiment_score >= -1 AND sentiment_score <= 1));

-- ─── 2. Job idempotency: prevent duplicate active jobs ───

-- Partial unique index: only one pending/processing job per (audit_id, job_type)
CREATE UNIQUE INDEX idx_job_queue_dedup
  ON job_queue (audit_id, job_type)
  WHERE status IN ('pending', 'processing');

-- ─── 3. Status transition validation via trigger ───

-- Add 'dead_letter' as valid job status
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_status_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_status_check
  CHECK (status IN ('pending', 'processing', 'completed', 'failed', 'dead_letter'));

-- Valid audit status transitions
CREATE OR REPLACE FUNCTION validate_audit_status_transition()
RETURNS TRIGGER AS $$
DECLARE
  valid_transitions JSONB := '{
    "uploaded": ["transcribing", "error"],
    "transcribing": ["transcribed", "error"],
    "transcribed": ["analyzing", "error"],
    "analyzing": ["analyzed", "error"],
    "analyzed": ["notifying", "error"],
    "notifying": ["completed", "error"],
    "completed": ["notifying"],
    "error": ["uploaded", "transcribing", "analyzing", "notifying"]
  }'::JSONB;
  allowed JSONB;
BEGIN
  -- Allow if status hasn't changed
  IF OLD.status = NEW.status THEN
    RETURN NEW;
  END IF;

  allowed := valid_transitions -> OLD.status;

  IF allowed IS NULL OR NOT (allowed ? NEW.status) THEN
    RAISE EXCEPTION 'Invalid status transition: % -> %', OLD.status, NEW.status;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_audit_status_transition
  BEFORE UPDATE OF status ON call_audits
  FOR EACH ROW EXECUTE FUNCTION validate_audit_status_transition();

-- ─── 4. Prompt versioning + report hash columns ───

ALTER TABLE call_audits
  ADD COLUMN IF NOT EXISTS prompt_version TEXT,
  ADD COLUMN IF NOT EXISTS report_hash TEXT;

-- Index for prompt version analysis
CREATE INDEX IF NOT EXISTS idx_call_audits_prompt_version ON call_audits(prompt_version)
  WHERE prompt_version IS NOT NULL;
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
-- ═══════════════════════════════════════════════════════════════
-- Migration 010: Safe async refresh for materialized views
-- Replaces synchronous REFRESH in trigger with pg_notify
-- Worker or pg_cron handles actual refresh asynchronously
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. Drop the blocking trigger ───
DROP TRIGGER IF EXISTS trigger_audit_refresh_views ON call_audits;
DROP FUNCTION IF EXISTS trigger_refresh_on_audit_complete();

-- ─── 2. Debounced refresh function ───
-- Only refreshes if last refresh was more than 30 seconds ago
-- Prevents cascading refreshes when multiple audits complete simultaneously

CREATE OR REPLACE FUNCTION refresh_dashboard_views_debounced()
RETURNS void AS $$
DECLARE
  last_refresh timestamptz;
BEGIN
  -- Use advisory lock to prevent concurrent refreshes
  IF NOT pg_try_advisory_lock(hashtext('refresh_dashboard_views')) THEN
    RETURN;  -- Another refresh is in progress, skip
  END IF;

  BEGIN
    -- Check last refresh time from a control record
    SELECT value->>'last_refresh'
    INTO last_refresh
    FROM app_config
    WHERE key = 'mv_refresh_control'
    LIMIT 1;

    -- Only refresh if more than 30s since last refresh (or first time)
    IF last_refresh IS NULL OR last_refresh < NOW() - INTERVAL '30 seconds' THEN
      REFRESH MATERIALIZED VIEW CONCURRENTLY mv_dashboard_stats;
      REFRESH MATERIALIZED VIEW CONCURRENTLY mv_closer_performance;

      -- Update last refresh timestamp
      INSERT INTO app_config (key, value, organization_id)
      VALUES ('mv_refresh_control', jsonb_build_object('last_refresh', NOW()::text), NULL)
      ON CONFLICT (organization_id, key)
      DO UPDATE SET value = jsonb_build_object('last_refresh', NOW()::text);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    -- Release lock even on error
    PERFORM pg_advisory_unlock(hashtext('refresh_dashboard_views'));
    RAISE;
  END;

  PERFORM pg_advisory_unlock(hashtext('refresh_dashboard_views'));
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─── 3. Lightweight trigger: notify instead of refresh ───
-- Sends a NOTIFY so the worker can refresh asynchronously

CREATE OR REPLACE FUNCTION trigger_notify_audit_complete()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status IN ('completed', 'analyzed') AND (OLD.status IS DISTINCT FROM NEW.status) THEN
    PERFORM pg_notify('audit_completed', json_build_object(
      'audit_id', NEW.id,
      'status', NEW.status,
      'organization_id', NEW.organization_id
    )::text);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trigger_audit_notify_complete
  AFTER UPDATE OF status ON call_audits
  FOR EACH ROW EXECUTE FUNCTION trigger_notify_audit_complete();

-- ─── 4. Keep refresh_dashboard_views() for manual/scheduled use ───
-- The original function is kept unchanged for:
--   * Manual refresh: SELECT refresh_dashboard_views();
--   * pg_cron scheduled refresh (recommended for production)
--   * Worker-driven refresh via refresh_dashboard_views_debounced()

-- Example pg_cron setup (run in Supabase SQL Editor, not in migration):
-- SELECT cron.schedule('refresh-mv', '*/5 * * * *', 'SELECT refresh_dashboard_views_debounced()');
-- Sprint 1: Análise do Supervisor
-- Tabelas: supervisor_analyses, supervisor_stage_scores, protocol_rules, negotiation_rules, closer_training_actions
-- Views: v_supervisor_closer_performance, v_supervisor_weakest_stages

-- ============================================================
-- 1. supervisor_analyses (Tabela principal)
-- ============================================================
CREATE TABLE supervisor_analyses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID REFERENCES call_audits(id) ON DELETE CASCADE,
  organization_id UUID REFERENCES organizations(id),
  protocol_version TEXT NOT NULL DEFAULT 'v1.0',
  prompt_version TEXT NOT NULL DEFAULT '1.0',

  -- Scores
  overall_score NUMERIC(3,1),
  overall_label TEXT,
  classification TEXT CHECK (classification IN ('EXCELENTE', 'BOA', 'REGULAR', 'FRACA', 'CRITICA')),

  -- Conteúdo
  executive_summary TEXT,
  raw_json JSONB,

  -- Negociação (extraído do JSON para queries diretas)
  table_price_presented BOOLEAN,
  silence_applied BOOLEAN,
  who_spoke_first TEXT CHECK (who_spoke_first IN ('closer', 'lead', 'unknown')),
  protagonist_transition_quality NUMERIC(3,1),
  cac_explained BOOLEAN,
  negotiation_firmness NUMERIC(3,1),
  downsell_used BOOLEAN,
  downsell_narrative_quality NUMERIC(3,1),

  -- Melhorias
  priority_improvements JSONB DEFAULT '[]',
  training_actions JSONB DEFAULT '[]',
  objections_detected JSONB DEFAULT '[]',

  -- Meta
  modelo_analise TEXT DEFAULT 'claude-sonnet-4',
  tokens_input INTEGER,
  tokens_output INTEGER,
  custo_estimado NUMERIC(8,4),

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 2. supervisor_stage_scores (Scores por etapa)
-- ============================================================
CREATE TABLE supervisor_stage_scores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID REFERENCES supervisor_analyses(id) ON DELETE CASCADE,
  stage_key TEXT NOT NULL,
  stage_name TEXT NOT NULL,
  stage_order INTEGER NOT NULL,
  score NUMERIC(3,1) NOT NULL,
  max_score NUMERIC(3,1) DEFAULT 10,
  weight NUMERIC(4,2),
  status TEXT CHECK (status IN ('excellent', 'ok', 'warning', 'critical', 'skipped')),
  justification TEXT,
  evidence_excerpt TEXT,
  missed_actions JSONB DEFAULT '[]',
  suggested_fix JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 3. protocol_rules (Regras configuráveis do protocolo)
-- ============================================================
CREATE TABLE protocol_rules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  version TEXT NOT NULL DEFAULT 'v1.0',
  stage_key TEXT NOT NULL,
  stage_name TEXT NOT NULL,
  stage_order INTEGER NOT NULL,
  description TEXT,
  expected_behaviors JSONB DEFAULT '[]',
  failure_behaviors JSONB DEFAULT '[]',
  scoring_weight NUMERIC(4,2) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(organization_id, version, stage_key)
);

-- ============================================================
-- 4. negotiation_rules (Regras de negociação)
-- ============================================================
CREATE TABLE negotiation_rules (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  max_discount_pct NUMERIC(5,2),
  max_installments INTEGER,
  allowed_bonuses JSONB DEFAULT '[]',
  concession_order JSONB DEFAULT '[]',
  downsell_products JSONB DEFAULT '[]',
  what_is_good_negotiation TEXT,
  what_is_good_downsell TEXT,
  version TEXT DEFAULT 'v1.0',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 5. closer_training_actions (Ações de treinamento)
-- ============================================================
CREATE TABLE closer_training_actions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  closer_id UUID REFERENCES closers(id) ON DELETE CASCADE,
  source_analysis_id UUID REFERENCES supervisor_analyses(id),
  weakness_key TEXT NOT NULL,
  stage_key TEXT,
  recommendation TEXT NOT NULL,
  priority TEXT CHECK (priority IN ('high', 'medium', 'low')) DEFAULT 'medium',
  status TEXT CHECK (status IN ('pending', 'sent', 'completed')) DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- Índices
-- ============================================================
CREATE INDEX idx_sup_analyses_audit ON supervisor_analyses(audit_id);
CREATE INDEX idx_sup_analyses_org ON supervisor_analyses(organization_id);
CREATE INDEX idx_sup_analyses_score ON supervisor_analyses(overall_score DESC);
CREATE INDEX idx_sup_stage_analysis ON supervisor_stage_scores(analysis_id);
CREATE INDEX idx_sup_stage_key ON supervisor_stage_scores(stage_key);
CREATE INDEX idx_negotiation_rules_org ON negotiation_rules(organization_id);
CREATE INDEX idx_protocol_rules_org ON protocol_rules(organization_id, version);
CREATE INDEX idx_training_closer ON closer_training_actions(closer_id);
CREATE INDEX idx_training_status ON closer_training_actions(status);

-- ============================================================
-- Trigger updated_at
-- ============================================================
CREATE TRIGGER trigger_supervisor_analyses_updated
  BEFORE UPDATE ON supervisor_analyses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- View: Performance por closer no protocolo do supervisor
-- ============================================================
CREATE OR REPLACE VIEW v_supervisor_closer_performance AS
SELECT
  c.id as closer_id,
  c.name as closer_name,
  c.organization_id,
  COUNT(sa.id) as total_analyses,
  ROUND(AVG(sa.overall_score), 1) as avg_score,
  COUNT(*) FILTER (WHERE sa.classification = 'EXCELENTE') as excelente_count,
  COUNT(*) FILTER (WHERE sa.classification = 'BOA') as boa_count,
  COUNT(*) FILTER (WHERE sa.classification = 'REGULAR') as regular_count,
  COUNT(*) FILTER (WHERE sa.classification IN ('FRACA', 'CRITICA')) as fraca_count,
  COUNT(*) FILTER (WHERE sa.downsell_used = true) as downsell_count,
  ROUND(AVG(sa.negotiation_firmness), 1) as avg_negotiation_firmness
FROM closers c
LEFT JOIN call_audits ca ON ca.closer_id = c.id
LEFT JOIN supervisor_analyses sa ON sa.audit_id = ca.id
GROUP BY c.id, c.name, c.organization_id;

-- ============================================================
-- View: Etapas mais fracas (aggregate)
-- ============================================================
CREATE OR REPLACE VIEW v_supervisor_weakest_stages AS
SELECT
  sss.stage_key,
  sss.stage_name,
  ROUND(AVG(sss.score), 1) as avg_score,
  COUNT(*) as total_evaluations,
  COUNT(*) FILTER (WHERE sss.status = 'critical') as critical_count,
  ROUND(AVG(sss.score) FILTER (WHERE sss.status = 'critical'), 1) as avg_when_critical
FROM supervisor_stage_scores sss
JOIN supervisor_analyses sa ON sa.id = sss.analysis_id
GROUP BY sss.stage_key, sss.stage_name
ORDER BY avg_score ASC;

-- ============================================================
-- Seed: Protocolo padrão System Digital v1.0 (16 etapas)
-- ============================================================
INSERT INTO protocol_rules (organization_id, version, stage_key, stage_name, stage_order, scoring_weight, expected_behaviors, failure_behaviors) VALUES
(NULL, 'v1.0', 'icebreaker', 'Quebra-gelo', 1, 0.03, '["Abertura natural","Pergunta sobre origem/cidade","Tom leve"]', '["Começou direto no negócio","Tom robótico","Sem personalização"]'),
(NULL, 'v1.0', 'rapport', 'Rapport', 2, 0.05, '["Pesquisou Instagram antes","Elogio específico","Ponto de conexão pessoal","Tirou sorriso do lead"]', '["Elogio genérico","Rapport forçado","Muito longo (>5min)","Não pesquisou perfil"]'),
(NULL, 'v1.0', 'initial_pact', 'Pacto Inicial', 3, 0.05, '["3 intenções claras","Frame de elegibilidade","Tom consultivo"]', '["Não fez pacto","Pulou para apresentação","Tom vendedor"]'),
(NULL, 'v1.0', 'spin_situation', 'SPIN — Situação', 4, 0.05, '["Mapeou estrutura/equipe","Mapeou faturamento","Mapeou processo comercial"]', '["Perguntas superficiais","Não mapeou equipe","Não entendeu faturamento"]'),
(NULL, 'v1.0', 'spin_problem', 'SPIN — Problema', 5, 0.05, '["Lead verbalizou a dor","Identificou dor emocional","Identificou dor financeira"]', '["Closer assumiu a dor","Lead não verbalizou","Perguntas fechadas demais"]'),
(NULL, 'v1.0', 'spin_implication', 'SPIN — Implicação', 6, 0.08, '["Quantificou custo da inação","Intensificou urgência","Lead sentiu peso do problema"]', '["Não aprofundou consequências","Não quantificou perda","Passou rápido"]'),
(NULL, 'v1.0', 'spin_need', 'SPIN — Necessidade', 7, 0.07, '["Lead verbalizou que precisa","Construiu o gap","Lead imaginou resultado"]', '["Closer disse que ele precisa","Gap não construído","Necessidade não verbalizada"]'),
(NULL, 'v1.0', 'transition_pact', 'Pacto de Transição', 8, 0.05, '["Pacto sim/não claro","Autoridade posicionada","Lead entendeu fazer sozinho"]', '["Não pediu sim/não","Não posicionou autoridade","Transição abrupta"]'),
(NULL, 'v1.0', 'presentation_method', 'Apresentação: Método', 9, 0.10, '["Credibilidade empresa","Cases concretos","Pacto do método feito","Lead falou o que mais gostou"]', '["Monólogo sem interação","Sem cases","Não fez pacto do método"]'),
(NULL, 'v1.0', 'presentation_product', 'Apresentação: Produto', 10, 0.10, '["Benefícios vs entregáveis","Micropactos feitos","Personalizado pro lead"]', '["Listou features","Sem micropactos","Genérico"]'),
(NULL, 'v1.0', 'objection_isolation', 'Isolamento de Objeções', 11, 0.08, '["Isolou que só preço resta","Contornou objeções antes","Lead confirmou que tudo faz sentido"]', '["Objeções não contornadas","Não isolou","Avançou com objeção pendente"]'),
(NULL, 'v1.0', 'anchoring', 'Ancoragem', 12, 0.08, '["Analogia de valor","Compromisso na ancoragem","Depoimentos aderentes","3 perguntas antes do preço"]', '["Sem ancoragem","Foi direto pro preço","Cases genéricos"]'),
(NULL, 'v1.0', 'table_price', 'Preço de Tabela', 13, 0.05, '["Mostrou com confiança","Aplicou silêncio","Lead falou primeiro"]', '["Closer falou primeiro","Justificou antes do lead reagir","Pediu desculpa pelo preço"]'),
(NULL, 'v1.0', 'protagonist_price', 'Preço Protagonista', 14, 0.05, '["Transição bem justificada","Explicou economia CAC","Lead entendeu o benefício"]', '["Transição fraca","Não explicou CAC","Parece desconto desesperado"]'),
(NULL, 'v1.0', 'negotiation', 'Negociação', 15, 0.07, '["Firmeza mantida","Concessões dentro dos parâmetros","Lead percebeu valor"]', '["Cedeu rápido demais","Fora dos parâmetros","Perdeu firmeza"]'),
(NULL, 'v1.0', 'downsell', 'Down Sell', 16, 0.04, '["Narrativa coerente","Ancorou antes no produto maior","Upgrade pathway claro"]', '["Só baixou preço","Sem narrativa","Pareceu desespero"]');

-- ============================================================
-- RLS
-- ============================================================
ALTER TABLE supervisor_analyses ENABLE ROW LEVEL SECURITY;
ALTER TABLE supervisor_stage_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE protocol_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE negotiation_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE closer_training_actions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated_all" ON supervisor_analyses
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all" ON supervisor_stage_scores
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all" ON protocol_rules
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all" ON negotiation_rules
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_all" ON closer_training_actions
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- Atualizar job_type na job_queue
-- ============================================================
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report', 'supervisor_analyze'));
-- Sprint 11: Email Routing por Closer
-- Adiciona campo notification_emails na tabela closers
-- Permite configurar quais supervisores recebem auditorias de cada closer

ALTER TABLE closers ADD COLUMN IF NOT EXISTS notification_emails TEXT[] DEFAULT '{}';

-- Indice para queries de notificacao
CREATE INDEX IF NOT EXISTS idx_closers_notification_emails ON closers USING GIN(notification_emails);

COMMENT ON COLUMN closers.notification_emails IS
  'Lista de emails de supervisores que recebem auditorias deste closer. Se vazio, usa config global.';
-- Migration 013: Fix Supervisor RLS + Channel webhook + Dequeue RPC
-- Replaces auth.org_id() with public.get_org_id() (avoids schema permission issues)
-- Adds 'webhook' channel to notifications
-- Creates enqueue_job and dequeue_job RPCs

-- ═══════════════════════════════════════
-- 1. Create public.get_org_id() to replace auth.org_id()
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.get_org_id()
RETURNS uuid
LANGUAGE sql
STABLE SECURITY DEFINER
AS $$
  SELECT organization_id FROM public.profiles WHERE id = auth.uid();
$$;

-- ═══════════════════════════════════════
-- 2. Update ALL RLS policies to use get_org_id() instead of auth.org_id()
-- ═══════════════════════════════════════

-- call_audits
DROP POLICY IF EXISTS "org_select" ON call_audits;
DROP POLICY IF EXISTS "org_insert" ON call_audits;
DROP POLICY IF EXISTS "org_update" ON call_audits;
CREATE POLICY "org_select" ON call_audits FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON call_audits FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON call_audits FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- closers
DROP POLICY IF EXISTS "org_select" ON closers;
DROP POLICY IF EXISTS "org_insert" ON closers;
DROP POLICY IF EXISTS "org_update" ON closers;
CREATE POLICY "org_select" ON closers FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON closers FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON closers FOR UPDATE TO authenticated USING (organization_id = get_org_id());

-- app_config
DROP POLICY IF EXISTS "org_select" ON app_config;
DROP POLICY IF EXISTS "org_insert" ON app_config;
DROP POLICY IF EXISTS "org_update" ON app_config;
CREATE POLICY "org_select" ON app_config FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON app_config FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON app_config FOR UPDATE TO authenticated USING (organization_id = get_org_id());

-- job_queue
DROP POLICY IF EXISTS "org_select_via_audit" ON job_queue;
CREATE POLICY "org_select_via_audit" ON job_queue FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- notifications
DROP POLICY IF EXISTS "org_select_via_audit" ON notifications;
CREATE POLICY "org_select_via_audit" ON notifications FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- drive_sync
DROP POLICY IF EXISTS "org_select_via_audit" ON drive_sync;
CREATE POLICY "org_select_via_audit" ON drive_sync FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));

-- call_bookmarks
DROP POLICY IF EXISTS "org_select" ON call_bookmarks;
DROP POLICY IF EXISTS "org_insert" ON call_bookmarks;
DROP POLICY IF EXISTS "owner_update" ON call_bookmarks;
DROP POLICY IF EXISTS "owner_delete" ON call_bookmarks;
CREATE POLICY "org_select" ON call_bookmarks FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON call_bookmarks FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id() AND bookmarked_by = auth.uid());
CREATE POLICY "owner_update" ON call_bookmarks FOR UPDATE TO authenticated USING (bookmarked_by = auth.uid()) WITH CHECK (organization_id = get_org_id());
CREATE POLICY "owner_delete" ON call_bookmarks FOR DELETE TO authenticated USING (bookmarked_by = auth.uid());

-- call_comments
DROP POLICY IF EXISTS "org_select" ON call_comments;
DROP POLICY IF EXISTS "org_insert" ON call_comments;
DROP POLICY IF EXISTS "org_update" ON call_comments;
DROP POLICY IF EXISTS "author_delete" ON call_comments;
CREATE POLICY "org_select" ON call_comments FOR SELECT TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON call_comments FOR INSERT TO authenticated
  WITH CHECK (author_id = auth.uid() AND audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "org_update" ON call_comments FOR UPDATE TO authenticated
  USING (audit_id IN (SELECT id FROM call_audits WHERE organization_id = get_org_id()));
CREATE POLICY "author_delete" ON call_comments FOR DELETE TO authenticated USING (author_id = auth.uid());

-- weekly_reports
DROP POLICY IF EXISTS "org_select" ON weekly_reports;
DROP POLICY IF EXISTS "org_insert" ON weekly_reports;
CREATE POLICY "org_select" ON weekly_reports FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON weekly_reports FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());

-- goals
DROP POLICY IF EXISTS "org_select" ON goals;
DROP POLICY IF EXISTS "org_insert" ON goals;
DROP POLICY IF EXISTS "org_update" ON goals;
DROP POLICY IF EXISTS "org_delete" ON goals;
CREATE POLICY "org_select" ON goals FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON goals FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON goals FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_delete" ON goals FOR DELETE TO authenticated USING (organization_id = get_org_id());

-- competitions
DROP POLICY IF EXISTS "org_select" ON competitions;
DROP POLICY IF EXISTS "org_insert" ON competitions;
DROP POLICY IF EXISTS "org_update" ON competitions;
CREATE POLICY "org_select" ON competitions FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON competitions FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON competitions FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- loss_patterns
DROP POLICY IF EXISTS "org_select" ON loss_patterns;
CREATE POLICY "org_select" ON loss_patterns FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- profiles
DROP POLICY IF EXISTS "org_read_profiles" ON profiles;
CREATE POLICY "org_read_profiles" ON profiles FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- supervisor_analyses
DROP POLICY IF EXISTS "authenticated_all" ON supervisor_analyses;
CREATE POLICY "org_select" ON supervisor_analyses FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON supervisor_analyses FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON supervisor_analyses FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- supervisor_stage_scores
DROP POLICY IF EXISTS "authenticated_all" ON supervisor_stage_scores;
CREATE POLICY "org_select" ON supervisor_stage_scores FOR SELECT TO authenticated
  USING (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON supervisor_stage_scores FOR INSERT TO authenticated
  WITH CHECK (analysis_id IN (SELECT id FROM supervisor_analyses WHERE organization_id = get_org_id()));

-- protocol_rules
DROP POLICY IF EXISTS "authenticated_all" ON protocol_rules;
CREATE POLICY "org_select" ON protocol_rules FOR SELECT TO authenticated USING (organization_id = get_org_id());
CREATE POLICY "org_insert" ON protocol_rules FOR INSERT TO authenticated WITH CHECK (organization_id = get_org_id());
CREATE POLICY "org_update" ON protocol_rules FOR UPDATE TO authenticated USING (organization_id = get_org_id()) WITH CHECK (organization_id = get_org_id());

-- negotiation_rules
DROP POLICY IF EXISTS "authenticated_all" ON negotiation_rules;
CREATE POLICY "org_select" ON negotiation_rules FOR SELECT TO authenticated USING (organization_id = get_org_id());

-- closer_training_actions
DROP POLICY IF EXISTS "authenticated_all" ON closer_training_actions;
CREATE POLICY "org_select" ON closer_training_actions FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));
CREATE POLICY "org_insert" ON closer_training_actions FOR INSERT TO authenticated
  WITH CHECK (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- closer_badges
DROP POLICY IF EXISTS "org_select_via_closer" ON closer_badges;
CREATE POLICY "org_select_via_closer" ON closer_badges FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- closer_streaks
DROP POLICY IF EXISTS "org_select_via_closer" ON closer_streaks;
CREATE POLICY "org_select_via_closer" ON closer_streaks FOR SELECT TO authenticated
  USING (closer_id IN (SELECT id FROM closers WHERE organization_id = get_org_id()));

-- storage (update to use get_org_id)
DROP POLICY IF EXISTS "org_upload_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_read_audios" ON storage.objects;
DROP POLICY IF EXISTS "org_delete_audios" ON storage.objects;
CREATE POLICY "org_upload_audios" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);
CREATE POLICY "org_read_audios" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);
CREATE POLICY "org_delete_audios" ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'audios' AND (storage.foldername(name))[1] = get_org_id()::text);

-- ═══════════════════════════════════════
-- 3. Add 'webhook' to notifications channel
-- ═══════════════════════════════════════
ALTER TABLE notifications DROP CONSTRAINT IF EXISTS notifications_channel_check;
ALTER TABLE notifications ADD CONSTRAINT notifications_channel_check
  CHECK (channel IN ('whatsapp', 'email', 'webhook'));

-- ═══════════════════════════════════════
-- 4. Update enqueue_job to use get_org_id()
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.enqueue_job(p_audit_id uuid, p_job_type text)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE v_org_id UUID; v_job_id UUID;
BEGIN
  IF p_job_type NOT IN (
    'transcribe', 'analyze', 'notify',
    'weekly_report', 'loss_pattern', 'supervisor_analyze'
  ) THEN
    RAISE EXCEPTION 'Tipo de job invalido: %', p_job_type;
  END IF;

  SELECT organization_id INTO v_org_id FROM call_audits WHERE id = p_audit_id;
  IF v_org_id IS NULL THEN RAISE EXCEPTION 'Audit not found: %', p_audit_id; END IF;
  IF v_org_id != public.get_org_id() THEN RAISE EXCEPTION 'Access denied'; END IF;
  INSERT INTO job_queue (audit_id, job_type, status)
    VALUES (p_audit_id, p_job_type, 'pending') RETURNING id INTO v_job_id;
  RETURN v_job_id;
END;
$function$;

-- ═══════════════════════════════════════
-- 5. Create dequeue_job RPC
-- ═══════════════════════════════════════
CREATE OR REPLACE FUNCTION public.dequeue_job()
RETURNS TABLE(id uuid, audit_id uuid, job_type text, status text, attempts integer, max_attempts integer, error_message text, started_at timestamp with time zone, completed_at timestamp with time zone, created_at timestamp with time zone)
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
BEGIN
  RETURN QUERY
  UPDATE job_queue jq SET status = 'processing', started_at = NOW()
  WHERE jq.id = (
    SELECT jq2.id FROM job_queue jq2
    WHERE jq2.status = 'pending'
    ORDER BY jq2.created_at ASC LIMIT 1
    FOR UPDATE SKIP LOCKED
  )
  RETURNING jq.id, jq.audit_id, jq.job_type, jq.status,
            jq.attempts, jq.max_attempts, jq.error_message,
            jq.started_at, jq.completed_at, jq.created_at;
END;
$function$;
-- Migration 014: Fix job_type constraint to include all 6 types
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report', 'loss_pattern', 'supervisor_analyze'));
-- Migration 015: Job queue webhook trigger via pg_net
-- Calls Edge Function when a new job is inserted

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

CREATE OR REPLACE FUNCTION public.trigger_process_job()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  edge_function_url TEXT;
BEGIN
  -- IMPORTANT: Update this URL when migrating to a new Supabase project
  edge_function_url := 'https://putdygyeerldrsyjhvzm.supabase.co/functions/v1/process-job';

  PERFORM net.http_post(
    url := edge_function_url,
    body := jsonb_build_object(
      'job_id', NEW.id,
      'audit_id', NEW.audit_id,
      'job_type', NEW.job_type
    ),
    headers := jsonb_build_object(
      'Content-Type', 'application/json'
    )::jsonb
  );

  RETURN NEW;
END;
$function$;

CREATE TRIGGER on_job_inserted
  AFTER INSERT ON public.job_queue
  FOR EACH ROW
  WHEN (NEW.status = 'pending')
  EXECUTE FUNCTION trigger_process_job();
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
-- Migration 017: Create reports storage bucket
-- For storing generated audit report markdown files

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'reports',
  'reports',
  false,
  10485760, -- 10 MB
  ARRAY['text/markdown', 'text/plain', 'application/pdf']
)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Service role full access reports"
  ON storage.objects FOR ALL TO service_role
  USING (bucket_id = 'reports');

CREATE POLICY "Auth users read reports"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'reports');
