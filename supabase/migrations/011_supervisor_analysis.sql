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
