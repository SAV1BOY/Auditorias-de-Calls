# Sprint 9 — Coaching e Treinamento

## Visão Geral

Sprint 9 transforma o CallAudit de ferramenta analítica em plataforma de coaching ativo. Três features:

| # | Feature | Ref MARKET-RESEARCH |
|---|---------|---------------------|
| 1 | Biblioteca de Calls Modelo | 2.3 |
| 2 | Coaching Assíncrono (Comentários em Timestamp) | 2.10 |
| 3 | Resumo Executivo Semanal Automático | 2.8 |

---

## 1. Banco de Dados — Migration 004

### 1.1 Tabela `call_bookmarks` (Biblioteca de Calls Modelo)

```sql
CREATE TABLE call_bookmarks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  organization_id UUID REFERENCES organizations(id),
  bookmarked_by UUID REFERENCES profiles(id),
  tags TEXT[] DEFAULT '{}',          -- ex: ['excelente-ancoragem', 'objecao-preco']
  highlight_timestamps JSONB DEFAULT '[]',
    -- ex: [{"start_sec": 120, "end_sec": 180, "label": "Ancoragem perfeita"}]
  notes TEXT,                        -- nota livre do supervisor
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_call_bookmarks_audit ON call_bookmarks(audit_id);
CREATE INDEX idx_call_bookmarks_org ON call_bookmarks(organization_id);
CREATE INDEX idx_call_bookmarks_tags ON call_bookmarks USING GIN(tags);

ALTER TABLE call_bookmarks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON call_bookmarks FOR ALL TO authenticated USING (true) WITH CHECK (true);
```

### 1.2 Tabela `call_comments` (Coaching Assíncrono)

```sql
CREATE TABLE call_comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES profiles(id),
  parent_id UUID REFERENCES call_comments(id) ON DELETE CASCADE, -- thread/resposta
  timestamp_sec NUMERIC(8,1),       -- momento no áudio (NULL = comentário geral)
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
CREATE POLICY "authenticated_all" ON call_comments FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE TRIGGER trigger_call_comments_updated
  BEFORE UPDATE ON call_comments FOR EACH ROW EXECUTE FUNCTION update_updated_at();
```

### 1.3 Tabela `weekly_reports` (Resumo Executivo Semanal)

```sql
CREATE TABLE weekly_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  week_start DATE NOT NULL,          -- segunda-feira da semana
  week_end DATE NOT NULL,            -- domingo
  report_markdown TEXT NOT NULL,      -- relatório completo gerado pela IA
  stats JSONB NOT NULL DEFAULT '{}',
    -- {total_calls, score_avg, score_avg_prev, top_closers: [...],
    --  most_improved_closer, weakest_dimension, best_call_id, worst_call_id,
    --  taxa_fechamento, taxa_fechamento_meta}
  sent_whatsapp BOOLEAN DEFAULT FALSE,
  sent_email BOOLEAN DEFAULT FALSE,
  sent_at TIMESTAMPTZ,
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_weekly_reports_week ON weekly_reports(organization_id, week_start);

ALTER TABLE weekly_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON weekly_reports FOR ALL TO authenticated USING (true) WITH CHECK (true);
```

### 1.4 Novo job_type na `job_queue`

```sql
ALTER TABLE job_queue DROP CONSTRAINT job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report'));
```

---

## 2. Feature 1 — Biblioteca de Calls Modelo

### 2.1 Objetivo
Curadoria de calls exemplares para treinamento. Supervisor marca calls como "modelo" com tags e timestamps dos melhores momentos.

### 2.2 Frontend — Componentes

| Componente | Arquivo | Tipo |
|------------|---------|------|
| `BookmarkButton` | `components/calls/bookmark-button.tsx` | Client |
| `BookmarkDialog` | `components/calls/bookmark-dialog.tsx` | Client |
| `LibraryPage` | `app/(dashboard)/library/page.tsx` | Server |
| `LibraryFilters` | `components/library/library-filters.tsx` | Client |
| `LibraryList` | `components/library/library-list.tsx` | Client |
| `TrainingPlaylist` | `components/library/training-playlist.tsx` | Client |

### 2.3 Fluxo

```
1. Supervisor abre detalhe de call → clica no ícone ★ (BookmarkButton)
2. BookmarkDialog abre → adicionar tags, selecionar highlight timestamps, nota
3. Call aparece na página /library
4. Filtros: por tag, por dimensão forte, por closer, por classificação (ELITE only default)
5. Montar "playlist" selecionando N calls → compartilhar link para closer estudar
```

### 2.4 Server Actions

