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
