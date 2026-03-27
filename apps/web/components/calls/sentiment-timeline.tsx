"use client"

import type { SentimentTimelineEntry } from "@/lib/types/audit"
import { SENTIMENT_LABELS, SENTIMENT_COLORS } from "@/lib/utils/constants"
import { SentimentBadge } from "./sentiment-badge"

interface SentimentTimelineProps {
  timeline: SentimentTimelineEntry[]
  overallSentiment: string
  sentimentScore: number
}

function getScoreColor(score: number): string {
  if (score >= 0.3) return "#4ade80"
  if (score >= -0.3) return "#8a8a8a"
  return "#f87171"
}

export function SentimentTimeline({ timeline, overallSentiment, sentimentScore }: SentimentTimelineProps) {
  if (timeline.length === 0 && overallSentiment === "neutral" && sentimentScore === 0) {
    return <p className="py-8 text-center text-muted-foreground">Análise de sentimento ainda não disponível.</p>
  }

  const scoreColor = getScoreColor(sentimentScore)

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center gap-4">
        <div className="flex items-center gap-2">
          <span className="text-sm text-muted-foreground">Sentimento Geral:</span>
          <SentimentBadge sentiment={overallSentiment} />
        </div>
        <div className="flex items-center gap-2">
          <span className="text-sm text-muted-foreground">Score:</span>
          <span className="text-lg font-bold font-body" style={{ color: scoreColor }}>
            {sentimentScore > 0 ? "+" : ""}{sentimentScore.toFixed(2)}
          </span>
        </div>
      </div>

      {timeline.length > 0 && (
        <div className="space-y-3">
          <h4 className="text-sm font-semibold font-headline">Timeline de Sentimento</h4>
          <div className="flex h-8 overflow-hidden rounded-md">
            {timeline.map((entry, i) => {
              const color = SENTIMENT_COLORS[entry.sentiment] ?? "#8a8a8a"
              return (
                <div key={i} className="flex-1 flex items-center justify-center text-[10px] font-medium text-white transition-opacity hover:opacity-80" style={{ backgroundColor: color }} title={`${entry.timestamp_range}: ${SENTIMENT_LABELS[entry.sentiment] ?? entry.sentiment} (${(entry.confidence * 100).toFixed(0)}%)`}>
                  {entry.timestamp_range}
                </div>
              )
            })}
          </div>
          <div className="space-y-2">
            {timeline.map((entry, i) => {
              const color = SENTIMENT_COLORS[entry.sentiment] ?? "#8a8a8a"
              return (
                <div key={i} className="flex items-start gap-3 rounded-lg bg-surface-container-high/30 p-3">
                  <div className="mt-0.5 h-3 w-3 shrink-0 rounded-full" style={{ backgroundColor: color }} />
                  <div className="flex-1 space-y-1">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-medium font-body">{entry.timestamp_range}</span>
                      <div className="flex items-center gap-2">
                        <SentimentBadge sentiment={entry.sentiment} />
                        <span className="text-xs text-muted-foreground font-body">{(entry.confidence * 100).toFixed(0)}% conf.</span>
                      </div>
                    </div>
                    <p className="text-xs text-muted-foreground">{entry.key_moment}</p>
                  </div>
                </div>
              )
            })}
          </div>
        </div>
      )}
    </div>
  )
}
