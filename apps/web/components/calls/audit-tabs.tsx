import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import type { CallAuditWithCloser } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { formatScore } from "@/lib/utils/format"
import { getScoreColor } from "@/lib/utils/colors"

interface AuditTabsProps {
  audit: CallAuditWithCloser
}

function ScorecardContent({ audit }: { audit: CallAuditWithCloser }) {
  const hasDimensions = DIMENSIONS.some(
    (d) => (audit as unknown as Record<string, unknown>)[d.id] != null
  )

  if (!hasDimensions) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Scorecard ainda não disponível. A análise precisa ser concluída.
      </p>
    )
  }

  return (
    <div className="space-y-3">
      {DIMENSIONS.map((dim) => {
        const score = (audit as unknown as Record<string, unknown>)[dim.id] as
          | number
          | null
        return (
          <div key={dim.id} className="space-y-1">
            <div className="flex items-center justify-between text-sm">
              <span>{dim.name}</span>
              <span className={`font-medium ${getScoreColor(score)}`}>
                {formatScore(score)}
              </span>
            </div>
            <div className="h-2 rounded-full bg-muted">
              <div
                className={`h-2 rounded-full ${
                  score !== null && score !== undefined
                    ? score >= 8.5
                      ? "bg-emerald-500"
                      : score >= 7.0
                        ? "bg-blue-500"
                        : score >= 5.5
                          ? "bg-amber-500"
                          : "bg-red-500"
                    : "bg-gray-300"
                }`}
                style={{ width: `${((score ?? 0) / 10) * 100}%` }}
              />
            </div>
          </div>
        )
      })}
    </div>
  )
}

function PlaceholderContent({ section }: { section: string }) {
  return (
    <p className="py-8 text-center text-muted-foreground">
      {section} — disponível no Sprint 5.
    </p>
  )
}

export function AuditTabs({ audit }: AuditTabsProps) {
  return (
    <Tabs defaultValue="scorecard">
      <TabsList className="flex-wrap">
        <TabsTrigger value="scorecard">Scorecard</TabsTrigger>
        <TabsTrigger value="relatorio">Relatório</TabsTrigger>
        <TabsTrigger value="transcricao">Transcrição</TabsTrigger>
        <TabsTrigger value="erros">Erros & Acertos</TabsTrigger>
        <TabsTrigger value="reescrita">Reescrita</TabsTrigger>
        <TabsTrigger value="plano">Plano de Ação</TabsTrigger>
      </TabsList>

      <TabsContent value="scorecard">
        <Card>
          <CardHeader>
            <CardTitle>Scorecard — 13 Dimensões</CardTitle>
          </CardHeader>
          <CardContent>
            <ScorecardContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="relatorio">
        <Card>
          <CardContent className="pt-6">
            <PlaceholderContent section="Relatório completo" />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="transcricao">
        <Card>
          <CardContent className="pt-6">
            <PlaceholderContent section="Transcrição com busca" />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="erros">
        <Card>
          <CardContent className="pt-6">
            <PlaceholderContent section="Top Erros & Acertos" />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="reescrita">
        <Card>
          <CardContent className="pt-6">
            <PlaceholderContent section="Reescrita de Falas" />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="plano">
        <Card>
          <CardContent className="pt-6">
            <PlaceholderContent section="Plano de Ação" />
          </CardContent>
        </Card>
      </TabsContent>
    </Tabs>
  )
}
