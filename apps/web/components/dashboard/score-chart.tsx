"use client"

import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
  Area,
  AreaChart,
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

const CHART_TOOLTIP_STYLE = {
  contentStyle: {
    background: 'rgba(26, 28, 30, 0.9)',
    backdropFilter: 'blur(16px)',
    border: '1px solid rgba(255, 255, 255, 0.06)',
    borderRadius: '12px',
    color: '#d8c3ac',
    fontFamily: 'Manrope, sans-serif',
  },
}

export function ScoreChart({ data, title = "Evolu\u00e7\u00e3o de Score" }: ScoreChartProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">{title}</CardTitle>
      </CardHeader>
      <CardContent>
        {data.length === 0 ? (
          <p className="py-12 text-center text-sm text-muted-foreground">
            Nenhum dado de score dispon\u00edvel.
          </p>
        ) : (
          <ResponsiveContainer width="100%" height={280}>
            <AreaChart data={data}>
              <defs>
                <linearGradient id="amberGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="#ffa600" stopOpacity={0.3} />
                  <stop offset="100%" stopColor="#ffa600" stopOpacity={0.02} />
                </linearGradient>
              </defs>
              <CartesianGrid stroke="hsl(225, 4%, 17%)" strokeDasharray="3 3" />
              <XAxis
                dataKey="date"
                tickFormatter={formatDateLabel}
                fontSize={12}
                tickLine={false}
                axisLine={false}
                tick={{ fill: '#8a8a8a', fontFamily: 'Manrope' }}
              />
              <YAxis
                domain={[0, 10]}
                fontSize={12}
                tickLine={false}
                axisLine={false}
                tick={{ fill: '#8a8a8a', fontFamily: 'Manrope' }}
              />
              <Tooltip
                labelFormatter={(label) => formatDateLabel(String(label))}
                formatter={(value) => [Number(value).toFixed(1), "Score"]}
                {...CHART_TOOLTIP_STYLE}
              />
              <Area
                type="monotone"
                dataKey="score"
                stroke="#ffa600"
                strokeWidth={2}
                fill="url(#amberGradient)"
                dot={{ r: 3, fill: '#ffa600', stroke: '#ffa600' }}
                activeDot={{ r: 5, fill: '#ffcc8d', stroke: '#ffa600' }}
              />
            </AreaChart>
          </ResponsiveContainer>
        )}
      </CardContent>
    </Card>
  )
}
