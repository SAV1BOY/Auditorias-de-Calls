# Catálogo de Variáveis de Ambiente

## Frontend (apps/web/)

| Variável | Obrigatória | Default | Tipo | Descrição |
|---|---|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | SIM | — | string | URL do projeto Supabase (ex: `https://xxx.supabase.co`) |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | SIM | — | string | Chave pública (anon) do Supabase |
| `NEXT_PUBLIC_APP_URL` | NÃO | `http://localhost:3000` | string | URL base da aplicação |
| `SUPABASE_SERVICE_ROLE_KEY` | SIM | — | string | Chave admin do Supabase (server-only, nunca expor ao client) |

## Worker (workers/)

### Obrigatórias

| Variável | Tipo | Descrição |
|---|---|---|
| `SUPABASE_URL` | string | URL do projeto Supabase |
| `SUPABASE_SERVICE_ROLE_KEY` | string | Chave admin do Supabase |
| `OPENAI_API_KEY` | string | Chave da API OpenAI (Whisper). Formato: `sk-proj-...` |
| `ANTHROPIC_API_KEY` | string | Chave da API Anthropic (Claude). Formato: `sk-ant-...` |

### Opcionais — Google Drive

| Variável | Default | Tipo | Descrição |
|---|---|---|---|
| `GOOGLE_SERVICE_ACCOUNT_JSON` | `""` | JSON string ou path | Credenciais da service account Google. Pode ser path para arquivo `.json` ou JSON inline |
| `GOOGLE_DRIVE_GRAVACOES_FOLDER_ID` | `""` | string | ID da pasta no Drive para gravações de áudio |
| `GOOGLE_DRIVE_RELATORIOS_FOLDER_ID` | `""` | string | ID da pasta no Drive para relatórios `.md` |

### Opcionais — Notificações

| Variável | Default | Tipo | Descrição |
|---|---|---|---|
| `EVOLUTION_API_URL` | `""` | string | URL base da Evolution API (WhatsApp) |
| `EVOLUTION_API_TOKEN` | `""` | string | Token de autenticação da Evolution API |
| `EVOLUTION_INSTANCE_ID` | `""` | string | ID da instância na Evolution API |
| `RESEND_API_KEY` | `""` | string | Chave da API Resend (email). Formato: `re_...` |
| `RESEND_FROM_EMAIL` | `noreply@callaudit.app` | string | Email remetente para notificações |

### Opcionais — Polling

| Variável | Default | Tipo | Descrição |
|---|---|---|---|
| `JOB_POLL_INTERVAL_SECONDS` | `30` | int | Intervalo de polling da job_queue (segundos) |
| `DRIVE_POLL_INTERVAL_SECONDS` | `120` | int | Intervalo de polling do Drive watcher (segundos) |

## Notas de Segurança

- **NUNCA** commitar arquivos `.env` no repositório
- `SUPABASE_SERVICE_ROLE_KEY` bypassa RLS — usar apenas no server/worker
- `NEXT_PUBLIC_*` são expostas ao browser — nunca colocar secrets nesse prefixo
- `GOOGLE_SERVICE_ACCOUNT_JSON` contém chave privada — tratar como secret
