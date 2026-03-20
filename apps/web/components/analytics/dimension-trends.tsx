"use client"

import { useState, useTransition } from "react"
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
  Legend,
} from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Button } from "@/components/ui/button"
import type { CloserRow, DimensionTrendPoint } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { getDimensionTrends } from "@/lib/actions/analytics"
import { calculateMovingAverage } from "@/lib/utils/analytics"
import { getScoreColor } from "@/lib/utils/colors"

function formatDateLabel(dateStr: string): string {
  const [, month, day] = dateStr.split("-")
  return `${day}/${month}`
}

interface DimensionTrendsProps {
  closers: CloserRow[]
}

export function DimensionTrends({ closers }: DimensionTrendsProps) {
  const [dimensionId, setDimensionId] = useState<string>(DIMENSIONS[0].id)
  const [closerId, setCloserId] = useState<string>("all")
  const [days, setDays] = useState<string>("90")
  const [data, setData] = useState<DimensionTrendPoint[]>([])
  const [isPending, startTransition] = useTransition()

  function handleLoad() {
    startTransition(async () => {
      const result = await getDimensionTrends(
        dimensionId,
        closerId === "all" ? undefined : closerId,
        Number(days)
      )

      // Add moving average
      const movingAvgs = calculateMovingAverage(result, 7)
      const merged = result.map((point, i) => ({
        ...point,
        movingAvg: movingAvgs[i]?.movingAvg,
      }))
      setData(merged)
    })
  }

  const currentDim = DIMENSIONS.find((d) => d.id === dimensionId)

  // Summary cards
  const scores = data.map((d) => d.score)
  const avgScore =
    scores.length > 0
      ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
      : null
  const currentScore = scores.length > 0 ? scores[scores.length - 1] : null
  const bestScore = scores.length > 0 ? Math.max(...scores) : null

  let trend: string | null = null
  if (scores.length >= 5) {
    const recent = scores.slice(-5)
    const older = scores.slice(-10, -5)
    if (older.length > 0) {
      const recentAvg = recent.reduce((a, b) => a + b, 0) / recent.length
      const olderAvg = older.reduce((a, b) => a + b, 0) / older.length
      const diff = recentAvg - olderAvg
      trend =
        diff > 0
          ? `+${diff.toFixed(1)} pts`
          : diff < 0
            ? `${diff.toFixed(1)} pts`
            : "estável"
    }
  }

  return (
    <div className="space-y-6">
      {/* Filters */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Filtros</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-wrap items-center gap-4">
            <Select value={dimensionId} onValueChange={setDimensionId}>
              <SelectTrigger className="w-56">
                <SelectValue placeholder="Dimensão" />
              </SelectTrigger>
              <SelectContent>
                {DIMENSIONS.map((dim) => (
                  <SelectItem key={dim.id} value={dim.id}>
                    {dim.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={closerId} onValueChange={setCloserId}>
              <SelectTrigger className="w-44">
                <SelectValue placeholder="Closer" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Todos os Closers</SelectItem>
                {closers
                  .filter((c) => c.active)
                  .map((closer) => (
                    <SelectItem key={closer.id} value={closer.id}>
                      {closer.name}
                    </SelectItem>
                  ))}
              </SelectContent>
            </Select>

            <Select value={days} onValueChange={setDays}>
              <SelectTrigger className="w-32">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="30">30 dias</SelectItem>
                <SelectItem value="60">60 dias</SelectItem>
                <SelectItem value="90">90 dias</SelectItem>
              </SelectContent>
            </Select>

            <Button onClick={handleLoad} disabled={isPending}>
              {isPending ? "Carregando..." : "Carregar"}
            </Button>
          </div>
        </CardContent>
      </Card>

      {data.length === 0 && (
        <p className="py-12 text-center text-sm text-muted-foreground">
          Selecione uma dimensão e clique em Carregar.
        </p>
      )}

      {data.length > 0 && (
        <>
          {/* Summary Cards */}
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <Card>
              <CardContent className="pt-6">
                <p className="text-sm text-muted-foreground">Nota Atual</p>
                <p className={`text-2xl font-bold ${getScoreColor(currentScore ?? null)}`}>
                  {currentScore?.toFixed(1) ?? "—"}
                </p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="pt-6">
                <p className="text-sm text-muted-foreground">Média do Período</p>
                <p className={`text-2xl font-bold ${getScoreColor(avgScore)}`}>
                  {avgScore?.toFixed(1) ?? "—"}
                </p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="pt-6">
                <p className="text-sm text-muted-foreground">Melhor Nota</p>
                <p className={`text-2xl font-bold ${getScoreColor(bestScore ?? null)}`}>
                  {bestScore?.toFixed(1) ?? "—"}
                </p>
              </CardContent>
            </Card>
            <Card>
              <CardContent className="pt-6">
                <p className="text-sm text-muted-foreground">Tendência</p>
                <p className="text-2xl font-bold">
                  {trend ?? "—"}
                </p>
              </CardContent>
            </Card>
          </div>

          {/* Chart */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">
                {currentDim?.name ?? "Dimensão"}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={340}>
                <LineChart data={data}>
                  <CartesianGrid
                    strokeDasharray="3 3"
                    className="stroke-muted"
                  />
                  <XAxis
                    dataKey="date"
                    tickFormatter={formatDateLabel}
                    fontSize={12}
                    tickLine={false}
                    axisLine={false}
                  />
                  <YAxis
                    domain={[0, 10]}
                    fontSize={12}
                    tickLine={false}
                    axisLine={false}
                  />
                  <Tooltip
                    labelFormatter={(label) =>
                      formatDateLabel(String(label))
                    }
                    formatter={(value, name) => [
                      Number(value).toFixed(1),
                      name === "score"
                        ? "Score"
                        : name === "teamAvg"
                          ? "Média Time"
                          : "Média Móvel 7d",
                    ]}
                  />
                  <Legend
                    formatter={(value) =>
                      value === "score"
                        ? "Score"
                        : value === "teamAvg"
                          ? "Média Time"
                          : "Média Móvel 7d"
                    }
                  />
                  <Line
                    type="monotone"
                    dataKey="score"
                    stroke="hsl(221.2 83.2% 53.3%)"
                    strokeWidth={2}
                    dot={{ r: 3 }}
                    activeDot={{ r: 5 }}
                  />
                  <Line
                    type="monotone"
                    dataKey="teamAvg"
                    stroke="hsl(var(--muted-foreground))"
                    strokeWidth={1}
                    strokeDasharray="5 5"
                    dot={false}
                  />
                  <Line
                    type="monotone"
                    dataKey="movingAvg"
                    stroke="hsl(262.1 83.3% 57.8%)"
                    strokeWidth={2}
                    dot={false}
                  />
                </LineChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </>
      )}
    </div>
  )
}
