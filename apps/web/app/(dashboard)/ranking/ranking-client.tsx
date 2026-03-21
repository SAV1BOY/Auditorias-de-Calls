"use client"

import { useState, useTransition } from "react"
import { getLeaderboard } from "@/lib/actions/gamification"
import type {
  BadgeRow,
  CompetitionWithStandings,
  LeaderboardEntry,
} from "@/lib/types/audit"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { LeaderboardTable } from "@/components/gamification/leaderboard-table"
import { LeaderboardFilters } from "@/components/gamification/leaderboard-filters"
import { BadgeGrid } from "@/components/gamification/badge-grid"
import { CompetitionCard } from "@/components/gamification/competition-card"
import { CompetitionForm } from "@/components/gamification/competition-form"
import { Trophy, Award } from "lucide-react"

interface RankingClientProps {
  initialEntries: LeaderboardEntry[]
  competitions: CompetitionWithStandings[]
  badges: BadgeRow[]
  earnedBadgeIds: string[]
}

export function RankingClient({
  initialEntries,
  competitions,
  badges,
  earnedBadgeIds,
}: RankingClientProps) {
  const [entries, setEntries] = useState(initialEntries)
  const [period, setPeriod] = useState("week")
  const [metric, setMetric] = useState("score_avg")
  const [isPending, startTransition] = useTransition()

  function handlePeriodChange(newPeriod: string) {
    setPeriod(newPeriod)
    refetch(newPeriod, metric)
  }

  function handleMetricChange(newMetric: string) {
    setMetric(newMetric)
    refetch(period, newMetric)
  }

  function refetch(p: string, m: string) {
    startTransition(async () => {
      const data = await getLeaderboard(
        p as "week" | "month" | "all",
        m as "score_avg" | "volume" | "taxa_fechamento"
      )
      setEntries(data)
    })
  }

  return (
    <div className="space-y-6">
      {/* Leaderboard */}
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-4">
          <div className="flex items-center gap-2">
            <Trophy className="h-5 w-5 text-yellow-500" />
            <CardTitle className="text-lg">Leaderboard</CardTitle>
          </div>
          <LeaderboardFilters
            period={period}
            metric={metric}
            onPeriodChange={handlePeriodChange}
            onMetricChange={handleMetricChange}
          />
        </CardHeader>
        <CardContent>
          <div className={isPending ? "opacity-50 pointer-events-none" : ""}>
            <LeaderboardTable entries={entries} />
          </div>
        </CardContent>
      </Card>

      {/* Competitions */}
      <div>
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold">Competições</h2>
          <CompetitionForm />
        </div>
        {competitions.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12 text-muted-foreground">
              <Trophy className="h-8 w-8 mb-2" />
              <p>Nenhuma competição ativa.</p>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-4 md:grid-cols-2">
            {competitions.map((comp) => (
              <CompetitionCard key={comp.id} competition={comp} />
            ))}
          </div>
        )}
      </div>

      {/* Badges Catalog */}
      <Card>
        <CardHeader>
          <div className="flex items-center gap-2">
            <Award className="h-5 w-5 text-primary" />
            <CardTitle className="text-lg">Badges</CardTitle>
          </div>
        </CardHeader>
        <CardContent>
          <BadgeGrid badges={badges} earnedBadgeIds={earnedBadgeIds} />
        </CardContent>
      </Card>
    </div>
  )
}
