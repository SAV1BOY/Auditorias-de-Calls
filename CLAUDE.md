# CLAUDE.md — Instruções para Claude Code

## Sobre o Projeto

CallAudit é um sistema de auditoria automática de calls de fechamento high ticket. Recebe gravações de calls, transcreve com Whisper API, analisa com Claude API contra 10 frameworks de vendas e 13 dimensões de scoring, e distribui relatórios para supervisores via WhatsApp e email.

## Arquitetura

- **Frontend:** Next.js 14 (App Router) em `apps/web/`
- **Worker:** Python 3.11+ em `workers/`
- **Database + Storage + Auth:** Supabase
- **APIs externas:** OpenAI Whisper, Anthropic Claude, Evolution API (WhatsApp), Resend (Email)

## Documentação Essencial — Ler ANTES de Codar

1. `docs/PRD.md` — Product Requirements (features, schema completo do banco, estrutura de diretórios, wireframes)
2. `docs/TDD.md` — Technical Design (ADRs, contratos de API, design do worker, deploy)
3. `docs/TESTS.md` — Especificações de testes (unitários, integração, E2E)
4. `05-system-prompt-analista/system-prompt-analista-calls-v1.md` — System prompt que o worker usa para análise

## Comandos

### Frontend (apps/web/)
```bash
cd apps/web
npm install
npm run dev          # Development server (localhost:3000)
npm run build        # Production build
npm run lint         # ESLint
npx vitest run       # Testes unitários
npx playwright test  # Testes E2E
```

### Worker (workers/)
```bash
cd workers
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python -m src.main   # Rodar worker
pytest tests/ -v     # Testes
```

### Supabase
```bash
# Migrations estão em supabase/migrations/
# Executar via Supabase Dashboard (SQL Editor) ou CLI
```

## Stack e Versões

| Dependência | Versão |
|---|---|
| Node.js | ≥18 |
| Next.js | 14.x (App Router) |
| React | 18.x |
| TypeScript | 5.x |
| Tailwind CSS | 3.x |
| shadcn/ui | latest |
| Python | ≥3.11 |
| Supabase JS | @supabase/supabase-js@2 |
| Recharts | 2.x (para gráficos) |

## Convenções de Código

### Frontend (TypeScript/React)
- Server Components por padrão. Client Components (`'use client'`) apenas quando necessário (interatividade, hooks)
- Server Actions para mutações (não API routes)
- `lib/supabase/server.ts` para server-side, `lib/supabase/client.ts` para client-side
- Tipos gerados do Supabase em `lib/types/database.ts`
- Componentes em PascalCase, arquivos em kebab-case
- shadcn/ui para todos os componentes base de UI
- Tailwind para estilização — não usar CSS modules

### Worker (Python)
- Type hints obrigatórios em todas as funções
- Docstrings em todas as classes e funções públicas
- `dataclasses` ou `pydantic` para estruturas de dados
- Logging via `logging` module (não print)
- Testes com `pytest` e `pytest-mock`

## Schema do Banco

O schema completo está em `docs/PRD.md` seção 6 e em `supabase/migrations/001_initial_schema.sql`.

Tabelas principais:
- `organizations` — multi-tenant (futuro)
- `profiles` — extends Supabase Auth
- `closers` — closers cadastrados
- `call_audits` — auditorias (tabela principal, 40+ colunas, inclui drive_file_id e drive_url)
- `job_queue` — fila de processamento assíncrono
- `drive_sync` — sync bidirecional Drive ↔ Supabase (anti-loop com drive_file_id + origin)
- `notifications` — registro de notificações enviadas
- `app_config` — configurações por organização

Views:
- `v_dashboard_stats` — estatísticas agregadas
- `v_closer_performance` — performance por closer com média de 13 dimensões

## Sync Bidirecional Google Drive ↔ Supabase (IMPORTANTE)

O sistema tem DOIS pontos de entrada para arquivos:
1. **Upload pelo frontend** → Supabase Storage → Worker copia para Drive → Pipeline
2. **Upload pelo Drive** → Worker detecta → copia para Supabase → Pipeline

Ambos convergem no mesmo pipeline. Anti-loop via tabela `drive_sync`:
- Todo arquivo sincronizado registra `drive_file_id` + `origin` ('frontend' ou 'drive')
- Drive Watcher ignora arquivos que já existem na tabela (vieram do frontend)
- NUNCA processa o mesmo arquivo duas vezes

