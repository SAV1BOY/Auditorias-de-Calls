import type { Classificacao, AuditStatus } from "@/lib/types/audit"

export function getClassificacaoColor(classificacao: Classificacao | null): string {
  switch (classificacao) {
    case "ELITE":
      return "bg-emerald-100 text-emerald-800"
    case "FORTE":
      return "bg-blue-100 text-blue-800"
    case "MEDIANA":
      return "bg-amber-100 text-amber-800"
    case "FRACA":
      return "bg-red-100 text-red-800"
    default:
      return "bg-gray-100 text-gray-800"
  }
}

export function getScoreColor(score: number | null): string {
  if (score === null) return "text-muted-foreground"
  if (score >= 8.5) return "text-emerald-600"
  if (score >= 7.0) return "text-blue-600"
  if (score >= 5.5) return "text-amber-600"
  return "text-red-600"
}

export function getStatusColor(status: AuditStatus): string {
  switch (status) {
    case "completed":
      return "bg-emerald-100 text-emerald-800"
    case "error":
      return "bg-red-100 text-red-800"
    case "uploaded":
      return "bg-gray-100 text-gray-800"
    default:
      return "bg-blue-100 text-blue-800"
  }
}
