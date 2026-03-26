"use client"

import { useState, useTransition } from "react"
import { useToast } from "@/components/ui/use-toast"
import { updateDimensionWeights } from "@/lib/actions/settings"
import { DIMENSIONS } from "@/lib/utils/constants"
import { AmberGlassButton } from "@/components/ui/amber-glass-button"

interface DimensionWeightsEditorProps {
  weights: Record<string, number>
}

export function DimensionWeightsEditor({ weights: initialWeights }: DimensionWeightsEditorProps) {
  const [weights, setWeights] = useState(initialWeights)
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  const total = Object.values(weights).reduce((a, b) => a + b, 0)
  const isValid = Math.abs(total - 100) < 0.1

  function handleChange(key: string, value: string) {
    const num = parseFloat(value)
    if (!isNaN(num) && num >= 0 && num <= 100) {
      setWeights((prev) => ({ ...prev, [key]: num }))
    }
  }

  function handleSave() {
    startTransition(async () => {
      const result = await updateDimensionWeights(weights)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: "Pesos salvos com sucesso" })
      }
    })
  }

  return (
    <div className="space-y-4">
      <div className="grid gap-3">
        {DIMENSIONS.map((dim) => (
          <div key={dim.id} className="flex items-center justify-between gap-4">
            <span className="text-sm font-body flex-1 min-w-0 truncate">{dim.name}</span>
            <div className="flex items-center gap-2">
              <input
                type="number"
                min="0"
                max="100"
                step="1"
                value={weights[dim.id] ?? dim.peso * 100}
                onChange={(e) => handleChange(dim.id, e.target.value)}
                className="w-16 bg-surface-container-high border border-transparent rounded px-2 py-1 text-sm text-center font-body focus:border-primary/30 focus:ring-1 focus:ring-ring focus:outline-none"
              />
              <span className="text-xs text-muted-foreground w-4">%</span>
            </div>
          </div>
        ))}
      </div>

      <div className="flex items-center justify-between pt-2 border-t border-white/5">
        <span className={`text-sm font-bold ${isValid ? "text-emerald-400" : "text-red-400"}`}>
          Total: {total.toFixed(0)}%
        </span>
        <AmberGlassButton onClick={handleSave} disabled={!isValid || isPending}>
          {isPending ? "Salvando..." : "Salvar Pesos"}
        </AmberGlassButton>
      </div>
    </div>
  )
}