```typescript
// lib/actions/bookmarks.ts
'use server'

export async function toggleBookmark(auditId: string, data: {
  tags: string[]
  highlightTimestamps: { startSec: number; endSec: number; label: string }[]
  notes?: string
}): Promise<{ success: boolean }>

export async function removeBookmark(auditId: string): Promise<{ success: boolean }>

export async function getBookmarkedCalls(filters: {
  tags?: string[]
  closerId?: string
  classificacao?: string
}): Promise<BookmarkedCall[]>
```

### 2.5 Melhorias no Audio Player

O `audio-player.tsx` atual é básico (HTML5 nativo). Para a biblioteca funcionar bem, precisa:
- Exibir **markers** visuais na timeline (highlight_timestamps)
- Botão para pular para o próximo highlight
- Indicador visual do trecho destacado durante a reprodução

Refatorar para componente customizado com barra de progresso interativa.

### 2.6 Tarefas

- [ ] Migration 004 (tabela `call_bookmarks`)
- [ ] Type `CallBookmark` em `database.ts`
- [ ] Server Actions (toggle, remove, list)
- [ ] `BookmarkButton` + `BookmarkDialog` na página de detalhe da call
- [ ] Página `/library` com filtros e lista
- [ ] Refatorar `AudioPlayer` com timeline markers
- [ ] Componente `TrainingPlaylist` (selecionar e compartilhar)

---

## 3. Feature 2 — Coaching Assíncrono (Comentários em Timestamp)

### 3.1 Objetivo
Supervisor deixa feedback pontual em momentos específicos do áudio. Closer recebe notificação, responde, marca como resolvido. Substitui 1:1 síncrono.

### 3.2 Frontend — Componentes

| Componente | Arquivo | Tipo |
|------------|---------|------|
| `CommentsPanel` | `components/calls/comments-panel.tsx` | Client |
| `CommentMarker` | `components/calls/comment-marker.tsx` | Client |
| `CommentThread` | `components/calls/comment-thread.tsx` | Client |
| `CommentForm` | `components/calls/comment-form.tsx` | Client |
| Tab "Coaching" | Adicionar em `audit-tabs.tsx` | Client |

### 3.3 Fluxo

```
1. Supervisor abre detalhe da call → tab "Coaching"
2. Clica na timeline do áudio no momento desejado
3. Form abre ancorado no timestamp → escreve comentário → salva
4. Marker aparece na timeline (ícone de balão)
5. Closer recebe notificação (WhatsApp/email): "Novo feedback na call X"
6. Closer abre → vê comentários sincronizados com áudio
7. Pode responder (thread) ou marcar como "resolvido" ✓
8. Realtime: usar Supabase Realtime para atualizar sem reload
```

### 3.4 Server Actions

```typescript
// lib/actions/comments.ts
'use server'

export async function createComment(data: {
  auditId: string
  timestampSec?: number
  content: string
  parentId?: string       // se for resposta
}): Promise<{ id: string }>

export async function resolveComment(commentId: string): Promise<void>

export async function getComments(auditId: string): Promise<CommentThread[]>

export async function deleteComment(commentId: string): Promise<void>
```

### 3.5 Melhorias no Audio Player (compartilhado com Feature 1)

- `onTimeClick` callback — quando supervisor clica na timeline, captura o timestamp
- Markers visuais para comentários (diferentes dos highlights da biblioteca)
- Clicar no marker → scroll para o comentário correspondente
- Clicar no comentário → seek do áudio para o timestamp

### 3.6 Notificação

Reutilizar o `notifier.py` existente. Adicionar template:
```
📝 Novo feedback do supervisor na call "{lead_name}" ({call_date})
Timestamp: {MM:SS}
"{comment_preview}..."
👉 Ver: {link}
```

### 3.7 Tarefas

- [ ] Migration 004 (tabela `call_comments`)
- [ ] Type `CallComment` em `database.ts`
- [ ] Server Actions (create, resolve, list, delete)
- [ ] `CommentsPanel` com lista de comentários
- [ ] `CommentThread` (thread de respostas)
- [ ] `CommentForm` ancorado em timestamp
- [ ] `CommentMarker` na timeline do audio player
- [ ] Tab "Coaching" no `audit-tabs.tsx`
- [ ] Supabase Realtime subscription para novos comentários
- [ ] Template de notificação WhatsApp/email no worker
- [ ] Marcar como resolvido (UI + action)

---

## 4. Feature 3 — Resumo Executivo Semanal Automático

### 4.1 Objetivo
Relatório semanal gerado pela IA toda segunda-feira, enviado por WhatsApp/email. Supervisor não precisa entrar no app para ter visão geral.

### 4.2 Worker — `weekly_reporter.py`

Novo módulo no worker:

