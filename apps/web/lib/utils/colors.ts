import type { Classificacao, AuditStatus } from "@/lib/types/audit"

export function getClassificacaoColor(classificacao: Classificacao | null): string {
  switch (classificacao) {
    case "ELITE":
      return "bg-amber-900/30 text-amber-300"
    case "FORTE":
      return "bg-emerald-900/30 text-emerald-400"
    case "MEDIANA":
      return "bg-yellow-900/30 text-yellow-400"
    case "FRACA":
      return "bg-red-900/30 text-red-400"
    default:
      return "bg-surface-container-high text-muted-foreground"
  }
}

export function getScoreColor(score: number | null): string {
  if (score === null) return "text-muted-foreground"
  if (score >= 8.5) return "text-amber-300 font-body font-bold"
  if (score >= 7.0) return "text-emerald-400 font-body font-bold"
  if (score >= 5.5) return "text-yellow-400 font-body font-bold"
  return "text-red-400 font-body font-bold"
}

export function getStatusColor(status: AuditStatus): string {
  switch (status) {
    case "completed":
      return "bg-emerald-900/30 text-emerald-400"
    case "error":
      return "bg-red-900/30 text-red-400"
    case "uploaded":
      return "bg-surface-container-high text-muted-foreground"
    default:
      return "bg-blue-900/30 text-blue-400"
  }
}
