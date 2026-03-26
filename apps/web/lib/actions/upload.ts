"use server"

import { createClient } from "@/lib/supabase/server"
import { AUDIO_FORMATS, MAX_FILE_SIZE_BYTES } from "@/lib/utils/constants"
import { uploadMetadataSchema } from "@/lib/validations/schemas"
import type { Database } from "@/lib/types/database"
import { requireRole } from "@/lib/auth/require-role"
import { rateLimit, RATE_LIMITS } from "@/lib/security/rate-limit"

type CallAuditInsert = Database["public"]["Tables"]["call_audits"]["Insert"]
type JobQueueInsert = Database["public"]["Tables"]["job_queue"]["Insert"]

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

    // Create transcribe job
    const { error: jobError } = await supabase.from("job_queue").insert({
      audit_id: auditId,
      job_type: "transcribe",
      status: "pending",
    } satisfies JobQueueInsert)

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
