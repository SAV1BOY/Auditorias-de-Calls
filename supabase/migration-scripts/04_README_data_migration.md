# Guia de Migração de Dados Pesados

## Pré-requisitos
- Instalar psql localmente: `brew install postgresql` (Mac) ou `apt install postgresql-client` (Linux)
- Credenciais do projeto FONTE (antigo): `mfqpjwxszbjzcmdfqcqw`
- Credenciais do projeto DESTINO (novo): `putdygyeerldrsyjhvzm`

## Ordem de Execução

### 1. Executar no SQL Editor do NOVO projeto (putdygyeerldrsyjhvzm):
```
01_full_schema.sql      → Cria todas as tabelas, funções, views, triggers, RLS
02_auth_migration.sql   → Cria os 5 usuários auth com senhas preservadas
03_data_migration.sql   → Insere dados das tabelas pequenas
```

### 2. Migrar call_audits e supervisor data via pg_dump (terminal local):

```bash
# Exportar call_audits do projeto ANTIGO
PGPASSWORD='<SENHA_PROJETO_ANTIGO>' pg_dump \
  -h db.mfqpjwxszbjzcmdfqcqw.supabase.co \
  -p 5432 -U postgres -d postgres \
  --data-only --table=public.call_audits \
  --table=public.supervisor_analyses \
  --table=public.supervisor_stage_scores \
  --table=public.protocol_rules \
  --table=public.negotiation_rules \
  --column-inserts \
  > /tmp/heavy_data_export.sql

# Importar no projeto NOVO
PGPASSWORD='Relava@2025' psql \
  -h db.putdygyeerldrsyjhvzm.supabase.co \
  -p 5432 -U postgres -d postgres \
  -c "ALTER TABLE call_audits DISABLE TRIGGER ALL;" \
  -f /tmp/heavy_data_export.sql \
  -c "ALTER TABLE call_audits ENABLE TRIGGER ALL;"
```

### 3. Alternativa (sem pg_dump): SQL Editor
Se não tiver psql local, copie e execute este SQL no SQL Editor do projeto ANTIGO para gerar os INSERTs:

```sql
-- No SQL Editor do projeto ANTIGO, execute:
SELECT 
  'INSERT INTO call_audits (' || 
  string_agg(column_name, ', ' ORDER BY ordinal_position) || 
  ') SELECT * FROM json_populate_record(null::call_audits, ''' || 
  '...json...' || '''::json);'
FROM information_schema.columns 
WHERE table_name = 'call_audits' AND table_schema = 'public';
```

Ou exporte via Dashboard: Table Editor → call_audits → Export as CSV → Import no novo projeto.

### 4. Refresh Materialized Views (executar no SQL Editor do NOVO projeto):
```sql
REFRESH MATERIALIZED VIEW mv_dashboard_stats;
REFRESH MATERIALIZED VIEW mv_closer_performance;
```

### 5. Verificação Final:
```sql
-- Contagem de rows (deve bater com o fonte)
SELECT 'organizations' as t, COUNT(*) FROM organizations
UNION ALL SELECT 'profiles', COUNT(*) FROM profiles
UNION ALL SELECT 'closers', COUNT(*) FROM closers
UNION ALL SELECT 'call_audits', COUNT(*) FROM call_audits
UNION ALL SELECT 'job_queue', COUNT(*) FROM job_queue
UNION ALL SELECT 'supervisor_analyses', COUNT(*) FROM supervisor_analyses
UNION ALL SELECT 'notifications', COUNT(*) FROM notifications;

-- Esperado:
-- organizations: 1
-- profiles: 5
-- closers: 1
-- call_audits: 10
-- job_queue: 20
-- supervisor_analyses: 11
-- notifications: 5
```

## Atualizar Variáveis de Ambiente

### Vercel (Frontend)
No painel: Settings → Environment Variables
- `NEXT_PUBLIC_SUPABASE_URL` = `https://putdygyeerldrsyjhvzm.supabase.co`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` = `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE`
- `SUPABASE_SERVICE_ROLE_KEY` = (copie do dashboard do novo projeto)

Depois: Deployments → Redeploy

### Worker (Oracle VPS)
```bash
ssh user@vps
sudo nano /opt/callaudit/workers/.env
# Alterar SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY
sudo systemctl restart callaudit-worker.service
```

### Local Development
Editar `apps/web/.env.local` e `workers/.env` com as novas credenciais.

## Testar Login
Após tudo configurado, testar no browser:
1. Acessar a URL do Vercel
2. Login com: `miguelgsaviotti29@gmail.com` (mesma senha de antes)
3. Verificar que o dashboard carrega com dados
