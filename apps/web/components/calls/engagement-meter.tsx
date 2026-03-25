import { ENGAGEMENT_LABELS, ENGAGEMENT_COLORS } from "@/lib/utils/constants"

interface EngagementMeterProps { level: string }
const LEVELS = ["low", "medium", "high"] as const

export function EngagementMeter({ level }: EngagementMeterProps) {
  const activeIndex = LEVELS.indexOf(level as (typeof LEVELS)[number])
  const label = ENGAGEMENT_LABELS[level] ?? level

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm font-medium font-display">N\u00edvel de Engajamento</span>
        <span className="text-sm font-semibold font-technical" style={{ color: ENGAGEMENT_COLORS[level] ?? "hsl(var(--muted-foreground))" }}>{label}</span>
      </div>
      <div className="flex gap-1">
        {LEVELS.map((lvl, i) => {
          const isActive = i <= activeIndex
          const color = isActive ? ENGAGEMENT_COLORS[level] ?? "hsl(var(--muted-foreground))" : undefined
          return <div key={lvl} className={`h-3 flex-1 rounded-sm ${isActive ? "" : "bg-surface-interaction"}`} style={isActive ? { backgroundColor: color } : undefined} />
        })}
      </div>
      <div className="flex justify-between text-xs text-muted-foreground font-technical"><span>Baixo</span><span>M\u00e9dio</span><span>Alto</span></div>
    </div>
  )
}
