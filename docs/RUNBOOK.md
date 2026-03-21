# Runbook de Incidentes — CallAudit

## 1. Worker Parado / Crash

**Sintomas:** Jobs acumulando com status `pending`, nenhum log novo do worker.

**Diagnóstico:**
```bash
# Verificar status do serviço
sudo systemctl status callaudit-worker

# Ver últimos logs
sudo journalctl -u callaudit-worker --since "30 min ago" -f

# Verificar health endpoint
curl http://localhost:8080/health
```

**Resolução:**
```bash
sudo systemctl restart callaudit-worker
```

**Se persistir:** Verificar se env vars estão configuradas (`/etc/callaudit/.env`), se Supabase está acessível, se há memória/disco disponível.

---

## 2. Job Stuck em `processing`

**Sintomas:** Job com status `processing` há mais de 15 minutos.

**Diagnóstico:**
```sql
SELECT id, job_type, audit_id, status, started_at, attempts
FROM job_queue
WHERE status = 'processing'
AND started_at < NOW() - INTERVAL '15 minutes';
```

**Resolução:**
```sql
-- Resetar para pending (será reprocessado)
UPDATE job_queue SET status = 'pending', started_at = NULL
WHERE id = '<job_id>';
```

**Se recorrente:** Verificar timeouts no worker (`main.py` — timeouts por tipo de job).

---

## 3. Jobs em Dead Letter

**Sintomas:** Jobs com `status = 'dead_letter'` acumulando.

**Diagnóstico:**
```sql
SELECT job_type, COUNT(*), MAX(updated_at)
FROM job_queue
WHERE status = 'dead_letter'
GROUP BY job_type;

-- Ver erros específicos
SELECT id, job_type, audit_id, error_message
FROM job_queue
WHERE status = 'dead_letter'
ORDER BY updated_at DESC
LIMIT 20;
```

**Resolução:**
1. Investigar `error_message` de cada job
2. Se erro transiente (API down), re-enfileirar:
```sql
UPDATE job_queue SET status = 'pending', attempts = 0, error_message = NULL
WHERE id = '<job_id>';
```
3. Se erro permanente (arquivo corrompido), marcar audit como error:
```sql
UPDATE call_audits SET status = 'error' WHERE id = '<audit_id>';
```

---

## 4. Transcrição Falhando (Whisper)

**Sintomas:** Jobs `transcribe` indo para dead_letter com erros de API.

**Causas comuns:**
- Arquivo de áudio corrompido ou formato não suportado
- Rate limit da OpenAI (429)
- Arquivo muito grande (>25MB)

**Diagnóstico:**
```sql
SELECT ca.id, ca.audio_filename, ca.audio_path, jq.error_message
FROM call_audits ca
JOIN job_queue jq ON jq.audit_id = ca.id
WHERE jq.job_type = 'transcribe' AND jq.status = 'dead_letter';
```

**Resolução:**
- **Rate limit:** Aguardar e re-enfileirar
- **Arquivo grande:** Converter/comprimir antes de re-upload
- **Formato inválido:** Verificar que é `.ogg`, `.mp3`, `.m4a`, `.wav`, `.webm`

---

## 5. Análise Falhando (Claude)

**Sintomas:** Jobs `analyze` falhando com erros 429 ou 529.

**Diagnóstico:** Verificar logs do worker para `rate_limit_error` ou `overloaded_error`.

**Resolução:**
- **429 (rate limit):** O worker já faz retry com backoff. Se persistir, reduzir concorrência.
- **529 (overloaded):** API Anthropic sobrecarregada. Aguardar 5-10 min e re-enfileirar.
- **Resposta malformada:** Verificar `prompt_version` e atualizar system prompt se necessário.

---

## 6. Google Drive Sync Loop

**Sintomas:** Mesmo arquivo sendo processado repetidamente.

**Diagnóstico:**
```sql
SELECT drive_file_id, origin, COUNT(*)
FROM drive_sync
GROUP BY drive_file_id, origin
HAVING COUNT(*) > 1;
```

**Resolução:**
1. Verificar tabela `drive_sync` — cada arquivo deve ter exatamente 1 registro
2. Se duplicado, remover registros extras
3. Verificar que `drive_file_id` está sendo salvo em `call_audits`

**Prevenção:** O sistema usa anti-loop via `drive_sync.drive_file_id` + `origin`. Se o campo não está sendo populado, verificar `DriveSync.sync_to_drive()` e `sync_from_drive()`.

---

## 7. Notificações Não Chegando

**Sintomas:** Auditorias completas mas sem WhatsApp/email.

**Diagnóstico:**
```sql
-- Verificar jobs de notify
SELECT * FROM job_queue
WHERE job_type = 'notify'
ORDER BY created_at DESC LIMIT 10;

-- Verificar config de notificação
SELECT * FROM app_config WHERE key IN ('whatsapp_numbers', 'email_addresses');
```

**Resolução:**
- **WhatsApp:** Verificar `EVOLUTION_API_URL`, `EVOLUTION_API_TOKEN`, `EVOLUTION_INSTANCE_ID`
- **Email:** Verificar `RESEND_API_KEY`, `RESEND_FROM_EMAIL`
- **Config vazia:** Configurar destinatários na página Settings

---

## 8. Supabase Storage Cheio / Upload Falhando

**Sintomas:** Uploads retornando erro, storage limit atingido.

**Diagnóstico:**
- Verificar usage no Supabase Dashboard → Storage
- Verificar RLS policies no bucket `audios`

**Resolução:**
- Limpar arquivos antigos do bucket (manter últimos 90 dias)
- Upgrade do plano Supabase se necessário
- Verificar que storage policies permitem upload pelo role correto

---

## 9. Performance Degradada no Dashboard

**Sintomas:** Dashboard lento (>3s de carregamento).

**Diagnóstico:**
```sql
-- Verificar se materialized views estão atualizadas
SELECT relname, last_refresh
FROM pg_stat_user_tables
WHERE relname LIKE 'mat_%';

-- Forçar refresh
REFRESH MATERIALIZED VIEW CONCURRENTLY mat_dashboard_stats;
REFRESH MATERIALIZED VIEW CONCURRENTLY mat_closer_performance;
```

**Resolução:**
1. Refresh manual das materialized views
2. Verificar que o trigger `trigger_audit_refresh_views` está ativo
3. Se volume muito grande (>10k auditorias), considerar particionamento

---

## Checklist Geral de Troubleshooting

1. [ ] Worker está rodando? (`systemctl status`)
2. [ ] Health endpoint responde? (`curl :8080/health`)
3. [ ] Logs mostram erros? (`journalctl -u callaudit-worker`)
4. [ ] Supabase está acessível? (testar URL no browser)
5. [ ] APIs externas respondem? (verificar status pages: OpenAI, Anthropic, Resend)
6. [ ] Env vars estão configuradas? (verificar `.env`)
7. [ ] Jobs na fila? (`SELECT COUNT(*) FROM job_queue WHERE status = 'pending'`)
8. [ ] Disco/memória OK? (`df -h`, `free -m`)
