"use client"

import { useState, useTransition } from "react"
import { useRouter } from "next/navigation"
import { requestSupervisorAnalysis } from "@/lib/actions/supervisor"
import { useToast } from "@/components/ui/use-toast"

interface AnalyzeFormProps {
  calls: Array<{ id: string; lead_name: string; closer_name: string; call_date: string; status: string }>
}

export function AnalyzeForm({ calls }: AnalyzeFormProps) {
  const [selectedCallId, setSelectedCallId] = useState("")
  const [isPending, startTransition] = useTransition()
  const router = useRouter()
  const { toast } = useToast()

  const eligibleCalls = calls.filter(
    (c) => c.status === "completed" || c.status === "analyzed"
  )

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!selectedCallId) return

    startTransition(async () => {
      const result = await requestSupervisorAnalysis(selectedCallId)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: "Análise solicitada", description: "A análise do supervisor foi adicionada à fila." })
        router.push("/supervisor")
      }
    })
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8 space-y-6">
        <div>
          <label className="font-label text-[10px] uppercase tracking-widest font-bold text-stone-500 block mb-2">
            Selecionar Call
          </label>
          <select
            value={selectedCallId}
            onChange={(e) => setSelectedCallId(e.target.value)}
            className="w-full bg-[#292a2d] border border-white/5 rounded-lg px-4 py-3 text-sm text-[#e3e2e5] focus:border-[#ffa600]/50 focus:ring-1 focus:ring-[#ffa600]/50 focus:outline-none transition-all"
          >
            <option value="">Selecione uma call transcrita...</option>
            {eligibleCalls.map((call) => (
              <option key={call.id} value={call.id}>
                {call.closer_name} x {call.lead_name} — {call.call_date}
              </option>
            ))}
          </select>
          {eligibleCalls.length === 0 && (
            <p className="mt-2 text-xs text-stone-500">
              Nenhuma call com transcrição disponível. Faça upload e aguarde o processamento.
            </p>
          )}
        </div>

        <div className="bg-[#121316]/50 rounded-lg p-4 text-sm text-stone-400">
          <p className="flex items-center gap-2">
            <span className="material-symbols-outlined text-[#ffa600] text-lg">info</span>
            A análise do supervisor avalia a call contra o protocolo System Digital (16 etapas).
            O processamento leva aproximadamente 15-30 segundos.
          </p>
        </div>
      </div>

      <button
        type="submit"
        disabled={!selectedCallId || isPending}
        className="w-full bg-[#ffa600] text-[#2a1800] py-4 rounded-xl font-headline font-bold text-sm tracking-widest uppercase hover:brightness-110 active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed"
      >
        {isPending ? (
          <span className="flex items-center justify-center gap-2">
            <span className="material-symbols-outlined animate-spin text-lg">progress_activity</span>
            Processando...
          </span>
        ) : (
          <span className="flex items-center justify-center gap-2">
            <span className="material-symbols-outlined text-lg">play_arrow</span>
            Gerar Análise do Supervisor
          </span>
        )}
      </button>
    </form>
  )
}
