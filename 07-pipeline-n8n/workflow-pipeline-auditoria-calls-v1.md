# WORKFLOW COMPLETO — Pipeline de Auditoria Automática de Calls
## n8n + Google Drive + Supabase + Whisper API + Claude + Evolution API + Email

**Versão:** 1.0 | **Arquitetura:** Event-driven com fallback
**Stack:** n8n (orquestrador) → Google Drive (storage bruto) → Whisper API (transcrição) → Claude API (análise) → Supabase (persistência) → Evolution API + Email (distribuição)

---

## ARQUITETURA VISUAL

```
┌──────────────────────────────────────────────────────────────────────────┐
│                          PIPELINE COMPLETO                               │
│                                                                          │
│  ┌─────────────┐    ┌──────────────┐    ┌─────────────┐                 │
│  │ Google Drive │───▶│   n8n        │───▶│ Whisper API │                 │
│  │ (Upload do   │    │ (Trigger:    │    │ (Transcrição│                 │
│  │  áudio)      │    │  novo arquivo│    │  PT-BR)     │                 │
│  └─────────────┘    └──────┬───────┘    └──────┬──────┘                 │
│                            │                    │                        │
│                            ▼                    ▼                        │
│                     ┌──────────────┐    ┌──────────────┐                │
│                     │ Preprocessar │◀───│ Transcrição  │                │
│                     │ (metadata,   │    │ formatada    │                │
│                     │  speakers,   │    └──────────────┘                │
│                     │  proporção)  │                                     │
│                     └──────┬───────┘                                     │
│                            │                                             │
│                            ▼                                             │
│                     ┌──────────────┐                                     │
│                     │ Claude API   │                                     │
│                     │ (System      │                                     │
│                     │  Prompt do   │                                     │
│                     │  Analista)   │                                     │
│                     └──────┬───────┘                                     │
│                            │                                             │
│                            ▼                                             │
│                     ┌──────────────┐                                     │
│                     │ Processar    │                                     │
│                     │ Output       │                                     │
│                     │ (score,      │                                     │
│                     │  resumo)     │                                     │
│                     └──────┬───────┘                                     │
│                            │                                             │
│              ┌─────────────┼─────────────┐                              │
│              ▼             ▼             ▼                               │
│       ┌───────────┐ ┌───────────┐ ┌───────────┐                        │
│       │ Supabase  │ │ WhatsApp  │ │  Email    │                        │
│       │ (persist) │ │ (resumo)  │ │ (completo)│                        │
│       └───────────┘ └───────────┘ └───────────┘                        │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## PARTE 1 — ESTRUTURA DE PASTAS NO GOOGLE DRIVE

Criar a seguinte estrutura no Drive:

```
📁 Auditorias Comerciais/
  📁 Gravações/
    📁 evelyn/
    📁 gustavo/
    📁 [nome-do-closer]/
  📁 Relatórios/
    📁 evelyn/
    📁 gustavo/
    📁 [nome-do-closer]/
  📁 Transcrições/
```

**Convenção de nome do arquivo de áudio:**
```
YYYY-MM-DD_nome-do-lead.ogg
```
Exemplo: `2026-03-02_elane-lima.ogg`

O nome da PASTA identifica o closer. O nome do ARQUIVO identifica a data e o lead.

---

## PARTE 2 — SCHEMA DO SUPABASE

### Tabela principal: `call_audits`

```sql
-- Executar no SQL Editor do Supabase

