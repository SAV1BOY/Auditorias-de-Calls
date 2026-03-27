import type { DashboardStats } from "@/lib/types/audit"
import { formatScore } from "@/lib/utils/format"

interface KpiCardProps {
  icon: string
  label: string
  value: string
  unit?: string
  statusLabel?: string
  progress?: number
}

function KpiCard({ icon, label, value, unit, statusLabel, progress }: KpiCardProps) {
  return (
    <div className="bg-[#1a1c1e]/85 backdrop-blur-sm p-6 rounded-xl border border-white/[0.08] hover:border-[#ffa600]/30 transition-all group shadow-[0_40px_40px_-10px_rgba(0,0,0,0.4)]">
      <div className="flex justify-between items-start mb-4">
        <span className="material-symbols-outlined text-[#ffa600] bg-[#ffa600]/10 p-3 rounded-xl text-2xl">
          {icon}
        </span>
        {statusLabel && (
          <span className="font-label text-[10px] text-[#ffa600] font-bold tracking-[0.2em] uppercase">
            {statusLabel}
          </span>
        )}
      </div>
      <h3 className="font-label text-stone-500 text-[11px] tracking-widest uppercase font-bold mb-1">
        {label}
      </h3>
      <div className="flex items-baseline gap-1">
        <span className="text-3xl font-headline font-bold group-hover:text-[#ffa600] transition-colors">
          {value}
        </span>
        {unit && (
          <span className="text-xl font-headline font-bold text-[#ffa600]/50">{unit}</span>
        )}
      </div>
      {progress !== undefined && (
        <div className="mt-4 h-1 w-full bg-[#343538] rounded-full overflow-hidden">
          <div
            className="bg-[#ffa600] h-full transition-all duration-500"
            style={{ width: `${Math.min(progress, 100)}%` }}
          />
        </div>
      )}
    </div>
  )
}

interface StatsCardsProps {
  stats: DashboardStats
}

export function StatsCards({ stats }: StatsCardsProps) {
  return (
    <section className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <KpiCard
        icon="phone_in_talk"
        label="Total Calls"
        value={String(stats.totalCalls || 0)}
        statusLabel="Audited"
        progress={100}
      />
      <KpiCard
        icon="analytics"
        label="Score Médio"
        value={formatScore(stats.mediaScore)}
        unit="/10"
        statusLabel="Global"
        progress={(stats.mediaScore || 0) * 10}
      />
      <KpiCard
        icon="handshake"
        label="Taxa Fechamento"
        value={stats.taxaFechamento !== null ? stats.taxaFechamento.toFixed(1) : "—"}
        unit="%"
        statusLabel="Conversão"
        progress={stats.taxaFechamento || 0}
      />
      <KpiCard
        icon="calendar_today"
        label="Calls Semana"
        value={String(stats.callsEstaSemana || 0)}
        statusLabel="This Week"
        progress={Math.min((stats.callsEstaSemana || 0) * 10, 100)}
      />
    </section>
  )
}
