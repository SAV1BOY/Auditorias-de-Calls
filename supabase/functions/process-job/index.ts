// Supabase Edge Function: process-job
// Processes job_queue entries (analyze, supervisor_analyze, transcribe)
// Replaces the Python worker for analysis pipeline
import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.100.0"
import Anthropic from "https://esm.sh/@anthropic-ai/sdk@0.39.0"

const CLAUDE_MODEL = "claude-sonnet-4-20250514"
const MAX_TOKENS = 16000

// ─── Dimension constants ───
const DIMENSION_KEYS: Record<number, string> = {
  1: "d01_frame", 2: "d02_qualificacao", 3: "d03_diag_quantitativo",
  4: "d04_diag_qualitativo", 5: "d05_consequencia", 6: "d06_ensino",
  7: "d07_identidade", 8: "d08_ancoragem", 9: "d09_isolamento",
  10: "d10_proporcao_fala", 11: "d11_promessas", 12: "d12_checkpoints",
  13: "d13_fechamento",
}

const DIMENSION_WEIGHTS: Record<string, number> = {
  d01_frame: 0.08, d02_qualificacao: 0.10, d03_diag_quantitativo: 0.12,
  d04_diag_qualitativo: 0.08, d05_consequencia: 0.10, d06_ensino: 0.05,
  d07_identidade: 0.05, d08_ancoragem: 0.10, d09_isolamento: 0.10,
  d10_proporcao_fala: 0.08, d11_promessas: 0.08, d12_checkpoints: 0.03,
  d13_fechamento: 0.03,
}

// ─── Parser functions (ported from Python parser.py) ───

function normalizeDecimal(text: string): number {
  return parseFloat(text.trim().replace(",", "."))
}

function classify(score: number): string {
  if (score >= 8.5) return "ELITE"
  if (score >= 7.0) return "FORTE"
  if (score >= 5.5) return "MEDIANA"
  return "FRACA"
}

function extractSection(raw: string, sectionNum: number): string {
  const pattern = new RegExp(`^##\\s+${sectionNum}\\.\\s`, "m")
  const match = raw.match(pattern)
  if (!match || match.index === undefined) return ""
  const start = match.index
  const rest = raw.slice(match.index + match[0].length)
  const nextMatch = rest.match(/^##\s+\d+\.\s/m)
  const end = nextMatch && nextMatch.index !== undefined
    ? match.index + match[0].length + nextMatch.index
    : raw.length
  return raw.slice(start, end)
}

function parseDimensions(raw: string): Record<string, number> {
  const section = extractSection(raw, 2) // Scorecard section
  const scores: Record<string, number> = {}
  const rowPattern = /\|\s*(\d+)\s*\|[^|]+\|[^|]+\|\s*([\d,\.]+)\s*\|/g
  let m
  while ((m = rowPattern.exec(section)) !== null) {
    const num = parseInt(m[1])
    const key = DIMENSION_KEYS[num]
    if (key) {
      scores[key] = normalizeDecimal(m[2])
    }
  }
  return scores
}

function parseScoreFinal(raw: string): { score: number; classificacao: string } {
  const pattern = /SCORE\s+FINAL[:\s]*([\d,\.]+)\s*\/\s*10\s*[—\-–]\s*(\S+)/i
  const match = raw.match(pattern)
  if (match) {
    const score = normalizeDecimal(match[1])
    return { score, classificacao: match[2].toUpperCase() }
  }
  // Fallback: calculate from dimensions
  const dims = parseDimensions(raw)
  let weighted = 0, totalWeight = 0
  for (const [key, score] of Object.entries(dims)) {
    const w = DIMENSION_WEIGHTS[key] || 0
    weighted += score * w
    totalWeight += w
  }
  const finalScore = totalWeight > 0 ? Math.round((weighted / totalWeight) * 10) / 10 : 0
  return { score: finalScore, classificacao: classify(finalScore) }
}

function parseTopItems(raw: string, sectionNum: number): Array<{ rank: number; title: string; description: string }> {
  const section = extractSection(raw, sectionNum)
  const items: Array<{ rank: number; title: string; description: string }> = []
  const pattern = /(\d+)\.\s*\*\*([^*]+)\*\*\s*[—\-–]\s*(.*?)(?=\n\d+\.|$)/gs
  let m
  while ((m = pattern.exec(section)) !== null) {
    items.push({ rank: parseInt(m[1]), title: m[2].trim(), description: m[3].trim() })
  }
  return items.slice(0, 5)
}

function parseSentiment(raw: string): {
  overall: string; score: number; engagement: string;
  timeline: Array<{ period: string; sentiment: string; confidence: number; moment: string }>;
} {
  const section = extractSection(raw, 10)
  let overall = "neutro", score = 0, engagement = "médio"
  const timeline: Array<{ period: string; sentiment: string; confidence: number; moment: string }> = []

  const overallMatch = section.match(/Sentimento[:\s]*\*?\*?(\w+)/i)
  if (overallMatch) overall = overallMatch[1].toLowerCase()

  const scoreMatch = section.match(/Score.*?:\s*([\-\d,\.]+)/i)
  if (scoreMatch) score = normalizeDecimal(scoreMatch[1])

  const engMatch = section.match(/Engajamento[:\s]*\*?\*?(\w+)/i)
  if (engMatch) engagement = engMatch[1].toLowerCase()

  const rowPattern = /\|\s*([^|]+)\s*\|\s*(\w+)\s*\|\s*([\d,\.]+)\s*\|\s*([^|]+)\s*\|/g
  let m
  while ((m = rowPattern.exec(section)) !== null) {
    if (m[1].includes("Trecho") || m[1].includes("---")) continue
    timeline.push({
      period: m[1].trim(), sentiment: m[2].trim().toLowerCase(),
      confidence: normalizeDecimal(m[3]), moment: m[4].trim(),
    })
  }
  return { overall, score, engagement, timeline }
}

function parseObjections(raw: string): Array<{ type: string; text: string; handled: boolean }> {
  const section = extractSection(raw, 10)
  const objections: Array<{ type: string; text: string; handled: boolean }> = []
  const pattern = /Objeção[:\s]*"([^"]+)".*?Efetividade[:\s]*(\w+)/gi
  let m
  while ((m = pattern.exec(section)) !== null) {
    objections.push({ type: "explicit", text: m[1], handled: m[2].toLowerCase() === "boa" })
  }
  return objections
}

