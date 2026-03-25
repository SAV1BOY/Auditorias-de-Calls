"use client"

import { useState } from "react"
import ReactMarkdown from "react-markdown"
import remarkGfm from "remark-gfm"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Input } from "@/components/ui/input"
import type { CallAuditWithCloser, SentimentTimelineEntry, DetectedObjection } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { formatScore } from "@/lib/utils/format"
import { getScoreColor } from "@/lib/utils/colors"
import { CommentsPanel } from "./comments-panel"
import { SentimentTimeline } from "./sentiment-timeline"
import { EngagementMeter } from "./engagement-meter"
import { ObjectionsList } from "./objections-list"
import { SupervisorTabContent } from "./supervisor-tab-content"

interface AuditTabsProps {
  audit: CallAuditWithCloser
  currentTime?: number
  onSeek?: (sec: number) => void
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 SCORECARD TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
function ScorecardContent({ audit }: { audit: CallAuditWithCloser }) {
  const hasDimensions = DIMENSIONS.some(
    (d) => (audit as unknown as Record<string, unknown>)[d.id] != null
  )

  if (!hasDimensions) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Scorecard ainda n\u00e3o dispon\u00edvel. A an\u00e1lise precisa ser conclu\u00edda.
      </p>
    )
  }

  return (
    <div className="space-y-3">
      {DIMENSIONS.map((dim) => {
        const score = (audit as unknown as Record<string, unknown>)[dim.id] as number | null
        return (
          <div key={dim.id} className="space-y-1">
            <div className="flex items-center justify-between text-sm">
              <span>
                {dim.name}{" "}
                <span className="text-xs text-muted-foreground">({(dim.peso * 100).toFixed(0)}%)</span>
              </span>
              <span className={`font-medium font-technical ${getScoreColor(score)}`}>{formatScore(score)}</span>
            </div>
            <div className="h-2 rounded-full bg-surface-interaction">
              <div
                className={`h-2 rounded-full transition-all duration-500 ${
                  score !== null && score !== undefined
                    ? score >= 8.5 ? "bg-amber-400" : score >= 7.0 ? "bg-emerald-500" : score >= 5.5 ? "bg-yellow-500" : "bg-red-500"
                    : "bg-surface-highest"
                }`}
                style={{ width: `${((score ?? 0) / 10) * 100}%` }}
              />
            </div>
          </div>
        )
      })}
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 RELAT\u00d3RIO TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
function RelatorioContent({ audit }: { audit: CallAuditWithCloser }) {
  if (!audit.relatorio_completo) {
    return <p className="py-8 text-center text-muted-foreground">Relat\u00f3rio ainda n\u00e3o dispon\u00edvel.</p>
  }
  return (
    <div className="prose prose-sm dark:prose-invert max-w-none">
      <ReactMarkdown remarkPlugins={[remarkGfm]}>{audit.relatorio_completo}</ReactMarkdown>
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 TRANSCRI\u00c7\u00c3O TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
function TranscricaoContent({ audit }: { audit: CallAuditWithCloser }) {
  const [search, setSearch] = useState("")

  if (!audit.transcricao) {
    return <p className="py-8 text-center text-muted-foreground">Transcri\u00e7\u00e3o ainda n\u00e3o dispon\u00edvel.</p>
  }

  const lines = audit.transcricao.split("\n")
  const searchLower = search.toLowerCase()

  return (
    <div className="space-y-4">
      <Input placeholder="Buscar na transcri\u00e7\u00e3o..." value={search} onChange={(e) => setSearch(e.target.value)} />
      <div className="max-h-[600px] overflow-y-auto rounded-lg bg-surface-interaction/30 p-4 text-sm leading-relaxed">
        {lines.map((line, i) => {
          if (!search) return <p key={i} className="mb-1">{line || "\u00A0"}</p>
          if (!line.toLowerCase().includes(searchLower)) return <p key={i} className="mb-1 opacity-30">{line || "\u00A0"}</p>
          const parts = line.split(new RegExp(`(${search.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")})`, "gi"))
          return (
            <p key={i} className="mb-1">
              {parts.map((part, j) =>
                part.toLowerCase() === searchLower
                  ? <mark key={j} className="bg-amber-900/40 text-amber-200 rounded px-0.5">{part}</mark>
                  : part
              )}
            </p>
          )
        })}
      </div>
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 ERROS & ACERTOS TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
interface TopItem { rank: number; title: string; description: string; severity?: string }

function ErrosAcertosContent({ audit }: { audit: CallAuditWithCloser }) {
  const erros = (audit.top_erros ?? []) as unknown as TopItem[]
  const acertos = (audit.top_acertos ?? []) as unknown as TopItem[]

  if (erros.length === 0 && acertos.length === 0) {
    return <p className="py-8 text-center text-muted-foreground">Erros e acertos ainda n\u00e3o dispon\u00edveis.</p>
  }

  return (
    <div className="grid gap-6 md:grid-cols-2">
      <div className="space-y-3">
        <h3 className="font-semibold font-display text-red-400">Top Erros</h3>
        {erros.length === 0 ? <p className="text-sm text-muted-foreground">Nenhum erro registrado.</p> : (
          erros.map((item) => (
            <div key={item.rank} className="rounded-lg bg-red-900/20 p-3">
              <div className="flex items-start gap-2">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-red-900/30 text-xs font-bold text-red-400 font-technical">{item.rank}</span>
                <div>
                  <p className="font-medium text-sm">
                    {item.title}
                    {item.severity && <Badge variant="destructive" className="ml-2 text-xs">{item.severity}</Badge>}
                  </p>
                  <p className="mt-1 text-xs text-muted-foreground">{item.description}</p>
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      <div className="space-y-3">
        <h3 className="font-semibold font-display text-emerald-400">Top Acertos</h3>
        {acertos.length === 0 ? <p className="text-sm text-muted-foreground">Nenhum acerto registrado.</p> : (
          acertos.map((item) => (
            <div key={item.rank} className="rounded-lg bg-emerald-900/20 p-3">
              <div className="flex items-start gap-2">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-emerald-900/30 text-xs font-bold text-emerald-400 font-technical">{item.rank}</span>
                <div>
                  <p className="font-medium text-sm">{item.title}</p>
                  <p className="mt-1 text-xs text-muted-foreground">{item.description}</p>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 REESCRITA TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
interface ReescritaItem { description: string; original?: string; rewritten?: string; reason?: string; impact?: string }

function ReescritaContent({ audit }: { audit: CallAuditWithCloser }) {
  const items = (audit.reescrita_falas ?? []) as unknown as ReescritaItem[]
  if (items.length === 0) return <p className="py-8 text-center text-muted-foreground">Reescrita de falas ainda n\u00e3o dispon\u00edvel.</p>

  return (
    <div className="space-y-6">
      {items.map((item, i) => (
        <div key={i} className="rounded-lg bg-surface-interaction/30 p-4 space-y-3">
          <h4 className="font-semibold text-sm font-display">Momento {i + 1}: {item.description}</h4>
          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-1">
              <p className="text-xs font-medium text-red-400 uppercase font-technical">O que foi dito</p>
              <p className="rounded-lg bg-red-950/50 p-3 text-sm">{item.original ?? "\u2014"}</p>
            </div>
            <div className="space-y-1">
              <p className="text-xs font-medium text-emerald-400 uppercase font-technical">O que deveria ter sido dito</p>
              <p className="rounded-lg bg-emerald-950/50 p-3 text-sm">{item.rewritten ?? "\u2014"}</p>
            </div>
          </div>
          {item.reason && <p className="text-xs text-muted-foreground"><strong>Por qu\u00ea:</strong> {item.reason}</p>}
          {item.impact && <p className="text-xs text-muted-foreground"><strong>Impacto estimado:</strong> {item.impact}</p>}
        </div>
      ))}
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 PLANO DE A\u00c7\u00c3O TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
interface PlanoItem { rank: number; title: string; o_que_fazer?: string; por_que?: string; como_treinar?: string; prioridade?: string }

function PlanoAcaoContent({ audit }: { audit: CallAuditWithCloser }) {
  const items = (audit.plano_acao ?? []) as unknown as PlanoItem[]
  if (items.length === 0) return <p className="py-8 text-center text-muted-foreground">Plano de a\u00e7\u00e3o ainda n\u00e3o dispon\u00edvel.</p>

  return (
    <div className="space-y-4">
      {items.map((item) => (
        <div key={item.rank} className="rounded-lg bg-surface-interaction/30 p-4 space-y-2">
          <div className="flex items-center gap-2">
            <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-blue-900/30 text-sm font-bold text-blue-400 font-technical">{item.rank}</span>
            <h4 className="font-semibold text-sm font-display">{item.title}</h4>
            {item.prioridade && <Badge variant="outline" className="ml-auto text-xs">{item.prioridade}</Badge>}
          </div>
          {item.o_que_fazer && <p className="text-sm"><strong className="text-muted-foreground">O que fazer:</strong> {item.o_que_fazer}</p>}
          {item.por_que && <p className="text-sm"><strong className="text-muted-foreground">Por qu\u00ea:</strong> {item.por_que}</p>}
          {item.como_treinar && <p className="text-sm"><strong className="text-muted-foreground">Como treinar:</strong> {item.como_treinar}</p>}
        </div>
      ))}
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 SENTIMENTO TAB \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
function SentimentoContent({ audit }: { audit: CallAuditWithCloser }) {
  const raw = audit as unknown as Record<string, unknown>
  const timeline = (raw.sentiment_timeline ?? []) as unknown as SentimentTimelineEntry[]
  const objections = (raw.objections_detected ?? []) as unknown as DetectedObjection[]
  const overallSentiment = (raw.sentiment_overall as string) ?? "neutral"
  const sentimentScore = (raw.sentiment_score as number) ?? 0
  const engagementLevel = (raw.engagement_level as string) ?? "medium"

  return (
    <div className="space-y-6">
      <SentimentTimeline timeline={timeline} overallSentiment={overallSentiment} sentimentScore={sentimentScore} />
      <EngagementMeter level={engagementLevel} />
      <ObjectionsList objections={objections} />
    </div>
  )
}

/* \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 MAIN TABS COMPONENT \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500 */
export function AuditTabs({ audit, currentTime, onSeek }: AuditTabsProps) {
  return (
    <Tabs defaultValue="scorecard">
      <TabsList className="flex-wrap">
        <TabsTrigger value="scorecard">Scorecard</TabsTrigger>
        <TabsTrigger value="relatorio">Relat\u00f3rio</TabsTrigger>
        <TabsTrigger value="transcricao">Transcri\u00e7\u00e3o</TabsTrigger>
        <TabsTrigger value="erros">Erros & Acertos</TabsTrigger>
        <TabsTrigger value="reescrita">Reescrita</TabsTrigger>
        <TabsTrigger value="plano">Plano de A\u00e7\u00e3o</TabsTrigger>
        <TabsTrigger value="sentimento">Sentimento</TabsTrigger>
        <TabsTrigger value="coaching">Coaching</TabsTrigger>
        <TabsTrigger value="supervisor">Supervisor</TabsTrigger>
      </TabsList>

      <TabsContent value="scorecard"><Card><CardHeader><CardTitle>Scorecard \u2014 13 Dimens\u00f5es</CardTitle></CardHeader><CardContent><ScorecardContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="relatorio"><Card><CardHeader><CardTitle>Relat\u00f3rio Completo</CardTitle></CardHeader><CardContent><RelatorioContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="transcricao"><Card><CardHeader><CardTitle>Transcri\u00e7\u00e3o</CardTitle></CardHeader><CardContent><TranscricaoContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="erros"><Card><CardHeader><CardTitle>Erros & Acertos</CardTitle></CardHeader><CardContent><ErrosAcertosContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="reescrita"><Card><CardHeader><CardTitle>Reescrita de Falas</CardTitle></CardHeader><CardContent><ReescritaContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="plano"><Card><CardHeader><CardTitle>Plano de A\u00e7\u00e3o</CardTitle></CardHeader><CardContent><PlanoAcaoContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="sentimento"><Card><CardHeader><CardTitle>An\u00e1lise de Sentimento</CardTitle></CardHeader><CardContent><SentimentoContent audit={audit} /></CardContent></Card></TabsContent>
      <TabsContent value="coaching"><Card><CardHeader><CardTitle>Coaching</CardTitle></CardHeader><CardContent><CommentsPanel auditId={audit.id} currentTime={currentTime} onSeek={onSeek} /></CardContent></Card></TabsContent>
      <TabsContent value="supervisor"><Card><CardHeader><CardTitle>An\u00e1lise do Supervisor</CardTitle></CardHeader><CardContent><SupervisorTabContent auditId={audit.id} /></CardContent></Card></TabsContent>
    </Tabs>
  )
}
