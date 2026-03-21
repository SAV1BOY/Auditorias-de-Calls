"use client"

import type { BadgeRow } from "@/lib/types/audit"
import { Card, CardContent } from "@/components/ui/card"
import { cn } from "@/lib/utils"
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

interface BadgeGridProps {
  badges: BadgeRow[]
  earnedBadgeIds: string[]
}

export function BadgeGrid({ badges, earnedBadgeIds }: BadgeGridProps) {
  const earnedSet = new Set(earnedBadgeIds)

  if (badges.length === 0) {
    return (
      <p className="text-sm text-muted-foreground py-4">
        Nenhum badge cadastrado.
      </p>
    )
  }

  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3">
      {badges.map((badge) => {
        const isEarned = earnedSet.has(badge.id)
        const IconComp = ICON_MAP[badge.icon] ?? Award

        return (
          <Card
            key={badge.id}
            className={cn(
              "transition-all",
              isEarned
                ? "border-primary/50 bg-primary/5"
                : "opacity-40 grayscale"
            )}
          >
            <CardContent className="flex flex-col items-center gap-2 p-4 text-center">
              <div
                className={cn(
                  "flex h-10 w-10 items-center justify-center rounded-full",
                  isEarned
                    ? "bg-primary/10 text-primary"
                    : "bg-muted text-muted-foreground"
                )}
              >
                <IconComp className="h-5 w-5" />
              </div>
              <span className="text-xs font-medium leading-tight">
                {badge.name}
              </span>
              <span className="text-[10px] text-muted-foreground leading-tight">
                {badge.description}
              </span>
            </CardContent>
          </Card>
        )
      })}
    </div>
  )
}
