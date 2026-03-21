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

interface AuditTabsProps {
  audit: CallAuditWithCloser
  currentTime?: number
  onSeek?: (sec: number) => void
}

/* ─────────────── SCORECARD TAB ─────────────── */
function ScorecardContent({ audit }: { audit: CallAuditWithCloser }) {
  const hasDimensions = DIMENSIONS.some(
    (d) => (audit as unknown as Record<string, unknown>)[d.id] != null
  )

  if (!hasDimensions) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Scorecard ainda não disponível. A análise precisa ser concluída.
      </p>
    )
  }

  return (
    <div className="space-y-3">
      {DIMENSIONS.map((dim) => {
        const score = (audit as unknown as Record<string, unknown>)[dim.id] as
          | number
          | null
        return (
          <div key={dim.id} className="space-y-1">
            <div className="flex items-center justify-between text-sm">
              <span>
                {dim.name}{" "}
                <span className="text-xs text-muted-foreground">
                  ({(dim.peso * 100).toFixed(0)}%)
                </span>
              </span>
              <span className={`font-medium ${getScoreColor(score)}`}>
                {formatScore(score)}
              </span>
            </div>
            <div className="h-2 rounded-full bg-muted">
              <div
                className={`h-2 rounded-full ${
                  score !== null && score !== undefined
                    ? score >= 8.5
                      ? "bg-emerald-500"
                      : score >= 7.0
                        ? "bg-blue-500"
                        : score >= 5.5
                          ? "bg-amber-500"
                          : "bg-red-500"
                    : "bg-gray-300"
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

/* ─────────────── RELATÓRIO TAB ─────────────── */
function RelatorioContent({ audit }: { audit: CallAuditWithCloser }) {
  if (!audit.relatorio_completo) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Relatório ainda não disponível.
      </p>
    )
  }

  return (
    <div className="prose prose-sm dark:prose-invert max-w-none">
      <ReactMarkdown remarkPlugins={[remarkGfm]}>
        {audit.relatorio_completo}
      </ReactMarkdown>
    </div>
  )
}

/* ─────────────── TRANSCRIÇÃO TAB ─────────────── */
function TranscricaoContent({ audit }: { audit: CallAuditWithCloser }) {
  const [search, setSearch] = useState("")

  if (!audit.transcricao) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Transcrição ainda não disponível.
      </p>
    )
  }

  const lines = audit.transcricao.split("\n")
  const searchLower = search.toLowerCase()

  return (
    <div className="space-y-4">
      <Input
        placeholder="Buscar na transcrição..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />
      <div className="max-h-[600px] overflow-y-auto rounded border p-4 text-sm leading-relaxed">
        {lines.map((line, i) => {
          if (!search) {
            return (
              <p key={i} className="mb-1">
                {line || "\u00A0"}
              </p>
            )
          }
          if (!line.toLowerCase().includes(searchLower)) {
            return (
              <p key={i} className="mb-1 opacity-30">
                {line || "\u00A0"}
              </p>
            )
          }
          // Highlight matches
          const parts = line.split(new RegExp(`(${search.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")})`, "gi"))
          return (
            <p key={i} className="mb-1">
              {parts.map((part, j) =>
                part.toLowerCase() === searchLower ? (
                  <mark key={j} className="bg-yellow-200 dark:bg-yellow-800">
                    {part}
                  </mark>
                ) : (
                  part
                )
              )}
            </p>
          )
        })}
      </div>
    </div>
  )
}

/* ─────────────── ERROS & ACERTOS TAB ─────────────── */
interface TopItem {
  rank: number
  title: string
  description: string
  severity?: string
}

function ErrosAcertosContent({ audit }: { audit: CallAuditWithCloser }) {
  const erros = (audit.top_erros ?? []) as unknown as TopItem[]
  const acertos = (audit.top_acertos ?? []) as unknown as TopItem[]

  if (erros.length === 0 && acertos.length === 0) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Erros e acertos ainda não disponíveis.
      </p>
    )
  }

  return (
    <div className="grid gap-6 md:grid-cols-2">
      <div className="space-y-3">
        <h3 className="font-semibold text-red-600 dark:text-red-400">
          Top Erros
        </h3>
        {erros.length === 0 ? (
          <p className="text-sm text-muted-foreground">Nenhum erro registrado.</p>
        ) : (
          erros.map((item) => (
            <div key={item.rank} className="rounded border border-red-200 p-3 dark:border-red-800">
              <div className="flex items-start gap-2">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-red-100 text-xs font-bold text-red-700 dark:bg-red-900 dark:text-red-300">
                  {item.rank}
                </span>
                <div>
                  <p className="font-medium text-sm">
                    {item.title}
                    {item.severity && (
                      <Badge variant="destructive" className="ml-2 text-xs">
                        {item.severity}
                      </Badge>
                    )}
                  </p>
                  <p className="mt-1 text-xs text-muted-foreground">{item.description}</p>
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      <div className="space-y-3">
        <h3 className="font-semibold text-emerald-600 dark:text-emerald-400">
          Top Acertos
        </h3>
        {acertos.length === 0 ? (
          <p className="text-sm text-muted-foreground">Nenhum acerto registrado.</p>
        ) : (
          acertos.map((item) => (
            <div key={item.rank} className="rounded border border-emerald-200 p-3 dark:border-emerald-800">
              <div className="flex items-start gap-2">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-emerald-100 text-xs font-bold text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300">
                  {item.rank}
                </span>
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

/* ─────────────── REESCRITA TAB ─────────────── */
interface ReescritaItem {
  description: string
  original?: string
  rewritten?: string
  reason?: string
  impact?: string
}

function ReescritaContent({ audit }: { audit: CallAuditWithCloser }) {
  const items = (audit.reescrita_falas ?? []) as unknown as ReescritaItem[]

  if (items.length === 0) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Reescrita de falas ainda não disponível.
      </p>
    )
  }

  return (
    <div className="space-y-6">
      {items.map((item, i) => (
        <div key={i} className="rounded border p-4 space-y-3">
          <h4 className="font-semibold text-sm">
            Momento {i + 1}: {item.description}
          </h4>
          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-1">
              <p className="text-xs font-medium text-red-600 dark:text-red-400 uppercase">
                O que foi dito
              </p>
              <p className="rounded bg-red-50 p-3 text-sm dark:bg-red-950">
                {item.original ?? "—"}
              </p>
            </div>
            <div className="space-y-1">
              <p className="text-xs font-medium text-emerald-600 dark:text-emerald-400 uppercase">
                O que deveria ter sido dito
              </p>
              <p className="rounded bg-emerald-50 p-3 text-sm dark:bg-emerald-950">
                {item.rewritten ?? "—"}
              </p>
            </div>
          </div>
          {item.reason && (
            <p className="text-xs text-muted-foreground">
              <strong>Por quê:</strong> {item.reason}
            </p>
          )}
          {item.impact && (
            <p className="text-xs text-muted-foreground">
              <strong>Impacto estimado:</strong> {item.impact}
            </p>
          )}
        </div>
      ))}
    </div>
  )
}

/* ─────────────── PLANO DE AÇÃO TAB ─────────────── */
interface PlanoItem {
  rank: number
  title: string
  o_que_fazer?: string
  por_que?: string
  como_treinar?: string
  prioridade?: string
}

function PlanoAcaoContent({ audit }: { audit: CallAuditWithCloser }) {
  const items = (audit.plano_acao ?? []) as unknown as PlanoItem[]

  if (items.length === 0) {
    return (
      <p className="py-8 text-center text-muted-foreground">
        Plano de ação ainda não disponível.
      </p>
    )
  }

  return (
    <div className="space-y-4">
      {items.map((item) => (
        <div key={item.rank} className="rounded border p-4 space-y-2">
          <div className="flex items-center gap-2">
            <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-blue-100 text-sm font-bold text-blue-700 dark:bg-blue-900 dark:text-blue-300">
              {item.rank}
            </span>
            <h4 className="font-semibold text-sm">{item.title}</h4>
            {item.prioridade && (
              <Badge variant="outline" className="ml-auto text-xs">
                {item.prioridade}
              </Badge>
            )}
          </div>
          {item.o_que_fazer && (
            <p className="text-sm">
              <strong className="text-muted-foreground">O que fazer:</strong>{" "}
              {item.o_que_fazer}
            </p>
          )}
          {item.por_que && (
            <p className="text-sm">
              <strong className="text-muted-foreground">Por quê:</strong>{" "}
              {item.por_que}
            </p>
          )}
          {item.como_treinar && (
            <p className="text-sm">
              <strong className="text-muted-foreground">Como treinar:</strong>{" "}
              {item.como_treinar}
            </p>
          )}
        </div>
      ))}
    </div>
  )
}

/* ─────────────── SENTIMENTO TAB ─────────────── */
function SentimentoContent({ audit }: { audit: CallAuditWithCloser }) {
  const raw = audit as unknown as Record<string, unknown>
  const timeline = (raw.sentiment_timeline ?? []) as unknown as SentimentTimelineEntry[]
  const objections = (raw.objections_detected ?? []) as unknown as DetectedObjection[]
  const overallSentiment = (raw.sentiment_overall as string) ?? "neutral"
  const sentimentScore = (raw.sentiment_score as number) ?? 0
  const engagementLevel = (raw.engagement_level as string) ?? "medium"

  return (
    <div className="space-y-6">
      <SentimentTimeline
        timeline={timeline}
        overallSentiment={overallSentiment}
        sentimentScore={sentimentScore}
      />
      <EngagementMeter level={engagementLevel} />
      <ObjectionsList objections={objections} />
    </div>
  )
}

/* ─────────────── MAIN TABS COMPONENT ─────────────── */
export function AuditTabs({ audit, currentTime, onSeek }: AuditTabsProps) {
  return (
    <Tabs defaultValue="scorecard">
      <TabsList className="flex-wrap">
        <TabsTrigger value="scorecard">Scorecard</TabsTrigger>
        <TabsTrigger value="relatorio">Relatório</TabsTrigger>
        <TabsTrigger value="transcricao">Transcrição</TabsTrigger>
        <TabsTrigger value="erros">Erros & Acertos</TabsTrigger>
        <TabsTrigger value="reescrita">Reescrita</TabsTrigger>
        <TabsTrigger value="plano">Plano de Ação</TabsTrigger>
        <TabsTrigger value="sentimento">Sentimento</TabsTrigger>
        <TabsTrigger value="coaching">Coaching</TabsTrigger>
      </TabsList>

      <TabsContent value="scorecard">
        <Card>
          <CardHeader>
            <CardTitle>Scorecard — 13 Dimensões</CardTitle>
          </CardHeader>
          <CardContent>
            <ScorecardContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="relatorio">
        <Card>
          <CardHeader>
            <CardTitle>Relatório Completo</CardTitle>
          </CardHeader>
          <CardContent>
            <RelatorioContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="transcricao">
        <Card>
          <CardHeader>
            <CardTitle>Transcrição</CardTitle>
          </CardHeader>
          <CardContent>
            <TranscricaoContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="erros">
        <Card>
          <CardHeader>
            <CardTitle>Erros & Acertos</CardTitle>
          </CardHeader>
          <CardContent>
            <ErrosAcertosContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="reescrita">
        <Card>
          <CardHeader>
            <CardTitle>Reescrita de Falas</CardTitle>
          </CardHeader>
          <CardContent>
            <ReescritaContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="plano">
        <Card>
          <CardHeader>
            <CardTitle>Plano de Ação</CardTitle>
          </CardHeader>
          <CardContent>
            <PlanoAcaoContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="sentimento">
        <Card>
          <CardHeader>
            <CardTitle>Análise de Sentimento</CardTitle>
          </CardHeader>
          <CardContent>
            <SentimentoContent audit={audit} />
          </CardContent>
        </Card>
      </TabsContent>

      <TabsContent value="coaching">
        <Card>
          <CardHeader>
            <CardTitle>Coaching</CardTitle>
          </CardHeader>
          <CardContent>
            <CommentsPanel
              auditId={audit.id}
              currentTime={currentTime}
              onSeek={onSeek}
            />
          </CardContent>
        </Card>
      </TabsContent>
    </Tabs>
  )
}
