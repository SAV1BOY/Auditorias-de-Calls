import type { TrainingAction } from "@/lib/types/supervisor"

interface TrainingListProps {
  actions: TrainingAction[]
}

function priorityBadge(priority: string): string {
  switch (priority) {
    case "high": return "bg-red-500/10 text-red-500 border-red-500/20"
    case "medium": return "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20"
    case "low": return "bg-stone-500/10 text-stone-400 border-stone-500/20"
    default: return "bg-stone-500/10 text-stone-400 border-stone-500/20"
  }
}

function statusBadge(status: string): string {
  switch (status) {
    case "pending": return "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20"
    case "sent": return "bg-blue-500/10 text-blue-400 border-blue-500/20"
    case "completed": return "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
    default: return "bg-stone-500/10 text-stone-400 border-stone-500/20"
  }
}

export function TrainingList({ actions }: TrainingListProps) {
  if (actions.length === 0) {
    return (
      <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8 text-center">
        <span className="material-symbols-outlined text-4xl text-stone-600 mb-2 block">school</span>
        <p className="text-stone-500">Nenhuma ação de treinamento registrada.</p>
        <p className="text-xs text-stone-600 mt-1">
          As ações são geradas automaticamente quando etapas recebem score abaixo de 6.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-3">
      {actions.map((action) => (
        <div
          key={action.id}
          className="bg-[#1a1c1e] rounded-xl border border-white/5 p-4 hover:border-[#ffa600]/20 transition-all"
        >
          <div className="flex items-start justify-between gap-4">
            <div className="flex-1 space-y-2">
              <p className="text-sm text-[#d8c3ac]">{action.recommendation}</p>
              <div className="flex flex-wrap items-center gap-2">
                <span className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${priorityBadge(action.priority)}`}>
                  {action.priority}
                </span>
                <span className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${statusBadge(action.status)}`}>
                  {action.status}
                </span>
                {action.stage_key && (
                  <span className="text-[10px] text-stone-500 font-label uppercase tracking-widest">
                    {action.stage_key.replace(/_/g, " ")}
                  </span>
                )}
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  )
}
