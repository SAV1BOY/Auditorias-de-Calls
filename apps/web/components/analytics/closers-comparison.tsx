"use client"

import { useState, useTransition } from "react"
import {
  RadarChart, Radar, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer, Tooltip, Legend,
} from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import type { CloserRow, CloserComparison as ComparisonData } from "@/lib/types/audit"
import { getClosersComparison } from "@/lib/actions/analytics"
import { getScoreColor } from "@/lib/utils/colors"
import { generateComparisonInsights } from "@/lib/utils/analytics"
import { CHART_COLORS, CHART_TOOLTIP_STYLE } from "@/lib/utils/chart-theme"

interface ClosersComparisonProps { closers: CloserRow[] }

export function ClosersComparison({ closers }: ClosersComparisonProps) {
  const [selectedIds, setSelectedIds] = useState<string[]>([])
  const [period, setPeriod] = useState<string>("all")
  const [data, setData] = useState<ComparisonData[]>([])
  const [isPending, startTransition] = useTransition()

  function toggleCloser(id: string) {
    setSelectedIds((prev) => prev.includes(id) ? prev.filter((i) => i !== id) : prev.length >= 5 ? prev : [...prev, id])
  }

  function handleCompare() {
    if (selectedIds.length < 2) return
    startTransition(async () => {
      const dateFrom = period === "all" ? undefined : new Date(Date.now() - Number(period) * 86400000).toISOString().split("T")[0]
      setData(await getClosersComparison(selectedIds, dateFrom))
    })
  }

  const radarData = data.length > 0 ? data[0].dimensions.map((dim, i) => {
    const point: Record<string, string | number> = { name: dim.shortName }
    data.forEach((c) => { point[c.closer_name] = c.dimensions[i]?.score ?? 0 })
    return point
  }) : []

  const insights = generateComparisonInsights(data)

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader><CardTitle className="text-base">Selecione os Closers</CardTitle></CardHeader>
        <CardContent className="space-y-4">
          <div className="flex flex-wrap gap-2">
            {closers.filter((c) => c.active).map((c) => (<Badge key={c.id} variant={selectedIds.includes(c.id) ? "default" : "outline"} className="cursor-pointer" onClick={() => toggleCloser(c.id)}>{c.name}</Badge>))}
          </div>
          <div className="flex items-center gap-4">
            <Select value={period} onValueChange={setPeriod}><SelectTrigger className="w-40"><SelectValue /></SelectTrigger><SelectContent><SelectItem value="7">7 dias</SelectItem><SelectItem value="30">30 dias</SelectItem><SelectItem value="90">90 dias</SelectItem><SelectItem value="all">Todo per\u00edodo</SelectItem></SelectContent></Select>
            <Button onClick={handleCompare} disabled={selectedIds.length < 2 || isPending}>{isPending ? "Carregando..." : "Comparar"}</Button>
            <span className="text-sm text-muted-foreground font-body">{selectedIds.length}/5 selecionados</span>
          </div>
        </CardContent>
      </Card>

      {data.length === 0 && <p className="py-12 text-center text-sm text-muted-foreground">Selecione 2 ou mais closers e clique em Comparar.</p>}

      {data.length >= 2 && (<>
        <Card>
          <CardHeader><CardTitle className="text-base">Radar Comparativo</CardTitle></CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={380}>
              <RadarChart data={radarData} cx="50%" cy="50%" outerRadius="70%">
                <PolarGrid stroke="hsl(225, 4%, 17%)" />
                <PolarAngleAxis dataKey="name" tick={{ fontSize: 10, fill: '#8a8a8a', fontFamily: 'Manrope' }} />
                <PolarRadiusAxis domain={[0, 10]} tick={{ fontSize: 9, fill: '#8a8a8a' }} axisLine={false} />
                <Tooltip formatter={(value) => [Number(value).toFixed(1), ""]} {...CHART_TOOLTIP_STYLE} />
                <Legend />
                {data.map((c, i) => (<Radar key={c.closer_id} name={c.closer_name} dataKey={c.closer_name} stroke={CHART_COLORS[i % CHART_COLORS.length]} fill={CHART_COLORS[i % CHART_COLORS.length]} fillOpacity={0.1} strokeWidth={2} />))}
              </RadarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader><CardTitle className="text-base">Tabela Comparativa</CardTitle></CardHeader>
          <CardContent className="overflow-x-auto">
            <Table>
              <TableHeader><TableRow><TableHead className="min-w-[160px]">Dimens\u00e3o</TableHead>{data.map((c) => (<TableHead key={c.closer_id} className="text-center min-w-[100px]">{c.closer_name}</TableHead>))}</TableRow></TableHeader>
              <TableBody>
                {data[0].dimensions.map((dim, i) => { const scores = data.map((c) => c.dimensions[i]?.score ?? 0); const mx = Math.max(...scores); return (<TableRow key={dim.name}><TableCell className="font-medium">{dim.name}</TableCell>{data.map((c) => { const s = c.dimensions[i]?.score ?? 0; return (<TableCell key={c.closer_id} className={`text-center ${getScoreColor(s)} ${s === mx && s > 0 ? "font-bold" : ""}`}>{s.toFixed(1)}</TableCell>) })}</TableRow>) })}
                <TableRow><TableCell className="font-bold">Score M\u00e9dio</TableCell>{data.map((c) => (<TableCell key={c.closer_id} className={`text-center font-bold ${getScoreColor(c.media_score)}`}>{c.media_score?.toFixed(1) ?? "\u2014"}</TableCell>))}</TableRow>
                <TableRow><TableCell className="text-muted-foreground">Total de Calls</TableCell>{data.map((c) => (<TableCell key={c.closer_id} className="text-center text-muted-foreground font-body">{c.total_calls}</TableCell>))}</TableRow>
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {insights.length > 0 && (<Card><CardHeader><CardTitle className="text-base">Insights</CardTitle></CardHeader><CardContent><ul className="space-y-2">{insights.map((ins, i) => (<li key={i} className="flex items-start gap-2 text-sm"><span className="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0" />{ins}</li>))}</ul></CardContent></Card>)}
      </>)}
    </div>
  )
}
