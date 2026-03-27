"use server"

import { createClient } from "@/lib/supabase/server"
import { AUDIO_FORMATS, MAX_FILE_SIZE_BYTES, TRANSCRIPTION_FORMATS, MAX_TRANSCRIPTION_FILE_SIZE_MB } from "@/lib/utils/constants"
import { uploadMetadataSchema } from "@/lib/validations/schemas"
import type { Database } from "@/lib/types/database"
import { requireRole } from "@/lib/auth/require-role"
import { rateLimit, RATE_LIMITS } from "@/lib/security/rate-limit"

type CallAuditInsert = Database["public"]["Tables"]["call_audits"]["Insert"]

export type UploadResult = {
  auditId?: string
  error?: string
}

export async function uploadCall(formData: FormData): Promise<UploadResult> {
  let organizationId: string | null = null
  let userId: string | null = null
  try {
    const ctx = await requireRole(["admin", "supervisor", "closer"])
    organizationId = ctx.organizationId
    userId = ctx.userId
  } catch {
    return { error: "Sem permissão para fazer upload de calls." }
  }

  // Rate limit: 10 uploads per hour per user
  if (userId) {
    const rl = rateLimit(`upload:${userId}`, RATE_LIMITS.upload)
    if (!rl.success) {
      return { error: "Muitos uploads em pouco tempo. Aguarde e tente novamente." }
    }
  }
  const file = formData.get("file") as File | null
  const valorFechamentoRaw = formData.get("valorFechamento") as string | null

  // File validation
  if (!file || file.size === 0) {
    return { error: "Selecione um arquivo de áudio." }
  }

  if (file.size > MAX_FILE_SIZE_BYTES) {
    return { error: `Arquivo muito grande. Máximo: 500 MB.` }
  }

  const ext = "." + file.name.split(".").pop()?.toLowerCase()
  if (!ext || !AUDIO_FORMATS.includes(ext as (typeof AUDIO_FORMATS)[number])) {
    return { error: `Formato não suportado. Use: ${AUDIO_FORMATS.join(", ")}` }
  }

  // Metadata validation via Zod
  const resultadoRaw = formData.get("resultado") as string | null
  const parsed = uploadMetadataSchema.safeParse({
    closerId: formData.get("closerId"),
    leadName: formData.get("leadName"),
    callDate: formData.get("callDate"),
    resultado: resultadoRaw || null,
    valorFechamento: valorFechamentoRaw && Number.isFinite(parseFloat(valorFechamentoRaw))
      ? parseFloat(valorFechamentoRaw)
      : null,
  })

  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "Dados inválidos." }
  }

  const { closerId, leadName, callDate, resultado } = parsed.data

  try {
    const supabase = await createClient()

    // Generate audit ID first to use as storage path
    const { data: auditData, error: auditError } = await supabase
      .from("call_audits")
      .insert({
        closer_id: closerId,
        lead_name: leadName,
        call_date: callDate,
        resultado: (resultado as CallAuditInsert["resultado"]) ?? null,
        valor_fechamento: parsed.data.valorFechamento ?? null,
        status: "uploaded" as const,
        organization_id: organizationId,
      } satisfies CallAuditInsert)
      .select("id")
      .single()

    if (auditError || !auditData) {
      console.error("Failed to create audit:", auditError)
      return { error: "Erro ao criar a auditoria. Tente novamente." }
    }

    const auditId = auditData.id

    // Upload to Supabase Storage
    const storagePath = `${organizationId}/${auditId}/${file.name}`
    const arrayBuffer = await file.arrayBuffer()

    const { error: storageError } = await supabase.storage
      .from("audios")
      .upload(storagePath, arrayBuffer, {
        contentType: file.type || "audio/ogg",
        upsert: false,
      })

    if (storageError) {
      console.error("Storage upload failed:", storageError)
      // Clean up the audit record
      await supabase.from("call_audits").delete().eq("id", auditId)
      return { error: "Erro no upload do áudio. Tente novamente." }
    }

    // Update audit with audio path
    await supabase
      .from("call_audits")
      .update({ audio_path: storagePath })
      .eq("id", auditId)

    // Create transcribe job via RPC (respects RLS)
    const { error: jobError } = await supabase.rpc("enqueue_job", {
      p_audit_id: auditId,
      p_job_type: "transcribe",
    })

    if (jobError) {
      console.error("Failed to create job:", jobError)
      // Non-fatal: audit exists, worker can pick it up manually
    }

    return { auditId }
  } catch (err) {
    console.error("Upload error:", err)
    return { error: "Erro inesperado no upload. Tente novamente." }
  }
}

/**
 * Upload a pre-made transcription file (MD, TXT, PDF, DOCX).
 * Skips Whisper transcription and goes straight to analysis.
 */