// ─── WhatsApp summary generator ───

function generateWhatsAppSummary(
  scoreFinal: number, classificacao: string,
  topAcertos: Array<{ rank: number; title: string }>,
  topErros: Array<{ rank: number; title: string }>,
  metadata: { closer_name: string; lead_name: string; call_date: string; duration_minutes?: number }
): string {
  const emojis: Record<string, string> = { ELITE: "🏆", FORTE: "💪", MEDIANA: "⚠️", FRACA: "🔴" }
  const emoji = emojis[classificacao] || "📊"
  const lines = [
    `${emoji} AUDITORIA: ${metadata.closer_name} x ${metadata.lead_name}`,
    `📅 ${metadata.call_date} | ⏱ ${metadata.duration_minutes ?? "N/A"}min`,
    `📊 Score: ${scoreFinal}/10 — ${classificacao}`,
    "",
  ]
  if (topAcertos.length) {
    lines.push("✅ Top Acertos:")
    topAcertos.slice(0, 3).forEach(a => lines.push(`${a.rank}. ${a.title.slice(0, 60)}`))
    lines.push("")
  }
  if (topErros.length) {
    lines.push("❌ Top Erros:")
    topErros.slice(0, 3).forEach(e => lines.push(`${e.rank}. ${e.title.slice(0, 60)}`))
  }
  return lines.join("\n").slice(0, 1000)
}

// ─── Main handler ───

