# PRD — Product Requirements Document
# CallAudit: Sistema de Auditoria de Calls de Fechamento High Ticket
## Versão 1.0 | Março 2026

---

## 1. Visão do Produto

### 1.1 Problema
Closers de vendas high ticket operam sem feedback estruturado. Supervisores não têm tempo para ouvir 100% das calls. Quando ouvem, a avaliação é subjetiva. Não existe histórico mensurável de evolução, nem padronização de método. Isso resulta em closers estagnados, calls perdidas por erros repetitivos, e zero previsibilidade de performance comercial.

### 1.2 Solução
CallAudit é uma plataforma que recebe gravações de calls de fechamento, transcreve automaticamente, analisa com IA contra 10 frameworks especializados e 13 dimensões de scoring, gera relatórios acionáveis com reescrita de falas, e distribui resumos para supervisores — tudo em menos de 5 minutos após o upload.

### 1.3 Proposta de Valor
- Para **closers**: feedback específico com scripts corrigidos a cada call
- Para **supervisores**: dashboard de evolução de cada closer sem precisar ouvir calls
- Para **gestores**: métricas de performance comercial baseadas em dados, não impressões

### 1.4 Visão de Longo Prazo
Iniciar como ferramenta interna da System Digital. Evoluir para SaaS multi-tenant para consultorias comerciais, clínicas com times de vendas, e operações de high ticket em geral.

---

## 2. Personas

### Persona 1: Closer (Evelyn)
- Faz 3-5 calls de fechamento por semana
- Quer saber onde está errando e como melhorar
- Precisa de feedback específico, não genérico
- Usa WhatsApp como canal primário

### Persona 2: Supervisor (Renan/Mateus)
- Gerencia 2-5 closers
- Não tem tempo de ouvir todas as calls
- Precisa de visão macro (dashboard) e micro (drill-down por call)
- Toma decisões de treinamento com base nos dados

### Persona 3: Gestor/Dono (futuro SaaS)
- Quer ver ROI do time comercial
- Precisa de taxa de fechamento, evolução de score, gargalos recorrentes
- Acessa via desktop, consultas rápidas via mobile

---

## 3. Arquitetura Técnica

### 3.1 Stack Definido

| Camada | Tecnologia | Justificativa |
|---|---|---|
| Frontend | Next.js 14 (App Router) | SSR, Server Actions, React Server Components, deploy fácil |
| UI Components | shadcn/ui + Tailwind CSS | Consistente, acessível, customizável |
| Auth | Supabase Auth | JWT, magic link, OAuth, RLS nativo |
| Database | Supabase (PostgreSQL) | RLS, realtime, edge functions, free tier generoso |
| File Storage (primário) | Supabase Storage | Integrado com RLS, API simples, buckets por tipo |
| File Storage (sync) | Google Drive | Pasta compartilhada para upload manual dos closers, sync bidirecional |
| Pipeline Worker | Python 3.11+ (scripts) | Melhor para audio processing, chamadas de API, parsing |
| Transcrição | OpenAI Whisper API | Melhor qualidade PT-BR |
| Análise IA | Anthropic Claude API (Sonnet) | Melhor custo-benefício para análise longa |
| Notificações | Evolution API (WhatsApp) + Resend (Email) | WhatsApp self-hosted, Resend tem free tier |
| Deploy Frontend | Vercel | Zero-config para Next.js |
| Deploy Workers | Oracle VPS (ARM) | Gratuito, já configurado |
| Fila de Jobs | Supabase Realtime + pg_cron ou BullMQ | Async processing |
| Versionamento | GitHub | CI/CD via GitHub Actions |

### 3.2 Diagrama de Arquitetura

