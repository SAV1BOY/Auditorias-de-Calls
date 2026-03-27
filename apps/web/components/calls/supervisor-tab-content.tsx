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

      {/* Timeline */}
      {analysis.stages.length > 0 && <StageTimeline stages={analysis.stages} />}

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

      {/* Priority improvements */}
      {analysis.priority_improvements.length > 0 && (
        <div>
          <p className="text-[10px] font-label uppercase tracking-widest text-stone-500 mb-2">
            Melhorias Prioritárias
          </p>
          <ul className="space-y-1">
            {analysis.priority_improvements.slice(0, 3).map((item, i) => (
              <li key={i} className="text-sm text-[#d8c3ac] flex items-start gap-2">
                <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-[#ffa600]/10 text-[9px] font-bold text-[#ffa600]">
                  {i + 1}
                </span>
                {item}
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
