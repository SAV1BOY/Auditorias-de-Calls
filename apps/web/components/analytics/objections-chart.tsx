"use client"

import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { CHART_COLORS, CHART_GRID, CHART_AXIS_TICK } from "@/lib/utils/chart-theme"

interface Objection { objection: string; count: number; best_response: string }
interface ObjectionsChartProps { objections: Objection[] }

export function ObjectionsChart({ objections }: ObjectionsChartProps) {
  if (objections.length === 0) {
    return (<Card><CardHeader><CardTitle className="text-base">Objeções Mais Comuns</CardTitle></CardHeader><CardContent><p className="text-sm text-muted-foreground">Nenhuma objeção identificada.</p></CardContent></Card>)
  }
  const data = objections.map((o) => ({ name: (o.objection ?? "").length > 40 ? (o.objection ?? "").slice(0, 37) + "..." : (o.objection ?? ""), fullName: o.objection ?? "", count: o.count, best_response: o.best_response }))

  return (
    <Card>
      <CardHeader><CardTitle className="text-base">Objeções Mais Comuns</CardTitle></CardHeader>
      <CardContent className="space-y-4">
        <div className="h-[300px]">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={data} layout="vertical" margin={{ left: 20, right: 20 }}>
              <CartesianGrid {...CHART_GRID} horizontal={false} />
              <XAxis type="number" allowDecimals={false} tick={CHART_AXIS_TICK} />
              <YAxis type="category" dataKey="name" width={180} tick={{ ...CHART_AXIS_TICK, fontSize: 11 }} />
              <Tooltip content={({ active, payload }) => {
                if (!active || !payload?.length) return null
                const item = payload[0].payload as (typeof data)[0]
                return (<div className="glass rounded-lg p-3 shadow-panel max-w-xs"><p className="font-medium text-sm">{item.fullName}</p><p className="text-xs text-muted-foreground mt-1">Ocorrências: {item.count}</p>{item.best_response && <p className="text-xs mt-2"><span className="font-medium">Melhor resposta: </span>{item.best_response}</p>}</div>)
              }} />
              <Bar dataKey="count" radius={[0, 4, 4, 0]}>{data.map((_, i) => (<Cell key={`cell-${i}`} fill={CHART_COLORS[i % CHART_COLORS.length]} />))}</Bar>
            </BarChart>
          </ResponsiveContainer>
        </div>
        <div className="space-y-2">
          {objections.map((o, i) => (<div key={i} className="rounded-md bg-surface-container-high/50 p-3"><p className="text-sm font-medium">{o.objection}</p>{o.best_response && <p className="text-xs text-muted-foreground mt-1">Resposta sugerida: {o.best_response}</p>}</div>))}
        </div>
      </CardContent>
    </Card>
  )
}
