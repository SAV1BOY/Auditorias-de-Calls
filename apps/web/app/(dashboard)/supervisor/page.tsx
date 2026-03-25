import { getSupervisorDashboardStats } from "@/lib/actions/supervisor"
import { SupervisorDashboard } from "@/components/supervisor/supervisor-dashboard"

export default async function SupervisorPage() {
  const stats = await getSupervisorDashboardStats()

  return (
    <div className="space-y-12">
      <header className="max-w-4xl">
        <h1 className="font-headline text-5xl md:text-6xl font-extrabold tracking-tighter leading-none mb-4">
          Supervisor <span className="text-[#ffa600] uppercase">ANALYSIS</span>
        </h1>
        <p className="font-body text-xl text-[#d8c3ac] max-w-2xl">
          Avaliação contra o protocolo System Digital. 16 etapas, pactos, SPIN,
          ancoragem, negociação e down sell.
        </p>
      </header>

      <SupervisorDashboard stats={stats} />
    </div>
  )
}