```
                    ┌─────────────────┐
                    │  Google Drive    │──── Upload manual do closer
                    │  (Pasta por     │     (joga .ogg na pasta)
                    │   closer)       │
                    └───────┬─┬───────┘
                      Detect│ │Sync back
                      new   │ │(Fluxo A)
                      file  │ │
                    (Fluxo B)│ │
┌────────────────────────────┼─┼──────────────────────────────────┐
│                 FRONTEND   │ │  (Next.js 14)                     │
│                 Deploy:    │ │  Vercel                            │
│                            │ │                                   │
│  ┌──────────┐  ┌──────────┼─┼┐  ┌──────────┐  ┌──────────┐    │
│  │ Dashboard │  │ Upload   │ ││  │ Detalhe  │  │ Config   │    │
│  │ (lista   │  │ (drag &  │ ││  │ (audit   │  │ (closers │    │
│  │  calls)  │  │  drop)   │ ││  │  completa│  │  perfis) │    │
│  └──────────┘  └──────────┘ ││  └──────────┘  └──────────┘    │
│                              ││                                  │
│                    Server Actions / API Routes                   │
└──────────────────────────────┼┼──────────────────────────────────┘
                               ││
                    ┌──────────┴┴─────────┐
                    │   Supabase Cloud     │
                    │                      │
                    │  ┌────────────────┐  │
                    │  │  PostgreSQL    │  │
                    │  │  - call_audits │  │
                    │  │  - closers     │  │
                    │  │  - job_queue   │  │
                    │  │  - drive_sync  │  │
                    │  │  - users       │  │
                    │  └────────────────┘  │
                    │                      │
                    │  ┌────────────────┐  │
                    │  │  Storage       │  │
                    │  │  - audios/     │  │
                    │  │  - reports/    │  │
                    │  └────────────────┘  │
                    │                      │
                    │  ┌────────────────┐  │
                    │  │  Auth          │  │
                    │  │  (JWT + RLS)   │  │
                    │  └────────────────┘  │
                    └──────────┬───────────┘
                               │
                    ┌──────────┴──────────┐
                    │  WORKER (Python)     │
                    │  Deploy: Oracle VPS  │
                    │                      │
                    │  ┌────────────────┐  │
                    │  │  job_runner.py │  │
                    │  │  - poll queue  │  │
                    │  │  - transcribe  │  │
                    │  │  - analyze     │  │
                    │  │  - notify      │  │
                    │  └────────────────┘  │
                    │  ┌────────────────┐  │
                    │  │ drive_watcher  │  │
                    │  │  - poll Drive  │  │
                    │  │  - sync ↔ Supa │  │
                    │  │  - anti-loop   │  │
                    │  └────────────────┘  │
                    │                      │
                    │  APIs externas:      │
                    │  - Google Drive API  │
                    │  - Whisper API       │
                    │  - Claude API        │
                    │  - Evolution API     │
                    │  - Resend API        │
                    └─────────────────────┘
```

### 3.3 Fluxos de Dados (DOIS PONTOS DE ENTRADA + SYNC BIDIRECIONAL)

O sistema aceita uploads por DOIS caminhos. Ambos convergem no mesmo pipeline. O arquivo SEMPRE fica em ambos os storages (Drive + Supabase).

**FLUXO A — Upload via Frontend (closer/supervisor usa o app)**
```
1. Usuário faz upload do áudio via frontend (drag & drop)
2. Next.js Server Action salva no Supabase Storage (bucket: audios/)
3. Server Action cria registro na tabela call_audits (status: 'uploaded')
4. Server Action insere job na tabela job_queue (tipo: 'process_call')
5. Python Worker detecta novo job (polling a cada 30s)
6. Worker TAMBÉM faz upload do áudio para Google Drive (pasta do closer)
   → Registra drive_file_id na tabela drive_sync (flag: origin='frontend')
7. Worker baixa áudio do Supabase Storage
8. Worker envia para Whisper API → recebe transcrição
9. Worker salva transcrição no call_audits (status: 'transcribed')
10. Worker envia transcrição + System Prompt para Claude API → recebe análise
11. Worker parseia análise (scores, erros, acertos, plano de ação)
12. Worker salva tudo no call_audits (status: 'analyzed')
13. Worker envia resumo via WhatsApp (Evolution API)
14. Worker envia relatório via Email (Resend)
15. Worker salva relatório no Google Drive (pasta Relatórios/closer/)
16. Worker atualiza status para 'completed'
17. Frontend exibe resultados em tempo real (Supabase Realtime)
```

**FLUXO B — Upload via Google Drive (closer só joga arquivo na pasta)**
```
1. Closer salva gravação na pasta: Gravações/evelyn/2026-03-20_lead.ogg
2. Worker (drive_watcher) detecta novo arquivo via Google Drive API (polling a cada 2min)
3. Worker consulta tabela drive_sync → se drive_file_id já existe, IGNORA (veio do Fluxo A)
4. Se arquivo é novo: Worker baixa do Drive → salva no Supabase Storage
5. Worker cria registro em call_audits (status: 'uploaded')
   - closer_name: extraído do nome da pasta pai
   - lead_name: extraído do nome do arquivo (após a data)
   - call_date: extraído do nome do arquivo (antes do underscore)
6. Worker registra na tabela drive_sync (flag: origin='drive')
7. Worker insere job na job_queue (tipo: 'process_call')
8. Pipeline normal: transcreve → analisa → salva → notifica
9. Resultados aparecem no frontend automaticamente
```

