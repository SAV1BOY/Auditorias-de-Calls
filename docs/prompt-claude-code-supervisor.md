# PROMPT PARA CLAUDE CODE — Implementar Aba "Análise do Supervisor"

## CONTEXTO

Você está trabalhando no repositório CallAudit (`Auditorias-de-Calls`). É um sistema de auditoria automática de calls de fechamento high ticket.

**Stack:**
- Frontend: Next.js 14 (App Router) em `apps/web/`
- Worker: Python 3.11+ em `workers/`
- Banco: Supabase (PostgreSQL)
- UI: Tailwind CSS + shadcn/ui
- Gráficos: Recharts

**Leia ANTES de começar:**
- `CLAUDE.md` (convenções do projeto)
- `docs/PRD.md` (schema completo)
- `supabase/migrations/001_initial_schema.sql` (schema atual)
- `apps/web/components/layout/sidebar.tsx` (navegação)
- `workers/src/pipeline/analyzer.py` (pipeline de análise)
- `workers/src/prompts/system_prompt.py` (prompt atual)
- `apps/web/lib/types/audit.ts` (types existentes)
- `apps/web/lib/actions/calls.ts` (server actions pattern)

---

## TAREFA

Implementar o módulo **"Análise do Supervisor"** — uma nova aba completa no app que permite análise de calls contra o protocolo específico da System Digital (9 etapas com pactos, SPIN, ancoragem, negociação e down sell).

Este módulo roda em **PARALELO** à análise padrão existente (13 dimensões). Cada call terá as duas análises: a genérica e a do supervisor.

---

## PASSO 1 — MIGRATION SQL

Criar arquivo `supabase/migrations/011_supervisor_analysis.sql` com:

```sql
-- Tabela principal de análises do supervisor
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
  raw_json JSONB, -- output completo da IA
  
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

-- Scores por etapa (normalizados)
CREATE TABLE supervisor_stage_scores (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  analysis_id UUID REFERENCES supervisor_analyses(id) ON DELETE CASCADE,
  stage_key TEXT NOT NULL,
  stage_name TEXT NOT NULL,
  stage_order INTEGER NOT NULL,
  score NUMERIC(3,1) NOT NULL,
  max_score NUMERIC(3,1) DEFAULT 10,
  weight NUMERIC(4,2), -- peso percentual (ex: 0.08 = 8%)
  status TEXT CHECK (status IN ('excellent', 'ok', 'warning', 'critical', 'skipped')),
  justification TEXT,
  evidence_excerpt TEXT,
  missed_actions JSONB DEFAULT '[]',
  suggested_fix JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Regras do protocolo (configurável)
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

-- Regras de negociação
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

-- Ações de treinamento por closer
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

-- Índices
CREATE INDEX idx_sup_analyses_audit ON supervisor_analyses(audit_id);
CREATE INDEX idx_sup_analyses_org ON supervisor_analyses(organization_id);
CREATE INDEX idx_sup_analyses_score ON supervisor_analyses(overall_score DESC);
CREATE INDEX idx_sup_stage_analysis ON supervisor_stage_scores(analysis_id);
CREATE INDEX idx_sup_stage_key ON supervisor_stage_scores(stage_key);
CREATE INDEX idx_protocol_rules_org ON protocol_rules(organization_id, version);
CREATE INDEX idx_training_closer ON closer_training_actions(closer_id);
CREATE INDEX idx_training_status ON closer_training_actions(status);

-- Trigger updated_at
CREATE TRIGGER trigger_supervisor_analyses_updated
  BEFORE UPDATE ON supervisor_analyses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- View: Performance por closer no protocolo do supervisor
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

-- View: Etapas mais fracas (aggregate)
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

-- Seed: Protocolo padrão System Digital v1.0
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

-- RLS
ALTER TABLE supervisor_analyses ENABLE ROW LEVEL SECURITY;
ALTER TABLE supervisor_stage_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE protocol_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE negotiation_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE closer_training_actions ENABLE ROW LEVEL SECURITY;
```

---

## PASSO 2 — TYPES DO FRONTEND

Criar `apps/web/lib/types/supervisor.ts`:

