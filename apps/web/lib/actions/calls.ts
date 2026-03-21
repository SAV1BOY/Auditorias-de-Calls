"use server"

import { createClient } from "@/lib/supabase/server"
import { requireRole } from "@/lib/auth/require-role"
import type { Database } from "@/lib/types/database"
import type {
  AuditFilters,
  CallAuditWithCloser,
  CloserRow,
  DashboardStats,
  PaginatedResult,
} from "@/lib/types/audit"

type JobQueueInsert = Database["public"]["Tables"]["job_queue"]["Insert"]

function groupByDateAvg(
  rows: Array<{ call_date: string; score_final: number | null }> | null
): Array<{ date: string; score: number }> {
  if (!rows || rows.length === 0) return []

  const groups = new Map<string, number[]>()
  for (const row of rows) {
    if (row.score_final === null) continue
    const existing = groups.get(row.call_date) ?? []
    existing.push(row.score_final)
    groups.set(row.call_date, existing)
  }

  return Array.from(groups.entries())
    .map(([date, scores]) => ({
      date,
      score: Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10,
    }))
    .sort((a, b) => a.date.localeCompare(b.date))
}

export async function getDashboardStats(): Promise<DashboardStats> {
  const supabase = await createClient()

  // 1. Stats from pre-aggregated view
  const { data: viewStats } = await supabase
    .from("v_dashboard_stats")
    .select("*")
    .limit(1)
    .maybeSingle()

  // 2. Calls this week
  const weekAgo = new Date()
  weekAgo.setDate(weekAgo.getDate() - 7)
  const { count: callsEstaSemana } = await supabase
    .from("call_audits")
    .select("*", { count: "exact", head: true })
    .gte("call_date", weekAgo.toISOString().split("T")[0])

  // 3. Score evolution (last 30 days)
  const thirtyDaysAgo = new Date()
  thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30)
  const { data: scoreData } = await supabase
    .from("call_audits")
    .select("call_date, score_final")
    .not("score_final", "is", null)
    .gte("call_date", thirtyDaysAgo.toISOString().split("T")[0])
    .order("call_date", { ascending: true })

  const evolucaoScore = groupByDateAvg(scoreData)

  return {
    totalCalls: viewStats?.total_calls ?? 0,
    mediaScore: viewStats?.media_score ?? null,
    taxaFechamento: viewStats?.taxa_fechamento_pct ?? null,
    callsEstaSemana: callsEstaSemana ?? 0,
    porClassificacao: {
      elite: viewStats?.calls_elite ?? 0,
      forte: viewStats?.calls_forte ?? 0,
      mediana: viewStats?.calls_mediana ?? 0,
      fraca: viewStats?.calls_fraca ?? 0,
    },
    evolucaoScore,
  }
}

export async function getRecentCalls(): Promise<CallAuditWithCloser[]> {
  const supabase = await createClient()

  const { data } = await supabase
    .from("call_audits")
    .select("*, closers(name)")
    .order("call_date", { ascending: false })
    .limit(10)

  return (data as unknown as CallAuditWithCloser[]) ?? []
}

const ALLOWED_SORT_COLUMNS = new Set([
  "call_date",
  "score_final",
  "lead_name",
  "status",
  "classificacao",
  "duration_minutes",
  "created_at",
])

export async function getAudits(
  filters: AuditFilters = {}
): Promise<PaginatedResult<CallAuditWithCloser>> {
  const supabase = await createClient()
  const {
    closerId,
    dateFrom,
    dateTo,
    classificacao,
    resultado,
    status,
    sortBy = "call_date",
    sortOrder = "desc",
    page = 1,
    pageSize = 20,
  } = filters

  let query = supabase
    .from("call_audits")
    .select("*, closers(name)", { count: "exact" })

  if (closerId) query = query.eq("closer_id", closerId)
  if (dateFrom) query = query.gte("call_date", dateFrom)
  if (dateTo) query = query.lte("call_date", dateTo)
  if (classificacao) query = query.eq("classificacao", classificacao)
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  if (resultado) query = query.eq("resultado", resultado as any)
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  if (status) query = query.eq("status", status as any)

  const safeSortBy = ALLOWED_SORT_COLUMNS.has(sortBy) ? sortBy : "call_date"
  query = query.order(safeSortBy, { ascending: sortOrder === "asc" })

  const from = (page - 1) * pageSize
  query = query.range(from, from + pageSize - 1)

  const { data, count } = await query

  return {
    data: (data as unknown as CallAuditWithCloser[]) ?? [],
    total: count ?? 0,
    page,
    pageSize,
    totalPages: Math.ceil((count ?? 0) / pageSize),
  }
}

export async function getClosers(): Promise<Pick<CloserRow, "id" | "name">[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("closers")
    .select("id, name")
    .order("name")
  return data ?? []
}

export async function getAuditDetail(
  id: string
): Promise<CallAuditWithCloser | null> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("call_audits")
    .select("*, closers(name)")
    .eq("id", id)
    .single()
  return (data as unknown as CallAuditWithCloser) ?? null
}

export async function resendNotification(
  auditId: string
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin", "supervisor"])

  const supabase = await createClient()

  const { data: audit, error: fetchError } = await supabase
    .from("call_audits")
    .select("id, status")
    .eq("id", auditId)
    .single()

  if (fetchError || !audit) {
    return { error: "Auditoria não encontrada." }
  }

  if (audit.status !== "completed" && audit.status !== "analyzed") {
    return { error: "Auditoria precisa estar completa para reenviar." }
  }

  const { error: jobError } = await supabase.from("job_queue").insert({
    audit_id: auditId,
    job_type: "notify",
    status: "pending",
  } satisfies JobQueueInsert)

  if (jobError) {
    return { error: "Erro ao criar job de notificação." }
  }

  return { success: true }
}
