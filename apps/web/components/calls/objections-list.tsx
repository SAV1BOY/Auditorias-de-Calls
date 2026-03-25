"use client"

import type { DetectedObjection } from "@/lib/types/audit"

interface ObjectionsListProps { objections: DetectedObjection[] }

export function ObjectionsList({ objections }: ObjectionsListProps) {
  if (objections.length === 0) {
    return <p className="py-4 text-center text-sm text-muted-foreground">Nenhuma obje\u00e7\u00e3o detectada.</p>
  }

  return (
    <div className="space-y-3">
      <h4 className="text-sm font-semibold font-display">Obje\u00e7\u00f5es Detectadas</h4>
      {objections.map((obj, i) => (
        <div key={i} className="rounded-lg bg-surface-interaction/30 p-3 space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-mono text-muted-foreground">{obj.timestamp}</span>
            <span className={`inline-flex items-center gap-1 text-xs font-medium ${obj.effectiveness === "good" ? "text-emerald-400" : "text-red-400"}`}>
              {obj.effectiveness === "good" ? (
                <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" /></svg>
              ) : (
                <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
              )}
              {obj.effectiveness === "good" ? "Boa resposta" : "Resposta fraca"}
            </span>
          </div>
          <div className="space-y-1">
            <p className="text-sm"><strong className="text-muted-foreground">Obje\u00e7\u00e3o:</strong> \u201c{obj.objection}\u201d</p>
            <p className="text-sm"><strong className="text-muted-foreground">Resposta:</strong> \u201c{obj.closer_response}\u201d</p>
          </div>
        </div>
      ))}
    </div>
  )
}
