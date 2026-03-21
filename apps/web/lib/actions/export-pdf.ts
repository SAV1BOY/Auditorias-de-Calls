"use server"

import { createClient } from "@/lib/supabase/server"
import type { CallAuditWithCloser } from "@/lib/types/audit"

export async function generateAuditPDF(
  auditId: string
): Promise<{ url?: string; error?: string }> {
  try {
    const supabase = await createClient()

    // Fetch audit data
    const { data: audit, error } = await supabase
      .from("call_audits")
      .select("*, closers(name)")
      .eq("id", auditId)
      .single()

    if (error || !audit) {
      return { error: "Auditoria não encontrada" }
    }

    // Dynamic import to avoid SSR issues with @react-pdf/renderer
    const { renderToBuffer } = await import("@react-pdf/renderer")
    const { AuditReportDocument } = await import("@/lib/pdf/audit-report")
    const React = await import("react")

    const element = React.createElement(AuditReportDocument, {
      audit: audit as CallAuditWithCloser,
    })
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const buffer = await renderToBuffer(element as any)

    // Upload to Supabase Storage
    const fileName = `relatorio-${audit.lead_name}-${audit.call_date}-${Date.now()}.pdf`
    const filePath = `reports/${fileName}`

    const { error: uploadError } = await supabase.storage
      .from("audios")
      .upload(filePath, buffer, {
        contentType: "application/pdf",
        upsert: true,
      })

    if (uploadError) {
      return { error: `Erro no upload: ${uploadError.message}` }
    }

    // Get signed URL (valid for 1 hour)
    const { data: urlData } = await supabase.storage
      .from("audios")
      .createSignedUrl(filePath, 3600)

    return { url: urlData?.signedUrl ?? undefined }
  } catch (err) {
    console.error("PDF generation error:", err)
    return { error: "Erro ao gerar PDF" }
  }
}

export async function generateBatchPDF(
  auditIds: string[]
): Promise<{ url?: string; error?: string }> {
  if (auditIds.length === 0) {
    return { error: "Nenhuma auditoria selecionada" }
  }

  if (auditIds.length === 1) {
    return generateAuditPDF(auditIds[0])
  }

  try {
    const supabase = await createClient()

    // Fetch all audits
    const { data: audits, error } = await supabase
      .from("call_audits")
      .select("*, closers(name)")
      .in("id", auditIds)

    if (error || !audits || audits.length === 0) {
      return { error: "Auditorias não encontradas" }
    }

    // Dynamic imports
    const { renderToBuffer } = await import("@react-pdf/renderer")
    const { AuditReportDocument } = await import("@/lib/pdf/audit-report")
    const React = await import("react")

    // For batch, generate the first one (could be extended with PDF merge later)
    const firstAudit = audits[0] as CallAuditWithCloser
    const element = React.createElement(AuditReportDocument, { audit: firstAudit })
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const buffer = await renderToBuffer(element as any)

    const fileName = `relatorios-batch-${Date.now()}.pdf`
    const filePath = `reports/${fileName}`

    const { error: uploadError } = await supabase.storage
      .from("audios")
      .upload(filePath, buffer, {
        contentType: "application/pdf",
        upsert: true,
      })

    if (uploadError) {
      return { error: `Erro no upload: ${uploadError.message}` }
    }

    const { data: urlData } = await supabase.storage
      .from("audios")
      .createSignedUrl(filePath, 3600)

    return { url: urlData?.signedUrl ?? undefined }
  } catch (err) {
    console.error("Batch PDF generation error:", err)
    return { error: "Erro ao gerar PDFs" }
  }
}
