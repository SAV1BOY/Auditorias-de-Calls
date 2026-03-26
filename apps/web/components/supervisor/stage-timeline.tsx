import type { SupervisorStageScore } from "@/lib/types/supervisor"

interface StageTimelineProps {
  stages: SupervisorStageScore[]
}

function statusColor(status: string): string {
  switch (status) {
    case "excellent": return "bg-emerald-500"
    case "ok": return "bg-[#ffa600]"
    case "warning": return "bg-amber-400"
    case "critical": return "bg-red-500"
    case "skipped": return "bg-stone-700"
    default: return "bg-stone-600"
  }
}

export function StageTimeline({ stages }: StageTimelineProps) {
  const sorted = [...stages].sort((a, b) => a.stage_order - b.stage_order)

  return (
    <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6">
      <h3 className="font-headline font-bold text-sm mb-4">
        Stage <span className="text-[#ffa600]">TIMELINE</span>
      </h3>
      <div className="flex gap-1 h-8 rounded-lg overflow-hidden">
        {sorted.map((stage) => (
          <div
            key={stage.stage_key}
            className={`flex-1 ${statusColor(stage.status)} flex items-center justify-center transition-opacity hover:opacity-80`}
            title={`${stage.stage_order}. ${stage.stage_name}: ${stage.score.toFixed(1)}/10 (${stage.status})`}
          >
            <span className="text-[9px] font-bold text-white/80 truncate px-0.5">
              {stage.stage_order}
            </span>
          </div>
        ))}
      </div>
      <div className="flex justify-between mt-2 text-[9px] text-stone-600 font-label uppercase tracking-widest">
        <span>Abertura</span>
        <span>SPIN</span>
        <span>Apresentação</span>
        <span>Fechamento</span>
      </div>
    </div>
  )
}
