"use client"

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { LEADERBOARD_PERIODS, LEADERBOARD_METRICS } from "@/lib/utils/constants"

interface LeaderboardFiltersProps {
  period: string
  metric: string
  onPeriodChange: (value: string) => void
  onMetricChange: (value: string) => void
}

export function LeaderboardFilters({
  period,
  metric,
  onPeriodChange,
  onMetricChange,
}: LeaderboardFiltersProps) {
  return (
    <div className="flex items-center gap-3">
      <Select value={period} onValueChange={onPeriodChange}>
        <SelectTrigger className="w-[160px]">
          <SelectValue placeholder="Período" />
        </SelectTrigger>
        <SelectContent>
          {LEADERBOARD_PERIODS.map((p) => (
            <SelectItem key={p.value} value={p.value}>
              {p.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>

      <Select value={metric} onValueChange={onMetricChange}>
        <SelectTrigger className="w-[200px]">
          <SelectValue placeholder="Métrica" />
        </SelectTrigger>
        <SelectContent>
          {LEADERBOARD_METRICS.map((m) => (
            <SelectItem key={m.value} value={m.value}>
              {m.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  )
}
