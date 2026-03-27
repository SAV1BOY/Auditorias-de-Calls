"use client"

import { useState, useTransition } from "react"
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid, Legend } from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Button } from "@/components/ui/button"
import type { CloserRow, DimensionTrendPoint } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { getDimensionTrends } from "@/lib/actions/analytics"
import { calculateMovingAverage } from "@/lib/utils/analytics"
import { getScoreColor } from "@/lib/utils/colors"
import { CHART_GRID, CHART_AXIS_TICK, CHART_TOOLTIP_STYLE } from "@/lib/utils/chart-theme"

function formatDateLabel(d: string) { const [, m, day] = d.split("-"); return `${day}/${m}` }

interface DimensionTrendsProps { closers: CloserRow[] }

export function DimensionTrends({ closers }: DimensionTrendsProps) {
  const [dimensionId, setDimensionId] = useState<string>(DIMENSIONS[0].id)
  const [closerId, setCloserId] = useState<string>("all")
  const [days, setDays] = useState<string>("90")
  const [data, setData] = useState<DimensionTrendPoint[]>([])
  const [isPending, startTransition] = useTransition()

  function handleLoad() {
    startTransition(async () => {
      const result = await getDimensionTrends(dimensionId, closerId === "all" ? undefined : closerId, Number(days))
      const ma = calculateMovingAverage(result, 7)
      setData(result.map((p, i) => ({ ...p, movingAvg: ma[i]?.movingAvg })))
    })
  }

  const currentDim = DIMENSIONS.find((d) => d.id === dimensionId)
  const scores = data.map((d) => d.score)
  const avgScore = scores.length > 0 ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10 : null
  const currentScore = scores.length > 0 ? scores[scores.length - 1] : null
  const bestScore = scores.length > 0 ? Math.max(...scores) : null
  let trend: string | null = null
  if (scores.length >= 5) {
    const recent = scores.slice(-5), older = scores.slice(-10, -5)
    if (older.length > 0) { const diff = recent.reduce((a, b) => a + b, 0) / recent.length - older.reduce((a, b) => a + b, 0) / older.length; trend = diff > 0 ? `+${diff.toFixed(1)} pts` : diff < 0 ? `${diff.toFixed(1)} pts` : "estável" }
  }

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader><CardTitle className="text-base">Filtros</CardTitle></CardHeader>
        <CardContent>
          <div className="flex flex-wrap items-center gap-4">
            <Select value={dimensionId} onValueChange={setDimensionId}><SelectTrigger className="w-56"><SelectValue placeholder="Dimensão" /></SelectTrigger><SelectContent>{DIMENSIONS.map((d) => (<SelectItem key={d.id} value={d.id}>{d.name}</SelectItem>))}</SelectContent></Select>
            <Select value={closerId} onValueChange={setCloserId}><SelectTrigger className="w-44"><SelectValue placeholder="Closer" /></SelectTrigger><SelectContent><SelectItem value="all">Todos os Closers</SelectItem>{closers.filter((c) => c.active).map((c) => (<SelectItem key={c.id} value={c.id}>{c.name}</SelectItem>))}</SelectContent></Select>
            <Select value={days} onValueChange={setDays}><SelectTrigger className="w-32"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="30">30 dias</SelectItem><SelectItem value="60">60 dias</SelectItem><SelectItem value="90">90 dias</SelectItem></SelectContent></Select>
            <Button onClick={handleLoad} disabled={isPending}>{isPending ? "Carregando..." : "Carregar"}</Button>
          </div>
        </CardContent>
      </Card>

      {data.length === 0 && <p className="py-12 text-center text-sm text-muted-foreground">Selecione uma dimensão e clique em Carregar.</p>}

      {data.length > 0 && (<>
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <Card><CardContent className="pt-6"><p className="text-sm text-muted-foreground font-body">Nota Atual</p><p className={`text-2xl font-bold font-body ${getScoreColor(currentScore ?? null)}`}>{currentScore?.toFixed(1) ?? "\u2014"}</p></CardContent></Card>
          <Card><CardContent className="pt-6"><p className="text-sm text-muted-foreground font-body">Média do Período</p><p className={`text-2xl font-bold font-body ${getScoreColor(avgScore)}`}>{avgScore?.toFixed(1) ?? "\u2014"}</p></CardContent></Card>
          <Card><CardContent className="pt-6"><p className="text-sm text-muted-foreground font-body">Melhor Nota</p><p className={`text-2xl font-bold font-body ${getScoreColor(bestScore ?? null)}`}>{bestScore?.toFixed(1) ?? "\u2014"}</p></CardContent></Card>
          <Card><CardContent className="pt-6"><p className="text-sm text-muted-foreground font-body">Tendência</p><p className="text-2xl font-bold font-body">{trend ?? "\u2014"}</p></CardContent></Card>
        </div>
        <Card>
          <CardHeader><CardTitle className="text-base">{currentDim?.name ?? "Dimensão"}</CardTitle></CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={340}>
              <LineChart data={data}>
                <CartesianGrid {...CHART_GRID} />
                <XAxis dataKey="date" tickFormatter={formatDateLabel} tick={CHART_AXIS_TICK} tickLine={false} axisLine={false} />
                <YAxis domain={[0, 10]} tick={CHART_AXIS_TICK} tickLine={false} axisLine={false} />
                <Tooltip labelFormatter={(l) => formatDateLabel(String(l))} formatter={(v, n) => [Number(v).toFixed(1), n === "score" ? "Score" : n === "teamAvg" ? "Média Time" : "Média Móvel 7d"]} {...CHART_TOOLTIP_STYLE} />
                <Legend formatter={(v) => v === "score" ? "Score" : v === "teamAvg" ? "Média Time" : "Média Móvel 7d"} />
                <Line type="monotone" dataKey="score" stroke="#ffa600" strokeWidth={2} dot={{ r: 3, fill: '#ffa600' }} activeDot={{ r: 5, fill: '#ffcc8d' }} />
                <Line type="monotone" dataKey="teamAvg" stroke="#8a8a8a" strokeWidth={1} strokeDasharray="5 5" dot={false} />
                <Line type="monotone" dataKey="movingAvg" stroke="#ffcc8d" strokeWidth={2} dot={false} />
              </LineChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </>)}
    </div>
  )
}
