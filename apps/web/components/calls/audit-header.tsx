import Link from "next/link"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { ArrowLeft, Calendar, Clock, User } from "lucide-react"
import type { CallAuditWithCloser, Classificacao } from "@/lib/types/audit"
import { formatDate, formatScore, formatDuration } from "@/lib/utils/format"
import { getClassificacaoColor, getScoreColor } from "@/lib/utils/colors"
import { RESULTADO_LABELS } from "@/lib/utils/constants"
import { ProcessingStatus } from "./processing-status"

interface AuditHeaderProps {
  audit: CallAuditWithCloser
}

export function AuditHeader({ audit }: AuditHeaderProps) {
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
              <h1 className="text-2xl font-bold">
                {audit.closers?.name ?? "—"} x {audit.lead_name}
              </h1>

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
                    : "—"}
                </span>
              </div>

              <div className="flex items-center gap-2">
                <ProcessingStatus
                  auditId={audit.id}
                  initialStatus={audit.status}
                />
              </div>
            </div>

            {/* Right: score */}
            <div className="flex flex-col items-center gap-1">
              <span
                className={`text-5xl font-bold ${getScoreColor(audit.score_final)}`}
              >
                {formatScore(audit.score_final)}
              </span>
              <span className="text-sm text-muted-foreground">/10</span>
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
