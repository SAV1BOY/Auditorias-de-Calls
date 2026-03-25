# Plano de Implantação — Aba "Análise do Supervisor"
## CallAudit | System Digital

---

## 1. DIAGNÓSTICO DO APP ATUAL

### Arquitetura Existente
- **Frontend:** Next.js 14 (App Router) em `apps/web/`
- **Worker:** Python 3.11+ em `workers/` (pipeline: transcrição → análise → notificação)
- **Banco:** Supabase (PostgreSQL + Auth + Storage + RLS)
- **Análise atual:** 13 dimensões genéricas (frame, qualificação, diagnóstico, etc.) via system prompt único
- **Output:** Markdown report + scores + erros/acertos + plano de ação

### O Que Existe Hoje (Abas do Sidebar)
1. Dashboard — stats gerais
2. Calls — lista de auditorias
3. Closers — perfis de closers
4. Analytics — tendências e comparações
5. Biblioteca — bookmarks de calls
6. Relatórios — relatórios semanais
7. Ranking — gamificação/leaderboard
8. Upload — envio de áudios
9. Configurações — setup geral

### Schema Atual da Tabela `call_audits`
- 13 dimensões de score (d01 a d13) — genéricas
- JSONB: top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise
- Campos de sentiment e objections (Sprint 11)
- Campo `relatorio_completo` (markdown do relatório geral)

### O Que Falta (Gap Identificado pelo Supervisor)
A análise atual é **genérica** — avalia contra frameworks de vendas gerais. O supervisor quer uma análise **específica** que:
1. Segue o protocolo EXATO da System Digital (9 etapas + pactos)
2. Avalia CADA pacto individualmente (não só dimensões genéricas)
3. Detecta se o closer seguiu a sequência lógica correta
4. Analisa a qualidade da negociação contra parâmetros definidos
5. Avalia narrativa de down sell (não só se fez, mas COMO fez)
6. Gera output JSON estruturado para dashboard
7. Tem protocolo configurável e versionado

---

## 2. ARQUITETURA DA NOVA ABA

### Princípio: Análise Paralela, Não Substituta

A análise do supervisor roda JUNTO com a análise existente, não no lugar dela. Cada call terá:
- **Análise padrão** (13 dimensões) — já existe
- **Análise do supervisor** (9-11 etapas do protocolo) — NOVA

### Novas Entidades no Banco

```
┌─────────────────────┐
│  call_audits         │ (já existe)
│  ├── id              │
│  ├── ...             │
│  └── análise padrão  │
└──────────┬──────────┘
           │ 1:N
           ▼
┌─────────────────────────────┐
│  supervisor_analyses        │ (NOVA)
│  ├── id                     │
│  ├── audit_id → call_audits │
│  ├── protocol_version       │
│  ├── overall_score          │
│  ├── overall_label          │
│  ├── executive_summary      │
│  ├── stages (JSONB)         │
│  ├── negotiation (JSONB)    │
│  ├── priority_improvements  │
│  ├── training_actions       │
│  └── created_at             │
└──────────┬──────────────────┘
           │ 1:N
           ▼
┌─────────────────────────────┐
│  supervisor_stage_scores    │ (NOVA)
│  ├── id                     │
│  ├── analysis_id            │
│  ├── stage_key              │
│  ├── stage_name             │
│  ├── score                  │
│  ├── max_score              │
│  ├── weight                 │
│  ├── status                 │
│  ├── justification          │
│  ├── evidence_excerpt       │
│  ├── missed_actions (JSONB) │
│  └── suggested_fix (JSONB)  │
└─────────────────────────────┘

┌─────────────────────────────┐
│  protocol_rules             │ (NOVA)
│  ├── id                     │
│  ├── organization_id        │
│  ├── version                │
│  ├── stage_key              │
│  ├── stage_name             │
│  ├── stage_order            │
│  ├── expected_behaviors     │
│  ├── failure_behaviors      │
│  ├── scoring_weight         │
│  ├── is_active              │
│  └── updated_at             │
└─────────────────────────────┘

┌─────────────────────────────┐
│  negotiation_rules          │ (NOVA)
│  ├── id                     │
│  ├── organization_id        │
│  ├── max_discount_pct       │
│  ├── max_installments       │
│  ├── allowed_bonuses        │
│  ├── concession_order       │
│  ├── downsell_products      │
│  ├── version                │
│  └── updated_at             │
└─────────────────────────────┘

┌─────────────────────────────┐
│  closer_training_actions    │ (NOVA)
│  ├── id                     │
│  ├── closer_id              │
│  ├── source_analysis_id     │
│  ├── weakness_key           │
│  ├── recommendation         │
│  ├── priority               │
│  ├── status                 │
│  └── created_at             │
└─────────────────────────────┘
```

