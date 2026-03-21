import { getLeaderboard, getCompetitions, getAllBadges, getAllEarnedBadgeIds } from "@/lib/actions/gamification"
import { RankingClient } from "./ranking-client"

export default async function RankingPage() {
  const [leaderboard, competitions, badges, earnedBadgeIds] = await Promise.all([
    getLeaderboard("week", "score_avg"),
    getCompetitions(),
    getAllBadges(),
    getAllEarnedBadgeIds(),
  ])

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold tracking-tight">Ranking</h1>
      <RankingClient
        initialEntries={leaderboard}
        competitions={competitions}
        badges={badges}
        earnedBadgeIds={earnedBadgeIds}
      />
    </div>
  )
}
