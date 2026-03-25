"use client"

import Link from "next/link"
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from "recharts"
import type { SupervisorDashboardStats } from "@/lib/types/supervisor"
import { getSupervisorClassificationColor } from "@/lib/types/supervisor"

interface SupervisorDashboardProps {
  stats: SupervisorDashboardStats
}

const CHART_TOOLTIP = {
  contentStyle: {
    backgroundColor: "#292a2d",
    border: "1px solid rgba(255,255,255,0.05)",
    borderRadius: "0.75rem",
    fontSize: 12,
  },
  labelStyle: { color: "#ffa600", fontWeight: "bold" },
  itemStyle: { color: "#e3e2e5" },
}

function barColor(score: number): string {
  if (score >= 8) return "#22c55e"
  if (score >= 6) return "#ffa600"
  if (score >= 4) return "#fbbf24"
  return "#ef4444"
}

export function SupervisorDashboard({ stats }: SupervisorDashboardProps) {
  const chartData = stats.weakest_stages.map((s) => ({
    name: s.stage_name.length > 15 ? s.stage_name.slice(0, 12) + "..." : s.stage_name,
    fullName: s.stage_name,
    score: s.avg_score,
    criticals: s.critical_count,
  }))

  return (
    <div className="space-y-8">
      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <KpiCard icon="analytics" label="Total Análises" value={String(stats.total_analyses)} />
        <KpiCard
          icon="speed"
          label="Score Médio"
          value={stats.avg_score?.toFixed(1) ?? "—"}
          unit="/10"
        />
        <KpiCard
          icon="verified"
          label="Excelentes + Boas"
          value={String(stats.by_classification.excelente + stats.by_classification.boa)}
        />
        <KpiCard
          icon="warning"
          label="Fracas + Críticas"
          value={String(stats.by_classification.fraca + stats.by_classification.critica)}
        />
      </div>

      {/* Weakest Stages Chart */}
      {chartData.length > 0 && (
        <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8">
          <h3 className="font-headline font-bold text-lg mb-6">
            Weakest <span className="text-[#ffa600]">STAGES</span>
          </h3>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={chartData} layout="vertical" margin={{ left: 20, right: 20 }}>
              <CartesianGrid stroke="rgba(255,255,255,0.05)" strokeDasharray="3 3" horizontal={false} />
              <XAxis type="number" domain={[0, 10]} tick={{ fill: "#7f8c8d", fontSize: 10 }} axisLine={false} tickLine={false} />
              <YAxis type="category" dataKey="name" width={140} tick={{ fill: "#d8c3ac", fontSize: 11 }} axisLine={false} tickLine={false} />
              <Tooltip
                {...CHART_TOOLTIP}
                formatter={(value) => [Number(value).toFixed(1), "Score"]}
                labelFormatter={(_, payload) => payload?.[0]?.payload?.fullName ?? ""}
              />
              <Bar dataKey="score" radius={[0, 4, 4, 0]}>
                {chartData.map((entry, i) => (
                  <Cell key={i} fill={barColor(entry.score)} />
                ))}
              </Bar>
            </BarChart>
          </ResponsiveContainer>
        </div>
      )}

      {/* Recent Analyses */}
      {stats.recent_analyses.length > 0 && (
        <div className="bg-[#1a1c1e] rounded-xl border border-white/5 overflow-hidden">
          <div className="p-6 border-b border-white/5 flex justify-between items-center">
            <h3 className="font-headline font-bold text-lg">
              Recent <span className="text-[#ffa600]">ANALYSES</span>
            </h3>
            <Link href="/supervisor/analyze">
              <button className="bg-[#ffa600] text-[#2a1800] px-4 py-2 rounded-lg text-[10px] font-bold tracking-[0.2em] uppercase hover:brightness-110 transition-all">
                Nova Análise
              </button>
            </Link>
          </div>
          <table className="w-full text-left border-collapse">
            <thead className="bg-[#292a2d]/30 text-stone-500 text-[10px] font-bold uppercase tracking-[0.2em] border-b border-white/5">
              <tr>
                <th className="px-6 py-3">Closer</th>
                <th className="px-6 py-3">Lead</th>
                <th className="px-6 py-3">Score</th>
                <th className="px-6 py-3">Class.</th>
              </tr>
            </thead>
            <tbody className="text-sm divide-y divide-white/5">
              {stats.recent_analyses.map((a) => (
                <Link key={a.id} href={`/supervisor/analysis/${a.id}`} className="contents">
                  <tr className="hover:bg-[#ffa600]/5 transition-colors cursor-pointer group">
                    <td className="px-6 py-3 font-bold group-hover:text-[#ffa600]">
                      {a.call_audits?.closers?.name ?? "—"}
                    </td>
                    <td className="px-6 py-3 text-[#e3e2e5]">
                      {a.call_audits?.lead_name ?? "—"}
                    </td>
                    <td className="px-6 py-3 font-headline font-bold text-[#ffa600]">
                      {a.overall_score?.toFixed(1) ?? "—"}
                    </td>
                    <td className="px-6 py-3">
                      {a.classification && (
                        <span className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${getSupervisorClassificationColor(a.classification)}`}>
                          {a.classification}
                        </span>
                      )}
                    </td>
                  </tr>
                </Link>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}

function KpiCard({ icon, label, value, unit }: { icon: string; label: string; value: string; unit?: string }) {
  return (
    <div className="bg-[#1a1c1e] p-6 rounded-xl border border-white/5 hover:border-[#ffa600]/30 transition-all group shadow-[0_40px_40px_-10px_rgba(0,0,0,0.4)]">
      <div className="flex justify-between items-start mb-4">
        <span className="material-symbols-outlined text-[#ffa600] bg-[#ffa600]/10 p-3 rounded-xl text-2xl">{icon}</span>
      </div>
      <h3 className="font-label text-stone-500 text-[11px] tracking-widest uppercase font-bold mb-1">{label}</h3>
      <div className="flex items-baseline gap-1">
        <span className="text-3xl font-headline font-bold group-hover:text-[#ffa600] transition-colors">{value}</span>
        {unit && <span className="text-xl font-headline font-bold text-[#ffa600]/50">{unit}</span>}
      </div>
    </div>
  )
}
