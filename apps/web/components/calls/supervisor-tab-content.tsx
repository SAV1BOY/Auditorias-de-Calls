"use client"

import { useCallback, useEffect, useRef, useState, useTransition } from "react"
import Link from "next/link"
import {
  getSupervisorAnalysisByAudit,
  requestSupervisorAnalysis,
} from "@/lib/actions/supervisor"
import type { SupervisorAnalysis } from "@/lib/types/supervisor"
import { getSupervisorClassificationColor } from "@/lib/types/supervisor"
import { StageTimeline } from "@/components/supervisor/stage-timeline"
import { useToast } from "@/components/ui/use-toast"

interface SupervisorTabContentProps {
  auditId: string
}

export function SupervisorTabContent({ auditId }: SupervisorTabContentProps) {
  const [analysis, setAnalysis] = useState<SupervisorAnalysis | null>(null)
  const [loading, setLoading] = useState(true)
  const [polling, setPolling] = useState(false)
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()
  const intervalRef = useRef<NodeJS.Timeout | null>(null)

  const fetchAnalysis = useCallback(async () => {
    const data = await getSupervisorAnalysisByAudit(auditId)
    if (data) {
      setAnalysis(data)
      setPolling(false)
      if (intervalRef.current) {
        clearInterval(intervalRef.current)
        intervalRef.current = null
      }
    }
    return data
  }, [auditId])

  // Initial fetch
  useEffect(() => {
    fetchAnalysis().then(() => setLoading(false))
  }, [fetchAnalysis])

  // Polling cleanup
  useEffect(() => {
    return () => {
      if (intervalRef.current) clearInterval(intervalRef.current)
    }
  }, [])

  function handleRequest() {
    startTransition(async () => {
      const result = await requestSupervisorAnalysis(auditId)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({
          title: "Análise solicitada",
          description: "Aguardando processamento. O resultado aparecerá automaticamente.",
        })
        // Start polling every 5 seconds for up to 2 minutes
        setPolling(true)
        let attempts = 0
        intervalRef.current = setInterval(async () => {
          attempts++
          const data = await fetchAnalysis()
          if (data || attempts >= 24) {
            // Found or timeout (24 * 5s = 2 min)
            if (!data && attempts >= 24) {
              setPolling(false)
              toast({
                title: "Processamento em andamento",
                description: "A análise ainda está sendo processada. Atualize a página em alguns minutos.",
              })
            }
            if (intervalRef.current) {
              clearInterval(intervalRef.current)
              intervalRef.current = null
            }
          }
        }, 5000)
      }
    })
  }

  if (loading) {
    return (
      <div className="py-8 text-center text-stone-500 animate-pulse">
        Carregando análise do supervisor...
      </div>
    )
  }

  if (!analysis) {
    return (
      <div className="py-12 text-center space-y-4">
        <span className="material-symbols-outlined text-4xl text-stone-600 block">
          supervisor_account
        </span>
        <p className="text-stone-500">
          Nenhuma análise do supervisor encontrada para esta call.
        </p>
        {polling ? (
          <div className="flex items-center justify-center gap-2 text-[#ffa600] text-sm">
            <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
            Aguardando resultado da análise...
          </div>
        ) : (
          <button
            onClick={handleRequest}
            disabled={isPending}
            className="bg-[#ffa600] text-[#2a1800] px-6 py-3 rounded-lg font-headline font-bold text-xs tracking-widest uppercase hover:brightness-110 active:scale-95 transition-all disabled:opacity-50"
          >
            {isPending ? (
              <span className="flex items-center gap-2">
                <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span>
                Solicitando...
              </span>
            ) : (
              <span className="flex items-center gap-2">
                <span className="material-symbols-outlined text-sm">play_arrow</span>
                Solicitar Análise do Supervisor
              </span>
            )}
          </button>
        )}
      </div>
    )
  }

  // Extract stages from raw_json if stages array is empty (fallback)
  const stages = analysis.stages.length > 0
    ? analysis.stages
    : ((analysis.raw_json as Record<string, unknown>)?.stages as Array<Record<string, unknown>> ?? []).map((s, idx) => ({
        id: `raw-${idx}`,
        analysis_id: analysis.id,
        stage_key: String(s.stage_key || s.key || `stage_${idx + 1}`),
        stage_name: String(s.stage_name || s.name || `Etapa ${idx + 1}`),
        stage_order: Number(s.stage_order || s.stage || s.order || idx + 1),
        score: Number(s.score ?? 0),
        max_score: Number(s.max_score || 10),
        weight: Number(s.weight ?? s.weight_pct ? (Number(s.weight_pct) / 100) : 0),
        status: String(s.status || "ok") as "excellent" | "ok" | "warning" | "critical" | "skipped",
        justification: String(s.justification || s.observations || ""),
        evidence_excerpt: s.evidence_excerpt ? String(s.evidence_excerpt) : null,
        missed_actions: Array.isArray(s.missed_actions) ? s.missed_actions.map(String) : [],
        suggested_fix: Array.isArray(s.suggested_fix) ? s.suggested_fix.map(String) : [],
      }))

  return (
    <div className="space-y-6">
      {/* Score header */}
      <div className="flex items-center justify-between">
        <div className="space-y-1">
          <div className="flex items-center gap-3">
            <span className="text-4xl font-headline font-bold text-[#ffa600]">
              {analysis.overall_score?.toFixed(1) ?? "—"}
            </span>
            <span className="text-lg text-stone-500 font-headline">/10</span>
            {analysis.classification && (
              <span
                className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${getSupervisorClassificationColor(analysis.classification)}`}
              >
                {analysis.classification}
              </span>
            )}
          </div>
          {analysis.overall_label && (
            <p className="text-sm text-[#d8c3ac]">{analysis.overall_label}</p>
          )}
        </div>
        <Link
          href={`/supervisor/analysis/${analysis.id}`}
          className="bg-[#ffa600]/10 text-[#ffa600] px-4 py-2 rounded-lg text-xs font-bold tracking-widest uppercase hover:bg-[#ffa600]/20 transition-all flex items-center gap-2"
        >
          <span className="material-symbols-outlined text-sm">open_in_new</span>
          Ver Detalhes
        </Link>
      </div>

      {/* Timeline - uses stages from DB or fallback from raw_json */}
      {stages.length > 0 && <StageTimeline stages={stages} />}

      {/* Executive summary */}
      {analysis.executive_summary && (
        <div className="bg-[#121316]/50 rounded-lg p-4">
          <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-2">
            Resumo Executivo
          </p>
          <p className="text-sm text-[#d8c3ac] leading-relaxed whitespace-pre-line">
            {analysis.executive_summary}
          </p>
        </div>
      )}

      {/* Priority improvements - handles both string[] and object[] */}
      {analysis.priority_improvements.length > 0 && (
        <div>
          <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-2">
            Melhorias Prioritárias
          </p>
          <ul className="space-y-2">
            {(analysis.priority_improvements as unknown[]).slice(0, 5).map((item, i) => {
              const obj = typeof item === "object" && item !== null ? item as Record<string, unknown> : null
              return (
                <li key={i} className="text-sm text-[#d8c3ac] bg-[#121316]/50 rounded-lg p-3">
                  <div className="flex items-start gap-2">
                    <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[#ffa600]/10 text-[9px] font-bold text-[#ffa600] mt-0.5">
                      {obj?.priority != null ? String(obj.priority) : i + 1}
                    </span>
                    <div className="flex-1 space-y-1">
                      {obj?.stage != null && (
                        <span className="text-[10px] font-bold uppercase tracking-wider text-[#ffa600]/70">
                          {String(obj.stage)}
                        </span>
                      )}
                      <p className="text-sm text-[#d8c3ac]">
                        {obj ? String(obj.issue || obj.text || obj.description || JSON.stringify(obj)) : String(item)}
                      </p>
                      {obj?.recommended_action != null && (
                        <p className="text-xs text-stone-500 mt-1">
                          <span className="text-emerald-400/70 font-bold">Ação:</span>{" "}
                          {String(obj.recommended_action)}
                        </p>
                      )}
                    </div>
                  </div>
                </li>
              )
            })}
          </ul>
        </div>
      )}

      {/* Training actions */}
      {(analysis.training_actions as unknown[])?.length > 0 && (
        <div>
          <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-2">
            Ações de Treinamento
          </p>
          <ul className="space-y-2">
            {(analysis.training_actions as unknown[]).slice(0, 5).map((item, i) => {
              const obj = typeof item === "object" && item !== null ? item as Record<string, unknown> : null
              return (
                <li key={i} className="text-sm text-[#d8c3ac] bg-[#121316]/50 rounded-lg p-3">
                  <div className="flex items-start gap-2">
                    <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-emerald-500/10 text-[9px] font-bold text-emerald-400 mt-0.5">
                      {i + 1}
                    </span>
                    <div className="flex-1 space-y-1">
                      {obj?.type != null && (
                        <span className="text-[10px] font-bold uppercase tracking-wider text-emerald-400/70">
                          {String(obj.type)}{obj.focus ? ` — ${String(obj.focus)}` : ""}
                        </span>
                      )}
                      <p className="text-sm text-[#d8c3ac]">
                        {obj ? String(obj.description || obj.recommendation || obj.text || JSON.stringify(obj)) : String(item)}
                      </p>
                      {obj?.responsible != null && (
                        <p className="text-xs text-stone-500">
                          <span className="text-[#ffa600]/70 font-bold">Responsável:</span> {String(obj.responsible)}
                          {obj.deadline_days ? ` · ${String(obj.deadline_days)} dias` : ""}
                        </p>
                      )}
                    </div>
                  </div>
                </li>
              )
            })}
          </ul>
        </div>
      )}

      {/* Objections detected */}
      {(analysis.objections_detected as unknown[])?.length > 0 && (
        <div>
          <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-2">
            Objeções Detectadas
          </p>
          <ul className="space-y-2">
            {(analysis.objections_detected as unknown[]).map((item, i) => {
              const obj = typeof item === "object" && item !== null ? item as Record<string, unknown> : null
              const handled = obj?.handled === true
              return (
                <li key={i} className="text-sm bg-[#121316]/50 rounded-lg p-3">
                  <div className="flex items-start gap-2">
                    <span className={`material-symbols-outlined text-sm mt-0.5 ${handled ? "text-emerald-400" : "text-red-400"}`}>
                      {handled ? "check_circle" : "cancel"}
                    </span>
                    <div className="flex-1 space-y-1">
                      <div className="flex items-center gap-2">
                        {obj?.type != null && (
                          <span className="text-[10px] font-bold uppercase tracking-wider text-[#ffa600]/70">
                            {String(obj.type)}
                          </span>
                        )}
                        {obj?.handling_quality != null && (
                          <span className={`text-[10px] px-1.5 py-0.5 rounded ${
                            obj.handling_quality === "Insuficiente" || obj.handling_quality === "Não tratada"
                              ? "bg-red-500/10 text-red-400"
                              : "bg-emerald-500/10 text-emerald-400"
                          }`}>
                            {String(obj.handling_quality)}
                          </span>
                        )}
                      </div>
                      {obj?.verbatim != null && (
                        <p className="text-sm text-stone-400 italic">&ldquo;{String(obj.verbatim)}&rdquo;</p>
                      )}
                      {obj?.notes != null && (
                        <p className="text-xs text-stone-500">{String(obj.notes)}</p>
                      )}
                    </div>
                  </div>
                </li>
              )
            })}
          </ul>
        </div>
      )}
    </div>
  )
}
