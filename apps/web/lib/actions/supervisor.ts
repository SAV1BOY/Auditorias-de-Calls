"use server"

import { createClient } from "@/lib/supabase/server"
import { requireRole, requireAuth } from "@/lib/auth/require-role"

import type {
  SupervisorAnalysis,
  SupervisorDashboardStats,
  SupervisorStageScore,
  ProtocolRule,
  TrainingAction,
  NegotiationAnalysis,
} from "@/lib/types/supervisor"

// ─── Row mapper: DB row → SupervisorAnalysis ───

function mapRowToAnalysis(row: Record<string, unknown>, stages: SupervisorStageScore[] = []): SupervisorAnalysis {
  return {
    ...(row as Record<string, unknown>),
    stages,
    negotiation: {
      table_price_presented: (row.table_price_presented as boolean) ?? false,
      silence_applied: (row.silence_applied as boolean) ?? false,
      who_spoke_first: (row.who_spoke_first as string) ?? "unknown",
      protagonist_transition_quality: (row.protagonist_transition_quality as number) ?? 0,
      cac_explained: (row.cac_explained as boolean) ?? false,
      negotiation_firmness: (row.negotiation_firmness as number) ?? 0,
      downsell_used: (row.downsell_used as boolean) ?? false,
      downsell_narrative_quality: row.downsell_narrative_quality as number | undefined,
    } as NegotiationAnalysis,
    priority_improvements: ((row.priority_improvements ?? []) as string[]),
    training_actions: ((row.training_actions ?? []) as SupervisorAnalysis["training_actions"]),
    objections_detected: ((row.objections_detected ?? []) as SupervisorAnalysis["objections_detected"]),
  } as SupervisorAnalysis
}

// ─── Dashboard Stats ───

export async function getSupervisorDashboardStats(): Promise<SupervisorDashboardStats> {
  await requireAuth()
  const supabase = await createClient()

  // Total analyses + avg score + classification distribution
  const { data: analyses } = await supabase
    .from("supervisor_analyses")
    .select("overall_score, classification")

  const total = analyses?.length ?? 0
  const scores = (analyses ?? [])
    .map((a) => a.overall_score)
    .filter((s): s is number => s !== null)
  const avgScore = scores.length > 0
    ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
    : null

  const byClassification = {
    excelente: (analyses ?? []).filter((a) => a.classification === "EXCELENTE").length,
    boa: (analyses ?? []).filter((a) => a.classification === "BOA").length,
    regular: (analyses ?? []).filter((a) => a.classification === "REGULAR").length,
    fraca: (analyses ?? []).filter((a) => a.classification === "FRACA").length,
    critica: (analyses ?? []).filter((a) => a.classification === "CRITICA").length,
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

  const recentAnalyses = (recent ?? []).map((row) =>
    mapRowToAnalysis(row as unknown as Record<string, unknown>)
  )

  return {
    total_analyses: total,
    avg_score: avgScore,
    by_classification: byClassification,
    weakest_stages: (weakestStages ?? []).map((s) => ({
      stage_key: s.stage_key as string,
      stage_name: s.stage_name as string,
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
  await requireAuth()
  const supabase = await createClient()

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

  return mapRowToAnalysis(
    row as unknown as Record<string, unknown>,
    (stages ?? []) as SupervisorStageScore[]
  )
}

// ─── Analysis by Audit ───

export async function getSupervisorAnalysisByAudit(
  auditId: string
): Promise<SupervisorAnalysis | null> {
  await requireAuth()
  const supabase = await createClient()

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

// ─── Protocol Rules ───

export async function getProtocolRules(
  version?: string
): Promise<ProtocolRule[]> {
  await requireAuth()
  const supabase = await createClient()

  let query = supabase
    .from("protocol_rules")
    .select("*")
    .eq("is_active", true)
    .order("stage_order")

  if (version) {
    query = query.eq("version", version)
  }

  const { data } = await query

  return (data ?? []).map((row) => ({
    ...row,
    expected_behaviors: (row.expected_behaviors ?? []) as string[],
    failure_behaviors: (row.failure_behaviors ?? []) as string[],
  })) as ProtocolRule[]
}

export async function updateProtocolRule(
  id: string,
  data: Partial<Pick<ProtocolRule, "stage_name" | "expected_behaviors" | "failure_behaviors" | "scoring_weight" | "is_active">>
): Promise<{ success: boolean; error?: string }> {
  await requireRole(["admin"])
  const supabase = await createClient()

  const { error } = await supabase
    .from("protocol_rules")
    .update(data)
    .eq("id", id)

  if (error) return { success: false, error: error.message }
  return { success: true }
}

// ─── Training Actions ───

export async function getTrainingActions(
  closerId?: string
): Promise<TrainingAction[]> {
  await requireAuth()
  const supabase = await createClient()

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
  await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

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

  // Create job in queue via RPC (respects RLS)
  const { error } = await supabase.rpc("enqueue_job", {
    p_audit_id: auditId,
    p_job_type: "supervisor_analyze",
  })

  if (error) {
    console.error("enqueue_job supervisor_analyze failed:", error)
    return { success: false, error: `Erro ao solicitar análise: ${error.message}` }
  }
  return { success: true }
}