Deno.serve(async (req: Request) => {
  try {
    const { job_id, audit_id, job_type } = await req.json()

    if (!audit_id || !job_type) {
      return new Response(JSON.stringify({ error: "audit_id and job_type required" }), { status: 400 })
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    const anthropicKey = Deno.env.get("ANTHROPIC_API_KEY")
    const openaiKey = Deno.env.get("OPENAI_API_KEY")

    const supabase = createClient(supabaseUrl, serviceRoleKey)
    const anthropic = anthropicKey ? new Anthropic({ apiKey: anthropicKey }) : null

    // Mark job as processing
    if (job_id) {
      await supabase.from("job_queue").update({
        status: "processing", started_at: new Date().toISOString()
      }).eq("id", job_id)
    }

    // ─── ANALYZE ───
    if (job_type === "analyze") {
      if (!anthropic) throw new Error("ANTHROPIC_API_KEY not configured")

      // 1. Update status
      await supabase.from("call_audits").update({ status: "analyzing" }).eq("id", audit_id)

      // 2. Fetch audit + transcription
      const { data: audit } = await supabase
        .from("call_audits")
        .select("*, closers(name)")
        .eq("id", audit_id)
        .single()

      if (!audit?.transcricao) throw new Error(`Audit ${audit_id} has no transcription`)

      const closerName = (audit.closers as { name: string } | null)?.name ?? "Desconhecido"
      const metadata = {
        closer_name: closerName,
        lead_name: audit.lead_name ?? "Desconhecido",
        call_date: audit.call_date ?? "N/A",
        duration_minutes: audit.duration_minutes,
      }

      const userMessage = `## DADOS DA CALL\n- **Closer:** ${metadata.closer_name}\n- **Lead:** ${metadata.lead_name}\n- **Data:** ${metadata.call_date}\n- **Duração:** ${metadata.duration_minutes ?? "N/A"} minutos\n\n## TRANSCRIÇÃO COMPLETA\n\n${audit.transcricao}`

      // 3. Call Claude API
      const response = await anthropic.messages.create({
        model: CLAUDE_MODEL,
        max_tokens: MAX_TOKENS,
        system: SYSTEM_PROMPT,
        messages: [{ role: "user", content: userMessage }],
      })

      const rawText = response.content[0].type === "text" ? response.content[0].text : ""

      // 4. Parse response
      const dimensions = parseDimensions(rawText)
      const { score, classificacao } = parseScoreFinal(rawText)
      const topAcertos = parseTopItems(rawText, 5)
      const topErros = parseTopItems(rawText, 6)
      const sentiment = parseSentiment(rawText)
      const objections = parseObjections(rawText)
      const resumoWhatsApp = generateWhatsAppSummary(score, classificacao, topAcertos, topErros, metadata)

      // 5. Save to DB
      await supabase.from("call_audits").update({
        status: "analyzed",
        score_final: score,
        classificacao,
        ...dimensions,
        top_erros: topErros,
        top_acertos: topAcertos,
        relatorio_completo: rawText,
        resumo_whatsapp: resumoWhatsApp,
        sentiment_overall: sentiment.overall,
        sentiment_score: sentiment.score,
        sentiment_timeline: sentiment.timeline,
        engagement_level: sentiment.engagement,
        objections_detected: objections,
        modelo_analise: CLAUDE_MODEL,
        tokens_input: response.usage.input_tokens,
        tokens_output: response.usage.output_tokens,
        custo_estimado: (response.usage.input_tokens * 3 + response.usage.output_tokens * 15) / 1_000_000,
        prompt_version: "1.0",
        analyzed_at: new Date().toISOString(),
      }).eq("id", audit_id)

      // 6. Create notify job
      await supabase.from("job_queue").insert({
        audit_id, job_type: "notify", status: "pending"
      })

      // 7. Mark job complete
      if (job_id) {
        await supabase.from("job_queue").update({
          status: "completed", completed_at: new Date().toISOString()
        }).eq("id", job_id)
      }

      // 8. Run supervisor analysis in-line (non-fatal)
      try {
        await runSupervisorAnalysis(supabase, anthropic, audit_id, audit.transcricao, metadata)
      } catch (e) {
        console.warn("Supervisor analysis failed (non-fatal):", e)
      }

      return new Response(JSON.stringify({
        success: true, audit_id, score, classificacao,
        tokens: { input: response.usage.input_tokens, output: response.usage.output_tokens }
      }))
    }

    // ─── SUPERVISOR_ANALYZE ───
    if (job_type === "supervisor_analyze") {
      if (!anthropic) throw new Error("ANTHROPIC_API_KEY not configured")

      const { data: audit } = await supabase
        .from("call_audits")
        .select("transcricao, lead_name, call_date, duration_minutes, closers(name)")
        .eq("id", audit_id)
        .single()

      if (!audit?.transcricao) throw new Error(`Audit ${audit_id} has no transcription`)

      const closerName = (audit.closers as { name: string } | null)?.name ?? "Desconhecido"
      const metadata = {
        closer_name: closerName,
        lead_name: audit.lead_name ?? "Desconhecido",
        call_date: audit.call_date ?? "N/A",
        duration_minutes: audit.duration_minutes,
      }

      await runSupervisorAnalysis(supabase, anthropic, audit_id, audit.transcricao, metadata)

      if (job_id) {
        await supabase.from("job_queue").update({
          status: "completed", completed_at: new Date().toISOString()
        }).eq("id", job_id)
      }

      return new Response(JSON.stringify({ success: true, audit_id, type: "supervisor_analyze" }))
    }

    // ─── TRANSCRIBE ───
    if (job_type === "transcribe") {
      // Whisper transcription via OpenAI API
      if (!openaiKey) throw new Error("OPENAI_API_KEY not configured")

      const { data: audit } = await supabase
        .from("call_audits")
        .select("audio_path")
        .eq("id", audit_id)
        .single()

      if (!audit?.audio_path) throw new Error(`Audit ${audit_id} has no audio_path`)

      await supabase.from("call_audits").update({ status: "transcribing" }).eq("id", audit_id)

      // Download audio from storage
      const { data: audioBlob } = await supabase.storage
        .from("audios")
        .download(audit.audio_path)

      if (!audioBlob) throw new Error("Failed to download audio")

      // Call Whisper API
      const formData = new FormData()
      formData.append("file", audioBlob, audit.audio_path.split("/").pop() || "audio.ogg")
      formData.append("model", "whisper-1")
      formData.append("response_format", "verbose_json")
      formData.append("language", "pt")

      const whisperResp = await fetch("https://api.openai.com/v1/audio/transcriptions", {
        method: "POST",
        headers: { Authorization: `Bearer ${openaiKey}` },
        body: formData,
      })

      if (!whisperResp.ok) throw new Error(`Whisper API error: ${whisperResp.status}`)

      const whisperData = await whisperResp.json()
      const transcription = whisperData.text || ""
      const durationSeconds = whisperData.duration || 0

      // Save transcription
      await supabase.from("call_audits").update({
        status: "transcribed",
        transcricao: transcription,
        audio_duration_seconds: durationSeconds,
        duration_minutes: Math.round(durationSeconds / 60),
        modelo_transcricao: "whisper-1",
        transcribed_at: new Date().toISOString(),
      }).eq("id", audit_id)

      // Create analyze job
      await supabase.from("job_queue").insert({
        audit_id, job_type: "analyze", status: "pending"
      })

      if (job_id) {
        await supabase.from("job_queue").update({
          status: "completed", completed_at: new Date().toISOString()
        }).eq("id", job_id)
      }

      return new Response(JSON.stringify({
        success: true, audit_id, type: "transcribe",
        duration_seconds: durationSeconds, text_length: transcription.length
      }))
    }

    // ─── NOTIFY (simplified) ───
    if (job_type === "notify") {
      // Mark as completed (full notification via Resend/Evolution requires separate config)
      await supabase.from("call_audits").update({
        status: "completed",
        notified_at: new Date().toISOString(),
        completed_at: new Date().toISOString(),
      }).eq("id", audit_id)

      if (job_id) {
        await supabase.from("job_queue").update({
          status: "completed", completed_at: new Date().toISOString()
        }).eq("id", job_id)
      }

      return new Response(JSON.stringify({ success: true, audit_id, type: "notify" }))
    }

    return new Response(JSON.stringify({ error: `Unknown job_type: ${job_type}` }), { status: 400 })

  } catch (error) {
    console.error("process-job error:", error)
    return new Response(JSON.stringify({ error: String(error) }), { status: 500 })
  }
})

// ─── Supervisor analysis helper ───

async function runSupervisorAnalysis(
  supabase: ReturnType<typeof createClient>,
  anthropic: Anthropic,
  auditId: string,
  transcription: string,
  metadata: { closer_name: string; lead_name: string; call_date: string; duration_minutes?: number }
) {
  const userMessage = `## DADOS DA CALL\n- **Closer:** ${metadata.closer_name}\n- **Lead:** ${metadata.lead_name}\n- **Data:** ${metadata.call_date}\n- **Duração:** ${metadata.duration_minutes ?? "N/A"} minutos\n\n## TRANSCRIÇÃO COMPLETA\n\n${transcription}`

  const response = await anthropic.messages.create({
    model: CLAUDE_MODEL,
    max_tokens: MAX_TOKENS,
    system: SUPERVISOR_SYSTEM_PROMPT,
    messages: [{ role: "user", content: userMessage }],
  })

  const rawText = response.content[0].type === "text" ? response.content[0].text : ""

  // Parse JSON response from supervisor
  let parsed
  try {
    // Extract JSON from response (may have markdown wrapping)
    const jsonMatch = rawText.match(/\{[\s\S]*\}/)
    parsed = jsonMatch ? JSON.parse(jsonMatch[0]) : JSON.parse(rawText)
  } catch {
    console.error("Failed to parse supervisor JSON, storing raw")
    parsed = { overall_score: null, classification: null, stages: [], executive_summary: rawText }
  }

  // Get org_id from audit
  const { data: audit } = await supabase.from("call_audits").select("organization_id").eq("id", auditId).single()

  // Insert supervisor analysis
  const { data: analysis } = await supabase
    .from("supervisor_analyses")
    .insert({
      audit_id: auditId,
      organization_id: audit?.organization_id,
      overall_score: parsed.overall_score,
      overall_label: parsed.overall_label,
      classification: parsed.classification,
      executive_summary: parsed.executive_summary,
      protocol_version: parsed.protocol_version || "v1.0",
      prompt_version: "1.0",
      table_price_presented: typeof parsed.negotiation?.table_price_presented === "boolean" ? parsed.negotiation.table_price_presented : !!parsed.negotiation?.price_table_presented,
      silence_applied: parsed.negotiation?.silence_applied === true,
      who_spoke_first: (() => { const w = String(parsed.negotiation?.who_spoke_first || "unknown").toLowerCase(); return ["closer","lead","unknown"].includes(w) ? w : w.includes("closer") || w.includes("vendedor") ? "closer" : w.includes("lead") || w.includes("client") ? "lead" : "unknown"; })(),
      protagonist_transition_quality: Number(parsed.negotiation?.protagonist_transition_quality) || null,
      cac_explained: parsed.negotiation?.cac_explained === true,
      negotiation_firmness: Number(parsed.negotiation?.negotiation_firmness) || null,
      downsell_used: parsed.negotiation?.downsell_used === true,
      downsell_narrative_quality: parsed.negotiation?.downsell_narrative_quality != null ? Number(parsed.negotiation.downsell_narrative_quality) : null,
      priority_improvements: parsed.priority_improvements || [],
      training_actions: parsed.training_actions || [],
      objections_detected: parsed.objections_detected || [],
      raw_json: parsed,
      tokens_input: response.usage.input_tokens,
      tokens_output: response.usage.output_tokens,
      custo_estimado: (response.usage.input_tokens * 3 + response.usage.output_tokens * 15) / 1_000_000,
      modelo_analise: CLAUDE_MODEL,
    })
    .select("id")
    .single()

  // Insert stage scores
  if (analysis && parsed.stages?.length) {
    const stageRows = parsed.stages.map((s: Record<string, unknown>) => ({
      analysis_id: analysis.id,
      stage_key: s.stage_key || `stage_${s.stage}`,
      stage_name: s.stage_name || s.name || `Etapa ${s.stage}`,
      stage_order: s.stage_order ?? s.stage ?? 0,
      score: s.score ?? 0,
      max_score: s.max_score || 10,
      weight: s.weight ?? (s.weight_pct ? Number(s.weight_pct) / 100 : 0),
      status: s.status || "ok",
      justification: s.justification || s.observations || "",
      evidence_excerpt: s.evidence_excerpt || null,
      missed_actions: s.missed_actions || [],
      suggested_fix: s.suggested_fix || [],
    }))
    await supabase.from("supervisor_stage_scores").insert(stageRows)
  }
}

// ─── System Prompts (embedded) ───
// Note: These are the full prompts from workers/src/prompts/

const SYSTEM_PROMPT = `# SYSTEM PROMPT — ANALISTA DE CALLS DE FECHAMENTO HIGH TICKET
# Versão: 1.0 | Para uso em n8n, API ou qualquer orquestrador de LLM
# Base: Protocolo de Elite 6 Fases + 10 Frameworks + Scorecard 13 Dimensões

---

## IDENTIDADE E MISSÃO

Você é o **Analista de Calls de Fechamento**, um auditor especializado em vendas high ticket. Sua função é receber transcrições de calls de fechamento e produzir uma auditoria completa, cirúrgica e acionável.

Você NÃO é um coach motivacional. Você é um auditor técnico. Sua análise deve ser:
- **Precisa**: baseada em evidência direta da transcrição (citações com timestamp)
- **Quantitativa**: scores numéricos ponderados por dimensão
- **Prescritiva**: não apenas apontar erros, mas reescrever como deveria ter sido feito
- **Calibrada**: distinguir erros estruturais (graves) de erros de calibragem (menores)

Sempre responda em português brasileiro.

Siga EXATAMENTE o formato de output especificado, incluindo: Resumo Executivo, Scorecard (13 dimensões com tabela), Análise Bloco a Bloco, Mapa de Frameworks (10), Top 5 Acertos, Top 5 Erros, Reescrita de Momentos Críticos, Plano de Ação, Alertas de Promessa, e Análise de Sentimento do Lead.

O SCORE FINAL deve seguir: SCORE FINAL: X,X/10 — CLASSIFICAÇÃO (ELITE ≥8.5, FORTE ≥7.0, MEDIANA ≥5.5, FRACA <5.5).

O Scorecard DEVE ter exatamente 13 linhas numeradas de 1 a 13 com colunas: # | Dimensão | Peso | Nota | Ponderada | Evidência.`

const SUPERVISOR_SYSTEM_PROMPT = `# SYSTEM PROMPT — AUDITOR DE QA COMERCIAL SÊNIOR
# Versão: 1.0 | Protocolo System Digital / FACE 100K

## IDENTIDADE E MISSÃO

Você é o **Auditor de QA Comercial Sênior** da System Digital. Sua missão é avaliar se o closer seguiu o **protocolo EXATO** de 16 etapas da empresa, com foco em pactos, SPIN selling, ancoragem de valor, e negociação.

## PROTOCOLO DE 16 ETAPAS

Etapa 1: Quebra-gelo (3%), Etapa 2: Rapport (5%), Etapa 3: Pacto Inicial (5%), Etapa 4: SPIN Situação (5%), Etapa 5: SPIN Problema (5%), Etapa 6: SPIN Implicação (8%), Etapa 7: SPIN Necessidade (7%), Etapa 8: Pacto de Transição (5%), Etapa 9: Apresentação Método (10%), Etapa 10: Apresentação Produto (10%), Etapa 11: Isolamento de Objeções (8%), Etapa 12: Ancoragem (8%), Etapa 13: Preço de Tabela (5%), Etapa 14: Preço Protagonista (5%), Etapa 15: Negociação (7%), Etapa 16: Down Sell (4%).

Scoring: 0-10 por etapa. Status: excellent (≥8), ok (≥6), warning (≥4), critical (<4), skipped (0).
Classificação: EXCELENTE (≥9), BOA (≥7), REGULAR (≥5), FRACA (≥3), CRITICA (<3).

Responda EXCLUSIVAMENTE com JSON válido (sem markdown). Estrutura:
{
  "protocol_version": "v1.0",
  "overall_score": number (0-10, média ponderada),
  "overall_label": "string descritivo",
  "classification": "EXCELENTE"|"BOA"|"REGULAR"|"FRACA"|"CRITICA",
  "executive_summary": "resumo em PT-BR",
  "stages": [{ "stage": number, "name": string, "score": number, "status": string, "weight_pct": number, "observations": string, "timestamp_start": "HH:MM:SS", "timestamp_end": "HH:MM:SS" }],
  "negotiation": {
    "table_price_presented": boolean,
    "silence_applied": boolean,
    "who_spoke_first": "closer"|"lead"|"unknown",
    "protagonist_transition_quality": number (0-10),
    "cac_explained": boolean,
    "negotiation_firmness": number (0-10),
    "downsell_used": boolean,
    "downsell_narrative_quality": number|null (0-10),
    "price_table_presented": "string do valor apresentado ou null",
    "anchor_value_used": "string",
    "discount_given_pct": number|null,
    "result": "string descritivo do resultado"
  },
  "objections_detected": [{ "id": number, "type": string, "verbatim": "fala exata do lead", "handled": boolean, "handling_quality": string, "notes": string, "timestamp": "HH:MM:SS" }],
  "priority_improvements": [{ "priority": number, "stage": string, "issue": string, "recommended_action": string }],
  "training_actions": [{ "type": string, "focus": string, "description": string, "responsible": string, "deadline_days": number }]
}

Todas as 16 etapas DEVEM aparecer no array "stages". Booleanos lowercase. Números sem aspas. who_spoke_first DEVE ser "closer", "lead" ou "unknown".`