```typescript
// Classificações do supervisor
export type SupervisorClassification = 'EXCELENTE' | 'BOA' | 'REGULAR' | 'FRACA' | 'CRITICA'
export type StageStatus = 'excellent' | 'ok' | 'warning' | 'critical' | 'skipped'

export interface SupervisorStageScore {
  stage_key: string
  stage_name: string
  stage_order: number
  score: number
  max_score: number
  weight: number
  status: StageStatus
  justification: string
  evidence_excerpt: string | null
  missed_actions: string[]
  suggested_fix: string[]
}

export interface NegotiationAnalysis {
  table_price_presented: boolean
  silence_applied: boolean
  who_spoke_first: 'closer' | 'lead' | 'unknown'
  protagonist_transition_quality: number
  cac_explained: boolean
  negotiation_firmness: number
  downsell_used: boolean
  downsell_narrative_quality: number | null
}

export interface DetectedObjectionSup {
  type: string
  text: string
  handled: boolean
  quality: 'good' | 'poor'
}

export interface TrainingAction {
  weakness_key: string
  stage_key: string | null
  recommendation: string
  priority: 'high' | 'medium' | 'low'
}

export interface SupervisorAnalysis {
  id: string
  audit_id: string
  protocol_version: string
  overall_score: number
  overall_label: string
  classification: SupervisorClassification
  executive_summary: string
  stages: SupervisorStageScore[]
  negotiation: NegotiationAnalysis
  priority_improvements: string[]
  training_actions: TrainingAction[]
  objections_detected: DetectedObjectionSup[]
  created_at: string
  // Joined data
  call_audits?: {
    lead_name: string
    call_date: string
    closer_id: string
    closers: { name: string } | null
  }
}

export interface SupervisorDashboardStats {
  total_analyses: number
  avg_score: number
  by_classification: {
    excelente: number
    boa: number
    regular: number
    fraca: number
    critica: number
  }
  weakest_stages: Array<{ stage_key: string; stage_name: string; avg_score: number }>
  recent_analyses: SupervisorAnalysis[]
}

export interface ProtocolRule {
  id: string
  stage_key: string
  stage_name: string
  stage_order: number
  scoring_weight: number
  expected_behaviors: string[]
  failure_behaviors: string[]
  is_active: boolean
}
```

---

## PASSO 3 — SYSTEM PROMPT DO SUPERVISOR

Criar `workers/src/prompts/supervisor_prompt.py`. O prompt deve:

1. Identificar o papel: "Você é um Auditor de QA Comercial Sênior"
2. Objetivo: avaliar se o closer seguiu o protocolo de 16 etapas (não verificar script palavra por palavra, mas se executou os pactos no momento correto)
3. Incluir a definição completa de cada etapa do protocolo (usar os dados da tabela `protocol_rules` acima)
4. Incluir as regras de negociação (da tabela `negotiation_rules`)
5. Instruir output em JSON puro (sem markdown, sem backticks)
6. O JSON deve seguir EXATAMENTE o schema definido no tipo `SupervisorAnalysis`
7. Incluir regra: score 0-10 por etapa, com status derivado (>=8 excellent, >=6 ok, >=4 warning, <4 critical)
8. Incluir regra: se uma etapa não aconteceu na call, status = 'skipped' e score = 0
9. Incluir regra: o overall_score é a média ponderada pelos weights
10. Incluir as definições de "boa negociação" e "bom down sell"

O prompt deve ser uma string constante `SUPERVISOR_SYSTEM_PROMPT` com `SUPERVISOR_PROMPT_VERSION = "1.0"`.

Baseie o conteúdo do prompt no framework completo da Evelyn (9 etapas documentadas em `08-documentos-base/framework-evelyn/evelyn-framework-transcricoes.md`) e na transcrição do áudio do supervisor.

---

## PASSO 4 — SUPERVISOR ANALYZER (Worker)

Criar `workers/src/pipeline/supervisor_analyzer.py`:

- Classe `SupervisorAnalyzer` com mesma estrutura de `Analyzer`
- Método `analyze(audit_id)` que:
  1. Busca a transcrição de `call_audits`
  2. Busca as `protocol_rules` ativas
  3. Busca as `negotiation_rules`
  4. Injeta protocolo + regras no prompt
  5. Chama Claude API
  6. Parseia o JSON de resposta
  7. Salva em `supervisor_analyses` e `supervisor_stage_scores`
  8. Gera `closer_training_actions` para stages com score < 6
  9. Retorna o resultado

Criar `workers/src/pipeline/supervisor_models.py` com dataclass `SupervisorAnalysisResult`.

---

## PASSO 5 — INTEGRAR NO PIPELINE

Modificar `workers/src/pipeline/analyzer.py`:
- Após salvar a análise padrão, chamar `SupervisorAnalyzer.analyze(audit_id)`
- Adicionar job_type 'supervisor_analyze' na job_queue se quiser separar

Modificar `workers/src/main.py`:
- Registrar o `SupervisorAnalyzer` no pipeline

---

## PASSO 6 — SERVER ACTIONS

Criar `apps/web/lib/actions/supervisor.ts` com:

