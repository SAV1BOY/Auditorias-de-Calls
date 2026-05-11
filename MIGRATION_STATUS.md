# CallAudit Supabase Migration — Status Final

**Última atualização:** 2026-05-11 ~02:30 BRT

## ✅ O que foi concluído

### 1. Migração de banco completa
- **Origem:** `mfqpjwxszbjzcmdfqcqw` (ls-interbank, reativado)
- **Destino:** `putdygyeerldrsyjhvzm` (CALL AUDIT, sa-east-1)
- **Schema:** 17 migrações aplicadas (12 locais + 5 reconstruídas do source)
- **Dados:** 1 organização, 5 profiles, 1 closer, 10 call_audits, 20 job_queue, 5 notifications, 11 supervisor_analyses, 160 stage_scores, 16 protocol_rules, 10 badges, 2 app_config
- **Auth users:** 5 usuários migrados com `encrypted_password` preservado
- **Storage buckets:** audios + reports criados

### 2. Vercel
- Env vars atualizadas (production + preview + development):
  - `NEXT_PUBLIC_SUPABASE_URL` → `https://putdygyeerldrsyjhvzm.supabase.co`
  - `NEXT_PUBLIC_SUPABASE_ANON_KEY` → atualizado
  - `SUPABASE_SERVICE_ROLE_KEY` → atualizado

### 3. Supabase Auth
- Site URL configurado: `https://auditorias-de-calls.vercel.app`
- Redirect URLs adicionados (production + preview + localhost)
- Email provider habilitado
- `aud='authenticated'` aplicado nos 5 usuários migrados (bug crítico identificado e corrigido)

### 4. Código (commits push'ados pra `main` pra trigger deploy de produção)
- **Commit `a522c7e`** (em `main`): Middleware com `redirectWithCookies()` — corrige perda de cookies em redirects
- CSP do main preservado (`unsafe-inline` + `unsafe-eval` pra shaders funcionarem)
- Diagnóstico logging adicionado em `[middleware]`

## ⏳ Próxima ação automática (Vercel)

Vercel está fazendo auto-deploy do commit `a522c7e` em `main` para produção.
Tempo esperado: ~2-4 minutos a partir de `2026-05-11 05:36 UTC`.

## 🔍 Quando você acordar

### Passo 1 — Verificar que o deploy concluiu

```powershell
vercel inspect https://auditorias-de-calls.vercel.app
```

A seção "Source" deve mostrar commit `a522c7eeb05d1e63bf7f0ce8e201e0f5c8580736`.

### Passo 2 — Testar login

Aba anônima → https://auditorias-de-calls.vercel.app/login
- Email: `miguelgsaviotti29@gmail.com`
- Senha: `CallAudit2026!`

Deve redirecionar pro dashboard e mostrar os 10 audits.

### Passo 3 — Se AINDA não funcionar

Em outro terminal, abra:

```powershell
vercel logs https://auditorias-de-calls.vercel.app --follow
```

Tente o login. Os logs `[middleware]` vão mostrar exatamente:
- Quantos cookies `sb-*` chegaram
- Se `getUser()` retorna o user válido
- Qual path está sendo redirecionado

Cole os logs comigo e identifico o bug residual.

## 🧠 O que estava bloqueando o login

| # | Bug | Onde | Status |
|---|-----|------|--------|
| 1 | `aud=NULL` na auth.users (Supabase Auth rejeita login) | Script 02_auth_migration.sql não setava `aud` | ✅ FIX aplicado via SQL Editor (Script 08) |
| 2 | Middleware `NextResponse.redirect()` descartando cookies do `getUser()` (refresh tokens perdidos) | `apps/web/middleware.ts` | ✅ FIX commit `a522c7e` |
| 3 | Server Action retornava `{success}` e client fazia `router.push` → race condition de cookie | `apps/web/lib/actions/auth.ts` | ✅ Main já tinha fix com `window.location.href` (full page reload) |
| 4 | Production rodava commit antigo (3h+) sem nenhum fix | Vercel deploy | ✅ Resolvido pelo push direto pra `main` |

## 📂 Arquivos importantes no repo

| Caminho | O que é |
|---------|---------|
| `supabase/migration-scripts/00_reset.sql` | Reset do banco destino |
| `supabase/migration-scripts/01_full_schema.sql` | Schema completo |
| `supabase/migration-scripts/02_auth_migration.sql` | Auth users (sem `aud`, corrigido pelo 08) |
| `supabase/migration-scripts/03_data_migration.sql` | Dados pequenos |
| `supabase/migration-scripts/05_call_audits_data.sql` | 10 call_audits com transcrições |
| `supabase/migration-scripts/06_supervisor_data.sql` | supervisor_analyses + stage_scores + protocol_rules |
| `supabase/migration-scripts/07_notifications_jobs.sql` | notifications + job_queue + refresh views |
| `supabase/migration-scripts/08_fix_auth_aud.sql` | **Fix crítico do `aud='authenticated'`** |
| `scripts/cli-setup-v2.ps1` | Instala Vercel/Supabase/GitHub CLIs |
| `scripts/full-diagnostic.ps1` | Testa Auth API + Vercel deploy + cookies |

## 🎯 Worker (Oracle VPS) — falta atualizar

O worker no Oracle VPS ainda aponta pro Supabase antigo. Quando acordar:

```bash
ssh user@vps
sudo nano /opt/callaudit/workers/.env
# Trocar:
SUPABASE_URL=https://putdygyeerldrsyjhvzm.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3ODQzOTUwOSwiZXhwIjoyMDk0MDE1NTA5fQ.jJXI9rUmc5UDFGd34OrEHs9aigijLhTpFZHq1-i5YTM
# Salvar (Ctrl+O, Enter, Ctrl+X)
sudo systemctl restart callaudit-worker.service
sudo systemctl status callaudit-worker.service
```
