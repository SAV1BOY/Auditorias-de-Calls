"use client"

import type { DetectedObjection } from "@/lib/types/audit"

interface ObjectionsListProps { objections: DetectedObjection[] }

export function ObjectionsList({ objections }: ObjectionsListProps) {
  if (objections.length === 0) {
    return <p className="py-4 text-center text-sm text-muted-foreground">Nenhuma objeção detectada.</p>
  }

  return (
    <div className="space-y-3">
      <h4 className="text-sm font-semibold font-headline">Objeções Detectadas</h4>
      {objections.map((obj, i) => {
        // Handle both formats: new {objection, closer_response, effectiveness, timestamp}
        // and legacy {text, type, handled}
        const raw = obj as unknown as Record<string, unknown>
        const objectionText = String(raw.objection ?? raw.text ?? raw.verbatim ?? "")
        const closerResponse = String(raw.closer_response ?? "")
        const timestamp = String(raw.timestamp ?? "")
        const isGood = raw.effectiveness === "good" || raw.handled === true

        return (
          <div key={i} className="rounded-lg bg-surface-container-high/30 p-3 space-y-2">
            <div className="flex items-center justify-between">
              {timestamp ? (
                <span className="text-xs font-mono text-muted-foreground">{timestamp}</span>
              ) : (
                <span className="text-xs text-muted-foreground capitalize">{String(raw.type ?? "")}</span>
              )}
              <span className={`inline-flex items-center gap-1 text-xs font-medium ${isGood ? "text-emerald-400" : "text-red-400"}`}>
                {isGood ? (
                  <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" /></svg>
                ) : (
                  <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
                )}
                {isGood ? "Boa resposta" : "Resposta fraca"}
              </span>
            </div>
            <div className="space-y-1">
              <p className="text-sm"><strong className="text-muted-foreground">Objeção:</strong> &ldquo;{objectionText}&rdquo;</p>
              {closerResponse && (
                <p className="text-sm"><strong className="text-muted-foreground">Resposta:</strong> &ldquo;{closerResponse}&rdquo;</p>
              )}
            </div>
          </div>
        )
      })}
    </div>
  )
}