O Worker tem dois loops paralelos:
- `job_runner.py` — processa jobs (transcrição, análise, notificação) a cada 30s
- `drive_watcher.py` — monitora novas gravações no Drive a cada 2min

Ver `docs/PRD.md` seção 3.3 e `docs/TDD.md` seção "Drive Watcher" para detalhes completos.

## Ordem de Desenvolvimento (Sprints)

Seguir EXATAMENTE esta ordem:

### Sprint 1 — Setup + DB + Auth
1. Inicializar projeto Next.js 14 em `apps/web/`
2. Instalar e configurar: Tailwind, shadcn/ui, @supabase/supabase-js, @supabase/ssr
3. Executar migration SQL no Supabase (inclui tabela drive_sync)
4. Criar Supabase clients (server + browser)
5. Implementar auth middleware (proteger rotas)
6. Criar login page
7. Criar layout base (sidebar + header)

### Sprint 2 — Upload + Worker Base + Drive Sync
1. Criar página de upload com dropzone
2. Implementar Server Action `uploadCall` (salva em Supabase Storage)
3. Criar bucket `audios` no Supabase Storage
4. Setup Python worker: projeto, venv, requirements
5. Implementar job runner (polling loop a cada 30s)
6. Implementar transcriber (Whisper API integration)
7. Implementar `drive_watcher.py` (polling Drive a cada 2min, anti-loop via drive_sync)
8. Implementar sync frontend → Drive (copiar áudio para pasta do closer no Drive)
9. Testar ambos os fluxos: upload frontend → Drive, upload Drive → Supabase

### Sprint 3 — Análise IA + Parser + Relatório no Drive
1. Implementar analyzer (Claude API integration)
2. Implementar parser (extrair scores, erros, acertos do markdown)
3. Salvar resultados parseados no Supabase
4. Implementar gerador de resumo WhatsApp
5. Implementar save_report_to_drive (salva .md na pasta Relatórios/closer/ no Drive)
6. Testar: transcrição → análise → dados no banco → relatório no Drive

### Sprint 4 — Dashboard + Lista
1. Criar dashboard page com stats cards
2. Implementar gráfico de evolução (Recharts)
3. Criar página de lista de calls com filtros
4. Implementar paginação
5. Realtime status updates (Supabase Realtime)

### Sprint 5 — Detalhe Completo
1. Criar página de detalhe com tabs
2. Tab Scorecard (13 dimensões com barras coloridas)
3. Tab Relatório (markdown render)
4. Tab Transcrição (com scroll e busca)
5. Tab Erros & Acertos
6. Tab Reescrita de Falas (side-by-side)
7. Tab Plano de Ação
8. Player de áudio integrado

### Sprint 6 — Closers + Notificações
1. CRUD de closers
2. Perfil do closer (radar chart, evolução)
3. Implementar notificação WhatsApp (Evolution API)
4. Implementar notificação Email (Resend)
5. Página de configurações

### Sprint 7 — Polish + Deploy
1. Loading states em todos os componentes assíncronos
2. Error boundaries
3. Responsividade mobile
4. Deploy frontend no Vercel
5. Deploy worker no Oracle VPS (systemd)
6. Testar pipeline end-to-end em produção

## Arquivos Importantes para Referência

- `05-system-prompt-analista/system-prompt-analista-calls-v1.md` → O system prompt completo que o worker envia para o Claude. Copiar para `workers/src/prompts/system_prompt.py` como constante.
- `08-documentos-base/transcricao-elane/` → Transcrição real para testar o pipeline.
- `01-auditoria-call-elane/` → Análise esperada — usar como baseline para validar output do analista IA.
- `04-scorecard/scorecard-auditoria-calls-v1.xlsx` → Referência dos pesos e cálculos do scorecard.

## Erros Comuns a Evitar

1. **Não colocar API keys no client-side.** Whisper, Claude, Evolution, Resend — todas no servidor (Server Actions ou Worker).
2. **Não usar `WidthType.PERCENTAGE` em tabelas docx.** Usar DXA (se gerar exports).
3. **Server Actions para mutações, não API routes.** API routes apenas para webhooks.
4. **Supabase RLS ativado.** Todas as queries precisam funcionar com RLS.
5. **Worker não é Lambda.** É um long-running process com polling. Precisa de systemd no VPS.
