import Link from "next/link"
import type { CallAuditWithCloser } from "@/lib/types/audit"
import { formatDate, formatScore } from "@/lib/utils/format"
import { STATUS_LABELS } from "@/lib/utils/constants"

function ClassBadge({ c }: { c: string | null }) {
  const s: Record<string, string> = {
    ELITE: "bg-emerald-500/10 text-emerald-500 border-emerald-500/20",
    FORTE: "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20",
    MEDIANA: "bg-amber-400/10 text-amber-400 border-amber-400/20",
    FRACA: "bg-red-500/10 text-red-500 border-red-500/20",
  }
  if (!c) return <span className="text-stone-600">—</span>
  return (
    <span
      className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${s[c] || ""}`}
    >
      {c}
    </span>
  )
}

function StatusBadge({ s }: { s: string }) {
  const st: Record<string, string> = {
    completed: "bg-emerald-500/10 text-emerald-500 border-emerald-500/20",
    analyzing: "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20",
    transcribing: "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20",
    uploaded: "bg-[#97deff]/10 text-[#97deff] border-[#97deff]/20",
    error: "bg-red-500/10 text-red-500 border-red-500/20",
  }
  const label = STATUS_LABELS[s] ?? s
  return (
    <span
      className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${st[s] || "bg-[#343538] text-[#d8c3ac]"}`}
    >
      {label}
    </span>
  )
}

interface RecentCallsProps {
  calls: CallAuditWithCloser[]
}

export function RecentCalls({ calls }: RecentCallsProps) {
  return (
    <section className="space-y-6">
      <div className="flex justify-between items-end">
        <h3 className="text-2xl font-headline font-bold">
          Recent <span className="text-[#ffa600]">AUDITS</span>
        </h3>
      </div>
      {calls.length === 0 ? (
        <p className="py-12 text-center text-stone-500">
          Nenhuma call auditada ainda.
        </p>
      ) : (
        <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] overflow-hidden">
          <table className="w-full text-left border-collapse">
            <thead className="bg-[#292a2d]/30 text-stone-500 text-[10px] font-bold uppercase tracking-[0.2em] border-b border-white/5">
              <tr>
                <th className="px-6 py-4">Data</th>
                <th className="px-6 py-4">Closer</th>
                <th className="px-6 py-4">Lead</th>
                <th className="px-6 py-4">Score</th>
                <th className="px-6 py-4">Class.</th>
                <th className="px-6 py-4">Status</th>
              </tr>
            </thead>
            <tbody className="text-sm divide-y divide-white/5">
              {calls.map((call) => (
                <Link key={call.id} href={`/calls/${call.id}`} className="contents">
                  <tr className="hover:bg-[#ffa600]/5 transition-colors group cursor-pointer">
                    <td className="px-6 py-4 text-stone-500 font-mono text-xs">
                      {formatDate(call.call_date)}
                    </td>
                    <td className="px-6 py-4 font-bold group-hover:text-[#ffa600] transition-colors">
                      {call.closers?.name ?? "—"}
                    </td>
                    <td className="px-6 py-4 text-[#e3e2e5]">{call.lead_name}</td>
                    <td className="px-6 py-4 font-headline font-bold text-[#ffa600]">
                      {formatScore(call.score_final)}
                    </td>
                    <td className="px-6 py-4">
                      <ClassBadge c={call.classificacao} />
                    </td>
                    <td className="px-6 py-4">
                      <StatusBadge s={call.status} />
                    </td>
                  </tr>
                </Link>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </section>
  )
}
