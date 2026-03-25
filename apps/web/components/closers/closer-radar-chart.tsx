"use client"

import { RadarChart, Radar, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer, Tooltip } from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { CHART_TOOLTIP_STYLE } from "@/lib/utils/chart-theme"

interface RadarDimension { name: string; score: number }
interface CloserRadarChartProps { dimensions: RadarDimension[] }

export function CloserRadarChart({ dimensions }: CloserRadarChartProps) {
  const hasData = dimensions.some((d) => d.score > 0)
  return (
    <Card>
      <CardHeader><CardTitle className="text-base">Radar de Dimens\u00f5es</CardTitle></CardHeader>
      <CardContent>
        {!hasData ? (<p className="py-12 text-center text-sm text-muted-foreground">Nenhum dado dispon\u00edvel.</p>) : (
          <ResponsiveContainer width="100%" height={320}>
            <RadarChart data={dimensions} cx="50%" cy="50%" outerRadius="75%">
              <PolarGrid stroke="hsl(225, 4%, 17%)" />
              <PolarAngleAxis dataKey="name" tick={{ fontSize: 10, fill: '#8a8a8a', fontFamily: 'Manrope' }} />
              <PolarRadiusAxis domain={[0, 10]} tick={{ fontSize: 9, fill: '#8a8a8a' }} axisLine={false} />
              <Tooltip formatter={(value) => [Number(value).toFixed(1), "Score"]} {...CHART_TOOLTIP_STYLE} />
              <Radar name="Score" dataKey="score" stroke="#ffa600" fill="#ffa600" fillOpacity={0.2} strokeWidth={2} />
            </RadarChart>
          </ResponsiveContainer>
        )}
      </CardContent>
    </Card>
  )
}
