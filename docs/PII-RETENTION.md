# Matriz PII / Retenção de Dados — CallAudit

## Classificação de Dados

### Dados Pessoais (PII)

| Dado | Tabela/Local | Sensibilidade | Justificativa |
|---|---|---|---|
| Nome do closer | `closers.name` | MÉDIA | Identificação profissional |
| Email do closer | `closers.email` | MÉDIA | Contato profissional |
| Telefone do closer | `closers.phone` | MÉDIA | WhatsApp corporativo |
| Nome do lead | `call_audits.lead_name` | ALTA | Dado do cliente final |
| Voz do closer/lead | `audios/*` (Storage) | ALTA | Biometria de voz |
| Transcrição da call | `call_audits.transcricao` | ALTA | Conteúdo da conversa com dados do lead |
| Email do usuário | `auth.users.email` | MÉDIA | Autenticação |

### Dados Sensíveis de Negócio

| Dado | Tabela/Local | Sensibilidade | Justificativa |
|---|---|---|---|
| Relatório de análise | `call_audits.relatorio_completo` | ALTA | Avaliação de performance |
| Scores das 13 dimensões | `call_audits.d01..d13` | MÉDIA | Métricas de desempenho |
| Score final | `call_audits.score_final` | MÉDIA | Classificação do closer |
| Plano de ação | dentro do relatório | MÉDIA | Orientações de melhoria |

### Dados Técnicos / Secrets

| Dado | Local | Sensibilidade | Notas |
|---|---|---|---|
| API keys | `.env` (nunca em repo) | CRÍTICA | OpenAI, Anthropic, Resend, Evolution |
| Service account Google | `GOOGLE_SERVICE_ACCOUNT_JSON` | CRÍTICA | Acesso ao Drive |
| Supabase service role key | `.env` | CRÍTICA | Bypassa RLS |

## Política de Retenção

| Tipo de Dado | Retenção | Ação após Expiração |
|---|---|---|
| Arquivos de áudio | 180 dias | Deletar do Storage e Drive |
| Transcrições | 365 dias | Anonimizar (remover nomes de leads) |
| Relatórios de análise | 365 dias | Manter sem PII do lead |
| Scores e métricas | Indefinido | Dados agregados, sem PII direta |
| Logs do worker | 90 dias | Deletar automaticamente |
| Jobs da fila | 30 dias (concluídos) | Deletar jobs com status `completed` ou `dead_letter` |
| Notificações enviadas | 180 dias | Deletar registros antigos |

## Procedimento de Exclusão de Dados (DSAR)

### Excluir dados de um lead específico

```sql
-- 1. Identificar auditorias do lead
SELECT id, audio_path FROM call_audits
WHERE lead_name ILIKE '%nome_do_lead%';

-- 2. Deletar áudios do Storage (via API ou Dashboard)
-- 3. Limpar dados pessoais
UPDATE call_audits SET
    lead_name = '[REMOVIDO]',
    transcricao = NULL,
    relatorio_completo = NULL
WHERE lead_name ILIKE '%nome_do_lead%';
```

### Excluir dados de um closer

```sql
-- 1. Anonimizar auditorias
UPDATE call_audits SET closer_id = NULL
WHERE closer_id = '<closer_id>';

-- 2. Deletar closer
DELETE FROM closers WHERE id = '<closer_id>';

-- 3. Deletar perfil (se é também usuário)
-- Feito via Supabase Auth admin
```

## Processamento por Terceiros

| Serviço | Dados Enviados | Retenção pelo Terceiro | Notas |
|---|---|---|---|
| OpenAI (Whisper) | Arquivo de áudio | Não retém (API) | [Política de dados da API](https://openai.com/policies/api-data-usage-policies) |
| Anthropic (Claude) | Transcrição + metadados | Não retém (API) | [Data retention](https://docs.anthropic.com/en/docs/resources/data-retention) |
| Resend | Email do destinatário + conteúdo | 30 dias (logs) | Apenas metadados de envio |
| Evolution API | Número WhatsApp + mensagem | Depende da instância | Self-hosted recomendado |
| Google Drive | Áudio + relatórios | Até exclusão manual | Controlado pela organização |
| Supabase | Todos os dados | Até exclusão do projeto | Região: conforme projeto |

## Checklist de Compliance

- [ ] Informar usuários sobre coleta de dados (política de privacidade)
- [ ] Obter consentimento para gravação das calls
- [ ] Configurar retenção automática no Supabase Storage
- [ ] Implementar endpoint de exclusão de dados (DSAR)
- [ ] Revisar políticas de terceiros anualmente
- [ ] Criptografia em trânsito (HTTPS) — já implementado via Supabase/Vercel
- [ ] Criptografia em repouso — dependente do plano Supabase
