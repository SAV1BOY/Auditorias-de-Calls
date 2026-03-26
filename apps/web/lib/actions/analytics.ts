"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"
import { requireRole } from "@/lib/auth/require-role"
import { createGoalSchema, updateGoalStatusSchema } from "@/lib/validations/schemas"
import { DIMENSIONS, RADAR_LABELS, DIM_INDEX_MAP } from "@/lib/utils/constants"
import type {
  CloserComparison,
  DimensionTrendPoint,
  GoalRow,
  GoalWithProgress,
  GoalMetric,
  GoalType,
  GoalStatus,
} from "@/lib/types/audit"

// ─── Closers Comparison ───

export async function getClosersComparison(
  closerIds: string[],
  dateFrom?: string,
  dateTo?: string
): Promise<CloserComparison[]> {
  if (closerIds.length === 0) return []

  const supabase = await createClient()

  if (!dateFrom && !dateTo) {
    const { data } = await supabase
      .from("v_closer_performance")
      .select("*")
      .in("closer_id", closerIds)

    return (data ?? []).map((row) => ({
      closer_id: row.closer_id ?? "",
      closer_name: row.closer_name ?? "",
      media_score: row.media_score != null ? Number(row.media_score) : null,
      total_calls: Number(row.total_calls ?? 0),
      dimensions: DIMENSIONS.map((dim) => ({
        name: dim.name,
        shortName: RADAR_LABELS[dim.id] ?? dim.name,
        score: Number((row as Record<string, unknown>)[DIM_INDEX_MAP[dim.id]] ?? 0),
      })),
    }))
  }

  // Date-filtered: batch fetch all audits + closers in 2 queries instead of 2N
  let query = supabase
    .from("call_audits")
    .select("closer_id, score_final, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento")
    .in("closer_id", closerIds)
    .not("score_final", "is", null)

  if (dateFrom) query = query.gte("call_date", dateFrom)
  if (dateTo) query = query.lte("call_date", dateTo)

  const [{ data: allCalls }, { data: closerRows }] = await Promise.all([
    query,
    supabase.from("closers").select("id, name").in("id", closerIds),
  ])

  const closerNameMap = new Map(
    (closerRows ?? []).map((c) => [c.id, c.name as string])
  )

  // Group by closer_id
  type AuditRow = Record<string, unknown>
  const callsByCloser = new Map<string, AuditRow[]>()
  for (const call of (allCalls ?? []) as AuditRow[]) {
    const cid = call.closer_id as string
    if (!callsByCloser.has(cid)) callsByCloser.set(cid, [])
    callsByCloser.get(cid)!.push(call)
  }

  const results: CloserComparison[] = []

  for (const closerId of closerIds) {
    const calls = callsByCloser.get(closerId)
    if (!calls || calls.length === 0) continue

    const dimensions = DIMENSIONS.map((dim) => {
      const scores = calls
        .map((c) => Number(c[dim.id] ?? 0))
        .filter((s) => s > 0)
      const avg =
        scores.length > 0
          ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
          : 0
      return { name: dim.name, shortName: RADAR_LABELS[dim.id] ?? dim.name, score: avg }
    })

    const scores = calls.map((c) => Number(c.score_final))
    const mediaScore =
      scores.length > 0
        ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
        : null

    results.push({
      closer_id: closerId,
      closer_name: closerNameMap.get(closerId) ?? "Desconhecido",
      media_score: mediaScore,
      total_calls: calls.length,
      dimensions,
    })
  }

  return results
}

// ─── Dimension Trends ───

export async function getDimensionTrends(
  dimensionId: string,
  closerId?: string,
  days: number = 90
): Promise<DimensionTrendPoint[]> {
  const supabase = await createClient()
  const fromDate = new Date()
  fromDate.setDate(fromDate.getDate() - days)
  const fromStr = fromDate.toISOString().split("T")[0]

  // Fetch all team data in one query, then filter for closer in JS (avoids 2nd query)
  const { data: teamData } = await supabase
    .from("call_audits")
    .select("call_date, closer_id, score_final, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento")
    .gte("call_date", fromStr)
    .not("score_final", "is", null)
    .order("call_date", { ascending: true })

  // Filter from teamData to avoid extra query
  type AuditRow = Record<string, unknown>
  let closerData: AuditRow[] | null = teamData as AuditRow[] | null
  if (closerId && teamData) {
    closerData = (teamData as AuditRow[]).filter((row) => row.closer_id === closerId)
  }

  const closerGrouped = groupByDateDimAvg(closerData, dimensionId)
  const teamGrouped = groupByDateDimAvg(teamData, dimensionId)

  const teamMap = new Map(teamGrouped.map((t) => [t.date, t.score]))
  return closerGrouped.map((point) => ({
    date: point.date,
    score: point.score,
    teamAvg: teamMap.get(point.date),
  }))
}

function groupByDateDimAvg(
  rows: Array<Record<string, unknown>> | null,
  dimensionId: string
): Array<{ date: string; score: number }> {
  if (!rows || rows.length === 0) return []

  const groups = new Map<string, number[]>()
  for (const row of rows) {
    const date = String(row.call_date)
    const score = Number(row[dimensionId] ?? 0)
    if (score === 0) continue
    const existing = groups.get(date) ?? []
    existing.push(score)
    groups.set(date, existing)
  }

  return Array.from(groups.entries())
    .map(([date, scores]) => ({
      date,
      score:
        Math.round(
          (scores.reduce((a, b) => a + b, 0) / scores.length) * 10
        ) / 10,
    }))
    .sort((a, b) => a.date.localeCompare(b.date))
}

// ─── Goals CRUD ───