```typescript
'use server'

// getSupervisorDashboardStats() — stats para o dashboard
// getSupervisorAnalysis(analysisId) — detalhe de uma análise
// getSupervisorAnalysisByAudit(auditId) — análise vinculada a uma call
// listSupervisorAnalyses(filters) — lista com filtros e paginação
// getProtocolRules(version) — regras do protocolo
// updateProtocolRule(id, data) — editar regra
// getWeakestStages(closerId?, period?) — etapas mais fracas
// getTrainingActions(closerId) — ações de treino pendentes
// requestSupervisorAnalysis(auditId) — solicitar análise manual
// getCloserSupervisorPerformance(closerId) — performance do closer no protocolo
```

Seguir o padrão de `apps/web/lib/actions/calls.ts` para estilo e error handling.

---

## PASSO 7 — PÁGINAS E COMPONENTES

### 7.1 Sidebar — Modificar `apps/web/components/layout/sidebar.tsx`

Adicionar entre "Ranking" e "Upload":
```typescript
{ href: "/supervisor", label: "Supervisor", icon: ShieldCheck }
```
Importar `ShieldCheck` de lucide-react.

### 7.2 Dashboard Supervisor — `apps/web/app/(dashboard)/supervisor/page.tsx`

Server component que busca stats. Mostrar:
- Cards: total análises, score médio, distribuição por classificação
- Gráfico: etapas mais fracas (bar chart horizontal)
- Lista: últimas 5 análises com score, closer, lead, classificação
- Botão: "Nova Análise"

### 7.3 Nova Análise — `apps/web/app/(dashboard)/supervisor/analyze/page.tsx`

Formulário com:
- Select: escolher call existente (dropdown com calls já transcritas)
- OU: textarea para colar transcrição manualmente
- Select: versão do protocolo
- Botão: "Gerar Análise do Supervisor"
- Loading state enquanto processa

### 7.4 Resultado — `apps/web/app/(dashboard)/supervisor/analysis/[id]/page.tsx`

Tela completa com:

**Bloco 1 — Header:**
- Nome do closer, lead, data, duração
- Score geral (badge grande com cor)
- Classificação
- Status (badge colorido)

**Bloco 2 — Resumo Executivo:**
- 3-6 linhas com o que funcionou, onde travou, por quê

**Bloco 3 — Score por Etapa:**
- Cards colapsáveis (accordion) para cada etapa
- Cada card mostra: nome, score/10, status badge, justificativa
- Expandido: evidência, ações faltantes, sugestão de fix

**Bloco 4 — Timeline:**
- Linha do tempo visual mostrando as etapas com cores por status

**Bloco 5 — Painel de Negociação:**
- Grid com: preço apresentado? silêncio? quem falou primeiro?
- Qualidade da transição, CAC explicado, firmeza, down sell

**Bloco 6 — Objeções:**
- Lista de objeções detectadas com badge handled/not handled

**Bloco 7 — Melhorias Prioritárias:**
- Lista ordenada com ações recomendadas

### 7.5 Tab no Detalhe da Call

Modificar `apps/web/components/calls/audit-tabs.tsx`:
- Adicionar tab "Supervisor" que mostra a análise do supervisor vinculada àquela call
- Se não tem análise ainda, mostrar botão "Solicitar Análise do Supervisor"

---

## PASSO 8 — UI PATTERNS

- Usar shadcn/ui para todos os componentes (Card, Badge, Tabs, Accordion, Table, Button, Select, Dialog)
- Cores por status: excellent=green, ok=blue, warning=yellow, critical=red, skipped=gray
- Recharts para gráficos (bar chart horizontal para etapas)
- Seguir o padrão visual existente no app (dark theme compatible)
- Server Components por padrão, Client Components só onde necessário
- Loading states com Skeleton em todas as páginas assíncronas
- Error boundaries em todas as rotas

---

## ORDEM DE EXECUÇÃO

1. Migration SQL
2. Types do frontend
3. System prompt do supervisor (workers)
4. Supervisor analyzer + parser + models (workers)
5. Server actions (frontend)
6. Sidebar atualizado
7. Dashboard supervisor (página + componentes)
8. Tela de nova análise
9. Tela de resultado detalhado
10. Tab supervisor no detalhe da call
11. Integração no pipeline do worker
12. Loading states e error boundaries
13. Testar end-to-end

---

## REGRAS IMPORTANTES

1. Não quebrar funcionalidade existente — a análise padrão (13 dimensões) continua funcionando normalmente
2. A análise do supervisor é ADICIONAL, não substituta
3. O JSON de output da IA deve ser parseado com try/catch — se falhar, salvar raw_json e marcar erro
4. Toda query Supabase deve funcionar com RLS ativado
5. Server Actions para mutações, nunca API routes
6. Não colocar API keys no client-side
7. Usar `lib/supabase/server.ts` para server-side
8. Componentes em PascalCase, arquivos em kebab-case
9. Type hints obrigatórios no Python
10. Commits semânticos: feat(supervisor): descrição
