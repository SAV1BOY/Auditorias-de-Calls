import { Card, CardContent } from "@/components/ui/card"
import { BarChart3, Target, TrendingUp, TrendingDown, Hash } from "lucide-react"
import { formatScore } from "@/lib/utils/format"
import { getScoreColor } from "@/lib/utils/colors"

interface CloserStatsProps {
  totalCalls: number
  mediaScore: number | null
  melhorScore: number | null
  piorScore: number | null
  fechamentos: number
}

export function CloserStats({
  totalCalls,
  mediaScore,
  melhorScore,
  piorScore,
  fechamentos,
}: CloserStatsProps) {
  const taxaFechamento =
    totalCalls > 0 ? Math.round((fechamentos / totalCalls) * 100) : null

  const stats = [
    {
      label: "Score Médio",
      value: formatScore(mediaScore),
      color: getScoreColor(mediaScore),
      icon: BarChart3,
    },
    {
      label: "Total de Calls",
      value: String(totalCalls),
      color: "",
      icon: Hash,
    },
    {
      label: "Taxa Fechamento",
      value: taxaFechamento !== null ? `${taxaFechamento}%` : "—",
      color: "",
      icon: Target,
    },
    {
      label: "Melhor Score",
      value: formatScore(melhorScore),
      color: getScoreColor(melhorScore),
      icon: TrendingUp,
    },
    {
      label: "Pior Score",
      value: formatScore(piorScore),
      color: getScoreColor(piorScore),
      icon: TrendingDown,
    },
  ]

  return (
    <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
      {stats.map((stat) => (
        <Card key={stat.label}>
          <CardContent className="pt-6">
            <div className="flex items-center gap-2">
              <stat.icon className="h-4 w-4 text-muted-foreground" />
              <p className="text-sm text-muted-foreground">{stat.label}</p>
            </div>
            <p className={`mt-1 text-2xl font-bold ${stat.color}`}>
              {stat.value}
            </p>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}
