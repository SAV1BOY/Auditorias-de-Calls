"use client"

import type { CompetitionWithStandings } from "@/lib/types/audit"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { Trophy, Medal, Calendar } from "lucide-react"
import { cn } from "@/lib/utils"

interface CompetitionCardProps {
  competition: CompetitionWithStandings
}

const METRIC_LABELS: Record<string, string> = {
  score_avg: "Média de Score",
  volume: "Volume de Calls",
  taxa_fechamento: "Taxa de Fechamento",
}

const STATUS_LABELS: Record<string, string> = {
  active: "Em andamento",
  upcoming: "Programada",
  completed: "Finalizada",
}

const STATUS_COLORS: Record<string, string> = {
  active: "text-green-600 bg-green-50",
  upcoming: "text-blue-600 bg-blue-50",
  completed: "text-gray-600 bg-gray-50",
}

function formatDate(d: string) {
  return new Date(d + "T00:00:00").toLocaleDateString("pt-BR", {
    day: "2-digit",
    month: "short",
  })
}

export function CompetitionCard({ competition }: CompetitionCardProps) {
  const top3 = competition.standings.slice(0, 3)

  return (
    <Card>
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between">
          <div>
            <CardTitle className="text-base">{competition.title}</CardTitle>
            {competition.description && (
              <CardDescription className="mt-1">
                {competition.description}
              </CardDescription>
            )}
          </div>
          <span
            className={cn(
              "rounded-full px-2 py-0.5 text-xs font-medium",
              STATUS_COLORS[competition.status] ?? "text-gray-600 bg-gray-50"
            )}
          >
            {STATUS_LABELS[competition.status] ?? competition.status}
          </span>
        </div>
        <div className="flex items-center gap-4 text-xs text-muted-foreground mt-2">
          <div className="flex items-center gap-1">
            <Calendar className="h-3 w-3" />
            {formatDate(competition.start_date)} - {formatDate(competition.end_date)}
          </div>
          <span>{METRIC_LABELS[competition.metric] ?? competition.metric}</span>
        </div>
      </CardHeader>
      <CardContent>
        {top3.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            Nenhum participante ainda.
          </p>
        ) : (
          <div className="space-y-2">
            {top3.map((standing) => (
              <div
                key={standing.closer_id}
                className="flex items-center justify-between rounded-md px-2 py-1.5"
              >
                <div className="flex items-center gap-2">
                  {standing.rank === 1 ? (
                    <Trophy className="h-4 w-4 text-yellow-500" />
                  ) : (
                    <Medal
                      className={cn(
                        "h-4 w-4",
                        standing.rank === 2
                          ? "text-gray-400"
                          : "text-amber-600"
                      )}
                    />
                  )}
                  <span className="text-sm font-medium">
                    {standing.closer_name}
                  </span>
                </div>
                <span className="text-sm font-semibold tabular-nums">
                  {standing.value}
                </span>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  )
}
