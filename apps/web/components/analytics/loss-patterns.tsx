"use client"

import { useState } from "react"
import { ChevronDown, ChevronUp, TrendingDown } from "lucide-react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import type { LossPatternReport } from "@/lib/types/audit"
import { PatternCard } from "./pattern-card"
import { ObjectionsChart } from "./objections-chart"
import { GeneratePatternButton } from "./generate-pattern-button"

interface LossPatternsProps {
  reports: LossPatternReport[]
}

export function LossPatterns({ reports }: LossPatternsProps) {
  const [expandedId, setExpandedId] = useState<string | null>(
    reports.length > 0 ? reports[0].id : null
  )

  function toggleExpand(id: string) {
    setExpandedId((prev) => (prev === id ? null : id))
  }

  return (
    <div className="space-y-6">
      {/* Header with generate button */}
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
        <div>
          <h2 className="text-lg font-semibold flex items-center gap-2">
            <TrendingDown className="h-5 w-5 text-red-500" />
            Padroes de Perda
          </h2>
          <p className="text-sm text-muted-foreground">
            Analise automatica de padroes em calls que nao resultaram em fechamento.
          </p>
        </div>
        <GeneratePatternButton />
      </div>

      {/* Reports list */}
      {reports.length === 0 ? (
        <Card>
          <CardContent className="py-8 text-center">
            <p className="text-muted-foreground">
              Nenhuma analise de padroes gerada ainda. Use o botao acima para iniciar.
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-4">
          {reports.map((report) => {
            const isExpanded = expandedId === report.id
            const formattedDate = new Date(report.generated_at).toLocaleDateString(
              "pt-BR",
              { day: "2-digit", month: "short", year: "numeric" }
            )

            return (
              <Card key={report.id}>
                <CardHeader
                  className="cursor-pointer"
                  onClick={() => toggleExpand(report.id)}
                >
                  <div className="flex items-center justify-between">
                    <div className="space-y-1">
                      <CardTitle className="text-base flex items-center gap-2">
                        Relatorio de {report.period_start} a {report.period_end}
                        <Badge variant="secondary" className="ml-2">
                          {report.total_lost_calls} calls perdidas
                        </Badge>
                        <Badge variant="outline">
                          {report.patterns.length} padroes
                        </Badge>
                      </CardTitle>
                      <p className="text-xs text-muted-foreground">
                        Gerado em {formattedDate}
                      </p>
                    </div>
                    <Button variant="ghost" size="icon">
                      {isExpanded ? (
                        <ChevronUp className="h-4 w-4" />
                      ) : (
                        <ChevronDown className="h-4 w-4" />
                      )}
                    </Button>
                  </div>
                </CardHeader>

                {isExpanded && (
                  <CardContent className="space-y-6">
                    {/* Pattern cards */}
                    {report.patterns.length > 0 && (
                      <div>
                        <h3 className="text-sm font-semibold mb-3">Padroes Identificados</h3>
                        <div className="grid gap-3 md:grid-cols-2">
                          {report.patterns.map((pattern, i) => (
                            <PatternCard key={i} pattern={pattern} />
                          ))}
                        </div>
                      </div>
                    )}

                    {/* Objections chart */}
                    {report.common_objections.length > 0 && (
                      <ObjectionsChart objections={report.common_objections} />
                    )}

                    {/* Weakest phases */}
                    {report.weakest_phases.length > 0 && (
                      <Card>
                        <CardHeader>
                          <CardTitle className="text-base">Fases Mais Fracas</CardTitle>
                        </CardHeader>
                        <CardContent>
                          <div className="space-y-2">
                            {report.weakest_phases.map((phase, i) => (
                              <div
                                key={i}
                                className="flex items-center justify-between rounded-md border p-3"
                              >
                                <span className="text-sm font-medium">{phase.phase}</span>
                                <Badge
                                  variant="outline"
                                  className={
                                    phase.avg_score < 5
                                      ? "text-red-600 border-red-300"
                                      : phase.avg_score < 7
                                        ? "text-yellow-600 border-yellow-300"
                                        : "text-green-600 border-green-300"
                                  }
                                >
                                  {phase.avg_score.toFixed(1)}
                                </Badge>
                              </div>
                            ))}
                          </div>
                        </CardContent>
                      </Card>
                    )}
                  </CardContent>
                )}
              </Card>
            )
          })}
        </div>
      )}
    </div>
  )
}
