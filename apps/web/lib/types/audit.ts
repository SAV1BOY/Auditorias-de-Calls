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
}