```python
# workers/src/weekly_reporter.py

class WeeklyReporter:
    """Gera resumo executivo semanal usando Claude API."""

    def should_generate(self) -> bool:
        """Verifica se é segunda-feira e se o relatório da semana ainda não foi gerado."""

    def collect_stats(self, org_id: str, week_start: date, week_end: date) -> WeeklyStats:
        """Coleta estatísticas da semana do banco."""
        # - Total de calls auditadas
        # - Score médio (e delta vs semana anterior)
        # - Top 3 closers por score
        # - Closer que mais evoluiu (maior delta positivo)
        # - Dimensão mais fraca do time
        # - Melhor e pior call da semana
        # - Taxa de fechamento vs meta (da tabela goals)

    def generate_report(self, stats: WeeklyStats) -> str:
        """Envia stats para Claude API e recebe relatório formatado em markdown."""

    def send_report(self, org_id: str, report: str) -> None:
        """Envia por WhatsApp e/ou email conforme app_config."""

    def run(self) -> None:
        """Entry point: check → collect → generate → save → send."""
```

### 4.3 System Prompt para Geração do Resumo

```
Você é o analista-chefe do CallAudit. Gere um resumo executivo semanal CONCISO e ACIONÁVEL.

Formato:
📊 RESUMO SEMANAL — {data_inicio} a {data_fim}

🔢 NÚMEROS DA SEMANA
- X calls auditadas (↑/↓ Y% vs semana anterior)
- Score médio: X.X (↑/↓ X.X)
- Taxa de fechamento: XX% (meta: XX%)

🏆 TOP 3 CLOSERS
1. Nome — score X.X
2. Nome — score X.X
3. Nome — score X.X

📈 DESTAQUE DE EVOLUÇÃO
Nome subiu de X.X para X.X (+XX%) — maior evolução da semana

⚠️ PRIORIDADE DE TREINAMENTO
Dimensão "{nome}" com média X.X — a mais baixa do time

🌟 CALL DESTAQUE: "{lead}" por {closer} — score X.X
❌ CALL ATENÇÃO: "{lead}" por {closer} — score X.X

💡 RECOMENDAÇÃO DA SEMANA
{1-2 frases acionáveis baseadas nos dados}
```

### 4.4 Integração no Main Loop

```python
# workers/src/main.py — adicionar ao loop principal
# Roda check a cada 1h (não a cada 30s como os jobs normais)
if minutes_since_last_weekly_check >= 60:
    weekly_reporter.run()
    last_weekly_check = now
```

### 4.5 Frontend — Página de Relatórios Semanais

| Componente | Arquivo | Tipo |
|------------|---------|------|
| `WeeklyReportsPage` | `app/(dashboard)/reports/page.tsx` | Server |
| `WeeklyReportCard` | `components/reports/weekly-report-card.tsx` | Client |
| `WeeklyReportDetail` | `app/(dashboard)/reports/[id]/page.tsx` | Server |

### 4.6 Fluxo

```
1. Worker roda check toda hora
2. Se é segunda-feira e relatório da semana não existe → gera
3. Coleta stats → chama Claude API → recebe markdown
4. Salva em weekly_reports
5. Envia notificação (WhatsApp + email) com link
6. Supervisor vê em /reports ou recebe direto no WhatsApp
```

### 4.7 Tarefas

- [ ] Migration 004 (tabela `weekly_reports` + job_type update)
- [ ] Type `WeeklyReport` em `database.ts`
- [ ] `weekly_reporter.py` no worker (collect, generate, send)
- [ ] System prompt para geração do resumo
- [ ] Integração no `main.py` (check horário)
- [ ] Template de notificação WhatsApp/email
- [ ] Página `/reports` com lista de relatórios
- [ ] Página `/reports/[id]` com detalhe (markdown render)
- [ ] Link no sidebar

---

## 5. Refatoração Compartilhada — Audio Player

O `audio-player.tsx` atual usa `<audio controls>` nativo. Para Sprint 9, precisa ser refatorado para suportar:

### 5.1 Nova Interface

```typescript
interface AudioPlayerProps {
  audioPath: string | null
  markers?: AudioMarker[]           // comentários + highlights na timeline
  onTimeClick?: (sec: number) => void  // callback quando clica na timeline
  onTimeUpdate?: (sec: number) => void // callback do tempo atual
  currentSeek?: number               // seek externo (clicou num comentário)
}

interface AudioMarker {
  id: string
  timestampSec: number
  type: 'comment' | 'highlight'
  label?: string
  color?: string
}
```

### 5.2 Componentes Internos

```
AudioPlayer (container)
├── PlaybackControls (play/pause, skip ±10s, speed)
├── ProgressBar (seekable, com markers renderizados)
│   ├── MarkerDot (cada marker individual)
│   └── HighlightRange (trecho colorido para highlights)
├── TimeDisplay (current / duration)
└── VolumeControl
```

