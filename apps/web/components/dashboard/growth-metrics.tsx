"use client"

import { AreaChart, Area, ResponsiveContainer, XAxis, Tooltip } from "recharts"

interface GrowthMetricsProps {
  data: Array<{ date: string; value: number }>
  value: string
  label: string
}

export function GrowthMetrics({ data, value, label }: GrowthMetricsProps) {
  return (
    <div className="bg-surface-container-low rounded-xl p-8 border-l-4 border-primary-container shadow-panel relative overflow-hidden">
      <div className="flex justify-between items-end mb-8">
        <div>
          <h2 className="font-headline text-3xl font-bold mb-2">
            Closing <span className="text-[#ffa600]">RATE</span>
          </h2>
          <p className="text-on-surface-variant/60 text-sm">
            Taxa de fechamento ao longo do tempo
          </p>
        </div>
        <div className="text-right">
          <span className="text-4xl font-headline font-bold">{value}</span>
          <p className="font-label text-[10px] uppercase tracking-widest text-primary-container font-bold">
            {label}
          </p>
        </div>
      </div>
      {data.length > 0 ? (
        <ResponsiveContainer width="100%" height={200}>
          <AreaChart data={data}>
            <defs>
              <linearGradient id="growthGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0%" stopColor="#ffa600" stopOpacity={0.3} />
                <stop offset="100%" stopColor="#ffa600" stopOpacity={0} />
              </linearGradient>
            </defs>
            <XAxis dataKey="date" hide />
            <Tooltip
              contentStyle={{
                backgroundColor: "#292a2d",
                border: "1px solid rgba(255,255,255,0.05)",
                borderRadius: "0.75rem",
              }}
              labelStyle={{ color: "#ffa600" }}
            />
            <Area
              type="monotone"
              dataKey="value"
              stroke="#ffa600"
              strokeWidth={3}
              fill="url(#growthGrad)"
              dot={false}
            />
          </AreaChart>
        </ResponsiveContainer>
      ) : (
        <div className="h-[200px] flex items-center justify-center text-stone-500 text-sm">
          Dados insuficientes para gráfico
        </div>
      )}
    </div>
  )
}
