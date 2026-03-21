"use client"

import type { DetectedObjection } from "@/lib/types/audit"

interface ObjectionsListProps {
  objections: DetectedObjection[]
}

export function ObjectionsList({ objections }: ObjectionsListProps) {
  if (objections.length === 0) {
    return (
      <p className="py-4 text-center text-sm text-muted-foreground">
        Nenhuma objeção detectada.
      </p>
    )
  }

  return (
    <div className="space-y-3">
      <h4 className="text-sm font-semibold">Objeções Detectadas</h4>
      {objections.map((obj, i) => (
        <div key={i} className="rounded border p-3 space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-mono text-muted-foreground">
              {obj.timestamp}
            </span>
            <span
              className={`inline-flex items-center gap-1 text-xs font-medium ${
                obj.effectiveness === "good"
                  ? "text-emerald-600 dark:text-emerald-400"
                  : "text-red-600 dark:text-red-400"
              }`}
            >
              {obj.effectiveness === "good" ? (
                <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                </svg>
              ) : (
                <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              )}
              {obj.effectiveness === "good" ? "Boa resposta" : "Resposta fraca"}
            </span>
          </div>
          <div className="space-y-1">
            <p className="text-sm">
              <strong className="text-muted-foreground">Objeção:</strong>{" "}
              &ldquo;{obj.objection}&rdquo;
            </p>
            <p className="text-sm">
              <strong className="text-muted-foreground">Resposta:</strong>{" "}
              &ldquo;{obj.closer_response}&rdquo;
            </p>
          </div>
        </div>
      ))}
    </div>
  )
}
