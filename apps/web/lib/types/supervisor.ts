// ─── Supervisor Analysis Types ───

export type SupervisorClassification = "EXCELENTE" | "BOA" | "REGULAR" | "FRACA" | "CRITICA"

export type StageStatus = "excellent" | "ok" | "warning" | "critical" | "skipped"

export interface SupervisorStageScore {
  id: string
  analysis_id: string
  stage_key: string
  stage_name: string
  stage_order: number
  score: number
  max_score: number
  weight: number
  status: StageStatus
  justification: string
  evidence_excerpt: string | null
  missed_actions: string[]
  suggested_fix: string[]
}

export interface NegotiationAnalysis {
  table_price_presented: boolean
  silence_applied: boolean
  who_spoke_first: "closer" | "lead" | "unknown"
  protagonist_transition_quality: number
  cac_explained: boolean
  negotiation_firmness: number
  downsell_used: boolean
  downsell_narrative_quality: number | null
}

export interface DetectedObjectionSup {
  type: string
  text: string
  handled: boolean
  quality: "good" | "poor"
}

export interface TrainingAction {
  id: string
  closer_id: string
  source_analysis_id: string
  weakness_key: string
  stage_key: string | null
  recommendation: string
  priority: "high" | "medium" | "low"
  status: "pending" | "sent" | "completed"
  created_at: string
}

export interface SupervisorAnalysisRow {
  id: string
  audit_id: string
  organization_id: string | null
  protocol_version: string
  prompt_version: string
  overall_score: number | null
  overall_label: string | null
  classification: SupervisorClassification | null
  executive_summary: string | null
  raw_json: unknown
  table_price_presented: boolean | null
  silence_applied: boolean | null
  who_spoke_first: "closer" | "lead" | "unknown" | null
  protagonist_transition_quality: number | null
  cac_explained: boolean | null
  negotiation_firmness: number | null
  downsell_used: boolean | null
  downsell_narrative_quality: number | null
  priority_improvements: string[]
  training_actions: Array<{ weakness_key: string; stage_key: string | null; recommendation: string; priority: string }>
  objections_detected: Array<{ type: string; text: string; handled: boolean; quality: string }>
  modelo_analise: string
  tokens_input: number | null
  tokens_output: number | null
  custo_estimado: number | null
  created_at: string
  updated_at: string
}

export interface SupervisorAnalysis extends SupervisorAnalysisRow {
  stages: SupervisorStageScore[]
  negotiation: NegotiationAnalysis
  call_audits?: {
    id: string
    lead_name: string
    call_date: string
    closer_id: string
    score_final: number | null
    classificacao: string | null
    closers: { name: string } | null
  }
}

export interface SupervisorDashboardStats {
  total_analyses: number
  avg_score: number | null
  by_classification: {
    excelente: number
    boa: number
    regular: number
    fraca: number
    critica: number
  }
  weakest_stages: Array<{
    stage_key: string
    stage_name: string
    avg_score: number
    total_evaluations: number
    critical_count: number
  }>
  recent_analyses: SupervisorAnalysis[]
}

export interface ProtocolRule {
  id: string
  organization_id: string | null
  version: string
  stage_key: string
  stage_name: string
  stage_order: number
  description: string | null
  expected_behaviors: string[]
  failure_behaviors: string[]
  scoring_weight: number
  is_active: boolean
  updated_at: string
}

export interface NegotiationRule {
  id: string
  organization_id: string | null
  max_discount_pct: number | null
  max_installments: number | null
  allowed_bonuses: string[]
  concession_order: string[]
  downsell_products: string[]
  what_is_good_negotiation: string | null
  what_is_good_downsell: string | null
  version: string
}

export interface SupervisorAnalysisFilters {
  closerId?: string
  classification?: SupervisorClassification
  dateFrom?: string
  dateTo?: string
  page?: number
  pageSize?: number
}

// ─── Stage Constants ───

export const SUPERVISOR_STAGES = [
  { key: "icebreaker", name: "Quebra-gelo", weight: 0.03 },
  { key: "rapport", name: "Rapport", weight: 0.05 },
  { key: "initial_pact", name: "Pacto Inicial", weight: 0.05 },
  { key: "spin_situation", name: "SPIN — Situação", weight: 0.05 },
  { key: "spin_problem", name: "SPIN — Problema", weight: 0.05 },
  { key: "spin_implication", name: "SPIN — Implicação", weight: 0.08 },
  { key: "spin_need", name: "SPIN — Necessidade", weight: 0.07 },
  { key: "transition_pact", name: "Pacto de Transição", weight: 0.05 },
  { key: "presentation_method", name: "Apresentação: Método", weight: 0.10 },
  { key: "presentation_product", name: "Apresentação: Produto", weight: 0.10 },
  { key: "objection_isolation", name: "Isolamento de Objeções", weight: 0.08 },
  { key: "anchoring", name: "Ancoragem", weight: 0.08 },
  { key: "table_price", name: "Preço de Tabela", weight: 0.05 },
  { key: "protagonist_price", name: "Preço Protagonista", weight: 0.05 },
  { key: "negotiation", name: "Negociação", weight: 0.07 },
  { key: "downsell", name: "Down Sell", weight: 0.04 },
] as const

export const SUPERVISOR_CLASSIFICATION_THRESHOLDS = {
  EXCELENTE: 9.0,
  BOA: 7.0,
  REGULAR: 5.0,
  FRACA: 3.0,
  CRITICA: 0.0, // scores below FRACA (< 3.0)
} as const

export function getSupervisorClassificationColor(classification: SupervisorClassification | null): string {
  switch (classification) {
    case "EXCELENTE":
      return "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
    case "BOA":
      return "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20"
    case "REGULAR":
      return "bg-amber-400/10 text-amber-400 border-amber-400/20"
    case "FRACA":
      return "bg-red-500/10 text-red-500 border-red-500/20"
    case "CRITICA":
      return "bg-red-700/10 text-red-700 border-red-700/20"
    default:
      return "bg-[#343538] text-[#d8c3ac]"
  }
}

export function getStageStatusColor(status: StageStatus): string {
  switch (status) {
    case "excellent":
      return "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
    case "ok":
      return "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20"
    case "warning":
      return "bg-amber-400/10 text-amber-400 border-amber-400/20"
    case "critical":
      return "bg-red-500/10 text-red-500 border-red-500/20"
    case "skipped":
      return "bg-[#343538] text-stone-500 border-stone-500/20"
  }
}
