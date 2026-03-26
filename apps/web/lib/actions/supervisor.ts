"use server"

// TODO: After applying migration 011_supervisor_analysis.sql and regenerating
// Supabase types with `supabase gen types typescript`, remove the `as any` casts.

import { createClient } from "@/lib/supabase/server"

// eslint-disable-next-line @typescript-eslint/no-explicit-any
async function getSupabase(): Promise<any> {
  return await createClient()
}

import type {
  SupervisorAnalysis,
  SupervisorAnalysisFilters,
  SupervisorDashboardStats,
  SupervisorStageScore,
  ProtocolRule,
  TrainingAction,
  NegotiationAnalysis,
} from "@/lib/types/supervisor"
import type { PaginatedResult } from "@/lib/types/audit"

// ─── Dashboard Stats ───

export async function getSupervisorDashboardStats(): Promise<SupervisorDashboardStats> {
  const supabase = await getSupabase()

  // Total analyses + avg score + classification distribution
  const { data: analyses } = await supabase
    .from("supervisor_analyses")
    .select("overall_score, classification")

  const total = analyses?.length ?? 0
  const scores = (analyses ?? [])
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    .map((a: any) => a.overall_score)
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    .filter((s: any): s is number => s !== null)
  const avgScore = scores.length > 0
    ? Math.round((scores.reduce((a: number, b: number) => a + b, 0) / scores.length) * 10) / 10
    : null

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const typedAnalyses = (analyses ?? []) as any[]
  const byClassification = {
    excelente: typedAnalyses.filter((a) => a.classification === "EXCELENTE").length,
    boa: typedAnalyses.filter((a) => a.classification === "BOA").length,
    regular: typedAnalyses.filter((a) => a.classification === "REGULAR").length,
    fraca: typedAnalyses.filter((a) => a.classification === "FRACA").length,
    critica: typedAnalyses.filter((a) => a.classification === "CRITICA").length,
  }

  // Weakest stages
  const { data: weakestStages } = await supabase
    .from("v_supervisor_weakest_stages")
    .select("*")
    .limit(5)

  // Recent analyses with call data
  const { data: recent } = await supabase
    .from("supervisor_analyses")
    .select("*, call_audits!inner(id, lead_name, call_date, closer_id, score_final, classificacao, closers(name))")
    .order("created_at", { ascending: false })
    .limit(5)

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const recentAnalyses: SupervisorAnalysis[] = (recent ?? []).map((row: any) => ({
    ...row,
    stages: [],
    negotiation: {
      table_price_presented: row.table_price_presented ?? false,
      silence_applied: row.silence_applied ?? false,
      who_spoke_first: row.who_spoke_first ?? "unknown",
      protagonist_transition_quality: row.protagonist_transition_quality ?? 0,
      cac_explained: row.cac_explained ?? false,
      negotiation_firmness: row.negotiation_firmness ?? 0,
      downsell_used: row.downsell_used ?? false,
      downsell_narrative_quality: row.downsell_narrative_quality,
    } as NegotiationAnalysis,
    priority_improvements: (row.priority_improvements ?? []) as string[],
    training_actions: (row.training_actions ?? []) as SupervisorAnalysis["training_actions"],
    objections_detected: (row.objections_detected ?? []) as SupervisorAnalysis["objections_detected"],
  }))

  return {
    total_analyses: total,
    avg_score: avgScore,
    by_classification: byClassification,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    weakest_stages: (weakestStages ?? []).map((s: any) => ({
      stage_key: s.stage_key,
      stage_name: s.stage_name,
      avg_score: Number(s.avg_score ?? 0),
      total_evaluations: Number(s.total_evaluations ?? 0),
      critical_count: Number(s.critical_count ?? 0),
    })),
    recent_analyses: recentAnalyses,
  }
}

// ─── Analysis Detail ───

