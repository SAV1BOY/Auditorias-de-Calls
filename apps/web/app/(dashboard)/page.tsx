import { getDashboardStats, getRecentCalls } from "@/lib/actions/calls"
import { StatsCards } from "@/components/dashboard/stats-cards"
import { RecentCalls } from "@/components/dashboard/recent-calls"
import { ScoreChart } from "@/components/dashboard/score-chart"
import { ClassificacaoChart } from "@/components/dashboard/classificacao-chart"
import { GrowthMetrics } from "@/components/dashboard/growth-metrics"

export default async function DashboardPage() {
  const [stats, recentCalls] = await Promise.all([
    getDashboardStats(),
    getRecentCalls(),
  ])

  // Generate closing rate evolution data from score evolution
  const closingRateData = stats.evolucaoScore.map((point) => ({
    date: point.date,
    value: Math.round(point.score * 10), // approximate closing rate from score
  }))

  const closingRateValue = stats.taxaFechamento !== null
    ? `${stats.taxaFechamento.toFixed(1)}%`
    : "—"

  return (
    <div className="space-y-12">
      <header className="max-w-4xl">
        <h1 className="font-headline text-5xl md:text-6xl font-extrabold tracking-tighter leading-none mb-4">
          Call <span className="text-[#ffa600] uppercase">AUDITS</span>
        </h1>
        <p className="font-body text-xl text-[#d8c3ac] max-w-2xl">
          Auditoria automatizada de calls de fechamento. Score em 13 dimensões,
          10 frameworks especializados.
        </p>
      </header>

      <StatsCards stats={stats} />

      <section className="grid grid-cols-1 xl:grid-cols-3 gap-8">
        <div className="xl:col-span-2">
          <ScoreChart data={stats.evolucaoScore} />
        </div>
        <ClassificacaoChart stats={stats.porClassificacao} />
      </section>

      <GrowthMetrics
        data={closingRateData}
        value={closingRateValue}
        label="Closing Rate"
      />

      <RecentCalls calls={recentCalls} />
    </div>
  )
}
