"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"
import { requireRole } from "@/lib/auth/require-role"
import type { LossPatternReport } from "@/lib/types/audit"

/* eslint-disable @typescript-eslint/no-explicit-any */
function db(supabase: any): { from: (table: string) => any } {
  return supabase
}
/* eslint-enable @typescript-eslint/no-explicit-any */

export async function getLossPatterns(
  dateFrom?: string,
  dateTo?: string
): Promise<LossPatternReport[]> {
  const supabase = await createClient()

  let query = db(supabase)
    .from("loss_patterns")
    .select("*")
    .gt("total_lost_calls", 0)
    .order("generated_at", { ascending: false })

  if (dateFrom) {
    query = query.gte("period_start", dateFrom)
  }
  if (dateTo) {
    query = query.lte("period_end", dateTo)
  }

  const { data, error } = await query

  if (error) {
    console.error("Error fetching loss patterns:", error)
    return []
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return (data ?? []).map((row: any) => ({
    id: row.id,
    generated_at: row.generated_at,
    period_start: row.period_start,
    period_end: row.period_end,
    total_lost_calls: row.total_lost_calls,
    patterns: (row.patterns ?? []) as LossPatternReport["patterns"],
    common_objections: (row.common_objections ?? []) as LossPatternReport["common_objections"],
    weakest_phases: (row.weakest_phases ?? []) as LossPatternReport["weakest_phases"],
    report_markdown: row.report_markdown,
  }))
}

export async function generateLossPatternAnalysis(
  dateFrom: string,
  dateTo: string
): Promise<{ success?: boolean; error?: string; reportId?: string }> {
  const { organizationId } = await requireRole(["admin", "supervisor"])

  if (!dateFrom || !dateTo) {
    return { error: "Datas de inicio e fim sao obrigatorias." }
  }

  if (dateFrom > dateTo) {
    return { error: "Data de inicio deve ser anterior a data de fim." }
  }

  const supabase = await createClient()

  // Create a placeholder row in loss_patterns (total_lost_calls=0 signals pending)
  const { data: report, error: insertError } = await db(supabase)
    .from("loss_patterns")
    .insert({
      period_start: dateFrom,
      period_end: dateTo,
      total_lost_calls: 0,
      patterns: [],
      common_objections: [],
      weakest_phases: [],
      organization_id: organizationId,
    })
    .select("id")
    .single()

  if (insertError || !report) {
    console.error("Error creating loss pattern report:", insertError)
    return { error: "Erro ao criar relatorio." }
  }

  // Insert a job into job_queue to trigger the worker
  const jobData = { audit_id: null, job_type: "loss_pattern", status: "pending" }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { error: jobError } = await db(supabase).from("job_queue").insert(jobData as any)

  if (jobError) {
    console.error("Error creating loss pattern job:", jobError)
    return { error: "Erro ao enfileirar analise." }
  }

  revalidatePath("/analytics")
  return { success: true, reportId: report.id }
}

export async function getLossPatternDetail(
  id: string
): Promise<LossPatternReport | null> {
  const supabase = await createClient()

  const { data, error } = await db(supabase)
    .from("loss_patterns")
    .select("*")
    .eq("id", id)
    .single()

  if (error || !data) {
    return null
  }

  return {
    id: data.id,
    generated_at: data.generated_at,
    period_start: data.period_start,
    period_end: data.period_end,
    total_lost_calls: data.total_lost_calls,
    patterns: (data.patterns ?? []) as LossPatternReport["patterns"],
    common_objections: (data.common_objections ?? []) as LossPatternReport["common_objections"],
    weakest_phases: (data.weakest_phases ?? []) as LossPatternReport["weakest_phases"],
    report_markdown: data.report_markdown,
  }
}
