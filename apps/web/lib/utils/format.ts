import type { Classificacao } from "@/lib/types/audit"
import { CLASSIFICACAO_THRESHOLDS } from "./constants"

export function formatDate(dateStr: string): string {
  const date = new Date(dateStr + "T00:00:00")
  return date.toLocaleDateString("pt-BR", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  })
}

export function formatScore(score: number | null): string {
  if (score === null || score === undefined) return "—"
  return score.toFixed(1)
}

export function formatCurrency(value: number | null): string {
  if (value === null || value === undefined) return "—"
  return value.toLocaleString("pt-BR", {
    style: "currency",
    currency: "BRL",
  })
}

export function getClassificacao(score: number | null): Classificacao | null {
  if (score === null) return null
  if (score >= CLASSIFICACAO_THRESHOLDS.ELITE) return "ELITE"
  if (score >= CLASSIFICACAO_THRESHOLDS.FORTE) return "FORTE"
  if (score >= CLASSIFICACAO_THRESHOLDS.MEDIANA) return "MEDIANA"
  return "FRACA"
}

export function formatDuration(minutes: number | null): string {
  if (minutes === null) return "—"
  const h = Math.floor(minutes / 60)
  const m = minutes % 60
  if (h === 0) return `${m}min`
  return `${h}h${m > 0 ? `${m}min` : ""}`
}
