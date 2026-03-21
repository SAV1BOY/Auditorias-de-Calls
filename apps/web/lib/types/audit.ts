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

// ─── Sprint 9: Coaching Types ───

export type CallBookmarkRow = Database["public"]["Tables"]["call_bookmarks"]["Row"]
export type CallCommentRow = Database["public"]["Tables"]["call_comments"]["Row"]
export type WeeklyReportRow = Database["public"]["Tables"]["weekly_reports"]["Row"]

export interface HighlightTimestamp {
  start_sec: number
  end_sec: number
  label: string
}

export interface CallBookmark extends Omit<CallBookmarkRow, "highlight_timestamps"> {
  highlight_timestamps: HighlightTimestamp[]
  call_audits?: Pick<CallAuditRow, "id" | "lead_name" | "call_date" | "score_final" | "classificacao"> & {
    closers: Pick<CloserRow, "name"> | null
  }
}

export interface CallComment extends CallCommentRow {
  author?: Pick<ProfileRow, "full_name" | "avatar_url" | "role">
  replies?: CallComment[]
}

export interface WeeklyStats {
  total_calls: number
  insufficient_data?: boolean
  score_avg: number
  score_avg_prev: number | null
  top_closers: { id: string; name: string; score: number }[]
  weakest_dimension: { id: string; name: string; avg: number } | null
  best_call: { id: string; lead_name: string; closer_name: string; score: number | null } | null
  worst_call: { id: string; lead_name: string; closer_name: string; score: number | null } | null
  taxa_fechamento: number
  total_prev_calls: number
}

export interface WeeklyReport extends Omit<WeeklyReportRow, "stats"> {
  stats: WeeklyStats
}

export interface AudioMarker {
  id: string
  timestampSec: number
  type: "comment" | "highlight"
  label?: string
  color?: string
}
