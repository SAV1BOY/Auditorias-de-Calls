# GUIA DE INTEGRAÇÃO — Analista de Calls no n8n

## Arquitetura Recomendada

```
[Transcrição]  →  [n8n Workflow]  →  [LLM com System Prompt]  →  [Output Formatado]
     ↓                  ↓                     ↓                        ↓
  Webhook ou       Preprocessar          Claude/GPT com            Enviar via
  Upload manual    texto + metadata      system prompt             WhatsApp/Email
                                         completo                  ou salvar em DB
```

## Fluxo no n8n

### Nó 1 — Trigger
- **Opção A:** Webhook (recebe transcrição via API da Evolution API ou outro)
- **Opção B:** Watch Folder (monitora pasta por novos arquivos .md/.txt)
- **Opção C:** Manual Trigger + Input de texto

### Nó 2 — Preprocessamento (Code Node)
```javascript
// Extrair metadata da transcrição
const transcricao = $input.first().json.transcricao;

// Detectar participantes
const speakers = [...new Set(
  transcricao.match(/\*\*([^*]+)\*\*/g)?.map(s => s.replace(/\*/g, '')) || []
)];

// Detectar duração
const timestamps = transcricao.match(/### (\d{2}:\d{2}:\d{2})/g) || [];
const lastTimestamp = timestamps[timestamps.length - 1]?.replace('### ', '') || 'N/A';

// Estimar contagem de palavras por speaker
const lines = transcricao.split('\n');
let speakerWordCount = {};
speakers.forEach(s => speakerWordCount[s] = 0);

let currentSpeaker = null;
lines.forEach(line => {
  const match = line.match(/\*\*([^*]+)\*\*:\s*(.*)/);
  if (match) {
    currentSpeaker = match[1];
    if (speakerWordCount[currentSpeaker] !== undefined) {
      speakerWordCount[currentSpeaker] += match[2].split(/\s+/).length;
    }
  } else if (currentSpeaker && line.trim()) {
    if (speakerWordCount[currentSpeaker] !== undefined) {
      speakerWordCount[currentSpeaker] += line.trim().split(/\s+/).length;
    }
  }
});

return {
  json: {
    transcricao,
    metadata: {
      speakers,
      duracao: lastTimestamp,
      palavras_por_speaker: speakerWordCount,
      total_palavras: Object.values(speakerWordCount).reduce((a, b) => a + b, 0)
    }
  }
};
```

### Nó 3 — LLM (HTTP Request ou AI Agent)

**Se usando Claude API diretamente (HTTP Request):**
```
URL: https://api.anthropic.com/v1/messages
Method: POST
Headers:
  x-api-key: {{$env.ANTHROPIC_API_KEY}}
  anthropic-version: 2023-06-01
  content-type: application/json

Body:
{
  "model": "claude-sonnet-4-20250514",
  "max_tokens": 16000,
  "system": "{{SYSTEM_PROMPT_COMPLETO}}",
  "messages": [
    {
      "role": "user", 
      "content": "Analise a seguinte transcrição de call de fechamento.\n\nMetadados:\n- Participantes: {{$json.metadata.speakers}}\n- Duração: {{$json.metadata.duracao}}\n- Palavras por participante: {{$json.metadata.palavras_por_speaker}}\n\nTranscrição completa:\n\n{{$json.transcricao}}"
    }
  ]
}
```

**Se usando OpenAI:**
- Substituir endpoint e headers
- Usar model: "gpt-4o" ou "gpt-4-turbo"
- O system prompt é o mesmo

**Se usando n8n AI Agent node:**
- Colar o system prompt no campo "System Message"
- Input: transcrição + metadata
- Tool: nenhum necessário (análise é puramente textual)

### Nó 4 — Formatação do Output (Code Node)
```javascript
const analysis = $input.first().json.content[0].text;

// Extrair score (regex no output formatado)
const scoreMatch = analysis.match(/(\d+[.,]\d+)\/10/);
const score = scoreMatch ? parseFloat(scoreMatch[1].replace(',', '.')) : null;

// Extrair classificação
const classMatch = analysis.match(/(CALL DE ELITE|CALL FORTE|CALL MEDIANA|CALL FRACA)/);
const classification = classMatch ? classMatch[1] : 'N/A';

return {
  json: {
    relatorio_completo: analysis,
    score,
    classificacao: classification,
    data_analise: new Date().toISOString(),
    // Para salvar no PostgreSQL/Supabase
    dados_estruturados: {
      score,
      classificacao: classification,
      closer: '', // extrair do relatório se necessário
      lead: '',
    }
  }
};
```

### Nó 5 — Entrega (escolher um ou mais)

**Opção A — WhatsApp (Evolution API):**
```
POST {{EVOLUTION_API_URL}}/message/sendText/{{INSTANCE}}
Body:
{
  "number": "{{NUMERO_CLOSER}}",
  "text": "📊 *AUDITORIA DA CALL*\n\nScore: {{$json.score}}/10\nClassificação: {{$json.classificacao}}\n\nRelatório completo enviado por e-mail."
}
```

**Opção B — Email (Send Email node)**
- Enviar relatório completo como corpo do email em markdown

**Opção C — PostgreSQL/Supabase:**
- Salvar score, classificação e relatório para dashboard histórico

**Opção D — Google Drive:**
- Salvar como .md ou converter para .docx

---

## Otimização de Tokens

O system prompt completo tem ~6.500 palavras (~8.500 tokens). Para calls longas (>2h como a da Elane), a transcrição pode ter 15.000-25.000 tokens. Total estimado por análise:

| Componente | Tokens estimados |
|---|---|
| System Prompt | ~8.500 |
| Transcrição (call 1h) | ~8.000-12.000 |
| Transcrição (call 2h) | ~15.000-25.000 |
| Output (relatório) | ~4.000-6.000 |
| **Total por análise (call 1h)** | **~22.000-28.000** |
| **Total por análise (call 2h)** | **~30.000-42.000** |

**Custo estimado por análise (Claude Sonnet):**
- Call de 1h: ~$0.10-0.15
- Call de 2h: ~$0.15-0.25

**Para reduzir custos:**
1. Use Claude Sonnet (não Opus) — qualidade excelente a 1/5 do preço
2. Se a transcrição for muito longa, corte trechos de conversa paralela (rapport sobre filhos, clima etc.)
3. O preprocessamento no Nó 2 pode resumir seções claramente não-comerciais

---

## Variáveis de Ambiente Necessárias

```
ANTHROPIC_API_KEY=sk-ant-...
EVOLUTION_API_URL=https://seu-servidor.com
EVOLUTION_INSTANCE=instancia-whatsapp
CLOSER_WHATSAPP=5531999999999
SUPABASE_URL=https://seu-projeto.supabase.co
SUPABASE_KEY=eyJ...
```

---

## Tabela de Referência — Modelos Recomendados

| Modelo | Qualidade da Análise | Custo por Call (1h) | Recomendação |
|---|---|---|---|
| Claude Opus 4 | 10/10 | ~$0.50-0.75 | Para calls críticas ou calibração |
| Claude Sonnet 4 | 9/10 | ~$0.10-0.15 | **Produção diária — melhor custo-benefício** |
| GPT-4o | 8/10 | ~$0.08-0.12 | Alternativa se já usa OpenAI |
| Claude Haiku | 6/10 | ~$0.02-0.04 | Só para triagem rápida (não recomendado para análise completa) |
