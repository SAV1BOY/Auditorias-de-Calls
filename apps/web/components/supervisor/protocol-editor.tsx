"use client"

import { useState, useTransition } from "react"
import type { ProtocolRule } from "@/lib/types/supervisor"
import { updateProtocolRule } from "@/lib/actions/supervisor"
import { useToast } from "@/components/ui/use-toast"

interface ProtocolEditorProps {
  rules: ProtocolRule[]
}

export function ProtocolEditor({ rules }: ProtocolEditorProps) {
  const [expandedId, setExpandedId] = useState<string | null>(null)
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  function handleToggleActive(rule: ProtocolRule) {
    startTransition(async () => {
      const result = await updateProtocolRule(rule.id, { is_active: !rule.is_active })
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: rule.is_active ? "Etapa desativada" : "Etapa ativada" })
      }
    })
  }

  return (
    <div className="space-y-3">
      {rules.map((rule) => (
        <div
          key={rule.id}
          className={`bg-[#1a1c1e] rounded-xl border transition-all ${
            rule.is_active ? "border-white/5 hover:border-[#ffa600]/20" : "border-white/5 opacity-50"
          }`}
        >
          <div
            className="p-4 flex items-center justify-between cursor-pointer"
            onClick={() => setExpandedId(expandedId === rule.id ? null : rule.id)}
          >
            <div className="flex items-center gap-3">
              <span className="font-headline font-bold text-xs text-stone-500 w-6 text-center">
                {rule.stage_order}
              </span>
              <span className="font-headline font-bold text-sm">{rule.stage_name}</span>
              <span className="text-[10px] text-stone-500 font-label uppercase tracking-widest">
                Peso: {(rule.scoring_weight * 100).toFixed(0)}%
              </span>
            </div>
            <div className="flex items-center gap-2">
              <button
                onClick={(e) => { e.stopPropagation(); handleToggleActive(rule) }}
                disabled={isPending}
                className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${
                  rule.is_active
                    ? "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
                    : "bg-red-500/10 text-red-500 border-red-500/20"
                }`}
              >
                {rule.is_active ? "Ativo" : "Inativo"}
              </button>
              <span className="material-symbols-outlined text-stone-500 text-sm">
                {expandedId === rule.id ? "expand_less" : "expand_more"}
              </span>
            </div>
          </div>

          {expandedId === rule.id && (
            <div className="px-4 pb-4 space-y-3 border-t border-white/5 pt-3">
              <div>
                <p className="text-[10px] font-label uppercase tracking-widest text-emerald-400 mb-1">
                  Comportamentos Esperados
                </p>
                <ul className="space-y-1">
                  {rule.expected_behaviors.map((b, i) => (
                    <li key={i} className="text-sm text-[#d8c3ac] flex items-start gap-2">
                      <span className="material-symbols-outlined text-emerald-500 text-xs mt-0.5">check</span>
                      {b}
                    </li>
                  ))}
                </ul>
              </div>
              <div>
                <p className="text-[10px] font-label uppercase tracking-widest text-red-400 mb-1">
                  Comportamentos de Falha
                </p>
                <ul className="space-y-1">
                  {rule.failure_behaviors.map((b, i) => (
                    <li key={i} className="text-sm text-stone-400 flex items-start gap-2">
                      <span className="material-symbols-outlined text-red-500 text-xs mt-0.5">close</span>
                      {b}
                    </li>
                  ))}
                </ul>
              </div>
              <p className="text-[10px] text-stone-600">
                Versão: {rule.version} | ID: {rule.id.slice(0, 8)}...
              </p>
            </div>
          )}
        </div>
      ))}
    </div>
  )
}
