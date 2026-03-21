"use client"

import { useState, useTransition } from "react"
import { Loader2, Search } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { useToast } from "@/components/ui/use-toast"
import { generateLossPatternAnalysis } from "@/lib/actions/loss-patterns"

export function GeneratePatternButton() {
  const today = new Date().toISOString().split("T")[0]
  const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000)
    .toISOString()
    .split("T")[0]

  const [dateFrom, setDateFrom] = useState(thirtyDaysAgo)
  const [dateTo, setDateTo] = useState(today)
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  function handleGenerate() {
    startTransition(async () => {
      const result = await generateLossPatternAnalysis(dateFrom, dateTo)

      if (result.error) {
        toast({
          title: "Erro",
          description: result.error,
          variant: "destructive",
        })
        return
      }

      toast({
        title: "Analise iniciada",
        description:
          "A analise de padroes de perda foi enfileirada. Os resultados aparecerao em alguns minutos.",
      })
    })
  }

  return (
    <div className="flex flex-col sm:flex-row items-start sm:items-end gap-3">
      <div className="space-y-1">
        <label htmlFor="lp-date-from" className="text-xs font-medium text-muted-foreground">
          De
        </label>
        <Input
          id="lp-date-from"
          type="date"
          value={dateFrom}
          onChange={(e) => setDateFrom(e.target.value)}
          className="w-40"
        />
      </div>
      <div className="space-y-1">
        <label htmlFor="lp-date-to" className="text-xs font-medium text-muted-foreground">
          Ate
        </label>
        <Input
          id="lp-date-to"
          type="date"
          value={dateTo}
          onChange={(e) => setDateTo(e.target.value)}
          className="w-40"
        />
      </div>
      <Button onClick={handleGenerate} disabled={isPending} size="sm">
        {isPending ? (
          <>
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            Gerando...
          </>
        ) : (
          <>
            <Search className="mr-2 h-4 w-4" />
            Gerar Analise
          </>
        )}
      </Button>
    </div>
  )
}
