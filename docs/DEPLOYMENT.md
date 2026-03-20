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

## Checklist Pós-Deploy

- [ ] Frontend acessível na URL do Vercel
- [ ] Login funcionando
- [ ] Upload de áudio salva no Supabase Storage
- [ ] Worker rodando (`systemctl status callaudit-worker`)
- [ ] Pipeline completo: upload → transcrição → análise → notificação
- [ ] WhatsApp recebendo resumo
- [ ] Email recebendo relatório completo
