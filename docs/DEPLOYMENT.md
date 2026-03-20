# DEPLOYMENT.md — Guia de Deploy

## Frontend (Vercel)

1. Conectar repositório GitHub ao Vercel
2. Root Directory: `apps/web`
3. Framework: Next.js
4. Configurar variáveis de ambiente:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `NEXT_PUBLIC_APP_URL`

## Worker (Oracle VPS)

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
cp ../.env.example .env
# Editar .env com as chaves reais

# 4. Testar
python -m src.main  # Ctrl+C para parar

# 5. Configurar systemd
sudo cp callaudit-worker.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable callaudit-worker
sudo systemctl start callaudit-worker

# 6. Verificar
sudo systemctl status callaudit-worker
journalctl -u callaudit-worker -f
```

## Supabase

1. Criar projeto no Supabase Dashboard
2. Ir em SQL Editor
3. Executar `supabase/migrations/001_initial_schema.sql`
4. Criar buckets no Storage: `audios` (private), `reports` (private)
5. Copiar URL e keys para variáveis de ambiente

## Google Drive (Sync Bidirecional)

1. Criar Service Account no Google Cloud Console
2. Ativar Google Drive API no projeto
3. Baixar JSON da Service Account → configurar em `GOOGLE_SERVICE_ACCOUNT_JSON`
4. Criar pasta raiz no Drive: "Auditorias Comerciais"
5. Compartilhar a pasta raiz com o email da Service Account (Editor)
6. Dentro dela, criar subpastas:
   - `Gravações/evelyn/`, `Gravações/gustavo/` (uma por closer)
   - `Relatórios/evelyn/`, `Relatórios/gustavo/` (uma por closer)
7. Copiar os IDs das pastas para as variáveis de ambiente
8. Testar: jogar um .ogg numa pasta de closer e verificar se o worker detecta

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