export async function getSupervisorAnalysis(
  analysisId: string
): Promise<SupervisorAnalysis | null> {
  const supabase = await getSupabase()

  const { data: row } = await supabase
    .from("supervisor_analyses")
    .select("*, call_audits!inner(id, lead_name, call_date, closer_id, score_final, classificacao, closers(name))")
    .eq("id", analysisId)
    .single()

  if (!row) return null

  // Fetch stage scores
  const { data: stages } = await supabase
    .from("supervisor_stage_scores")
    .select("*")
    .eq("analysis_id", analysisId)
    .order("stage_order")

  return {
    ...row,
    stages: (stages ?? []) as SupervisorStageScore[],
    negotiation: {
      table_price_presented: row.table_price_presented ?? false,
      silence_applied: row.silence_applied ?? false,
      who_spoke_first: row.who_spoke_first ?? "unknown",
      protagonist_transition_quality: row.protagonist_transition_quality ?? 0,
      cac_explained: row.cac_explained ?? false,
      negotiation_firmness: row.negotiation_firmness ?? 0,
      downsell_used: row.downsell_used ?? false,
      downsell_narrative_quality: row.downsell_narrative_quality,
    } as NegotiationAnalysis,
    priority_improvements: (row.priority_improvements ?? []) as string[],
    training_actions: (row.training_actions ?? []) as SupervisorAnalysis["training_actions"],
    objections_detected: (row.objections_detected ?? []) as SupervisorAnalysis["objections_detected"],
  }
}

// ─── Analysis by Audit ───

export async function getSupervisorAnalysisByAudit(
  auditId: string
): Promise<SupervisorAnalysis | null> {
  const supabase = await getSupabase()

  const { data: row } = await supabase
    .from("supervisor_analyses")
    .select("*")
    .eq("audit_id", auditId)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle()

  if (!row) return null

  return getSupervisorAnalysis(row.id)
}

// ─── List Analyses ───

export async function listSupervisorAnalyses(
  filters: SupervisorAnalysisFilters = {}
): Promise<PaginatedResult<SupervisorAnalysis>> {
  const supabase = await getSupabase()
  const page = filters.page ?? 1
  const pageSize = filters.pageSize ?? 10
  const from = (page - 1) * pageSize
  const to = from + pageSize - 1

  let query = supabase
    .from("supervisor_analyses")
    .select("*, call_audits!inner(id, lead_name, call_date, closer_id, score_final, classificacao, closers(name))", { count: "exact" })
    .order("created_at", { ascending: false })
    .range(from, to)

  if (filters.classification) {
    query = query.eq("classification", filters.classification)
  }
  if (filters.closerId) {
    query = query.eq("call_audits.closer_id", filters.closerId)
  }
  if (filters.dateFrom) {
    query = query.gte("created_at", filters.dateFrom)
  }
  if (filters.dateTo) {
    query = query.lte("created_at", filters.dateTo)
  }

  const { data, count } = await query

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const analyses: SupervisorAnalysis[] = (data ?? []).map((row: any) => ({
    ...row,
    stages: [],
    negotiation: {
      table_price_presented: row.table_price_presented ?? false,
      silence_applied: row.silence_applied ?? false,
      who_spoke_first: row.who_spoke_first ?? "unknown",
      protagonist_transition_quality: row.protagonist_transition_quality ?? 0,
      cac_explained: row.cac_explained ?? false,
      negotiation_firmness: row.negotiation_firmness ?? 0,
      downsell_used: row.downsell_used ?? false,
      downsell_narrative_quality: row.downsell_narrative_quality,
    } as NegotiationAnalysis,
    priority_improvements: (row.priority_improvements ?? []) as string[],
    training_actions: (row.training_actions ?? []) as SupervisorAnalysis["training_actions"],
    objections_detected: (row.objections_detected ?? []) as SupervisorAnalysis["objections_detected"],
  }))

  const total = count ?? 0

  return {
    data: analyses,
    total,
    page,
    pageSize,
    totalPages: Math.ceil(total / pageSize),
  }
}

// ─── Protocol Rules ───

export async function getProtocolRules(
  version?: string
): Promise<ProtocolRule[]> {
  const supabase = await getSupabase()

  let query = supabase
    .from("protocol_rules")
    .select("*")
    .eq("is_active", true)
    .order("stage_order")

  if (version) {
    query = query.eq("version", version)
  }

  const { data } = await query

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return (data ?? []).map((row: any) => ({
    ...row,
    expected_behaviors: (row.expected_behaviors ?? []) as string[],
    failure_behaviors: (row.failure_behaviors ?? []) as string[],
  }))
}

export async function updateProtocolRule(
  id: string,
  data: Partial<Pick<ProtocolRule, "stage_name" | "expected_behaviors" | "failure_behaviors" | "scoring_weight" | "is_active">>
): Promise<{ success: boolean; error?: string }> {
  const supabase = await getSupabase()

  const { error } = await supabase
    .from("protocol_rules")
    .update(data)
    .eq("id", id)

  if (error) return { success: false, error: error.message }
  return { success: true }
}

