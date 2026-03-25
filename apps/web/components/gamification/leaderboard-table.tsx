"use client"

import type { LeaderboardEntry } from "@/lib/types/audit"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Trophy, Medal, TrendingUp, TrendingDown, Minus, Award } from "lucide-react"
import { cn } from "@/lib/utils"

interface LeaderboardTableProps { entries: LeaderboardEntry[] }

function RankBadge({ rank }: { rank: number }) {
  if (rank === 1) return <Trophy className="h-5 w-5 text-amber-400" />
  if (rank === 2) return <Medal className="h-5 w-5 text-muted-foreground" />
  if (rank === 3) return <Medal className="h-5 w-5 text-primary-dim" />
  return <span className="text-sm text-muted-foreground font-technical">{rank}</span>
}

function TrendIcon({ trend }: { trend: "up" | "down" | "stable" }) {
  if (trend === "up") return <TrendingUp className="h-4 w-4 text-emerald-400" />
  if (trend === "down") return <TrendingDown className="h-4 w-4 text-red-400" />
  return <Minus className="h-4 w-4 text-muted-foreground" />
}

export function LeaderboardTable({ entries }: LeaderboardTableProps) {
  if (entries.length === 0) {
    return (<div className="flex flex-col items-center justify-center py-12 text-muted-foreground"><Trophy className="h-10 w-10 mb-2" /><p>Nenhum dado para o per\u00edodo selecionado.</p></div>)
  }
  return (
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead className="w-12">#</TableHead>
          <TableHead>Closer</TableHead>
          <TableHead className="text-right">Valor</TableHead>
          <TableHead className="text-center w-16">Trend</TableHead>
          <TableHead className="text-center w-20">Badges</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {entries.map((entry) => (
          <TableRow key={entry.closer_id} className={cn(entry.rank <= 3 && "bg-accent/30")}>
            <TableCell><div className="flex items-center justify-center w-8"><RankBadge rank={entry.rank} /></div></TableCell>
            <TableCell>
              <div className="flex items-center gap-2">
                <div className="flex h-8 w-8 items-center justify-center rounded-full bg-primary/10 text-xs font-medium font-technical">{entry.closer_name.split(" ").map((n) => n[0]).join("").slice(0, 2).toUpperCase()}</div>
                <span className="font-medium">{entry.closer_name}</span>
              </div>
            </TableCell>
            <TableCell className="text-right font-semibold font-technical tabular-nums">{entry.value}</TableCell>
            <TableCell className="text-center"><div className="flex items-center justify-center"><TrendIcon trend={entry.trend} /></div></TableCell>
            <TableCell className="text-center"><div className="flex items-center justify-center gap-1"><Award className="h-3.5 w-3.5 text-muted-foreground" /><span className="text-sm font-technical">{entry.badges_count}</span></div></TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  )
}
