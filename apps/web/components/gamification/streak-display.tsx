"use client"

import type { CloserStreakRow } from "@/lib/types/audit"
import { Flame } from "lucide-react"

interface StreakDisplayProps { streaks: CloserStreakRow[] }

const STREAK_TYPE_LABELS: Record<string, string> = { good_score: "Score 7+", elite: "Elite" }

export function StreakDisplay({ streaks }: StreakDisplayProps) {
  if (streaks.length === 0) return <p className="text-sm text-muted-foreground">Nenhuma sequência ativa.</p>
  return (
    <div className="flex flex-wrap gap-4">
      {streaks.map((streak) => (
        <div key={streak.id} className="flex items-center gap-2 rounded-md bg-surface-container-high px-3 py-2">
          <Flame className="h-4 w-4 text-primary" />
          <div className="text-sm">
            <span className="font-medium">{STREAK_TYPE_LABELS[streak.streak_type] ?? streak.streak_type}</span>
            <span className="text-muted-foreground ml-2 font-body">Atual: {streak.current_count} | Melhor: {streak.best_count}</span>
          </div>
        </div>
      ))}
    </div>
  )
}
