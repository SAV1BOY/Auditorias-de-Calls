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

-- Índices
CREATE INDEX idx_call_audits_org ON call_audits(organization_id);
CREATE INDEX idx_call_audits_closer ON call_audits(closer_id);
CREATE INDEX idx_call_audits_status ON call_audits(status);
CREATE INDEX idx_call_audits_date ON call_audits(call_date DESC);
CREATE INDEX idx_call_audits_score ON call_audits(score_final DESC);
CREATE INDEX idx_job_queue_status ON job_queue(status) WHERE status = 'pending';
CREATE INDEX idx_job_queue_audit ON job_queue(audit_id);

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
  COUNT(*) FILTER (WHERE status IN ('uploaded','transcribing','analyzing')) as calls_em_processamento,
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
