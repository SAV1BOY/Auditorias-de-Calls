"use client"

import type { CloserBadgeWithInfo } from "@/lib/types/audit"
import {
  Award,
  Trophy,
  Crown,
  Star,
  Flame,
  Zap,
  CheckCircle,
  TrendingUp,
  Medal,
} from "lucide-react"
import type { LucideIcon } from "lucide-react"

const ICON_MAP: Record<string, LucideIcon> = {
  award: Award,
  trophy: Trophy,
  crown: Crown,
  star: Star,
  flame: Flame,
  zap: Zap,
  "check-circle": CheckCircle,
  "trending-up": TrendingUp,
  medal: Medal,
}

interface CloserBadgesSummaryProps {
  badges: CloserBadgeWithInfo[]
}

export function CloserBadgesSummary({ badges }: CloserBadgesSummaryProps) {
  if (badges.length === 0) {
    return (
      <span className="text-xs text-muted-foreground">Nenhum badge</span>
    )
  }

  return (
    <div className="flex flex-wrap gap-1">
      {badges.map((cb) => {
        const IconComp = ICON_MAP[cb.badge.icon] ?? Award
        return (
          <div
            key={cb.id}
            title={`${cb.badge.name}: ${cb.badge.description}`}
            className="flex h-7 w-7 items-center justify-center rounded-full bg-primary/10 text-primary"
          >
            <IconComp className="h-3.5 w-3.5" />
          </div>
        )
      })}
    </div>
  )
}
