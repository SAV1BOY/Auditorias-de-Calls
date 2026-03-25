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

      <RecentCalls calls={recentCalls} />
    </div>
  )
}