CREATE TABLE IF NOT EXISTS call_audits (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  
  -- Identificação
  closer_name TEXT NOT NULL,
  lead_name TEXT NOT NULL,
  call_date DATE NOT NULL,
  duration_minutes INTEGER,
  resultado TEXT, -- 'fechamento', 'não fechou', 'reagendar'
  valor_fechamento NUMERIC(12,2), -- valor se fechou
  
  -- Score (13 dimensões)
  score_final NUMERIC(3,1),
  classificacao TEXT, -- 'ELITE', 'FORTE', 'MEDIANA', 'FRACA'
  d01_frame NUMERIC(3,1),
  d02_qualificacao NUMERIC(3,1),
  d03_diag_quantitativo NUMERIC(3,1),
  d04_diag_qualitativo NUMERIC(3,1),
  d05_consequencia NUMERIC(3,1),
  d06_ensino NUMERIC(3,1),
  d07_identidade NUMERIC(3,1),
  d08_ancoragem NUMERIC(3,1),
  d09_isolamento NUMERIC(3,1),
  d10_proporcao_fala NUMERIC(3,1),
  d11_promessas NUMERIC(3,1),
  d12_checkpoints NUMERIC(3,1),
  d13_fechamento NUMERIC(3,1),
  
  -- Conteúdo
  relatorio_completo TEXT,
  resumo_whatsapp TEXT,
  transcricao TEXT,
  
  -- URLs
  audio_drive_url TEXT,
  audio_drive_id TEXT,
  relatorio_drive_url TEXT,
  
  -- Análise complementar
  top_erros JSONB, -- [{erro, timestamp, gravidade, correcao}]
  top_acertos JSONB, -- [{acerto, timestamp, framework}]
  plano_acao JSONB, -- [{acao, fase, framework, impacto}]
  frases_proibidas JSONB, -- [{frase, timestamp, risco, substituicao}]
  
  -- Metadata
  modelo_ia TEXT DEFAULT 'claude-sonnet-4',
  tokens_usados INTEGER,
  custo_estimado NUMERIC(6,4),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices para consultas rápidas
CREATE INDEX idx_call_audits_closer ON call_audits(closer_name);
CREATE INDEX idx_call_audits_date ON call_audits(call_date DESC);
CREATE INDEX idx_call_audits_score ON call_audits(score_final DESC);
CREATE INDEX idx_call_audits_classificacao ON call_audits(classificacao);

-- Trigger para updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_call_audits
  BEFORE UPDATE ON call_audits
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- View para dashboard de evolução por closer
CREATE OR REPLACE VIEW closer_evolution AS
SELECT 
  closer_name,
  COUNT(*) as total_calls,
  ROUND(AVG(score_final), 1) as media_score,
  ROUND(MIN(score_final), 1) as pior_score,
  ROUND(MAX(score_final), 1) as melhor_score,
  COUNT(*) FILTER (WHERE classificacao = 'ELITE') as calls_elite,
  COUNT(*) FILTER (WHERE classificacao = 'FORTE') as calls_forte,
  COUNT(*) FILTER (WHERE classificacao = 'MEDIANA') as calls_mediana,
  COUNT(*) FILTER (WHERE classificacao = 'FRACA') as calls_fraca,
  COUNT(*) FILTER (WHERE resultado = 'fechamento') as fechamentos,
  ROUND(
    COUNT(*) FILTER (WHERE resultado = 'fechamento')::NUMERIC / 
    NULLIF(COUNT(*), 0) * 100, 1
  ) as taxa_fechamento_pct,
  -- Média por dimensão
  ROUND(AVG(d01_frame), 1) as avg_frame,
  ROUND(AVG(d02_qualificacao), 1) as avg_qualificacao,
  ROUND(AVG(d03_diag_quantitativo), 1) as avg_diag_quant,
  ROUND(AVG(d04_diag_qualitativo), 1) as avg_diag_qual,
  ROUND(AVG(d05_consequencia), 1) as avg_consequencia,
  ROUND(AVG(d06_ensino), 1) as avg_ensino,
  ROUND(AVG(d07_identidade), 1) as avg_identidade,
  ROUND(AVG(d08_ancoragem), 1) as avg_ancoragem,
  ROUND(AVG(d09_isolamento), 1) as avg_isolamento,
  ROUND(AVG(d10_proporcao_fala), 1) as avg_proporcao_fala,
  ROUND(AVG(d11_promessas), 1) as avg_promessas,
  ROUND(AVG(d12_checkpoints), 1) as avg_checkpoints,
  ROUND(AVG(d13_fechamento), 1) as avg_fechamento
FROM call_audits
GROUP BY closer_name
ORDER BY media_score DESC;

-- View para últimas 20 calls
CREATE OR REPLACE VIEW recent_audits AS
SELECT 
  id,
  closer_name,
  lead_name,
  call_date,
  duration_minutes,
  score_final,
  classificacao,
  resultado,
  valor_fechamento,
  resumo_whatsapp,
  created_at
FROM call_audits
ORDER BY created_at DESC
LIMIT 20;

-- RLS (Row Level Security) - ativar se necessário
-- ALTER TABLE call_audits ENABLE ROW LEVEL SECURITY;
```

### Tabela de configuração: `audit_config`

```sql
CREATE TABLE IF NOT EXISTS audit_config (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Inserir configurações iniciais
INSERT INTO audit_config (key, value) VALUES
  ('closers', '["evelyn", "gustavo"]'),
  ('supervisores', '[{"nome": "Renan", "whatsapp": "55XXXXXXXXXXX", "email": "renan@system.com"}, {"nome": "Mateus", "whatsapp": "55XXXXXXXXXXX", "email": "mateus@system.com"}]'),
  ('grupo_whatsapp', '"GRUPO_ID_AQUI"'),
  ('drive_folder_gravacoes', '"FOLDER_ID_AQUI"'),
  ('drive_folder_relatorios', '"FOLDER_ID_AQUI"'),
  ('whisper_model', '"whisper-1"'),
  ('claude_model', '"claude-sonnet-4-20250514"'),
  ('evolution_instance', '"INSTANCE_NAME"')
ON CONFLICT (key) DO NOTHING;
```

---

## PARTE 3 — WORKFLOW n8n (Nó por Nó)

### NÓ 1 — Google Drive Trigger
**Tipo:** Google Drive Trigger
**Configuração:**
- Event: File Created
- Folder ID: `{{ID_DA_PASTA_GRAVACOES}}` (pasta "Gravações" e subpastas)
- Poll interval: 5 minutos (ou webhook se disponível)

**Output esperado:**
```json
{
  "id": "1aBcDeFgH...",
  "name": "2026-03-02_elane-lima.ogg",
  "mimeType": "audio/ogg",
  "parents": ["FOLDER_ID_DO_CLOSER"],
  "webViewLink": "https://drive.google.com/file/d/..."
}
```

---

### NÓ 2 — Identificar Closer (Code Node)
**Tipo:** Code (JavaScript)

```javascript
// Extrair metadata do arquivo
const file = $input.first().json;
const fileName = file.name; // "2026-03-02_elane-lima.ogg"
const parentFolderId = file.parents?.[0] || '';

// Extrair data e nome do lead do nome do arquivo
const match = fileName.match(/^(\d{4}-\d{2}-\d{2})_(.+)\.\w+$/);
const callDate = match ? match[1] : new Date().toISOString().split('T')[0];
const leadName = match ? match[2].replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase()) : 'Desconhecido';

// O nome do closer vem da pasta pai
// Isso será resolvido no próximo nó via Google Drive API
return {
  json: {
    fileId: file.id,
    fileName,
    callDate,
    leadName,
    parentFolderId,
    driveUrl: file.webViewLink || `https://drive.google.com/file/d/${file.id}`,
    mimeType: file.mimeType
  }
};
```

---

### NÓ 3 — Buscar Nome da Pasta (Google Drive Node)
**Tipo:** Google Drive - Get File/Folder
**Configuração:**
- Operation: Get
- File/Folder ID: `{{$json.parentFolderId}}`

**Depois: Code Node para extrair o nome:**
```javascript
const folderName = $input.first().json.name; // "evelyn"
const prev = $('Identificar Closer').first().json;

return {
  json: {
    ...prev,
    closerName: folderName.charAt(0).toUpperCase() + folderName.slice(1)
  }
};
```

---

### NÓ 4 — Download do Áudio (Google Drive Node)
**Tipo:** Google Drive - Download File
**Configuração:**
- File ID: `{{$json.fileId}}`
- Output: Binary data

---

### NÓ 5 — Transcrição via Whisper API (HTTP Request)
**Tipo:** HTTP Request
**Configuração:**

```
URL: https://api.openai.com/v1/audio/transcriptions
Method: POST
Authentication: Header Auth
  Header Name: Authorization
  Header Value: Bearer {{$env.OPENAI_API_KEY}}

Content-Type: multipart/form-data
Body Parameters:
  - file: (binary data do nó anterior)
  - model: whisper-1
  - language: pt
  - response_format: verbose_json
  - timestamp_granularities[]: segment
```

**Output esperado:**
```json
{
  "text": "transcrição completa...",
  "segments": [
    {"start": 0.0, "end": 5.2, "text": "Olá, tudo bem?"},
    {"start": 5.2, "end": 12.1, "text": "Tudo sim, e você?"}
  ],
  "duration": 5640.5
}
```

---

### NÓ 6 — Preprocessamento (Code Node)
**Tipo:** Code (JavaScript)

```javascript
const whisperOutput = $input.first().json;
const metadata = $('Buscar Nome Closer').first().json;

const transcricao = whisperOutput.text;
const durationSeconds = whisperOutput.duration || 0;
const durationMinutes = Math.round(durationSeconds / 60);
const segments = whisperOutput.segments || [];

// Formatar transcrição com timestamps
let formattedTranscription = '';
for (const seg of segments) {
  const mins = Math.floor(seg.start / 60);
  const secs = Math.floor(seg.start % 60);
  const timestamp = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
  formattedTranscription += `[${timestamp}] ${seg.text.trim()}\n`;
}

// Estimar palavras totais
const totalWords = transcricao.split(/\s+/).length;

return {
  json: {
    closerName: metadata.closerName,
    leadName: metadata.leadName,
    callDate: metadata.callDate,
    fileId: metadata.fileId,
    driveUrl: metadata.driveUrl,
    durationMinutes,
    durationSeconds,
    totalWords,
    transcricaoRaw: transcricao,
    transcricaoFormatada: formattedTranscription,
    segmentCount: segments.length
  }
};
```

---

### NÓ 7 — Análise via Claude API (HTTP Request)
**Tipo:** HTTP Request
**Configuração:**

```
URL: https://api.anthropic.com/v1/messages
Method: POST
Headers:
  x-api-key: {{$env.ANTHROPIC_API_KEY}}
  anthropic-version: 2023-06-01
  content-type: application/json

Body (JSON):
{
  "model": "claude-sonnet-4-20250514",
  "max_tokens": 16000,
  "system": "<<SYSTEM_PROMPT_ANALISTA_COMPLETO_AQUI>>",
  "messages": [
    {
      "role": "user",
      "content": "Analise a seguinte transcrição de call de fechamento.\n\n## Dados da Call\n- Closer: {{$json.closerName}}\n- Lead: {{$json.leadName}}\n- Data: {{$json.callDate}}\n- Duração: {{$json.durationMinutes}} minutos\n- Total de palavras: {{$json.totalWords}}\n\n## Transcrição Completa\n\n{{$json.transcricaoFormatada}}"
    }
  ]
}
```

**IMPORTANTE:** O system prompt completo (arquivo `system-prompt-analista-calls-v1.md`) deve ser colado inteiro no campo `system`. No n8n, pode ser armazenado como variável de ambiente ou em um nó de configuração.

---

### NÓ 8 — Processar Output da IA (Code Node)
**Tipo:** Code (JavaScript)

```javascript
const response = $input.first().json;
const prev = $('Preprocessamento').first().json;

const analysis = response.content?.[0]?.text || response.content || '';
const tokensUsed = (response.usage?.input_tokens || 0) + (response.usage?.output_tokens || 0);

// Extrair score final
const scoreMatch = analysis.match(/(\d+[.,]\d+)\s*\/\s*10/);
const scoreFinal = scoreMatch ? parseFloat(scoreMatch[1].replace(',', '.')) : null;

// Extrair classificação
const classPatterns = [
  { pattern: /CALL DE ELITE/i, value: 'ELITE' },
  { pattern: /CALL FORTE/i, value: 'FORTE' },
  { pattern: /CALL MEDIANA/i, value: 'MEDIANA' },
  { pattern: /CALL FRACA/i, value: 'FRACA' },
];
let classificacao = 'N/A';
for (const { pattern, value } of classPatterns) {
  if (pattern.test(analysis)) { classificacao = value; break; }
}

// Extrair notas das 13 dimensões via regex na tabela do relatório
function extractDimensionScore(text, dimNumber) {
  // Busca padrão: "| N |" seguido de nota
  const patterns = [
    new RegExp(`\\|\\s*${dimNumber}\\s*\\|[^|]*\\|[^|]*\\|\\s*(\\d+[.,]?\\d*)\\s*\\|`, 'i'),
    new RegExp(`Dimensão ${dimNumber}[^\\d]*(\\d+[.,]\\d+)`, 'i'),
  ];
  for (const p of patterns) {
    const m = text.match(p);
    if (m) return parseFloat(m[1].replace(',', '.'));
  }
  return null;
}

const dimensions = {};
for (let i = 1; i <= 13; i++) {
  dimensions[`d${String(i).padStart(2, '0')}`] = extractDimensionScore(analysis, i);
}

// Extrair seções para JSONB
function extractSection(text, sectionTitle) {
  const regex = new RegExp(`## \\d+\\.\\s*${sectionTitle}[\\s\\S]*?(?=## \\d+\\.|$)`, 'i');
  const match = text.match(regex);
  return match ? match[0].trim() : '';
}

const errosSection = extractSection(analysis, 'Top 5 Erros');
const acertosSection = extractSection(analysis, 'Top 5 Acertos');
const planoSection = extractSection(analysis, 'Plano de Ação');

// Gerar resumo para WhatsApp
const emoji_score = scoreFinal >= 8.5 ? '🏆' : scoreFinal >= 7 ? '✅' : scoreFinal >= 5.5 ? '⚠️' : '🔴';

// Extrair top 3 erros e acertos de forma simplificada
function extractTopItems(section, count = 3) {
  const items = [];
  const regex = /(?:Erro|Acerto|Prioridade)\s*(\d+)[^\n]*\n[^]*?(?:\*\*O que|O que aconteceu|O que foi feito|O que fazer)[:\*]*\s*([^\n]+)/gi;
  let match;
  while ((match = regex.exec(section)) !== null && items.length < count) {
    items.push(match[2].trim().substring(0, 100));
  }
  return items;
}

const topErros = extractTopItems(errosSection);
const topAcertos = extractTopItems(acertosSection);

let resumoWhatsapp = `📊 *AUDITORIA — Call ${prev.closerName} x ${prev.leadName}*\n`;
resumoWhatsapp += `📅 ${prev.callDate} | ⏱️ ${prev.durationMinutes}min\n\n`;
resumoWhatsapp += `${emoji_score} *Score: ${scoreFinal}/10 — ${classificacao}*\n\n`;

if (topAcertos.length > 0) {
  resumoWhatsapp += `✅ *Acertos:*\n`;
  topAcertos.forEach((a, i) => resumoWhatsapp += `${i+1}. ${a}\n`);
  resumoWhatsapp += `\n`;
}

if (topErros.length > 0) {
  resumoWhatsapp += `⚠️ *Melhorar:*\n`;
  topErros.forEach((e, i) => resumoWhatsapp += `${i+1}. ${e}\n`);
  resumoWhatsapp += `\n`;
}

resumoWhatsapp += `📋 Relatório completo enviado por email.`;

// Estimar custo
const inputTokens = response.usage?.input_tokens || 0;
const outputTokens = response.usage?.output_tokens || 0;
// Claude Sonnet pricing: $3/MTok input, $15/MTok output
const custoEstimado = (inputTokens * 3 / 1000000) + (outputTokens * 15 / 1000000);

return {
  json: {
    // Identificação
    closerName: prev.closerName,
    leadName: prev.leadName,
    callDate: prev.callDate,
    durationMinutes: prev.durationMinutes,
    fileId: prev.fileId,
    driveUrl: prev.driveUrl,
    
    // Scores
    scoreFinal,
    classificacao,
    ...dimensions,
    
    // Conteúdo
    relatorioCompleto: analysis,
    resumoWhatsapp,
    transcricao: prev.transcricaoRaw,
    
    // Análise
    topErros: JSON.stringify(topErros),
    topAcertos: JSON.stringify(topAcertos),
    errosSection,
    acertosSection,
    planoSection,
    
    // Meta
    tokensUsed,
    custoEstimado: Math.round(custoEstimado * 10000) / 10000,
  }
};
```

---

### NÓ 9 — Salvar no Supabase (HTTP Request ou Supabase Node)
**Tipo:** HTTP Request (para Supabase REST API)

```
URL: {{$env.SUPABASE_URL}}/rest/v1/call_audits
Method: POST
Headers:
  apikey: {{$env.SUPABASE_KEY}}
  Authorization: Bearer {{$env.SUPABASE_KEY}}
  Content-Type: application/json
  Prefer: return=representation

Body:
{
  "closer_name": "{{$json.closerName}}",
  "lead_name": "{{$json.leadName}}",
  "call_date": "{{$json.callDate}}",
  "duration_minutes": {{$json.durationMinutes}},
  "score_final": {{$json.scoreFinal}},
  "classificacao": "{{$json.classificacao}}",
  "d01_frame": {{$json.d01}},
  "d02_qualificacao": {{$json.d02}},
  "d03_diag_quantitativo": {{$json.d03}},
  "d04_diag_qualitativo": {{$json.d04}},
  "d05_consequencia": {{$json.d05}},
  "d06_ensino": {{$json.d06}},
  "d07_identidade": {{$json.d07}},
  "d08_ancoragem": {{$json.d08}},
  "d09_isolamento": {{$json.d09}},
  "d10_proporcao_fala": {{$json.d10}},
  "d11_promessas": {{$json.d11}},
  "d12_checkpoints": {{$json.d12}},
  "d13_fechamento": {{$json.d13}},
  "relatorio_completo": "{{$json.relatorioCompleto}}",
  "resumo_whatsapp": "{{$json.resumoWhatsapp}}",
  "transcricao": "{{$json.transcricao}}",
  "audio_drive_url": "{{$json.driveUrl}}",
  "audio_drive_id": "{{$json.fileId}}",
  "top_erros": {{$json.topErros}},
  "top_acertos": {{$json.topAcertos}},
  "tokens_usados": {{$json.tokensUsed}},
  "custo_estimado": {{$json.custoEstimado}}
}
```

---

### NÓ 10 — Enviar WhatsApp (HTTP Request — Evolution API)
**Tipo:** HTTP Request

```
URL: {{$env.EVOLUTION_API_URL}}/message/sendText/{{$env.EVOLUTION_INSTANCE}}
Method: POST
Headers:
  apikey: {{$env.EVOLUTION_API_KEY}}
  Content-Type: application/json

Body:
{
  "number": "{{$env.GRUPO_WHATSAPP_ID}}",
  "text": "{{$json.resumoWhatsapp}}"
}
```

**Para enviar também individualmente para supervisores:**
Duplicar este nó ou usar um loop com os números dos supervisores.

---

### NÓ 11 — Enviar Email (Send Email Node ou SMTP)
**Tipo:** Send Email (ou HTTP Request para API de email)

```
To: renan@system.com, mateus@system.com
Subject: 📊 Auditoria Call — {{$json.closerName}} x {{$json.leadName}} | Score: {{$json.scoreFinal}}/10

Body (HTML):
<h2>Auditoria de Call — {{$json.closerName}} x {{$json.leadName}}</h2>
<p><strong>Data:</strong> {{$json.callDate}} | <strong>Duração:</strong> {{$json.durationMinutes}}min</p>
<p><strong>Score:</strong> {{$json.scoreFinal}}/10 — {{$json.classificacao}}</p>
<hr>
<p>O relatório completo está abaixo em formato markdown:</p>
<pre>{{$json.relatorioCompleto}}</pre>
<hr>
<p><a href="{{$json.driveUrl}}">🔗 Áudio da call no Google Drive</a></p>
```

**Alternativa melhor (se tiver SMTP ou API de email):**
Converter o markdown do relatório em HTML formatado usando um nó Code antes de enviar.

---

### NÓ 12 — Salvar Relatório no Drive (Google Drive Node)
**Tipo:** Google Drive - Upload File
**Configuração:**
- Folder ID: pasta "Relatórios/[closer]"
- File Name: `{{$json.callDate}}_{{$json.leadName}}_auditoria.md`
- File Content: `{{$json.relatorioCompleto}}`

---

## PARTE 4 — VARIÁVEIS DE AMBIENTE (n8n)

Configurar em Settings → Variables ou em .env:

```bash
# APIs
OPENAI_API_KEY=sk-proj-...
ANTHROPIC_API_KEY=sk-ant-api03-...

# Supabase
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_KEY=eyJhbGci...

# Evolution API (WhatsApp)
EVOLUTION_API_URL=https://seu-servidor.com
EVOLUTION_API_KEY=sua-api-key
EVOLUTION_INSTANCE=system-digital

# Google Drive Folder IDs
DRIVE_FOLDER_GRAVACOES=1aBcDeFgH...
DRIVE_FOLDER_RELATORIOS=2xYzAbCdE...

# Distribuição
GRUPO_WHATSAPP_ID=120363...@g.us
EMAIL_SUPERVISORES=renan@system.com,mateus@system.com
```

---

## PARTE 5 — ESTIMATIVA DE CUSTOS POR CALL

| Componente | Call 1h | Call 2h | Observação |
|---|---|---|---|
| Whisper API (transcrição) | ~$0.36 | ~$0.72 | $0.006/min |
| Claude Sonnet (análise) | ~$0.12 | ~$0.20 | Input + output tokens |
| Supabase | ~$0.00 | ~$0.00 | Free tier suficiente |
| Evolution API | ~$0.00 | ~$0.00 | Self-hosted |
| Google Drive | ~$0.00 | ~$0.00 | Free tier |
| Email | ~$0.00 | ~$0.00 | SMTP próprio |
| **TOTAL por call** | **~$0.48** | **~$0.92** | **~R$ 2,50-5,00** |

Para 20 calls por mês: ~R$ 50-100/mês. Custo irrisório vs o valor da informação.

---

## PARTE 6 — CHECKLIST DE IMPLEMENTAÇÃO

### Fase 1 — Setup (1-2 horas)
- [ ] Criar estrutura de pastas no Google Drive
- [ ] Executar SQL no Supabase (tabelas + views)
- [ ] Configurar variáveis de ambiente no n8n
- [ ] Testar conexão Google Drive ↔ n8n
- [ ] Testar conexão Supabase ↔ n8n
- [ ] Testar conexão Evolution API ↔ n8n

### Fase 2 — Workflow (2-3 horas)
- [ ] Criar workflow no n8n com todos os 12 nós
- [ ] Colar System Prompt do Analista no nó do Claude
- [ ] Testar com a transcrição da Elane (já temos)
- [ ] Validar que o output bate com a auditoria manual
- [ ] Ajustar regex de extração se necessário

### Fase 3 — Calibração (1-2 horas)
- [ ] Rodar 2-3 calls reais pelo pipeline
- [ ] Comparar scores automáticos vs avaliação manual
- [ ] Ajustar System Prompt se necessário (pesos, calibração)
- [ ] Validar formato do WhatsApp e email

### Fase 4 — Produção
- [ ] Ativar trigger automático no Google Drive
- [ ] Documentar processo para o time (onde fazer upload)
- [ ] Configurar alertas de erro no n8n
- [ ] Monitorar primeiras 10 execuções

---

## PARTE 7 — FLUXO OPERACIONAL DO TIME

```
1. Closer faz a call (Google Meet / Zoom / presencial gravado)
2. Gravação é salva na pasta do closer no Google Drive
   📁 Gravações/evelyn/2026-03-20_maria-silva.ogg
3. n8n detecta o novo arquivo automaticamente
4. Pipeline roda em ~3-5 minutos:
   - Transcreve → Analisa → Salva → Distribui
5. Supervisores recebem:
   - WhatsApp: resumo com score + top 3 erros/acertos
   - Email: relatório completo + link do áudio
6. Supabase: histórico completo para dashboard
7. Google Drive: relatório salvo na pasta do closer
```

**Tempo total do pipeline:** 3-5 minutos (Whisper ~1-2min + Claude ~1-2min + distribuição ~30s)
