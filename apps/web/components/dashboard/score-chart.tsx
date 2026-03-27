"use client"

import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts"

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
    <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] p-8">
      <div className="flex justify-between items-center mb-10">
        <h3 className="text-xl font-headline font-bold">
          {title}
        </h3>
        <div className="flex gap-4">
          <span className="text-[10px] font-bold text-stone-500 uppercase tracking-widest border-b-2 border-[#ffa600] pb-1">
            Monthly
          </span>
          <span className="text-[10px] font-bold text-stone-700 uppercase tracking-widest pb-1 hover:text-stone-500 cursor-pointer transition-colors">
            Weekly
          </span>
        </div>
      </div>
      {data.length === 0 ? (
        <p className="py-12 text-center text-sm text-stone-500">
          Nenhum dado de score disponível.
        </p>
      ) : (
        <ResponsiveContainer width="100%" height={280}>
          <AreaChart data={data}>
            <defs>
              <linearGradient id="scoreGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stopColor="#ffa600" stopOpacity={0.3} />
                <stop offset="100%" stopColor="#ffa600" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid stroke="rgba(255,255,255,0.05)" strokeDasharray="3 3" />
            <XAxis
              dataKey="date"
              tickFormatter={formatDateLabel}
              stroke="rgba(255,255,255,0.1)"
              tick={{ fill: "#7f8c8d", fontSize: 10 }}
              axisLine={false}
              tickLine={false}
            />
            <YAxis
              domain={[0, 10]}
              stroke="rgba(255,255,255,0.1)"
              tick={{ fill: "#7f8c8d", fontSize: 10 }}
              axisLine={false}
              tickLine={false}
            />
            <Tooltip
              contentStyle={{
                backgroundColor: "#292a2d",
                border: "1px solid rgba(255,255,255,0.05)",
                borderRadius: "0.75rem",
                fontSize: 12,
              }}
              labelStyle={{ color: "#ffa600", fontWeight: "bold" }}
              itemStyle={{ color: "#e3e2e5" }}
              labelFormatter={(label) => formatDateLabel(String(label))}
              formatter={(value) => [Number(value).toFixed(1), "Score"]}
            />
            <Area
              type="monotone"
              dataKey="score"
              stroke="#ffa600"
              strokeWidth={3}
              fill="url(#scoreGrad)"
              dot={false}
              activeDot={{ r: 6, fill: "#ffa600", stroke: "#121316", strokeWidth: 2 }}
            />
          </AreaChart>
        </ResponsiveContainer>
      )}
    </div>
  )
}
