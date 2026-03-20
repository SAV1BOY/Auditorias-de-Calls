"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"
import { DIMENSIONS, RADAR_LABELS, DIM_INDEX_MAP } from "@/lib/utils/constants"
import type {
  CloserComparison,
  DimensionTrendPoint,
  GoalRow,
  GoalWithProgress,
  GoalMetric,
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
      closer_id: row.closer_id,
      closer_name: row.closer_name,
      media_score: row.media_score != null ? Number(row.media_score) : null,
      total_calls: Number(row.total_calls ?? 0),
      dimensions: DIMENSIONS.map((dim) => ({
        name: dim.name,
        shortName: RADAR_LABELS[dim.id] ?? dim.name,
        score: Number((row as Record<string, unknown>)[DIM_INDEX_MAP[dim.id]] ?? 0),
      })),
    }))
  }

  // Date-filtered: calculate from raw call_audits
  const results: CloserComparison[] = []

  for (const closerId of closerIds) {
    let query = supabase
      .from("call_audits")
      .select("*")
      .eq("closer_id", closerId)
      .not("score_final", "is", null)

    if (dateFrom) query = query.gte("call_date", dateFrom)
    if (dateTo) query = query.lte("call_date", dateTo)

    const { data: calls } = await query

    if (!calls || calls.length === 0) continue

    const { data: closer } = await supabase
      .from("closers")
      .select("name")
      .eq("id", closerId)
      .maybeSingle()

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
      closer_name: closer?.name ?? "Desconhecido",
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

  // Fetch all completed audits in date range
  let closerQuery = supabase
    .from("call_audits")
    .select("*")
    .gte("call_date", fromStr)
    .not("score_final", "is", null)
    .order("call_date", { ascending: true })

  if (closerId) {
    closerQuery = closerQuery.eq("closer_id", closerId)
  }

  const { data: closerData } = await closerQuery

  // Team average (all closers)
  const { data: teamData } = await supabase
    .from("call_audits")
    .select("*")
    .gte("call_date", fromStr)
    .not("score_final", "is", null)
    .order("call_date", { ascending: true })

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

  if (!goals) return []

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

  const results: GoalWithProgress[] = []

  for (const goal of goals) {
    const currentValue = await calculateCurrentValue(goal, supabase)
    const progress =
      goal.target_value > 0
        ? Math.min(100, Math.round((currentValue / Number(goal.target_value)) * 100))
        : 100

    results.push({
      id: goal.id,
      organization_id: goal.organization_id,
      title: goal.title,
      type: goal.type,
      metric: goal.metric as GoalMetric,
      target_value: Number(goal.target_value),
      dimension_id: goal.dimension_id,
      closer_id: goal.closer_id,
      start_date: goal.start_date,
      end_date: goal.end_date,
      status: goal.status,
      created_at: goal.created_at,
      updated_at: goal.updated_at,
      current_value: currentValue,
      progress,
      closer_name: goal.closer_id ? closerNames.get(goal.closer_id) : undefined,
    })
  }

  return results
}

async function calculateCurrentValue(
  goal: GoalRow,
  supabase: Awaited<ReturnType<typeof createClient>>
): Promise<number> {
  let query = supabase
    .from("call_audits")
    .select("*")
    .gte("call_date", goal.start_date)
    .lte("call_date", goal.end_date)
    .not("score_final", "is", null)

  if (goal.closer_id) {
    query = query.eq("closer_id", goal.closer_id)
  }

  const { data: calls } = await query

  if (!calls || calls.length === 0) return 0

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
      const dimId = goal.dimension_id as keyof typeof calls[0]
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
  const title = formData.get("title")?.toString().trim()
  if (!title) return { error: "Título é obrigatório." }

  const type = formData.get("type")?.toString() as "individual" | "team" | "dimension"
  const metric = formData.get("metric")?.toString() as "score_avg" | "score_min" | "classificacao_count" | "taxa_fechamento" | "dimension_avg"
  const targetValue = Number(formData.get("target_value"))
  const startDate = formData.get("start_date")?.toString()
  const endDate = formData.get("end_date")?.toString()
  const closerId = formData.get("closer_id")?.toString() || null
  const dimensionId = formData.get("dimension_id")?.toString() || null

  if (!type || !metric || !startDate || !endDate || isNaN(targetValue)) {
    return { error: "Preencha todos os campos obrigatórios." }
  }

  const supabase = await createClient()
  const { error } = await supabase.from("goals").insert({
    title,
    type,
    metric,
    target_value: targetValue,
    start_date: startDate,
    end_date: endDate,
    closer_id: closerId,
    dimension_id: dimensionId,
  })

  if (error) return { error: "Erro ao criar meta." }

  revalidatePath("/analytics")
  return { success: true }
}

export async function updateGoalStatus(
  goalId: string,
  status: "active" | "completed" | "failed"
): Promise<{ success?: boolean; error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase
    .from("goals")
    .update({ status })
    .eq("id", goalId)

  if (error) return { error: "Erro ao atualizar meta." }

  revalidatePath("/analytics")
  return { success: true }
}

export async function deleteGoal(
  goalId: string
): Promise<{ success?: boolean; error?: string }> {
  const supabase = await createClient()
  const { error } = await supabase.from("goals").delete().eq("id", goalId)

  if (error) return { error: "Erro ao excluir meta." }

  revalidatePath("/analytics")
  return { success: true }
}
