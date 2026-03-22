# Guia de Setup — CallAudit

Passo a passo completo para colocar o app funcionando do zero.

---

## 0. Pré-requisitos de Sistema

Antes de começar, certifique-se de que tem instalado:

| Ferramenta | Versão Mínima | Como verificar |
|------------|--------------|----------------|
| **Node.js** | ≥18 | `node --version` |
| **npm** | ≥9 | `npm --version` |
| **Python** | ≥3.11 | `python3 --version` |
| **pip** | ≥23 | `pip --version` |
| **Git** | ≥2.30 | `git --version` |

### Instalação rápida (Ubuntu/Debian)

```bash
# Node.js 20 via NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Python 3.11+
sudo apt-get install -y python3 python3-venv python3-pip

# Git
sudo apt-get install -y git
```

### Instalação rápida (macOS)

```bash
# Via Homebrew
brew install node@20 python@3.11 git
```

---

## 1. APIs e Chaves Necessárias

Você vai precisar criar contas e obter chaves de **6 serviços**:

### 1.1 Supabase (Banco de Dados + Storage + Auth)

**O que é:** Banco PostgreSQL gerenciado + autenticação + armazenamento de arquivos.

**Como obter:**
1. Acesse [supabase.com](https://supabase.com) e crie uma conta gratuita
2. Crie um novo projeto (escolha a região mais próxima)
3. Vá em **Settings > API** e copie:

| Chave | Onde encontrar | Para quê |
|-------|---------------|----------|
| `NEXT_PUBLIC_SUPABASE_URL` | Settings > API > Project URL | Conexão com o banco |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Settings > API > anon public | Acesso público (frontend) |
| `SUPABASE_SERVICE_ROLE_KEY` | Settings > API > service_role secret | Acesso admin (backend) |

---

### 1.2 OpenAI — Whisper API (Transcrição de Áudio)

**O que é:** API que transcreve áudio em texto.

**Como obter:**
1. Acesse [platform.openai.com](https://platform.openai.com)
2. Crie uma conta e adicione créditos (mínimo $5)
3. Vá em **API Keys** e crie uma nova chave

| Chave | Para quê |
|-------|----------|
| `OPENAI_API_KEY` | Transcrição de áudio (Whisper) |

**Custo estimado:** ~$0.006/minuto de áudio (~R$0.03/minuto)

---

### 1.3 Anthropic — Claude API (Análise IA)

**O que é:** API que analisa a transcrição contra 10 frameworks de vendas.

**Como obter:**
1. Acesse [console.anthropic.com](https://console.anthropic.com)
2. Crie uma conta e adicione créditos (mínimo $10)
3. Vá em **API Keys** e crie uma nova chave

| Chave | Para quê |
|-------|----------|
| `ANTHROPIC_API_KEY` | Análise da call com Claude |

**Custo estimado:** ~$0.05-0.15 por call analisada

---

### 1.4 Evolution API (WhatsApp)

**O que é:** API para enviar mensagens via WhatsApp (self-hosted ou cloud).

**Como obter:**
1. Você precisa de uma instância da Evolution API rodando
   - Opção 1: Self-hosted — [docs.evolution-api.com](https://doc.evolution-api.com)
   - Opção 2: Cloud — contratar serviço gerenciado
2. Após instalar, crie uma instância e escaneie o QR Code com o WhatsApp
3. Copie as credenciais:

| Chave | Para quê |
|-------|----------|
| `EVOLUTION_API_URL` | URL da sua instância (ex: `https://evo.seuservidor.com`) |
| `EVOLUTION_API_TOKEN` | Token de autenticação da API |
| `EVOLUTION_INSTANCE_ID` | Nome da instância (ex: `callaudit`) |

**Nota:** Se não configurar, o app funciona normalmente — apenas não envia WhatsApp.

---

### 1.5 Resend (Email)

**O que é:** API para envio de emails transacionais.

**Como obter:**
1. Acesse [resend.com](https://resend.com) e crie uma conta (plano gratuito: 100 emails/dia)
2. Vá em **API Keys** e crie uma nova chave
3. Configure um domínio de envio (ou use o domínio de teste)

| Chave | Para quê |
|-------|----------|
| `RESEND_API_KEY` | Envio de relatórios por email |
| `RESEND_FROM_EMAIL` | Endereço de envio (ex: `noreply@seudominio.com`) |

**Nota:** Se não configurar, o app funciona — apenas não envia emails.

---

### 1.6 Google Drive (Sync Bidirecional)

**O que é:** Integração para upload/download de gravações e relatórios via Google Drive.

**Como obter:**
1. Acesse [console.cloud.google.com](https://console.cloud.google.com)
2. Crie um novo projeto
3. Ative a **Google Drive API** (APIs & Services > Library)
4. Crie uma **Service Account** (APIs & Services > Credentials > Create Credentials)
5. Gere uma chave JSON para a Service Account e baixe o arquivo
6. No Google Drive:
   - Crie uma pasta raiz: **"Auditorias Comerciais"**
   - Dentro dela, crie: `Gravações/` e `Relatórios/`
   - Dentro de cada uma, crie subpastas por closer: `evelyn/`, `gustavo/`, etc.
   - Compartilhe a pasta raiz com o email da Service Account (permissão: **Editor**)
7. Copie os IDs das pastas (está na URL do Drive: `drive.google.com/drive/folders/XXXXX`)

| Chave | Para quê |
|-------|----------|
| `GOOGLE_SERVICE_ACCOUNT_JSON` | Caminho para o arquivo JSON da Service Account |
| `GOOGLE_DRIVE_GRAVACOES_FOLDER_ID` | ID da pasta "Gravações" |
| `GOOGLE_DRIVE_RELATORIOS_FOLDER_ID` | ID da pasta "Relatórios" |

**Nota:** Se não configurar, o app funciona — apenas não sincroniza com o Drive.

---

## 2. Setup do Supabase (Banco de Dados)

### 2.1 Executar Migrations

1. No Supabase Dashboard, vá em **SQL Editor**
2. Execute os arquivos **na ordem numérica** (um por vez, aguardando cada um completar):

| # | Arquivo | O que faz |
|---|---------|-----------|
| 1 | `001_initial_schema.sql` | Tabelas core (organizations, profiles, closers, call_audits, job_queue, drive_sync, notifications, app_config), views, índices e triggers |
| 2 | `002_rls_policies.sql` | Políticas de Row Level Security (RLS) básicas |
| 3 | `003_goals.sql` | Tabela de metas/goals para closers |
| 4 | `003_storage_bucket.sql` | Cria buckets `audios` e `reports` via SQL (alternativa ao passo 2.2 manual) |
| 5 | `004_coaching.sql` | Tabelas de coaching: bookmarks e comentários em calls |
| 6 | `005_gamification.sql` | Badges, conquistas e competições |
| 7 | `006_sentiment_loss.sql` | Scores de sentimento e padrões de perda |
| 8 | `007_rls_multitenant.sql` | RLS multi-tenant com isolamento por organização |
| 9 | `008_data_constraints.sql` | CHECK constraints (scores 0-10), dedup de jobs, validação de status |
| 10 | `009_materialized_views.sql` | Views materializadas para dashboard (performance) |
| 11 | `010_async_mv_refresh.sql` | Refresh assíncrono das views materializadas |

**Dica:** Para executar todos de uma vez via terminal (requer Supabase CLI):
```bash
supabase db push
```

### 2.2 Criar Storage Buckets

> **Nota:** Se você executou a migration `003_storage_bucket.sql`, os buckets já foram criados automaticamente. Verifique em Storage no Dashboard antes de criar manualmente.

1. Vá em **Storage** no Dashboard
2. Se os buckets ainda não existem, clique em **New Bucket** e crie:

| Bucket | Visibilidade | Tamanho Máx | Tipos Permitidos |
|--------|-------------|-------------|-----------------|
| `audios` | Private | 500MB | `audio/*` |
| `reports` | Private | 10MB | `application/pdf, text/*` |

### 2.3 Criar Primeiro Usuário

1. Vá em **Authentication > Users > Add User**
2. Crie um usuário com email e senha
3. No **SQL Editor**, promova para admin:

```sql
UPDATE profiles SET role = 'admin' WHERE id = 'SEU-USER-UUID-AQUI';
```

(O UUID aparece na lista de usuários do Authentication)

---

## 3. Rodar o Frontend (Local)

```bash
# 1. Entrar na pasta do frontend
cd apps/web

# 2. Instalar dependências
npm install

# 3. Criar arquivo de variáveis de ambiente
cp .env.example .env.local
```

### 3.1 Preencher o `.env.local`

```env
NEXT_PUBLIC_SUPABASE_URL=https://SEU-PROJETO.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiI...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiI...
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

### 3.2 Iniciar o servidor

```bash
npm run dev
```

Acesse **http://localhost:3000** — você deve ver a tela de login.

### 3.3 Verificar

- [ ] Tela de login aparece
- [ ] Consegue fazer login com o usuário criado no Supabase
- [ ] Dashboard carrega (vazio, sem dados ainda)
- [ ] Página de Upload está acessível
- [ ] Página de Closers está acessível
- [ ] Página de Configurações está acessível

---

## 4. Rodar o Worker (Local)

```bash
# 1. Entrar na pasta do worker
cd workers

# 2. Criar ambiente virtual Python
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# ou: venv\Scripts\activate  # Windows

# 3. Instalar dependências
pip install -r requirements.txt

# 4. Criar arquivo de variáveis de ambiente
cp .env.example .env
```

### 4.1 Preencher o `.env`

```env
# Supabase (mesmas chaves do frontend, mas sem NEXT_PUBLIC_)
SUPABASE_URL=https://SEU-PROJETO.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiI...

# OpenAI (Whisper)
OPENAI_API_KEY=sk-proj-SUA-CHAVE-AQUI

# Anthropic (Claude)
ANTHROPIC_API_KEY=sk-ant-api03-SUA-CHAVE-AQUI

# Evolution API (WhatsApp) — opcional
EVOLUTION_API_URL=https://seu-evolution.com
EVOLUTION_API_TOKEN=seu-token
EVOLUTION_INSTANCE_ID=callaudit

# Google Drive — opcional
GOOGLE_SERVICE_ACCOUNT_JSON=/caminho/para/service-account.json
GOOGLE_DRIVE_GRAVACOES_FOLDER_ID=
GOOGLE_DRIVE_RELATORIOS_FOLDER_ID=

# Resend (Email) — opcional
RESEND_API_KEY=re_SUA-CHAVE
RESEND_FROM_EMAIL=noreply@seudominio.com

# Polling
JOB_POLL_INTERVAL_SECONDS=30
DRIVE_POLL_INTERVAL_SECONDS=120
```

### 4.2 Iniciar o Worker

```bash
python -m src.main
```

Você deve ver no terminal:
```
INFO - Starting CallAudit Worker...
INFO - Job runner started (polling every 30s)
INFO - Drive watcher started (polling every 120s)
```

---

## 5. Teste End-to-End Completo

Siga esta sequência para validar que tudo funciona:

### 5.1 Cadastrar um Closer

1. Vá em **Closers** no menu lateral
2. Clique em **Novo Closer**
3. Preencha: Nome, Email (opcional), WhatsApp (opcional)
4. Salve

### 5.2 Fazer Upload de uma Call

1. Vá em **Upload** no menu lateral
2. Arraste um arquivo de áudio (.ogg, .mp3, .wav, etc.)
3. Selecione o closer no dropdown
4. Preencha o nome do lead
5. Selecione a data e o resultado
6. Clique em **Enviar Call para Auditoria**

### 5.3 Acompanhar o Pipeline

1. Vá em **Calls** no menu lateral
2. Observe o status da call mudar em tempo real:

| Status | O que está acontecendo | Tempo esperado |
|--------|----------------------|----------------|
| **Enviado** | Áudio salvo, aguardando worker | Até 30s |
| **Transcrevendo** | Whisper processando o áudio | 1-5 min |
| **Transcrito** | Transcrição salva, aguardando análise | Até 30s |
| **Analisando** | Claude analisando a call | 1-3 min |
| **Analisado** | Análise completa, aguardando notificação | Até 30s |
| **Notificando** | Enviando WhatsApp e Email | 10-30s |
| **Completo** | Pipeline concluído | — |

### 5.4 Verificar o Resultado

1. Clique na call para ver o detalhe
2. Verifique cada aba:
   - **Scorecard** — 13 dimensões com notas de 0 a 10
   - **Relatório** — Análise completa em markdown
   - **Transcrição** — Texto completo do áudio
   - **Erros & Acertos** — Top 5 erros e acertos
   - **Reescrita** — Falas corrigidas (original vs sugerido)
   - **Plano de Ação** — 5 prioridades de melhoria
3. Ouça o áudio pelo player integrado
4. Confira o score final e a classificação (Elite/Forte/Mediana/Fraca)

### 5.5 Verificar Notificações (se configurado)

- [ ] WhatsApp: grupo recebeu o resumo da auditoria
- [ ] Email: supervisores receberam o relatório completo

### 5.6 Verificar Google Drive (se configurado)

- [ ] Áudio copiado para a pasta `Gravações/[closer]/`
- [ ] Relatório salvo em `Relatórios/[closer]/`

### 5.7 Verificar o Dashboard

1. Volte ao **Dashboard**
2. Os stat cards devem mostrar:
   - Total de Calls: 1
   - Score Médio: o score da call
   - Taxa de Fechamento: baseado no resultado
   - Calls Esta Semana: 1
3. O gráfico de evolução deve ter 1 ponto
4. A tabela de calls recentes deve mostrar a call

---

## 6. Testes Automatizados

Depois de configurar o ambiente, rode os testes para validar que tudo está funcionando.

### 6.1 Testes do Frontend (Vitest)

Testes unitários dos componentes React e server actions.

```bash
cd apps/web

# Rodar todos os testes
npx vitest run

# Rodar em modo watch (re-executa ao salvar)
npm run test:watch

# Com relatório de cobertura
npm run test:coverage
```

**O que testa:** Server actions (upload, closers, settings), componentes (scorecard, upload form, processing status), validações Zod.

### 6.2 Testes do Worker (pytest)

Testes unitários do pipeline Python (transcrição, análise, parser, notificações).

```bash
cd workers
source venv/bin/activate   # Ativar venv (Linux/Mac)

# Rodar todos os testes
pytest tests/ -v

# Rodar com cobertura
pytest tests/ -v --cov=src --cov-report=term-missing

# Rodar apenas um módulo
pytest tests/test_parser.py -v
```

**O que testa:** Transcriber (Whisper mock), Analyzer (Claude mock), Parser (extração de scores), Notifier (WhatsApp/Email mock), Drive Sync (anti-loop).

### 6.3 Testes E2E (Playwright)

Testes end-to-end que simulam o usuário no browser.

```bash
cd apps/web

# Instalar browsers (primeira vez)
npx playwright install chromium

# Rodar testes E2E
npx playwright test

# Com interface visual (debug)
npx playwright test --ui

# Ver relatório HTML
npx playwright show-report
```

**Pré-requisito:** O frontend deve estar rodando (`npm run dev`) ou o Playwright inicia automaticamente.

**O que testa:** Fluxo completo: login → upload → processamento → visualização de resultado.

### 6.4 Verificações de Qualidade

```bash
cd apps/web

# TypeScript — verificar erros de tipo
npx tsc --noEmit

# ESLint — verificar padrões de código
npm run lint

# Build de produção — garante que compila
npm run build
```

### 6.5 Resumo dos Comandos

| Teste | Comando | Diretório | Tempo |
|-------|---------|-----------|-------|
| Unit Frontend | `npx vitest run` | `apps/web/` | ~10s |
| Unit Worker | `pytest tests/ -v` | `workers/` | ~5s |
| E2E | `npx playwright test` | `apps/web/` | ~30-60s |
| TypeScript | `npx tsc --noEmit` | `apps/web/` | ~5s |
| Lint | `npm run lint` | `apps/web/` | ~5s |
| Build | `npm run build` | `apps/web/` | ~30s |

---

## 7. Checklist de APIs — O Que Enviar

Para o app funcionar **100%**, você precisa de:

### Obrigatórias (app não funciona sem):

| # | Serviço | Chaves necessárias | Como obter |
|---|---------|-------------------|------------|
| 1 | **Supabase** | URL + Anon Key + Service Role Key | Criar projeto em supabase.com |
| 2 | **OpenAI** | OPENAI_API_KEY | Criar conta em platform.openai.com |
| 3 | **Anthropic** | ANTHROPIC_API_KEY | Criar conta em console.anthropic.com |

### Opcionais (app funciona sem, mas perde funcionalidade):

| # | Serviço | Chaves necessárias | Funcionalidade |
|---|---------|-------------------|---------------|
| 4 | **Evolution API** | URL + Token + Instance ID | Notificação WhatsApp |
| 5 | **Resend** | API Key + From Email | Notificação Email |
| 6 | **Google Drive** | Service Account JSON + Folder IDs | Sync bidirecional Drive |

---

## 8. Troubleshooting

### "Login não funciona"
- Verifique se `NEXT_PUBLIC_SUPABASE_URL` e `NEXT_PUBLIC_SUPABASE_ANON_KEY` estão corretos
- Verifique se o usuário foi criado no Supabase Authentication

### "Upload funciona mas status fica em 'Enviado' para sempre"
- O worker não está rodando. Execute `python -m src.main` na pasta `workers/`
- Verifique se `SUPABASE_URL` e `SUPABASE_SERVICE_ROLE_KEY` estão no `.env` do worker

### "Transcrição falha"
- Verifique se `OPENAI_API_KEY` está correta e tem créditos
- Verifique o log do worker para ver a mensagem de erro

### "Análise falha"
- Verifique se `ANTHROPIC_API_KEY` está correta e tem créditos
- Calls muito longas (>2h) podem exceder o limite de tokens

### "WhatsApp não envia"
- Verifique se a instância Evolution está conectada (QR Code escaneado)
- Verifique os 3 campos: URL, Token, Instance ID
- Teste manualmente no terminal:
  ```bash
  curl -X POST "$EVOLUTION_API_URL/message/sendText/$EVOLUTION_INSTANCE_ID" \
    -H "apikey: $EVOLUTION_API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"number": "5511999999999", "text": "teste"}'
  ```

### "Dashboard vazio mesmo com calls completas"
- Verifique se as migrations foram executadas corretamente
- No SQL Editor do Supabase, teste: `SELECT * FROM v_dashboard_stats;`

---

## 9. Custos Estimados (por Call)

| Serviço | Custo por call de 30 min | Custo por call de 60 min |
|---------|--------------------------|--------------------------|
| Whisper (transcrição) | ~R$0.90 | ~R$1.80 |
| Claude (análise) | ~R$0.25-0.75 | ~R$0.50-1.50 |
| Supabase (free tier) | R$0 | R$0 |
| **Total** | **~R$1.15-1.65** | **~R$2.30-3.30** |

Notificações (WhatsApp/Email) e Drive são essencialmente gratuitos no volume de uso típico.
