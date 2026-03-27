"use client"

import { Badge } from "@/components/ui/badge"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import type { LossPattern } from "@/lib/types/audit"

const SEVERITY_CONFIG: Record<LossPattern["severity"], { label: string; className: string }> = {
  high: { label: "Alta", className: "bg-red-900/30 text-red-400" },
  medium: { label: "Média", className: "bg-yellow-900/30 text-yellow-400" },
  low: { label: "Baixa", className: "bg-emerald-900/30 text-emerald-400" },
}

interface PatternCardProps { pattern: LossPattern }

export function PatternCard({ pattern }: PatternCardProps) {
  const severity = SEVERITY_CONFIG[pattern.severity] ?? SEVERITY_CONFIG.medium
  return (
    <Card>
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between gap-2">
          <CardTitle className="text-sm font-semibold leading-snug">{pattern.pattern}</CardTitle>
          <Badge variant="outline" className={severity.className}>{severity.label}</Badge>
        </div>
      </CardHeader>
      <CardContent className="space-y-3 text-sm">
        <div className="flex items-center gap-4 text-muted-foreground"><span>Frequência: <strong className="text-foreground font-body">{pattern.frequency} calls</strong></span></div>
        {pattern.affected_closers.length > 0 && <div><span className="text-muted-foreground">Closers afetados: </span><span>{pattern.affected_closers.join(", ")}</span></div>}
        {pattern.recommendation && <div className="rounded-md bg-surface-container-high/50 p-3"><p className="text-xs font-medium text-muted-foreground mb-1">Recomendação</p><p className="text-sm">{pattern.recommendation}</p></div>}
      </CardContent>
    </Card>
  )
}
