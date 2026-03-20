"use client"

import {
  RadarChart,
  Radar,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  ResponsiveContainer,
  Tooltip,
} from "recharts"
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"

interface RadarDimension {
  name: string
  score: number
}

interface CloserRadarChartProps {
  dimensions: RadarDimension[]
}

export function CloserRadarChart({ dimensions }: CloserRadarChartProps) {
  const hasData = dimensions.some((d) => d.score > 0)

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Radar de Dimensões</CardTitle>
      </CardHeader>
      <CardContent>
        {!hasData ? (
          <p className="py-12 text-center text-sm text-muted-foreground">
            Nenhum dado disponível.
          </p>
        ) : (
          <ResponsiveContainer width="100%" height={320}>
            <RadarChart data={dimensions} cx="50%" cy="50%" outerRadius="75%">
              <PolarGrid />
              <PolarAngleAxis
                dataKey="name"
                tick={{ fontSize: 10, fill: "hsl(var(--muted-foreground))" }}
              />
              <PolarRadiusAxis
                domain={[0, 10]}
                tick={{ fontSize: 9 }}
                axisLine={false}
              />
              <Tooltip
                formatter={(value) => [Number(value).toFixed(1), "Score"]}
              />
              <Radar
                name="Score"
                dataKey="score"
                stroke="hsl(221.2 83.2% 53.3%)"
                fill="hsl(221.2 83.2% 53.3%)"
                fillOpacity={0.3}
                strokeWidth={2}
              />
            </RadarChart>
          </ResponsiveContainer>
        )}
      </CardContent>
    </Card>
  )
}
