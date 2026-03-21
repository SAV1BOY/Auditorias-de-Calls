import { ENGAGEMENT_LABELS, ENGAGEMENT_COLORS } from "@/lib/utils/constants"

interface EngagementMeterProps {
  level: string
}

const LEVELS = ["low", "medium", "high"] as const

export function EngagementMeter({ level }: EngagementMeterProps) {
  const activeIndex = LEVELS.indexOf(level as (typeof LEVELS)[number])
  const label = ENGAGEMENT_LABELS[level] ?? level

  return (
    <div className="space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm font-medium">Nível de Engajamento</span>
        <span
          className="text-sm font-semibold"
          style={{ color: ENGAGEMENT_COLORS[level] ?? "#a3a3a3" }}
        >
          {label}
        </span>
      </div>
      <div className="flex gap-1">
        {LEVELS.map((lvl, i) => {
          const isActive = i <= activeIndex
          const color = isActive
            ? ENGAGEMENT_COLORS[level] ?? "#a3a3a3"
            : undefined

          return (
            <div
              key={lvl}
              className={`h-3 flex-1 rounded-sm ${
                isActive ? "" : "bg-muted"
              }`}
              style={isActive ? { backgroundColor: color } : undefined}
            />
          )
        })}
      </div>
      <div className="flex justify-between text-xs text-muted-foreground">
        <span>Baixo</span>
        <span>Médio</span>
        <span>Alto</span>
      </div>
    </div>
  )
}
