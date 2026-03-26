"use client"

import { useState, useTransition } from "react"
import Link from "next/link"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import {
  ArrowLeft,
  Calendar,
  Clock,
  Download,
  ExternalLink,
  Send,
  User,
} from "lucide-react"
import type { CallAuditWithCloser, Classificacao } from "@/lib/types/audit"
import {
  formatDate,
  formatScore,
  formatDuration,
  formatCurrency,
} from "@/lib/utils/format"
import { getClassificacaoColor, getScoreColor } from "@/lib/utils/colors"
import { RESULTADO_LABELS } from "@/lib/utils/constants"
import { ProcessingStatus } from "./processing-status"
import { BookmarkButton } from "./bookmark-button"
import { ExportPdfButton } from "./export-pdf-button"
import { resendNotification } from "@/lib/actions/calls"

interface AuditHeaderProps {
  audit: CallAuditWithCloser
}

export function AuditHeader({ audit }: AuditHeaderProps) {
  const [isPending, startTransition] = useTransition()
  const [notifMsg, setNotifMsg] = useState<string | null>(null)

  function handleDownloadReport() {
    if (!audit.relatorio_completo) return
    const blob = new Blob([audit.relatorio_completo], {
      type: "text/markdown",
    })
    const url = URL.createObjectURL(blob)
    const a = document.createElement("a")
    a.href = url
    a.download = `relatorio-${audit.lead_name}-${audit.call_date}.md`
    a.click()
    URL.revokeObjectURL(url)
  }

  function handleResendNotification() {
    startTransition(async () => {
      const result = await resendNotification(audit.id)
      setNotifMsg(result.error ?? "Notifica\u00e7\u00e3o reenviada!")
      setTimeout(() => setNotifMsg(null), 3000)
    })
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center gap-2">
        <Button variant="ghost" size="sm" asChild>
          <Link href="/calls">
            <ArrowLeft className="mr-1 h-4 w-4" />
            Voltar
          </Link>
        </Button>
      </div>

      <Card>
        <CardContent className="pt-6">
          <div className="flex flex-col gap-6 md:flex-row md:items-start md:justify-between">
            {/* Left: metadata */}
            <div className="space-y-3">
              <div className="flex items-center gap-2">
                <h1 className="text-2xl font-bold font-headline">
                  {audit.closers?.name ?? "\u2014"} x <span className="amber-keyword">{audit.lead_name}</span>
                </h1>
                <BookmarkButton auditId={audit.id} />
              </div>

              <div className="flex flex-wrap items-center gap-4 text-sm text-muted-foreground">
                <span className="flex items-center gap-1">
                  <Calendar className="h-4 w-4" />
                  {formatDate(audit.call_date)}
                </span>
                <span className="flex items-center gap-1">
                  <Clock className="h-4 w-4" />
                  {formatDuration(audit.duration_minutes)}
                </span>
                <span className="flex items-center gap-1">
                  <User className="h-4 w-4" />
                  {audit.resultado
                    ? RESULTADO_LABELS[audit.resultado] ?? audit.resultado
                    : "\u2014"}
                  {audit.resultado === "fechamento" &&
                    audit.valor_fechamento && (
                      <span className="ml-1 font-medium font-body text-emerald-400">
                        ({formatCurrency(audit.valor_fechamento)})
                      </span>
                    )}
                </span>
              </div>

              <div className="flex items-center gap-2">
                <ProcessingStatus
                  auditId={audit.id}
                  initialStatus={audit.status}
                />
              </div>

              {/* Drive links */}
              {(audit.drive_url || audit.drive_report_url) && (
                <div className="flex flex-wrap items-center gap-3 text-sm">
                  {audit.drive_url && (
                    <a
                      href={audit.drive_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="flex items-center gap-1 text-on-surface-variant hover:text-primary transition-colors"
                    >
                      <ExternalLink className="h-3 w-3" />
                      \u00c1udio no Drive
                    </a>
                  )}
                  {audit.drive_report_url && (
                    <a
                      href={audit.drive_report_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="flex items-center gap-1 text-on-surface-variant hover:text-primary transition-colors"
                    >
                      <ExternalLink className="h-3 w-3" />
                      Relat\u00f3rio no Drive
                    </a>
                  )}
                </div>
              )}

              {/* Action buttons */}
              <div className="flex flex-wrap items-center gap-2 pt-1">
                {audit.relatorio_completo && (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={handleDownloadReport}
                  >
                    <Download className="mr-1 h-4 w-4" />
                    Download Relat\u00f3rio
                  </Button>
                )}
                {(audit.status === "completed" ||
                  audit.status === "analyzed") && (
                  <ExportPdfButton auditId={audit.id} />
                )}
                {(audit.status === "completed" ||
                  audit.status === "analyzed") && (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={handleResendNotification}
                    disabled={isPending}
                  >
                    <Send className="mr-1 h-4 w-4" />
                    {isPending ? "Enviando..." : "Reenviar Notif."}
                  </Button>
                )}
                {notifMsg && (
                  <span className="text-xs text-muted-foreground">
                    {notifMsg}
                  </span>
                )}
              </div>
            </div>

            {/* Right: score */}
            <div className="flex flex-col items-center gap-1">
              <span
                className={`text-5xl font-bold font-body ${getScoreColor(audit.score_final)}`}
              >
                {formatScore(audit.score_final)}
              </span>
              <span className="text-sm text-muted-foreground font-body">/10</span>
              {audit.classificacao && (
                <Badge
                  variant="secondary"
                  className={`mt-1 text-sm ${getClassificacaoColor(audit.classificacao as Classificacao)}`}
                >
                  {audit.classificacao}
                </Badge>
              )}
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
