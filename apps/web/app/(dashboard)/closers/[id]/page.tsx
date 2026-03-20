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
import { DIMENSIONS, type DimensionId } from "@/lib/utils/constants"
import { CloserStats } from "@/components/closers/closer-stats"
import { CloserRadarChart } from "@/components/closers/closer-radar-chart"
import { ScoreChart } from "@/components/dashboard/score-chart"

const RADAR_LABELS: Record<string, string> = {
  d01_frame: "Frame",
  d02_qualificacao: "Qualif.",
  d03_diag_quantitativo: "Diag.Quant.",
  d04_diag_qualitativo: "Diag.Qual.",
  d05_consequencia: "Conseq.",
  d06_ensino: "Ensino",
  d07_identidade: "Ident.",
  d08_ancoragem: "Ancor.",
  d09_isolamento: "Isol.",
  d10_proporcao_fala: "Prop.Fala",
  d11_promessas: "Promessas",
  d12_checkpoints: "Checkp.",
  d13_fechamento: "Fech.",
}

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

  // View columns are avg_d01..avg_d13 (not avg_d01_frame)
  const dimIndexMap: Record<string, string> = {
    d01_frame: "avg_d01",
    d02_qualificacao: "avg_d02",
    d03_diag_quantitativo: "avg_d03",
    d04_diag_qualitativo: "avg_d04",
    d05_consequencia: "avg_d05",
    d06_ensino: "avg_d06",
    d07_identidade: "avg_d07",
    d08_ancoragem: "avg_d08",
    d09_isolamento: "avg_d09",
    d10_proporcao_fala: "avg_d10",
    d11_promessas: "avg_d11",
    d12_checkpoints: "avg_d12",
    d13_fechamento: "avg_d13",
  }

  const radarData = DIMENSIONS.map((dim) => ({
    name: RADAR_LABELS[dim.id] ?? dim.name,
    score: Number(performance?.[dimIndexMap[dim.id]] ?? 0),
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
