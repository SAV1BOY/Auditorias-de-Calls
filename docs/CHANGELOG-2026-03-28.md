# CallAudit — Changelog 2026-03-28 (Sessão de Correção Completa)

## Resumo
Correção de todos os problemas na aba Supervisor, aba Sentimento e aba Transcrição. Validação do pipeline automático. Processamento de 3 novas análises de supervisor.

## Commits

| SHA | Descrição |
|-----|-----------|
| `7f0be99e5b` | Fix TS2322: cast unknown→ReactNode nos componentes supervisor |
| `a9bb75ae55` | Fix lint: remove renderPriorityItem não usado + escape quotes JSX |
| `bcd93fd11b` | Fix mapRowToAnalysis: fallback raw_json negotiation, verbatim→text, priority improvements |
| `e4b17d4caa` | Fix Edge Function: prompt supervisor + mapeamento negotiation + stage_scores |
| `8c83efccad` | Fix ObjectionsList: suporta formato legacy e novo |
| `e6c8dc88fa` | Feat: render Markdown na aba Transcrição |

## Migrações SQL
- `fix_weakest_stages_view`: Recriação da view v_supervisor_weakest_stages

## Edge Function
- Deploy v12 do `process-job` com prompt e mapeamento corrigidos

## Problemas Corrigidos

### 5.1 Weakest Stages Chart sem barras
- **Causa**: View agrupava stage_keys descritivos (score 0) com stage_N (score real)
- **Fix**: Limpeza de registros legados + recriação da view
- **Prevenção**: Validar stage_key padrão no insert

### 5.2 Negotiation Analysis NULL/0.0
- **Causa Backend**: Field names do Claude ≠ DB schema, sem coerção de tipos
- **Causa Frontend**: Sem fallback para raw_json
- **Fix**: Prompt explícito + coerção no insert + fallback raw_json no frontend
- **Prevenção**: Schema JSON no prompt, coerção de tipos, fallback raw_json

### 5.3 Detected Objections "undefined"
- **Causa**: Claude retorna `verbatim`, frontend espera `text`
- **Fix**: Mapeamento verbatim→text em mapRowToAnalysis
- **Prevenção**: Mapear explicitamente field names LLM→frontend

### 5.4 Priority Improvements [object Object]
- **Causa**: Tipo string[] mas dados são objetos
- **Fix**: Tipo unknown[] + renderização com verificação typeof
- **Prevenção**: Usar unknown[] para arrays de LLM

### 5.5 Sentimento — Objeções vazias
- **Causa**: ObjectionsList usava obj.objection, dados antigos têm obj.text
- **Fix**: Fallback chain: objection ?? text ?? verbatim
- **Prevenção**: Componentes defensivos com fallback chain

### 5.6 Transcrição Markdown literal
- **Causa**: Renderizava como texto plain sem ReactMarkdown
- **Fix**: Detecção de markdown + renderização condicional
- **Prevenção**: Upload .md → sempre renderizar como markdown

## Lições Aprendidas
1. Nunca confiar nos field names do LLM — mapear explicitamente
2. Sempre ter fallback para raw_json JSONB
3. Usar unknown[] para arrays de LLM
4. Componentes defensivos com fallback chain
5. Schema JSON explícito no prompt do LLM
6. Validar views SQL com dados reais
7. Spend limit ≠ créditos na Anthropic