**REGRA ANTI-LOOP (CRÍTICA):**
A tabela `drive_sync` registra todo arquivo sincronizado com `drive_file_id` + `origin` ('frontend' ou 'drive'). Quando:
- Fluxo A cria arquivo no Drive: registra com origin='frontend'
- Fluxo B detecta arquivo no Drive: verifica se ID já existe → se sim, ignora
- Resultado: NUNCA há processamento duplicado
```

---

## 4. Features — MVP (v1.0)

### F1 — Autenticação
- Login com email/senha
- Proteção de rotas
- RLS no Supabase (cada org vê só seus dados)

### F2 — Dashboard Principal
- Lista de todas as calls auditadas
- Filtros: closer, data, score, classificação, resultado
- Ordenação por qualquer coluna
- Cards de resumo no topo: total calls, média score, taxa fechamento, calls esta semana
- Status em tempo real: uploaded → transcribing → analyzing → completed

### F3 — Upload de Call (Frontend)
- Drag & drop ou file picker
- Selecionar closer (dropdown dos closers cadastrados)
- Campo: nome do lead
- Campo: data da call
- Campo: resultado (fechamento / não fechou / reagendar)
- Campo: valor do fechamento (se aplicável)
- Aceitar: .ogg, .mp3, .mp4, .webm, .wav, .m4a
- Limite: 500MB por arquivo
- Progress bar de upload
- Após upload: salva no Supabase Storage + copia para Google Drive (pasta do closer)
- Redirecionar para página de detalhe (com status "processando")

### F3b — Sync Bidirecional Google Drive ↔ Supabase (CORE)
- **Drive → Supabase:** Worker monitora pasta "Gravações/" no Drive a cada 2 minutos. Arquivo novo detectado → baixa → salva no Supabase Storage → cria audit → inicia pipeline. Closer e lead extraídos do nome da pasta e arquivo.
- **Frontend → Drive:** Quando upload é feito pelo app, o Worker copia o arquivo para a pasta do closer no Drive automaticamente.
- **Anti-loop:** Tabela `drive_sync` com `drive_file_id` + `origin` impede processamento duplicado.
- **Relatório no Drive:** Após análise completa, relatório (.md) é salvo na pasta Relatórios/[closer]/ no Drive.
- **Estrutura de pastas no Drive:**
  ```
  📁 Auditorias Comerciais/
    📁 Gravações/
      📁 evelyn/
        2026-03-02_elane-lima.ogg
      📁 gustavo/
    📁 Relatórios/
      📁 evelyn/
        2026-03-02_elane-lima_auditoria.md
      📁 gustavo/
  ```
- **Convenção de nome:** `YYYY-MM-DD_nome-do-lead.ogg` — a data e o lead são extraídos automaticamente
- **Configurável:** IDs das pastas do Drive são armazenados em `app_config`
- **Visível no frontend:** Cada audit mostra link para o arquivo no Drive e link para o relatório no Drive

### F4 — Detalhe da Auditoria
- Header: closer, lead, data, duração, resultado, score (destaque grande)
- Classificação com cor (Elite/Forte/Mediana/Fraca)
- Tab 1: Scorecard — 13 dimensões com notas, barra de progresso, justificativa
- Tab 2: Relatório Completo — markdown renderizado da análise do Claude
- Tab 3: Transcrição — texto completo com timestamps
- Tab 4: Erros & Acertos — top 5 cada, com trechos e correções
- Tab 5: Reescrita de Falas — original vs corrigido side by side
- Tab 6: Plano de Ação — 5 prioridades para próxima call
- Botão: download relatório (.md ou .pdf)
- Player de áudio integrado

### F5 — Gestão de Closers
- CRUD de closers (nome, email, WhatsApp, foto)
- Perfil do closer: média de score, evolução, calls totais, taxa de fechamento
- Gráfico de evolução de score ao longo do tempo
- Radar chart com média das 13 dimensões (mostra pontos fortes e fracos)

### F6 — Notificações
- WhatsApp: resumo enviado para grupo e/ou individual
- Email: relatório completo para supervisores
- Configurável: quem recebe o quê

### F7 — Configurações
- Cadastro de closers
- Cadastro de supervisores (com canais de notificação)
- Chaves de API (Whisper, Claude, Evolution, Resend)
- Grupo WhatsApp para notificações

---

## 5. Features — Futuras (v2.0+)

- F8: Comparativo entre closers (ranking, benchmark)
- F9: Detecção automática de speakers (diarização)
- F10: Integração com Google Meet/Zoom (auto-import)
- F11: Multi-tenant SaaS (organizações separadas)
- F12: Customização de frameworks e pesos do scorecard
- F13: Gravação direta pelo app (sem precisar de arquivo externo)
- F14: App mobile (React Native) para consulta rápida
- F15: Webhook para integração com CRMs

---

## 6. Schema do Banco de Dados

### Tabelas

```sql
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

