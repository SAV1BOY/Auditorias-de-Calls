"use client"

import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
} from "recharts"
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"

interface ScoreChartProps {
  data: Array<{ date: string; score: number }>
  title?: string
}

function formatDateLabel(dateStr: string): string {
  const [, month, day] = dateStr.split("-")
  return `${day}/${month}`
}

export function ScoreChart({ data, title = "Evolução de Score" }: ScoreChartProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">{title}</CardTitle>
      </CardHeader>
      <CardContent>
        {data.length === 0 ? (
          <p className="py-12 text-center text-sm text-muted-foreground">
            Nenhum dado de score disponível.
          </p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <LineChart data={data}>
              <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
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
                labelFormatter={(label) => formatDateLabel(String(label))}
                formatter={(value) => [Number(value).toFixed(1), "Score"]}
              />
              <Line
                type="monotone"
                dataKey="score"
                stroke="hsl(221.2 83.2% 53.3%)"
                strokeWidth={2}
                dot={{ r: 3 }}
                activeDot={{ r: 5 }}
              />
            </LineChart>
          </ResponsiveContainer>
        )}
      </CardContent>
    </Card>
  )
}