export async function getGoals(): Promise<GoalWithProgress[]> {
  const supabase = await createClient()

  const { data: goals } = await supabase
    .from("goals")
    .select("*")
    .order("status")
    .order("end_date", { ascending: true })

  if (!goals || goals.length === 0) return []

  // Get closer names for goals that have closer_id
  const closerIds = Array.from(new Set(goals.filter((g) => g.closer_id).map((g) => g.closer_id!)))
  const closerNames = new Map<string, string>()

  if (closerIds.length > 0) {
    const { data: closers } = await supabase
      .from("closers")
      .select("id, name")
      .in("id", closerIds)

    for (const c of closers ?? []) {
      closerNames.set(c.id, c.name)
    }
  }

  // Batch fetch all calls needed for goal calculations (avoid N+1)
  // Find the widest date range across all goals
  const minDate = goals.reduce((min, g) => (g.start_date < min ? g.start_date : min), goals[0].start_date)
  const maxDate = goals.reduce((max, g) => (g.end_date > max ? g.end_date : max), goals[0].end_date)

  const { data: allCalls } = await supabase
    .from("call_audits")
    .select("closer_id, call_date, score_final, classificacao, resultado, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento")
    .gte("call_date", minDate)
    .lte("call_date", maxDate)
    .not("score_final", "is", null) as { data: Array<Record<string, unknown>> | null }

  const results: GoalWithProgress[] = []

  for (const goal of goals) {
    const goalRow: GoalRow = {
      id: goal.id,
      organization_id: goal.organization_id,
      title: goal.title,
      type: goal.type as GoalType,
      metric: goal.metric as GoalMetric,
      target_value: Number(goal.target_value),
      dimension_id: goal.dimension_id,
      closer_id: goal.closer_id,
      start_date: goal.start_date,
      end_date: goal.end_date,
      status: goal.status as GoalStatus,
      created_at: goal.created_at ?? "",
      updated_at: goal.updated_at ?? "",
    }
    const currentValue = calculateCurrentValueFromCache(goalRow, allCalls ?? [])
    const progress =
      goal.target_value > 0
        ? Math.min(100, Math.round((currentValue / Number(goal.target_value)) * 100))
        : 100

    results.push({
      ...goalRow,
      current_value: currentValue,
      progress,
      closer_name: goal.closer_id ? closerNames.get(goal.closer_id) : undefined,
    })
  }

  return results
}

function calculateCurrentValueFromCache(
  goal: GoalRow,
  allCalls: Array<Record<string, unknown>>
): number {
  // Filter calls for this specific goal's date range and closer
  const calls = allCalls.filter((c) => {
    const date = String(c.call_date)
    if (date < goal.start_date || date > goal.end_date) return false
    if (goal.closer_id && c.closer_id !== goal.closer_id) return false
    return true
  })

  if (calls.length === 0) return 0

  switch (goal.metric) {
    case "score_avg": {
      const scores = calls.map((c) => Number(c.score_final))
      return Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
    }
    case "score_min": {
      const scores = calls.map((c) => Number(c.score_final))
      return Math.min(...scores)
    }
    case "classificacao_count": {
      const fracas = calls.filter((c) => c.classificacao === "FRACA").length
      return calls.length - fracas
    }
    case "taxa_fechamento": {
      const fechamentos = calls.filter((c) => c.resultado === "fechamento").length
      return Math.round((fechamentos / calls.length) * 100)
    }
    case "dimension_avg": {
      if (!goal.dimension_id) return 0
      const dimId = goal.dimension_id
      const scores = calls
        .map((c) => Number(c[dimId] ?? 0))
        .filter((s) => s > 0)
      if (scores.length === 0) return 0
      return Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
    }
    default:
      return 0
  }
}

export async function createGoal(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin", "supervisor"])

  const closerIdRaw = formData.get("closer_id")?.toString()
  const dimensionIdRaw = formData.get("dimension_id")?.toString()

  const parsed = createGoalSchema.safeParse({
    title: formData.get("title")?.toString().trim(),
    type: formData.get("type")?.toString(),
    metric: formData.get("metric")?.toString(),
    target_value: Number(formData.get("target_value")),
    start_date: formData.get("start_date")?.toString(),
    end_date: formData.get("end_date")?.toString(),
    closer_id: closerIdRaw && closerIdRaw !== "none" ? closerIdRaw : null,
    dimension_id: dimensionIdRaw && dimensionIdRaw !== "none" ? dimensionIdRaw : null,
  })

  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "Dados inválidos." }
  }

  const supabase = await createClient()
  const { error } = await supabase.from("goals").insert({
    title: parsed.data.title,
    type: parsed.data.type,
    metric: parsed.data.metric,
    target_value: parsed.data.target_value,
    start_date: parsed.data.start_date,
    end_date: parsed.data.end_date,
    closer_id: parsed.data.closer_id ?? null,
    dimension_id: parsed.data.dimension_id ?? null,
    organization_id: organizationId,
  })

  if (error) return { error: "Erro ao criar meta." }

  revalidatePath("/analytics")
  return { success: true }
}

export async function updateGoalStatus(
  goalId: string,
  status: "active" | "completed" | "failed"
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin", "supervisor"])

  const parsed = updateGoalStatusSchema.safeParse({ goalId, status })
  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "Dados inválidos." }
  }

  const supabase = await createClient()
  const { error } = await supabase
    .from("goals")
    .update({ status: parsed.data.status })
    .eq("id", parsed.data.goalId)

  if (error) return { error: "Erro ao atualizar meta." }

  revalidatePath("/analytics")
  return { success: true }
}

export async function deleteGoal(
  goalId: string
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin", "supervisor"])

  const supabase = await createClient()
  const { error } = await supabase.from("goals").delete().eq("id", goalId)

  if (error) return { error: "Erro ao excluir meta." }

  revalidatePath("/analytics")
  return { success: true }
}