### Novas Rotas (Frontend)

```
/supervisor                     → Dashboard do Supervisor
/supervisor/analyze             → Nova Análise (selecionar call existente ou colar transcrição)
/supervisor/analysis/[id]       → Resultado detalhado de uma análise
/supervisor/protocol            → Configuração do protocolo
/supervisor/training            → Ações de treinamento por closer
```

### Novo Item no Sidebar

```typescript
{ href: "/supervisor", label: "Supervisor", icon: ShieldCheck }
```

Posição: entre "Ranking" e "Upload".

---

## 3. AS 11 ETAPAS DO PROTOCOLO DO SUPERVISOR

Mapeadas a partir do áudio do supervisor + framework da Evelyn:

| # | stage_key | stage_name | Peso | O Que Avaliar |
|---|-----------|------------|------|---------------|
| 1 | icebreaker | Quebra-gelo | 3% | Naturalidade, personalização |
| 2 | rapport | Rapport | 5% | Conexão genuína, pesquisa prévia, sorriso |
| 3 | initial_pact | Pacto Inicial | 5% | 3 intenções claras, alinhamento |
| 4 | spin_situation | SPIN — Situação | 5% | Mapeou estrutura, equipe, faturamento |
| 5 | spin_problem | SPIN — Problema | 5% | Identificou dor real, lead verbalizou |
| 6 | spin_implication | SPIN — Implicação | 8% | Aprofundou consequências, quantificou perda |
| 7 | spin_need | SPIN — Necessidade | 7% | Lead verbalizou que precisa da solução |
| 8 | transition_pact | Pacto de Transição | 5% | Sim/não, autoridade, "fazer sozinho" |
| 9 | presentation_method | Apresentação: Método | 10% | Credibilidade, pactos empresa+método |
| 10 | presentation_product | Apresentação: Produto | 10% | Benefícios vs entregáveis, micropactos |
| 11 | objection_isolation | Isolamento de Objeções | 8% | Só preço restou como impeditivo |
| 12 | anchoring | Ancoragem | 8% | Valor vs preço, compromisso, depoimentos |
| 13 | table_price | Preço de Tabela | 5% | Silêncio, quem falou primeiro |
| 14 | protagonist_price | Preço Protagonista | 5% | Transição CAC, justificativa |
| 15 | negotiation | Negociação | 7% | Firmeza, concessões, dentro dos parâmetros |
| 16 | downsell | Down Sell | 4% | Narrativa coerente, não "baixou preço" |

**Total: 100%**

---

## 4. FLUXO DE FUNCIONAMENTO

### Fluxo 1 — Análise Automática (junto com pipeline existente)

```
Call processada pelo pipeline existente
  → transcrição pronta
  → análise padrão (13 dimensões) roda
  → NOVO: análise do supervisor roda em paralelo
    → usa supervisor_system_prompt.py
    → output JSON estruturado
    → salva em supervisor_analyses + supervisor_stage_scores
    → gera training_actions se score < 6
```

### Fluxo 2 — Análise Manual (supervisor pede reanálise)

```
Supervisor vai em /supervisor/analyze
  → Seleciona call existente OU cola transcrição
  → Seleciona versão do protocolo
  → Clica "Gerar Análise"
  → Worker processa com supervisor_system_prompt
  → Resultado aparece em /supervisor/analysis/[id]
```

---

## 5. SCHEMA JSON DE OUTPUT DA IA

```json
{
  "protocol_version": "v1.0",
  "overall_score": 7.4,
  "overall_label": "Boa call com gargalos em SPIN e negociação",
  "classification": "FORTE",
  "executive_summary": "O closer conduziu bem abertura e rapport mas...",
  "stages": [
    {
      "stage_key": "icebreaker",
      "stage_name": "Quebra-gelo",
      "score": 8,
      "max_score": 10,
      "status": "ok",
      "justification": "Abertura natural...",
      "evidence_excerpt": "Trecho da transcrição...",
      "missed_actions": [],
      "suggested_fix": []
    }
  ],
  "negotiation": {
    "table_price_presented": true,
    "silence_applied": false,
    "who_spoke_first": "closer",
    "protagonist_transition_quality": 5,
    "cac_explained": true,
    "negotiation_firmness": 6,
    "downsell_used": false,
    "downsell_narrative_quality": null
  },
  "objections_detected": [
    {
      "type": "financial",
      "text": "Achei 8000 mês pesado",
      "handled": true,
      "quality": "good"
    }
  ],
  "priority_improvements": [
    "Fortalecer SPIN - Implicação",
    "Sustentar silêncio após preço"
  ],
  "training_actions": [
    {
      "weakness_key": "spin_implication",
      "recommendation": "Treinar perguntas de impacto financeiro",
      "priority": "high"
    }
  ]
}
```

