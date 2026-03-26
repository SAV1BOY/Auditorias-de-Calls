"use client"

import { PieChart, Pie, Cell, ResponsiveContainer } from "recharts"

interface ClassificacaoChartProps {
  stats: {
    elite: number
    forte: number
    mediana: number
    fraca: number
  }
}

const COLORS: Record<string, string> = {
  ELITE: "#22c55e",
  FORTE: "#ffa600",
  MEDIANA: "#ffcc8d",
  FRACA: "#ef4444",
}

export function ClassificacaoChart({ stats }: ClassificacaoChartProps) {
  const total = stats.elite + stats.forte + stats.mediana + stats.fraca

  const chartData = [
    { name: "Elite", value: stats.elite, color: COLORS.ELITE },
    { name: "Forte", value: stats.forte, color: COLORS.FORTE },
    { name: "Mediana", value: stats.mediana, color: COLORS.MEDIANA },
    { name: "Fraca", value: stats.fraca, color: COLORS.FRACA },
  ].filter((d) => d.value > 0)

  return (
    <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8 flex flex-col items-center">
      <h3 className="text-xl font-headline font-bold mb-6 w-full text-center">
        Call <span className="text-[#ffa600]">CLASSIFICATION</span>
      </h3>
      <div className="relative w-48 h-48 mb-8">
        <ResponsiveContainer>
          <PieChart>
            <Pie
              data={chartData}
              cx="50%"
              cy="50%"
              innerRadius={55}
              outerRadius={80}
              paddingAngle={3}
              dataKey="value"
              strokeWidth={0}
            >
              {chartData.map((entry, i) => (
                <Cell key={i} fill={entry.color} />
              ))}
            </Pie>
          </PieChart>
        </ResponsiveContainer>
        <div className="absolute inset-0 flex flex-col items-center justify-center">
          <span className="text-3xl font-headline font-bold text-amber-500">{total}</span>
          <span className="font-label text-[9px] uppercase tracking-widest text-stone-500">
            Total Calls
          </span>
        </div>
      </div>
      <div className="w-full space-y-3">
        {chartData.map((item) => (
          <div
            key={item.name}
            className="flex justify-between items-center bg-[#121316]/30 p-2 rounded-lg border border-white/5"
          >
            <div className="flex items-center gap-2">
              <span
                className="w-2 h-2 rounded-full"
                style={{ backgroundColor: item.color }}
              />
              <span className="font-label text-[10px] uppercase font-bold text-stone-400 tracking-widest">
                {item.name}
              </span>
            </div>
            <span className="font-headline font-bold text-sm">{item.value}</span>
          </div>
        ))}
      </div>
    </div>
  )
}
