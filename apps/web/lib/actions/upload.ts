"use server"

import { createClient } from "@/lib/supabase/server"
import { AUDIO_FORMATS, MAX_FILE_SIZE_BYTES } from "@/lib/utils/constants"
import type { Database } from "@/lib/types/database"

type CallAuditInsert = Database["public"]["Tables"]["call_audits"]["Insert"]
type JobQueueInsert = Database["public"]["Tables"]["job_queue"]["Insert"]

export type UploadResult = {
  auditId?: string
  error?: string
}

export async function uploadCall(formData: FormData): Promise<UploadResult> {
  const file = formData.get("file") as File | null
  const closerId = formData.get("closerId") as string | null
  const leadName = formData.get("leadName") as string | null
  const callDate = formData.get("callDate") as string | null
  const resultado = formData.get("resultado") as string | null
  const valorFechamento = formData.get("valorFechamento") as string | null

  // Validation
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

  if (!closerId) {
    return { error: "Selecione um closer." }
  }

  if (!leadName?.trim()) {
    return { error: "Nome do lead é obrigatório." }
  }

  if (!callDate) {
    return { error: "Data da call é obrigatória." }
  }

  const validResultados = ["fechamento", "nao_fechou", "reagendar", "outro"]
  if (resultado && !validResultados.includes(resultado)) {
    return { error: "Resultado inválido." }
  }

  try {
    const supabase = await createClient()

    // Generate audit ID first to use as storage path
    const { data: auditData, error: auditError } = await supabase
      .from("call_audits")
      .insert({
        closer_id: closerId,
        lead_name: leadName.trim(),
        call_date: callDate,
        resultado: (resultado as CallAuditInsert["resultado"]) || null,
        valor_fechamento: valorFechamento
          ? (Number.isFinite(parseFloat(valorFechamento)) ? parseFloat(valorFechamento) : null)
          : null,
        status: "uploaded" as const,
      } satisfies CallAuditInsert)
      .select("id")
      .single()

    if (auditError || !auditData) {
      console.error("Failed to create audit:", auditError)
      return { error: "Erro ao criar a auditoria. Tente novamente." }
    }

    const auditId = auditData.id

    // Upload to Supabase Storage
    const storagePath = `${auditId}/${file.name}`
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