---

## 6. ARQUIVOS A CRIAR/MODIFICAR

### Novos Arquivos

**Banco (Migration):**
```
supabase/migrations/011_supervisor_analysis.sql
```

**Worker (Python):**
```
workers/src/prompts/supervisor_prompt.py        → System prompt do supervisor
workers/src/pipeline/supervisor_analyzer.py     → Analyzer separado
workers/src/pipeline/supervisor_parser.py       → Parser do JSON
workers/src/pipeline/supervisor_models.py       → Dataclasses
```

**Frontend (TypeScript/React):**
```
apps/web/app/(dashboard)/supervisor/page.tsx                    → Dashboard
apps/web/app/(dashboard)/supervisor/analyze/page.tsx            → Nova análise
apps/web/app/(dashboard)/supervisor/analysis/[id]/page.tsx      → Detalhe
apps/web/app/(dashboard)/supervisor/protocol/page.tsx           → Config protocolo
apps/web/app/(dashboard)/supervisor/training/page.tsx           → Treinamento
apps/web/app/(dashboard)/supervisor/loading.tsx                 → Loading state

apps/web/components/supervisor/supervisor-dashboard.tsx         → Cards + métricas
apps/web/components/supervisor/analyze-form.tsx                 → Form de análise
apps/web/components/supervisor/analysis-result.tsx              → Resultado completo
apps/web/components/supervisor/stage-score-card.tsx             → Card por etapa
apps/web/components/supervisor/stage-timeline.tsx               → Timeline visual
apps/web/components/supervisor/negotiation-panel.tsx            → Painel negociação
apps/web/components/supervisor/protocol-editor.tsx              → Editor protocolo
apps/web/components/supervisor/training-list.tsx                → Lista de treinos

apps/web/lib/actions/supervisor.ts                              → Server actions
apps/web/lib/types/supervisor.ts                                → Types
```

### Arquivos a Modificar

```
apps/web/components/layout/sidebar.tsx          → Adicionar link Supervisor
apps/web/lib/types/audit.ts                     → Adicionar supervisor types
workers/src/main.py                             → Registrar supervisor analyzer no pipeline
workers/src/pipeline/analyzer.py                → Chamar supervisor analysis após análise padrão
apps/web/app/(dashboard)/calls/[id]/page.tsx    → Adicionar tab "Análise Supervisor" no detalhe
apps/web/components/calls/audit-tabs.tsx        → Nova tab
```

---

## 7. FASES DE IMPLEMENTAÇÃO

### Fase 1 — Fundação (3-4 dias)
1. Migration SQL (tabelas + índices + views)
2. Supervisor system prompt
3. Supervisor analyzer + parser no worker
4. Types no frontend
5. Server actions básicas

### Fase 2 — UI Core (3-4 dias)
1. Dashboard do supervisor
2. Tela de nova análise
3. Tela de resultado detalhado
4. Stage score cards
5. Timeline visual
6. Sidebar atualizado

### Fase 3 — Integração Pipeline (2-3 dias)
1. Análise automática no pipeline existente
2. Tab "Supervisor" no detalhe da call
3. Painel de negociação
4. Job queue para análise do supervisor

### Fase 4 — Inteligência (2-3 dias)
1. Configuração de protocolo
2. Ações de treinamento por closer
3. Histórico e tendências por etapa
4. Versionamento de protocolo

---

## 8. PESOS DO SCORE RECOMENDADOS

```
Abertura (quebra-gelo + rapport + pacto inicial): 13%
SPIN (4 subfases): 25%
Transição + Apresentação: 23%
Isolamento de objeções: 8%
Ancoragem + Preço: 18%
Negociação: 8%
Down Sell: 5%
```

### Classificação
- 9.0–10.0 → EXCELENTE (call referência)
- 7.0–8.9  → BOA (poucos ajustes)
- 5.0–6.9  → REGULAR (gargalos relevantes)
- 3.0–4.9  → FRACA (falhas estruturais)
- 0.0–2.9  → CRÍTICA (precisa retreinamento)

---

*Documento gerado em 25/03/2026*
