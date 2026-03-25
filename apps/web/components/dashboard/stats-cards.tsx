import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Phone, Target, TrendingUp, Calendar } from "lucide-react"
import type { DashboardStats } from "@/lib/types/audit"
import { formatScore } from "@/lib/utils/format"

interface StatsCardsProps {
  stats: DashboardStats
}

export function StatsCards({ stats }: StatsCardsProps) {
  const cards = [
    {
      title: "Total de Calls",
      value: stats.totalCalls.toString(),
      icon: Phone,
    },
    {
      title: "Score M\u00e9dio",
      value: formatScore(stats.mediaScore),
      icon: Target,
    },
    {
      title: "Taxa de Fechamento",
      value:
        stats.taxaFechamento !== null
          ? `${stats.taxaFechamento.toFixed(0)}%`
          : "\u2014",
      icon: TrendingUp,
    },
    {
      title: "Calls Esta Semana",
      value: stats.callsEstaSemana.toString(),
      icon: Calendar,
    },
  ]

  return (
    <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
      {cards.map((card) => (
        <Card key={card.title}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium font-technical text-muted-foreground">
              {card.title}
            </CardTitle>
            <card.icon className="h-5 w-5 text-primary/60" />
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold font-technical text-accent-foreground">{card.value}</div>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}