-- Sync bidirecional Google Drive ↔ Supabase (anti-loop)
CREATE TABLE drive_sync (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  drive_file_id TEXT NOT NULL UNIQUE, -- ID do arquivo no Google Drive
  drive_folder_id TEXT, -- ID da pasta (identifica o closer)
  audit_id UUID REFERENCES call_audits(id),
  file_name TEXT NOT NULL,
  origin TEXT NOT NULL CHECK (origin IN ('frontend', 'drive')),
    -- 'frontend': arquivo subiu pelo app e foi copiado pro Drive
    -- 'drive': arquivo subiu pelo Drive e foi copiado pro Supabase
  synced_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_drive_sync_file_id ON drive_sync(drive_file_id);
CREATE INDEX idx_drive_sync_audit ON drive_sync(audit_id);

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
```

---

## 7. Estrutura de Diretórios do Projeto

```
callaudit/
├── .github/
│   └── workflows/
│       ├── ci.yml                    # Lint + tests on PR
│       └── deploy.yml                # Deploy on push to main
│
├── apps/
│   └── web/                          # Next.js 14 App
│       ├── app/
│       │   ├── (auth)/
│       │   │   ├── login/page.tsx
│       │   │   └── layout.tsx
│       │   ├── (dashboard)/
│       │   │   ├── layout.tsx         # Sidebar + header
│       │   │   ├── page.tsx           # Dashboard principal
│       │   │   ├── calls/
│       │   │   │   ├── page.tsx       # Lista de calls
│       │   │   │   ├── [id]/page.tsx  # Detalhe da auditoria
│       │   │   │   └── upload/page.tsx # Upload de call
│       │   │   ├── closers/
│       │   │   │   ├── page.tsx       # Lista de closers
│       │   │   │   └── [id]/page.tsx  # Perfil do closer
│       │   │   └── settings/
│       │   │       └── page.tsx       # Configurações
│       │   ├── api/
│       │   │   ├── webhooks/
│       │   │   │   └── processing/route.ts  # Webhook do worker
│       │   │   └── cron/
│       │   │       └── cleanup/route.ts     # Limpeza periódica
│       │   ├── layout.tsx
│       │   └── globals.css
│       ├── components/
│       │   ├── ui/                    # shadcn/ui components
│       │   ├── dashboard/
│       │   │   ├── stats-cards.tsx
│       │   │   ├── recent-calls.tsx
│       │   │   └── score-chart.tsx
│       │   ├── calls/
│       │   │   ├── call-list.tsx
│       │   │   ├── call-detail.tsx
│       │   │   ├── scorecard-display.tsx
│       │   │   ├── report-viewer.tsx
│       │   │   ├── transcription-viewer.tsx
│       │   │   ├── errors-acertos.tsx
│       │   │   ├── rewrite-comparison.tsx
│       │   │   ├── action-plan.tsx
│       │   │   └── audio-player.tsx
│       │   ├── closers/
│       │   │   ├── closer-card.tsx
│       │   │   ├── closer-profile.tsx
│       │   │   ├── radar-chart.tsx
│       │   │   └── evolution-chart.tsx
│       │   ├── upload/
│       │   │   ├── upload-form.tsx
│       │   │   ├── dropzone.tsx
│       │   │   └── processing-status.tsx
│       │   └── layout/
│       │       ├── sidebar.tsx
│       │       ├── header.tsx
│       │       └── mobile-nav.tsx
│       ├── lib/
│       │   ├── supabase/
│       │   │   ├── client.ts          # Browser client
│       │   │   ├── server.ts          # Server client
│       │   │   └── middleware.ts       # Auth middleware
│       │   ├── actions/
│       │   │   ├── calls.ts           # Server actions for calls
│       │   │   ├── closers.ts         # Server actions for closers
│       │   │   ├── upload.ts          # Server action for upload
│       │   │   └── config.ts          # Server actions for config
│       │   ├── types/
│       │   │   ├── database.ts        # Supabase generated types
│       │   │   ├── audit.ts           # Audit-specific types
│       │   │   └── api.ts             # API response types
│       │   └── utils/
│       │       ├── format.ts          # Date, number, score formatting
│       │       ├── colors.ts          # Score-to-color mapping
│       │       └── constants.ts       # Dimension names, weights, etc
│       ├── hooks/
│       │   ├── use-realtime-audit.ts  # Supabase realtime subscription
│       │   └── use-upload.ts          # Upload with progress
│       ├── next.config.js
│       ├── tailwind.config.ts
│       ├── tsconfig.json
│       └── package.json
│
├── workers/                           # Python processing pipeline
│   ├── src/
│   │   ├── __init__.py
│   │   ├── main.py                    # Job runner (polling loop, 30s)
│   │   ├── config.py                  # Environment variables
│   │   ├── db.py                      # Supabase client wrapper
│   │   ├── storage.py                 # Supabase storage operations
│   │   ├── drive/
│   │   │   ├── __init__.py
│   │   │   ├── watcher.py             # Polling Drive a cada 2min, detecta novos arquivos
│   │   │   ├── sync.py                # Sync bidirecional (Drive↔Supabase) + anti-loop
│   │   │   └── client.py              # Google Drive API wrapper
│   │   ├── pipeline/
│   │   │   ├── __init__.py
│   │   │   ├── transcriber.py         # Whisper API integration
│   │   │   ├── analyzer.py            # Claude API integration
│   │   │   ├── parser.py              # Parse Claude output → structured data
│   │   │   └── preprocessor.py        # Audio metadata, speaker estimation
│   │   ├── notifications/
│   │   │   ├── __init__.py
│   │   │   ├── whatsapp.py            # Evolution API
│   │   │   └── email.py               # Resend API
│   │   ├── prompts/
│   │   │   └── system_prompt.py       # System prompt as Python constant
│   │   └── utils/
│   │       ├── __init__.py
│   │       └── scoring.py             # Score calculation helpers
│   ├── tests/
│   │   ├── __init__.py
│   │   ├── test_transcriber.py
│   │   ├── test_analyzer.py
│   │   ├── test_parser.py
│   │   ├── test_drive_sync.py         # Testes do sync bidirecional + anti-loop
│   │   ├── test_notifications.py
│   │   ├── test_pipeline_integration.py
│   │   └── fixtures/
│   │       ├── sample_transcription.txt
│   │       ├── sample_analysis.md
│   │       └── sample_audio.ogg
│   ├── requirements.txt
│   ├── Dockerfile
│   └── README.md
│
├── supabase/
│   └── migrations/
│       └── 001_initial_schema.sql     # O SQL completo acima
│
├── docs/
│   ├── PRD.md                         # Este documento
│   ├── TDD.md                         # Technical Design Document
│   ├── SYSTEM_PROMPT.md               # System prompt do analista
│   ├── PLAYBOOK.md                    # Protocolo de 6 fases
│   └── DEPLOYMENT.md                  # Guia de deploy
│
├── .env.example
├── .gitignore
├── package.json                       # Workspace root (monorepo)
└── README.md
```

---

## 8. Wireframes (Descrição Textual)

### 8.1 Dashboard Principal (`/`)
```
┌─────────────────────────────────────────────────┐
│ [Logo] CallAudit          [User Avatar ▼]       │
├──────┬──────────────────────────────────────────┤
│      │                                          │
│ Nav  │  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐   │
│      │  │ 47   │ │ 7.2  │ │ 68%  │ │ 5    │   │
│ 🏠   │  │Calls │ │Score │ │Fech. │ │Semana│   │
│ 📞   │  │Total │ │Médio │ │Rate  │ │      │   │
│ 👥   │  └──────┘ └──────┘ └──────┘ └──────┘   │
│ ⬆️   │                                          │
│ ⚙️   │  Calls Recentes                          │
│      │  ┌────────────────────────────────────┐  │
│      │  │ Closer  Lead    Data   Score Class │  │
│      │  │ Evelyn  Elane   03/02  6.8  FORTE │  │
│      │  │ Gustavo Maria   03/15  7.5  FORTE │  │
│      │  │ Evelyn  Julia   03/18  8.7  ELITE │  │
│      │  └────────────────────────────────────┘  │
│      │                                          │
│      │  Evolução de Score (gráfico de linha)    │
│      │  ┌────────────────────────────────────┐  │
│      │  │ 📈 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~   │  │
│      │  └────────────────────────────────────┘  │
└──────┴──────────────────────────────────────────┘
```

### 8.2 Upload (`/calls/upload`)
```
┌──────────────────────────────────────────┐
│  Upload de Call                          │
│                                          │
│  ┌────────────────────────────────────┐  │
│  │                                    │  │
│  │   📎 Arraste o áudio aqui         │  │
│  │      ou clique para selecionar    │  │
│  │                                    │  │
│  │   .ogg .mp3 .mp4 .wav .m4a       │  │
│  │   Máximo: 500MB                   │  │
│  └────────────────────────────────────┘  │
│                                          │
│  Closer:  [ Evelyn          ▼ ]         │
│  Lead:    [ __________________ ]         │
│  Data:    [ 2026-03-20         ]         │
│  Resultado: [○Fechamento ○Não ○Outro]   │
│  Valor:   [ R$ ______________ ]         │
│                                          │
│  [ Enviar para Análise ]                │
└──────────────────────────────────────────┘
```

### 8.3 Detalhe da Auditoria (`/calls/[id]`)
```
┌──────────────────────────────────────────────────┐
│  ← Voltar                                        │
│                                                   │
│  Evelyn x Elane Lima                             │
│  02/03/2026 | 164 min | Fechamento R$ 44.000     │
│                                                   │
│  ┌──────────────────────┐                        │
│  │    6.8 / 10          │  CALL FORTE            │
│  │    ████████░░        │                        │
│  └──────────────────────┘                        │
│                                                   │
│  [Scorecard] [Relatório] [Transcrição] [Erros]   │
│  [Reescrita] [Plano de Ação]                     │
│                                                   │
│  ┌──────────────────────────────────────────┐    │
│  │ # | Dimensão              | Nota | Peso  │    │
│  │ 1 | Frame e Liderança     | 8.5  | 8%   │    │
│  │ 2 | Qualificação          | 5.0  | 10%  │    │
│  │ 3 | Diag. Quantitativo    | 4.0  | 12%  │    │
│  │ ...                                       │    │
│  └──────────────────────────────────────────┘    │
│                                                   │
│  [▶ Player de Áudio ━━━━━━━━━━━━━━━ 02:44:17]   │
│                                                   │
│  [📥 Download Relatório]  [📤 Reenviar Notif.]   │
└──────────────────────────────────────────────────┘
```

---

## 9. Requisitos Não-Funcionais

| Requisito | Meta |
|---|---|
| Tempo de processamento | <5 min para call de 1h |
| Uptime | 99% (considerando infra free tier) |
| Tamanho máximo de upload | 500MB |
| Formatos de áudio aceitos | ogg, mp3, mp4, webm, wav, m4a |
| Responsividade | Mobile-first (consultável no celular) |
| Latência do dashboard | <2s para carregar lista de calls |
| Concurrent uploads | Até 3 simultâneos |
| Retenção de dados | Indefinida (Supabase free tier: 500MB DB) |
| Segurança | Auth obrigatório, RLS ativo, API keys no servidor |

---

## 10. Métricas de Sucesso (v1.0)

| Métrica | Meta |
|---|---|
| Calls auditadas no primeiro mês | ≥20 |
| Tempo médio entre upload e relatório | <5 minutos |
| Score médio dos closers (depois de 1 mês usando) | +0.5 ponto vs primeira call |
| Taxa de uso (closers que fazem upload semanalmente) | ≥80% |
| NPS dos supervisores | ≥8/10 |

---

## 11. Cronograma de Desenvolvimento

| Fase | Duração | Entregas |
|---|---|---|
| **Sprint 1** — Setup + DB + Auth | 2-3 dias | Projeto Next.js, Supabase schema, auth flow, layout |
| **Sprint 2** — Upload + Worker base | 2-3 dias | Upload form, Supabase Storage, Python job runner, Whisper integration |
| **Sprint 3** — Análise IA + Parser | 2-3 dias | Claude integration, parser do output, salvar scores |
| **Sprint 4** — Dashboard + Lista | 2-3 dias | Dashboard stats, lista de calls com filtros, detalhe básico |
| **Sprint 5** — Detalhe completo | 2-3 dias | Todas as tabs do detalhe, player de áudio, markdown render |
| **Sprint 6** — Closers + Notificações | 2-3 dias | CRUD closers, perfil, radar chart, WhatsApp, Email |
| **Sprint 7** — Polish + Deploy | 2-3 dias | Responsividade, loading states, error handling, deploy |
| **TOTAL** | **~15-20 dias** | MVP completo |
