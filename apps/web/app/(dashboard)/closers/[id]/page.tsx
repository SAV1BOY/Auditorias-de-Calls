import { notFound } from "next/navigation"
import Link from "next/link"
import { ArrowLeft } from "lucide-react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  getCloserById,
  getCloserPerformance,
  getCloserScoreEvolution,
} from "@/lib/actions/closers"
import { DIMENSIONS, RADAR_LABELS, DIM_INDEX_MAP } from "@/lib/utils/constants"
import { CloserStats } from "@/components/closers/closer-stats"
import { CloserRadarChart } from "@/components/closers/closer-radar-chart"
import { ScoreChart } from "@/components/dashboard/score-chart"

export default async function CloserProfilePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const closer = await getCloserById(id)
  if (!closer) notFound()

  const [performance, evolution] = await Promise.all([
    getCloserPerformance(id),
    getCloserScoreEvolution(id),
  ])

  const radarData = DIMENSIONS.map((dim) => ({
    name: RADAR_LABELS[dim.id] ?? dim.name,
    score: Number(performance?.[DIM_INDEX_MAP[dim.id]] ?? 0),
  }))

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-2">
        <Button variant="ghost" size="sm" asChild>
          <Link href="/closers">
            <ArrowLeft className="mr-1 h-4 w-4" />
            Voltar
          </Link>
        </Button>
      </div>

      {/* Header */}
      <div className="flex items-center gap-4">
        <Avatar className="h-16 w-16">
          <AvatarImage src={closer.avatar_url ?? undefined} />
          <AvatarFallback className="text-xl">
            {closer.name.slice(0, 2).toUpperCase()}
          </AvatarFallback>
        </Avatar>
        <div>
          <h1 className="text-2xl font-bold">{closer.name}</h1>
          <div className="flex items-center gap-2 mt-1">
            <Badge variant={closer.active ? "default" : "secondary"}>
              {closer.active ? "Ativo" : "Inativo"}
            </Badge>
            {closer.email && (
              <span className="text-sm text-muted-foreground">
                {closer.email}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* Stats cards */}
      <CloserStats
        totalCalls={performance?.total_calls ?? 0}
        mediaScore={performance?.media_score ?? null}
        melhorScore={performance?.melhor_score ?? null}
        piorScore={performance?.pior_score ?? null}
        fechamentos={performance?.fechamentos ?? 0}
      />

      {/* Charts */}
      <div className="grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <ScoreChart data={evolution} title="Evolução do Closer" />
        </div>
        <div>
          <CloserRadarChart dimensions={radarData} />
        </div>
      </div>
    </div>
  )
}
