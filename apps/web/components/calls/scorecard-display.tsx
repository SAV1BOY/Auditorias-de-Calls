import type { CallAuditWithCloser } from "@/lib/types/audit"
import { formatScore } from "@/lib/utils/format"
import { getScoreColor } from "@/lib/utils/colors"

const DIMENSIONS = [
  { key: "d01_frame", label: "Frame e Liderança", icon: "record_voice_over", peso: 8 },
  { key: "d02_qualificacao", label: "Qualificação Preliminar", icon: "fact_check", peso: 10 },
  { key: "d03_diag_quantitativo", label: "Diagnóstico Quantitativo", icon: "calculate", peso: 12 },
  { key: "d04_diag_qualitativo", label: "Diagnóstico Qualitativo", icon: "psychology", peso: 8 },
  { key: "d05_consequencia", label: "Perguntas de Consequência", icon: "warning", peso: 10 },
  { key: "d06_ensino", label: "Ensino Comercial", icon: "school", peso: 5 },
  { key: "d07_identidade", label: "Reframe de Identidade", icon: "person_search", peso: 5 },
  { key: "d08_ancoragem", label: "Ancoragem de Valor", icon: "payments", peso: 10 },
  { key: "d09_isolamento", label: "Isolamento de Objeção", icon: "filter_alt", peso: 10 },
  { key: "d10_proporcao_fala", label: "Proporção de Fala", icon: "graphic_eq", peso: 8 },
  { key: "d11_promessas", label: "Segurança de Promessas", icon: "verified", peso: 8 },
  { key: "d12_checkpoints", label: "Checkpoints", icon: "playlist_add_check", peso: 3 },
  { key: "d13_fechamento", label: "Controle e Fechamento", icon: "handshake", peso: 3 },
]

function barColor(score: number): string {
  if (score >= 8.5) return "bg-emerald-500"
  if (score >= 7) return "bg-[#ffa600]"
  if (score >= 5.5) return "bg-amber-400"
  return "bg-red-500"
}

function textColor(score: number): string {
  if (score >= 8.5) return "text-emerald-500"
  if (score >= 7) return "text-[#ffa600]"
  if (score >= 5.5) return "text-amber-400"
  return "text-red-500"
}

interface ScorecardDisplayProps {
  audit: CallAuditWithCloser
}

export function ScorecardDisplay({ audit }: ScorecardDisplayProps) {
  return (
    <div className="space-y-3">
      {DIMENSIONS.map((dim) => {
        const score = (audit as unknown as Record<string, unknown>)[dim.key] as number | null
        return (
          <div
            key={dim.key}
            className="bg-surface-container-low p-4 rounded-xl border border-white/5 hover:border-[#ffa600]/20 transition-all"
          >
            <div className="flex items-center justify-between mb-2">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-[#ffa600] bg-[#ffa600]/10 p-2 rounded-lg text-lg">
                  {dim.icon}
                </span>
                <div>
                  <span className="font-headline font-bold text-sm">{dim.label}</span>
                  <span className="font-label text-[10px] text-stone-500 ml-2">
                    Peso: {dim.peso}%
                  </span>
                </div>
              </div>
              <span
                className={`text-2xl font-headline font-bold ${
                  score !== null ? textColor(score) : "text-stone-600"
                }`}
              >
                {score !== null ? score.toFixed(1) : "—"}
              </span>
            </div>
            <div className="h-2 w-full bg-surface-container-highest rounded-full overflow-hidden">
              <div
                className={`h-full rounded-full transition-all duration-700 ${
                  score !== null ? barColor(score) : "bg-stone-700"
                }`}
                style={{ width: `${score !== null ? score * 10 : 0}%` }}
              />
            </div>
          </div>
        )
      })}
    </div>
  )
}
