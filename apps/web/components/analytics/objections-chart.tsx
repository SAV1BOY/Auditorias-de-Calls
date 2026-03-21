"use client"

import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Cell,
} from "recharts"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"

interface Objection {
  objection: string
  count: number
  best_response: string
}

interface ObjectionsChartProps {
  objections: Objection[]
}

export function ObjectionsChart({ objections }: ObjectionsChartProps) {
  if (objections.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Objecoes Mais Comuns</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Nenhuma objecao identificada.</p>
        </CardContent>
      </Card>
    )
  }

  const data = objections.map((o) => ({
    name: o.objection.length > 40 ? o.objection.slice(0, 37) + "..." : o.objection,
    fullName: o.objection,
    count: o.count,
    best_response: o.best_response,
  }))

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Objecoes Mais Comuns</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="h-[300px]">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={data} layout="vertical" margin={{ left: 20, right: 20 }}>
              <CartesianGrid strokeDasharray="3 3" horizontal={false} />
              <XAxis type="number" allowDecimals={false} />
              <YAxis
                type="category"
                dataKey="name"
                width={180}
                tick={{ fontSize: 12 }}
              />
              <Tooltip
                content={({ active, payload }) => {
                  if (!active || !payload?.length) return null
                  const item = payload[0].payload as (typeof data)[0]
                  return (
                    <div className="rounded-lg border bg-background p-3 shadow-md max-w-xs">
                      <p className="font-medium text-sm">{item.fullName}</p>
                      <p className="text-xs text-muted-foreground mt-1">
                        Ocorrencias: {item.count}
                      </p>
                      {item.best_response && (
                        <p className="text-xs mt-2">
                          <span className="font-medium">Melhor resposta: </span>
                          {item.best_response}
                        </p>
                      )}
                    </div>
                  )
                }}
              />
              <Bar dataKey="count" radius={[0, 4, 4, 0]}>
                {data.map((_, index) => (
                  <Cell
                    key={`cell-${index}`}
                    fill={`hsl(${220 + index * 15}, 70%, 55%)`}
                  />
                ))}
              </Bar>
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Response list below the chart */}
        <div className="space-y-2">
          {objections.map((o, i) => (
            <div key={i} className="rounded-md bg-muted/50 p-3">
              <p className="text-sm font-medium">{o.objection}</p>
              {o.best_response && (
                <p className="text-xs text-muted-foreground mt-1">
                  Resposta sugerida: {o.best_response}
                </p>
              )}
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  )
}