export async function uploadTranscription(formData: FormData): Promise<UploadResult> {
  let organizationId: string | null = null
  let userId: string | null = null
  try {
    const ctx = await requireRole(["admin", "supervisor", "closer"])
    organizationId = ctx.organizationId
    userId = ctx.userId
  } catch {
    return { error: "Sem permissão para fazer upload." }
  }

  if (userId) {
    const rl = rateLimit(`upload:${userId}`, RATE_LIMITS.upload)
    if (!rl.success) {
      return { error: "Muitos uploads em pouco tempo. Aguarde." }
    }
  }

  const file = formData.get("file") as File | null
  if (!file || file.size === 0) {
    return { error: "Selecione um arquivo de transcrição." }
  }

  const maxBytes = MAX_TRANSCRIPTION_FILE_SIZE_MB * 1024 * 1024
  if (file.size > maxBytes) {
    return { error: `Arquivo muito grande. Máximo: ${MAX_TRANSCRIPTION_FILE_SIZE_MB} MB.` }
  }

  const ext = "." + file.name.split(".").pop()?.toLowerCase()
  if (!ext || !TRANSCRIPTION_FORMATS.includes(ext as (typeof TRANSCRIPTION_FORMATS)[number])) {
    return { error: `Formato não suportado. Use: ${TRANSCRIPTION_FORMATS.join(", ")}` }
  }

  // Extract text from file
  let transcriptionText: string
  try {
    if (ext === ".md" || ext === ".txt") {
      transcriptionText = await file.text()
    } else if (ext === ".pdf") {
      // PDF: extract raw text from arraybuffer
      const buffer = await file.arrayBuffer()
      const bytes = new Uint8Array(buffer)
      // Simple PDF text extraction: decode as UTF-8 and strip binary
      const raw = new TextDecoder("utf-8", { fatal: false }).decode(bytes)
      // Extract text between stream/endstream or just use raw decoded
      transcriptionText = raw
        .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, " ")
        .replace(/\s{3,}/g, "\n")
        .trim()
      if (transcriptionText.length < 100) {
        return { error: "Não foi possível extrair texto do PDF. Use um arquivo .txt ou .md." }
      }
    } else if (ext === ".docx") {
      // DOCX: extract raw text (simplified — reads XML content)
      const buffer = await file.arrayBuffer()
      const raw = new TextDecoder("utf-8", { fatal: false }).decode(new Uint8Array(buffer))
      // DOCX is a ZIP with XML inside — extract text between <w:t> tags
      const textParts = raw.match(/<w:t[^>]*>([^<]*)<\/w:t>/g) || []
      transcriptionText = textParts.map(t => t.replace(/<[^>]+>/g, "")).join(" ").trim()
      if (transcriptionText.length < 100) {
        return { error: "Não foi possível extrair texto do DOCX. Use um arquivo .txt ou .md." }
      }
    } else {
      return { error: "Formato não suportado." }
    }
  } catch {
    return { error: "Erro ao ler o arquivo. Verifique o formato." }
  }

  if (transcriptionText.trim().length < 50) {
    return { error: "Transcrição muito curta. Mínimo: 50 caracteres." }
  }

  // Metadata validation
  const parsed = uploadMetadataSchema.safeParse({
    closerId: formData.get("closerId"),
    leadName: formData.get("leadName"),
    callDate: formData.get("callDate"),
    resultado: formData.get("resultado") || null,
    valorFechamento: null,
  })

  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "Dados inválidos." }
  }

  const { closerId, leadName, callDate, resultado } = parsed.data

  try {
    const supabase = await createClient()

    // Create audit with transcription already filled — status "transcribed" (skip Whisper)
    const { data: auditData, error: auditError } = await supabase
      .from("call_audits")
      .insert({
        closer_id: closerId,
        lead_name: leadName,
        call_date: callDate,
        resultado: (resultado as CallAuditInsert["resultado"]) ?? null,
        status: "transcribed" as const,
        transcricao: transcriptionText,
        organization_id: organizationId,
      } satisfies CallAuditInsert)
      .select("id")
      .single()

    if (auditError || !auditData) {
      console.error("Failed to create audit:", auditError)
      return { error: "Erro ao criar a auditoria." }
    }

    // Enqueue "analyze" job directly (skip transcribe)
    const { error: jobError } = await supabase.rpc("enqueue_job", {
      p_audit_id: auditData.id,
      p_job_type: "analyze",
    })

    if (jobError) {
      console.error("Failed to enqueue analyze job:", jobError)
    }

    return { auditId: auditData.id }
  } catch (err) {
    console.error("Transcription upload error:", err)
    return { error: "Erro inesperado no upload." }
  }
}
