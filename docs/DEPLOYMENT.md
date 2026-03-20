# DEPLOYMENT.md — Guia de Deploy

## Pré-requisitos

- Node.js >= 18
- Python >= 3.11
- Conta Supabase (projeto criado)
- Conta Vercel (conectada ao GitHub)
- VPS (Oracle/AWS/etc.) para o Worker
- Conta Google Cloud (Service Account para Drive API)
- Conta Evolution API (para WhatsApp)
- Conta Resend (para Email)

---

## 1. Supabase (Database + Storage + Auth)

### 1.1 Setup Inicial

1. Criar projeto no [Supabase Dashboard](https://supabase.com/dashboard)
2. Ir em **SQL Editor**
3. Executar as migrations em ordem:
   ```
   supabase/migrations/001_initial_schema.sql
   supabase/migrations/002_rls_policies.sql
   ```
4. Copiar URL e keys (Settings > API):
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`

### 1.2 Storage Buckets

Criar via Dashboard (Storage > New Bucket):

- **audios** — Private, max 500MB per file, allowed: `audio/*`
- **reports** — Private, max 10MB per file, allowed: `application/pdf, text/*`

### 1.3 Auth

1. Habilitar Email/Password em Authentication > Providers
2. Criar primeiro usuário admin manualmente (Authentication > Users > Add User)
3. O trigger `on_auth_user_created` cria automaticamente o profile com role `viewer`
4. Atualizar role para `admin` no SQL Editor:
   ```sql
   UPDATE profiles SET role = 'admin' WHERE id = '<user-uuid>';
   ```

---

## 2. Frontend (Vercel)

### 2.1 Deploy

1. Conectar repositório GitHub ao Vercel
2. O arquivo `vercel.json` na raiz do repo já configura:
   - Root directory: `apps/web`
   - Framework: Next.js
   - Build command: `cd apps/web && npm run build`
3. Configurar variáveis de ambiente no dashboard do Vercel:

   ```
   NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGci...
   SUPABASE_SERVICE_ROLE_KEY=eyJhbGci...
   NEXT_PUBLIC_APP_URL=https://seu-dominio.vercel.app
   ```

   Referência: `apps/web/.env.example`

### 2.2 Verificação

- Acessar a URL do Vercel
- Login deve funcionar
- Dashboard deve carregar (vazio inicialmente)

---

## 3. Worker (Oracle VPS)

### 3.1 Setup

```bash
# 1. Clonar repositório
cd /opt
git clone https://github.com/SAV1BOY/Auditorias-de-Calls.git callaudit
cd callaudit/workers

# 2. Criar venv e instalar deps
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 3. Criar .env
cp .env.example .env
# Editar .env com as chaves reais (ver workers/.env.example para todas as variáveis)

# 4. Testar manualmente
python -m src.main  # Ctrl+C para parar
```

### 3.2 Systemd Service

O arquivo `callaudit-worker.service` está na raiz do repositório.

```bash
# Copiar service file
sudo cp /opt/callaudit/callaudit-worker.service /etc/systemd/system/

# Habilitar e iniciar
sudo systemctl daemon-reload
sudo systemctl enable callaudit-worker
sudo systemctl start callaudit-worker

# Verificar status
sudo systemctl status callaudit-worker
```

### 3.3 Monitoramento

```bash
# Logs em tempo real
journalctl -u callaudit-worker -f

# Últimas 100 linhas
journalctl -u callaudit-worker -n 100

# Filtrar por erro
journalctl -u callaudit-worker --since "1 hour ago" | grep ERROR

# Reiniciar worker
sudo systemctl restart callaudit-worker
```

### 3.4 Atualizar Worker

```bash
cd /opt/callaudit
git pull origin main
cd workers
source venv/bin/activate
pip install -r requirements.txt
sudo systemctl restart callaudit-worker
```

---

## 4. Google Drive (Sync Bidirecional)

1. Criar Service Account no Google Cloud Console
2. Ativar Google Drive API no projeto
3. Baixar JSON da Service Account → configurar em `GOOGLE_SERVICE_ACCOUNT_JSON`
4. Criar pasta raiz no Drive: "Auditorias Comerciais"
5. Compartilhar a pasta raiz com o email da Service Account (Editor)
6. Dentro dela, criar subpastas:
   - `Gravações/evelyn/`, `Gravações/gustavo/` (uma por closer)
   - `Relatórios/evelyn/`, `Relatórios/gustavo/` (uma por closer)
7. Copiar os IDs das pastas para as variáveis de ambiente:
   - `GOOGLE_DRIVE_GRAVACOES_FOLDER_ID` — ID da pasta Gravações
   - `GOOGLE_DRIVE_RELATORIOS_FOLDER_ID` — ID da pasta Relatórios
8. Testar: jogar um .ogg numa pasta de closer e verificar se o worker detecta

---

## 5. CI/CD (GitHub Actions)

O pipeline CI está em `.github/workflows/ci.yml` e roda automaticamente em push/PR para `main`.

Jobs:
- **frontend**: `npm ci` → `tsc --noEmit` → `lint` → `build`
- **worker**: `pip install` → `pytest tests/ -v`

Verificar no GitHub: Actions tab → CI workflow.

---

## 6. Troubleshooting

### Worker não inicia

```bash
# Verificar logs
journalctl -u callaudit-worker -n 50
# Problemas comuns:
# - .env não existe ou está incompleto
# - venv não tem as dependências instaladas
# - Porta/URL do Supabase incorretos
```

### Jobs parados (status = 'pending' por muito tempo)

```sql
-- Verificar jobs pendentes
SELECT * FROM job_queue WHERE status = 'pending' ORDER BY created_at;

-- Verificar se há jobs travados em 'processing'
SELECT * FROM job_queue WHERE status = 'processing' AND started_at < NOW() - INTERVAL '10 minutes';

-- Reset de job travado
UPDATE job_queue SET status = 'pending', attempts = attempts WHERE id = '<job-id>';
```

### WhatsApp não envia

1. Verificar se `EVOLUTION_API_URL`, `EVOLUTION_API_TOKEN`, `EVOLUTION_INSTANCE_ID` estão configurados
2. Verificar se a instância do Evolution está conectada (QR code escaneado)
3. Testar endpoint manualmente:
   ```bash
   curl -X POST "$EVOLUTION_API_URL/message/sendText/$EVOLUTION_INSTANCE_ID" \
     -H "apikey: $EVOLUTION_API_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"number": "5511999999999", "text": "teste"}'
   ```

### Drive Watcher não detecta arquivos

1. Verificar se `GOOGLE_SERVICE_ACCOUNT_JSON` está correto
2. Verificar se a pasta foi compartilhada com a Service Account
3. Verificar logs: `journalctl -u callaudit-worker | grep "drive_watcher"`
4. O watcher roda a cada 2 minutos — espere pelo menos um ciclo

### Build do frontend falha

```bash
cd apps/web
npm ci
npx tsc --noEmit    # Verifica erros de TypeScript
npm run lint         # Verifica ESLint
npm run build        # Build completo
```

---

## Checklist Pós-Deploy

- [ ] Frontend acessível na URL do Vercel
- [ ] Login funcionando
- [ ] Upload de áudio pelo frontend salva no Supabase Storage
- [ ] Upload pelo frontend copia arquivo para Google Drive (pasta do closer)
- [ ] Worker rodando (`systemctl status callaudit-worker`)
- [ ] Drive Watcher detectando novos arquivos a cada 2min
- [ ] Upload pelo Drive cria audit e inicia pipeline automaticamente
- [ ] Anti-loop: arquivo do frontend NÃO é reprocessado quando detectado no Drive
- [ ] Pipeline completo: upload → transcrição → análise → notificação
- [ ] WhatsApp recebendo resumo no grupo
- [ ] Email recebendo relatório completo
- [ ] Relatório .md salvo na pasta Relatórios/closer/ no Drive
- [ ] Dashboard exibindo calls processadas
- [ ] Links do Drive visíveis na página de detalhe da auditoria
- [ ] Loading skeletons aparecem durante navegação
- [ ] Error boundaries funcionam (forçar erro → botão retry aparece)
- [ ] Mobile: todas as páginas acessíveis em 375px
- [ ] CI pipeline: push → GitHub Actions executa lint + typecheck + build + pytest
