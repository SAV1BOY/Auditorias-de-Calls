import type { Database } from "./database"

export type CallAuditRow = Database["public"]["Tables"]["call_audits"]["Row"]
export type CloserRow = Database["public"]["Tables"]["closers"]["Row"]
export type ProfileRow = Database["public"]["Tables"]["profiles"]["Row"]

export type Classificacao = "ELITE" | "FORTE" | "MEDIANA" | "FRACA"

export type AuditStatus = CallAuditRow["status"]

export type Resultado = NonNullable<CallAuditRow["resultado"]>

export interface CallAuditWithCloser extends CallAuditRow {
  closers: Pick<CloserRow, "name"> | null
}

export interface DashboardStats {
  totalCalls: number
  mediaScore: number | null
  taxaFechamento: number | null
  callsEstaSemana: number
  porClassificacao: {
    elite: number
    forte: number
    mediana: number
    fraca: number
  }
  evolucaoScore: Array<{ date: string; score: number }>
}

export interface AuditFilters {
  closerId?: string
  dateFrom?: string
  dateTo?: string
  classificacao?: Classificacao
  resultado?: string
  status?: string
  sortBy?: string
  sortOrder?: "asc" | "desc"
  page?: number
  pageSize?: number
}

export interface PaginatedResult<T> {
  data: T[]
  total: number
  page: number
  pageSize: number
  totalPages: number
}

// ─── Analytics Types ───

export type GoalType = "individual" | "team" | "dimension"
export type GoalMetric = "score_avg" | "score_min" | "classificacao_count" | "taxa_fechamento" | "dimension_avg"
export type GoalStatus = "active" | "completed" | "failed"

export interface GoalRow {
  id: string
  organization_id: string | null
  title: string
  type: GoalType
  metric: GoalMetric
  target_value: number
  dimension_id: string | null
  closer_id: string | null
  start_date: string
  end_date: string
  status: GoalStatus
  created_at: string
  updated_at: string
}

export interface GoalWithProgress extends GoalRow {
  current_value: number
  progress: number
  closer_name?: string
}

export interface CloserComparison {
  closer_id: string
  closer_name: string
  dimensions: Array<{ name: string; shortName: string; score: number }>
  media_score: number | null
  total_calls: number
}

export interface DimensionTrendPoint {
  date: string
  score: number
  teamAvg?: number
  movingAvg?: number
}
