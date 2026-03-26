"use client"

import { useState } from "react"
import type { SupervisorStageScore } from "@/lib/types/supervisor"
import { getStageStatusColor } from "@/lib/types/supervisor"

interface StageScoreCardProps {
  stage: SupervisorStageScore
}

export function StageScoreCard({ stage }: StageScoreCardProps) {
  const [expanded, setExpanded] = useState(false)
  const pct = (stage.score / stage.max_score) * 100

  return (
    <div
      className="bg-[#1a1c1e] rounded-xl border border-white/5 hover:border-[#ffa600]/20 transition-all cursor-pointer"
      onClick={() => setExpanded(!expanded)}
    >
      <div className="p-4 flex items-center justify-between">
        <div className="flex items-center gap-3 flex-1 min-w-0">
          <span className="font-headline font-bold text-xs text-stone-500 w-6 text-center">
            {stage.stage_order}
          </span>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2">
              <span className="font-headline font-bold text-sm truncate">
                {stage.stage_name}
              </span>
              <span
                className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${getStageStatusColor(stage.status)}`}
              >
                {stage.status}
              </span>
            </div>
            <div className="mt-1 h-1.5 w-full bg-[#343538] rounded-full overflow-hidden">
              <div
                className={`h-full rounded-full transition-all duration-500 ${
                  stage.score >= 8 ? "bg-emerald-500" : stage.score >= 6 ? "bg-[#ffa600]" : stage.score >= 4 ? "bg-amber-400" : "bg-red-500"
                }`}
                style={{ width: `${pct}%` }}
              />
            </div>
          </div>
        </div>
        <div className="flex items-center gap-2 ml-4">
          <span
            className={`text-2xl font-headline font-bold ${
              stage.score >= 8 ? "text-emerald-500" : stage.score >= 6 ? "text-[#ffa600]" : stage.score >= 4 ? "text-amber-400" : "text-red-500"
            }`}
          >
            {stage.score.toFixed(1)}
          </span>
          <span className="text-xs text-stone-500 font-headline">/{stage.max_score}</span>
          <span className="material-symbols-outlined text-stone-500 text-sm">
            {expanded ? "expand_less" : "expand_more"}
          </span>
        </div>
      </div>

      {expanded && (
        <div className="px-4 pb-4 space-y-3 border-t border-white/5 pt-3">
          {stage.justification && (
            <div>
              <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-1">
                Justificativa
              </p>
              <p className="text-sm text-[#d8c3ac]">{stage.justification}</p>
            </div>
          )}
          {stage.evidence_excerpt && (
            <div>
              <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-1">
                Evidência
              </p>
              <p className="text-sm text-stone-400 italic">{`"${stage.evidence_excerpt}"`}</p>
            </div>
          )}
          {stage.missed_actions.length > 0 && (
            <div>
              <p className="text-[10px] font-label uppercase tracking-widest text-red-400 mb-1">
                Ações Faltantes
              </p>
              <ul className="space-y-1">
                {stage.missed_actions.map((action, i) => (
                  <li key={i} className="text-sm text-red-400 flex items-start gap-2">
                    <span className="material-symbols-outlined text-xs mt-0.5">close</span>
                    {action}
                  </li>
                ))}
              </ul>
            </div>
          )}
          {stage.suggested_fix.length > 0 && (
            <div>
              <p className="text-[10px] font-label uppercase tracking-widest text-emerald-400 mb-1">
                Sugestões de Melhoria
              </p>
              <ul className="space-y-1">
                {stage.suggested_fix.map((fix, i) => (
                  <li key={i} className="text-sm text-emerald-400 flex items-start gap-2">
                    <span className="material-symbols-outlined text-xs mt-0.5">check</span>
                    {fix}
                  </li>
                ))}
              </ul>
            </div>
          )}
          <div className="text-[10px] text-stone-600">
            Peso: {(stage.weight * 100).toFixed(0)}%
          </div>
        </div>
      )}
    </div>
  )
}