// ─── Weakest Stages ───

export async function getWeakestStages(
  closerId?: string,
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  _period?: string,
): Promise<Array<{ stage_key: string; stage_name: string; avg_score: number; total_evaluations: number; critical_count: number }>> {
  const supabase = await getSupabase()

  if (closerId) {
    // Per-closer weakest stages (manual aggregation)
    const { data } = await supabase
      .from("supervisor_stage_scores")
      .select("stage_key, stage_name, score, status, supervisor_analyses!inner(audit_id, call_audits!inner(closer_id))")
      .eq("supervisor_analyses.call_audits.closer_id", closerId)

    if (!data || data.length === 0) return []

    const grouped = new Map<string, { scores: number[]; criticals: number; name: string }>()
    for (const row of data) {
      const existing = grouped.get(row.stage_key) ?? { scores: [] as number[], criticals: 0, name: row.stage_name }
      existing.scores.push(Number(row.score))
      if (row.status === "critical") existing.criticals++
      grouped.set(row.stage_key, existing)
    }

    return Array.from(grouped.entries())
      .map(([key, val]) => ({
        stage_key: key,
        stage_name: val.name,
        avg_score: Math.round((val.scores.reduce((a: number, b: number) => a + b, 0) / val.scores.length) * 10) / 10,
        total_evaluations: val.scores.length,
        critical_count: val.criticals,
      }))
      .sort((a, b) => a.avg_score - b.avg_score)
  }

  // Global weakest stages from view
  const { data } = await supabase
    .from("v_supervisor_weakest_stages")
    .select("*")

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return (data ?? []).map((s: any) => ({
    stage_key: s.stage_key,
    stage_name: s.stage_name,
    avg_score: Number(s.avg_score ?? 0),
    total_evaluations: Number(s.total_evaluations ?? 0),
    critical_count: Number(s.critical_count ?? 0),
  }))
}

// ─── Training Actions ───

export async function getTrainingActions(
  closerId?: string
): Promise<TrainingAction[]> {
  const supabase = await getSupabase()

  let query = supabase
    .from("closer_training_actions")
    .select("*")
    .order("created_at", { ascending: false })

  if (closerId) {
    query = query.eq("closer_id", closerId)
  }

  const { data } = await query

  return (data ?? []) as TrainingAction[]
}

// ─── Request Manual Analysis ───

export async function requestSupervisorAnalysis(
  auditId: string
): Promise<{ success: boolean; error?: string }> {
  const supabase = await getSupabase()

  // Rate limit: 5 analysis requests per hour
  const { rateLimit: rl, RATE_LIMITS } = await import("@/lib/security/rate-limit")
  const check = rl(`analysis:${auditId}`, RATE_LIMITS.analysis)
  if (!check.success) {
    return { success: false, error: "Muitas solicitações. Aguarde antes de solicitar nova análise." }
  }

  // Verify audit exists and has transcription
  const { data: audit } = await supabase
    .from("call_audits")
    .select("id, transcricao, status")
    .eq("id", auditId)
    .single()

  if (!audit) return { success: false, error: "Auditoria não encontrada." }
  if (!audit.transcricao) return { success: false, error: "Transcrição ainda não disponível." }

  // Create job in queue
  const { error } = await supabase.from("job_queue").insert({
    audit_id: auditId,
    job_type: "supervisor_analyze",
    status: "pending",
  })

  if (error) return { success: false, error: "Erro ao solicitar análise." }
  return { success: true }
}

// ─── Closer Supervisor Performance ───

export async function getCloserSupervisorPerformance(
  closerId: string
): Promise<{
  total_analyses: number
  avg_score: number | null
  excelente_count: number
  boa_count: number
  regular_count: number
  fraca_count: number
} | null> {
  const supabase = await getSupabase()

  const { data } = await supabase
    .from("v_supervisor_closer_performance")
    .select("*")
    .eq("closer_id", closerId)
    .maybeSingle()

  if (!data) return null

  return {
    total_analyses: Number(data.total_analyses ?? 0),
    avg_score: data.avg_score ? Number(data.avg_score) : null,
    excelente_count: Number(data.excelente_count ?? 0),
    boa_count: Number(data.boa_count ?? 0),
    regular_count: Number(data.regular_count ?? 0),
    fraca_count: Number(data.fraca_count ?? 0),
  }
}
