import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"

interface ClassificacaoChartProps {
  stats: {
    elite: number
    forte: number
    mediana: number
    fraca: number
  }
}

const items = [
  { key: "elite" as const, label: "ELITE", color: "bg-emerald-500" },
  { key: "forte" as const, label: "FORTE", color: "bg-blue-500" },
  { key: "mediana" as const, label: "MEDIANA", color: "bg-amber-500" },
  { key: "fraca" as const, label: "FRACA", color: "bg-red-500" },
]

export function ClassificacaoChart({ stats }: ClassificacaoChartProps) {
  const total = stats.elite + stats.forte + stats.mediana + stats.fraca

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Por Classificação</CardTitle>
      </CardHeader>
      <CardContent className="space-y-3">
        {items.map(({ key, label, color }) => {
          const count = stats[key]
          const pct = total > 0 ? (count / total) * 100 : 0
          return (
            <div key={key} className="space-y-1">
              <div className="flex items-center justify-between text-sm">
                <span className="font-medium">{label}</span>
                <span className="text-muted-foreground">{count}</span>
              </div>
              <div className="h-2 rounded-full bg-muted">
                <div
                  className={`h-2 rounded-full ${color}`}
                  style={{ width: `${pct}%` }}
                />
              </div>
            </div>
          )
        })}
      </CardContent>
    </Card>
  )
}