### 5.3 Tarefas

- [ ] Refatorar `audio-player.tsx` com custom UI (Tailwind, não nativo)
- [ ] Barra de progresso seekable com markers
- [ ] Callbacks `onTimeClick`, `onTimeUpdate`, `currentSeek`
- [ ] Controles: play/pause, ±10s, speed (0.5x/1x/1.5x/2x), volume
- [ ] Highlight ranges visuais na timeline

---

## 6. Sidebar — Novas Entradas

Adicionar ao `sidebar.tsx`:

```
📚 Biblioteca    → /library
📝 Coaching      → (integrado no detalhe da call, tab "Coaching")
📊 Relatórios    → /reports
```

---

## 7. Types — Adições ao `database.ts`

```typescript
export interface CallBookmark {
  id: string
  audit_id: string
  organization_id: string | null
  bookmarked_by: string | null
  tags: string[]
  highlight_timestamps: { start_sec: number; end_sec: number; label: string }[]
  notes: string | null
  created_at: string
}

export interface CallComment {
  id: string
  audit_id: string
  author_id: string
  parent_id: string | null
  timestamp_sec: number | null
  content: string
  resolved: boolean
  resolved_by: string | null
  resolved_at: string | null
  created_at: string
  updated_at: string
  // Joined
  author?: { full_name: string; avatar_url: string | null; role: string }
  replies?: CallComment[]
}

export interface WeeklyReport {
  id: string
  organization_id: string | null
  week_start: string
  week_end: string
  report_markdown: string
  stats: WeeklyStats
  sent_whatsapp: boolean
  sent_email: boolean
  sent_at: string | null
  generated_at: string
  created_at: string
}

export interface WeeklyStats {
  total_calls: number
  score_avg: number
  score_avg_prev: number | null
  top_closers: { id: string; name: string; score: number }[]
  most_improved_closer: { id: string; name: string; delta: number } | null
  weakest_dimension: { id: string; name: string; avg: number } | null
  best_call_id: string | null
  worst_call_id: string | null
  taxa_fechamento: number
  taxa_fechamento_meta: number | null
}
```

---

## 8. Ordem de Implementação

### Fase A — Database + Types (1 sessão)
1. Criar `supabase/migrations/004_coaching.sql` (todas as 3 tabelas + job_type)
2. Atualizar `database.ts` com novos types
3. Atualizar sidebar com novas entradas

### Fase B — Audio Player Refatorado (1 sessão)
4. Refatorar `audio-player.tsx` com UI customizada
5. Adicionar markers, callbacks, highlight ranges
6. Testar com dados mockados

### Fase C — Biblioteca de Calls Modelo (1-2 sessões)
7. Server Actions de bookmarks
8. `BookmarkButton` + `BookmarkDialog` no detalhe da call
9. Página `/library` com filtros e lista
10. `TrainingPlaylist`

### Fase D — Coaching Assíncrono (1-2 sessões)
11. Server Actions de comments
12. `CommentsPanel` + `CommentThread` + `CommentForm`
13. Tab "Coaching" no `audit-tabs.tsx`
14. Markers de comentários no audio player
15. Realtime subscription
16. Template de notificação no worker

### Fase E — Resumo Executivo Semanal (1-2 sessões)
17. `weekly_reporter.py` no worker
18. System prompt de geração
19. Integração no `main.py`
20. Página `/reports` + `/reports/[id]`
21. Template de notificação WhatsApp/email

### Fase F — Polish (1 sessão)
22. Loading states para novas páginas
23. Skeleton components
24. Error boundaries
25. Testes

---

## 9. Dependências Externas

| Dependência | Uso | Já instalada? |
|-------------|-----|---------------|
| `react-markdown` + `remark-gfm` | Render do resumo semanal | Sim |
| `recharts` | Nenhum novo gráfico neste sprint | Sim |
| Supabase Realtime | Comments em tempo real | Já configurado |
| Claude API | Geração do resumo semanal | Via worker (já existe) |
| Evolution API | Notificação WhatsApp | Via worker (já existe) |
| Resend | Notificação email | Via worker (já existe) |

**Nenhuma dependência nova necessária.**

---

## 10. Riscos e Mitigações

| Risco | Mitigação |
|-------|-----------|
| Audio player refatorado quebra UX existente | Manter fallback para `<audio controls>` nativo se custom falhar |
| Comentários em Realtime sobrecarregando | Throttle de 2s no subscription, batch updates |
| Resumo semanal com dados insuficientes | Se < 3 calls na semana, gerar nota simples em vez de relatório completo |
| Custo de Claude API para resumos semanais | ~500 tokens input + ~800 output = ~$0.01/semana por org (negligível) |
