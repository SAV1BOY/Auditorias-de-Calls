import { createClient } from "@/lib/supabase/server"
import { StatsCards } from "@/components/dashboard/stats-cards"
import { RecentCalls } from "@/components/dashboard/recent-calls"
import type { DashboardStats, CallAuditWithCloser } from "@/lib/types/audit"
import type { Database } from "@/lib/types/database"

type CallAuditRow = Database["public"]["Tables"]["call_audits"]["Row"]

async function getDashboardStats(): Promise<DashboardStats> {
  const supabase = await createClient()

  const { data: audits } = await supabase.from("call_audits").select("*")

  const all: CallAuditRow[] = audits ?? []
  const completed = all.filter((a) => a.status === "completed")
  const withScore = completed.filter((a) => a.score_final !== null)

  const today = new Date()
  const weekAgo = new Date(today)
  weekAgo.setDate(weekAgo.getDate() - 7)
  const weekAgoStr = weekAgo.toISOString().split("T")[0]

  const callsEstaSemana = all.filter((a) => a.call_date >= weekAgoStr).length

  const mediaScore =
    withScore.length > 0
      ? withScore.reduce((sum, a) => sum + (a.score_final ?? 0), 0) /
        withScore.length
      : null

  const withResultado = all.filter((a) => a.resultado !== null)
  const fechamentos = all.filter((a) => a.resultado === "fechamento").length
  const taxaFechamento =
    withResultado.length > 0
      ? (fechamentos / withResultado.length) * 100
      : null

  return {
    totalCalls: all.length,
    mediaScore,
    taxaFechamento,
    callsEstaSemana,
    porClassificacao: {
      elite: all.filter((a) => a.classificacao === "ELITE").length,
      forte: all.filter((a) => a.classificacao === "FORTE").length,
      mediana: all.filter((a) => a.classificacao === "MEDIANA").length,
      fraca: all.filter((a) => a.classificacao === "FRACA").length,
    },
  }
}

async function getRecentCalls(): Promise<CallAuditWithCloser[]> {
  const supabase = await createClient()

  const { data } = await supabase
    .from("call_audits")
    .select("*, closers(name)")
    .order("call_date", { ascending: false })
    .limit(10)

  return (data as unknown as CallAuditWithCloser[]) ?? []
}

export default async function DashboardPage() {
  const [stats, recentCalls] = await Promise.all([
    getDashboardStats(),
    getRecentCalls(),
  ])

  return (
    <div className="space-y-6">
      <StatsCards stats={stats} />
      <RecentCalls calls={recentCalls} />
    </div>
  )
}
