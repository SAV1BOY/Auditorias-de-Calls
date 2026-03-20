"use client"

import { useState, useTransition } from "react"
import {
  RadarChart,
  Radar,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  ResponsiveContainer,
  Tooltip,
  Legend,
} from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import type { CloserRow, CloserComparison as ComparisonData } from "@/lib/types/audit"
import { getClosersComparison } from "@/lib/actions/analytics"
import { getScoreColor } from "@/lib/utils/colors"
import { generateComparisonInsights } from "@/lib/utils/analytics"

const COLORS = [
  "hsl(221.2 83.2% 53.3%)",
  "hsl(142.1 76.2% 36.3%)",
  "hsl(346.8 77.2% 49.8%)",
  "hsl(47.9 95.8% 53.1%)",
  "hsl(262.1 83.3% 57.8%)",
]

interface ClosersComparisonProps {
  closers: CloserRow[]
}

export function ClosersComparison({ closers }: ClosersComparisonProps) {
  const [selectedIds, setSelectedIds] = useState<string[]>([])
  const [period, setPeriod] = useState<string>("all")
  const [data, setData] = useState<ComparisonData[]>([])
  const [isPending, startTransition] = useTransition()

  function toggleCloser(id: string) {
    setSelectedIds((prev) =>
      prev.includes(id)
        ? prev.filter((i) => i !== id)
        : prev.length >= 5
          ? prev
          : [...prev, id]
    )
  }

  function handleCompare() {
    if (selectedIds.length < 2) return

    startTransition(async () => {
      const dateFrom =
        period === "all"
          ? undefined
          : new Date(
              Date.now() - Number(period) * 24 * 60 * 60 * 1000
            )
              .toISOString()
              .split("T")[0]

      const result = await getClosersComparison(selectedIds, dateFrom)
      setData(result)
    })
  }

  // Build radar data: each dimension with a score per closer
  const radarData =
    data.length > 0
      ? data[0].dimensions.map((dim, i) => {
          const point: Record<string, string | number> = {
            name: dim.shortName,
          }
          data.forEach((closer) => {
            point[closer.closer_name] = closer.dimensions[i]?.score ?? 0
          })
          return point
        })
      : []

  const insights = generateComparisonInsights(data)

  return (
    <div className="space-y-6">
      {/* Selection */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Selecione os Closers</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex flex-wrap gap-2">
            {closers
              .filter((c) => c.active)
              .map((closer) => {
                const isSelected = selectedIds.includes(closer.id)
                return (
                  <Badge
                    key={closer.id}
                    variant={isSelected ? "default" : "outline"}
                    className="cursor-pointer"
                    onClick={() => toggleCloser(closer.id)}
                  >
                    {closer.name}
                  </Badge>
                )
              })}
          </div>
          <div className="flex items-center gap-4">
            <Select value={period} onValueChange={setPeriod}>
              <SelectTrigger className="w-40">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="7">7 dias</SelectItem>
                <SelectItem value="30">30 dias</SelectItem>
                <SelectItem value="90">90 dias</SelectItem>
                <SelectItem value="all">Todo período</SelectItem>
              </SelectContent>
            </Select>
            <Button
              onClick={handleCompare}
              disabled={selectedIds.length < 2 || isPending}
            >
              {isPending ? "Carregando..." : "Comparar"}
            </Button>
            <span className="text-sm text-muted-foreground">
              {selectedIds.length}/5 selecionados
            </span>
          </div>
        </CardContent>
      </Card>

      {data.length === 0 && (
        <p className="py-12 text-center text-sm text-muted-foreground">
          Selecione 2 ou mais closers e clique em Comparar.
        </p>
      )}

      {data.length >= 2 && (
        <>
          {/* Radar Chart */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">
                Radar Comparativo
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={380}>
                <RadarChart data={radarData} cx="50%" cy="50%" outerRadius="70%">
                  <PolarGrid />
                  <PolarAngleAxis
                    dataKey="name"
                    tick={{
                      fontSize: 10,
                      fill: "hsl(var(--muted-foreground))",
                    }}
                  />
                  <PolarRadiusAxis
                    domain={[0, 10]}
                    tick={{ fontSize: 9 }}
                    axisLine={false}
                  />
                  <Tooltip
                    formatter={(value) => [
                      Number(value).toFixed(1),
                      "",
                    ]}
                  />
                  <Legend />
                  {data.map((closer, index) => (
                    <Radar
                      key={closer.closer_id}
                      name={closer.closer_name}
                      dataKey={closer.closer_name}
                      stroke={COLORS[index % COLORS.length]}
                      fill={COLORS[index % COLORS.length]}
                      fillOpacity={0.1}
                      strokeWidth={2}
                    />
                  ))}
                </RadarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          {/* Comparison Table */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">
                Tabela Comparativa
              </CardTitle>
            </CardHeader>
            <CardContent className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="min-w-[160px]">Dimensão</TableHead>
                    {data.map((closer) => (
                      <TableHead key={closer.closer_id} className="text-center min-w-[100px]">
                        {closer.closer_name}
                      </TableHead>
                    ))}
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {data[0].dimensions.map((dim, i) => {
                    const scores = data.map((c) => c.dimensions[i]?.score ?? 0)
                    const maxScore = Math.max(...scores)

                    return (
                      <TableRow key={dim.name}>
                        <TableCell className="font-medium">
                          {dim.name}
                        </TableCell>
                        {data.map((closer) => {
                          const score = closer.dimensions[i]?.score ?? 0
                          const isBest = score === maxScore && score > 0
                          return (
                            <TableCell
                              key={closer.closer_id}
                              className={`text-center ${getScoreColor(score)} ${isBest ? "font-bold" : ""}`}
                            >
                              {score.toFixed(1)}
                            </TableCell>
                          )
                        })}
                      </TableRow>
                    )
                  })}
                  {/* Score final row */}
                  <TableRow className="border-t-2">
                    <TableCell className="font-bold">Score Médio</TableCell>
                    {data.map((closer) => (
                      <TableCell
                        key={closer.closer_id}
                        className={`text-center font-bold ${getScoreColor(closer.media_score)}`}
                      >
                        {closer.media_score?.toFixed(1) ?? "—"}
                      </TableCell>
                    ))}
                  </TableRow>
                  <TableRow>
                    <TableCell className="text-muted-foreground">
                      Total de Calls
                    </TableCell>
                    {data.map((closer) => (
                      <TableCell
                        key={closer.closer_id}
                        className="text-center text-muted-foreground"
                      >
                        {closer.total_calls}
                      </TableCell>
                    ))}
                  </TableRow>
                </TableBody>
              </Table>
            </CardContent>
          </Card>

          {/* Insights */}
          {insights.length > 0 && (
            <Card>
              <CardHeader>
                <CardTitle className="text-base">Insights</CardTitle>
              </CardHeader>
              <CardContent>
                <ul className="space-y-2">
                  {insights.map((insight, i) => (
                    <li
                      key={i}
                      className="flex items-start gap-2 text-sm"
                    >
                      <span className="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0" />
                      {insight}
                    </li>
                  ))}
                </ul>
              </CardContent>
            </Card>
          )}
        </>
      )}
    </div>
  )
}
