import { getDashboardStats, getRecentCalls } from "@/lib/actions/calls"
import { StatsCards } from "@/components/dashboard/stats-cards"
import { RecentCalls } from "@/components/dashboard/recent-calls"
import { ScoreChart } from "@/components/dashboard/score-chart"
import { ClassificacaoChart } from "@/components/dashboard/classificacao-chart"

export default async function DashboardPage() {
  const [stats, recentCalls] = await Promise.all([
    getDashboardStats(),
    getRecentCalls(),
  ])

  return (
    <div className="space-y-6">
      <StatsCards stats={stats} />
      <div className="grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <ScoreChart data={stats.evolucaoScore} />
        </div>
        <ClassificacaoChart stats={stats.porClassificacao} />
      </div>
      <RecentCalls calls={recentCalls} />
    </div>
  )
}
