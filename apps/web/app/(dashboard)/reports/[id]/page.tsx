import { notFound } from "next/navigation"
import Link from "next/link"
import ReactMarkdown from "react-markdown"
import remarkGfm from "remark-gfm"
import { getWeeklyReport } from "@/lib/actions/reports"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { ArrowLeft, Calendar } from "lucide-react"
import { formatDate } from "@/lib/utils/format"

interface ReportDetailPageProps {
  params: Promise<{ id: string }>
}

export default async function ReportDetailPage({
  params,
}: ReportDetailPageProps) {
  const { id } = await params
  const report = await getWeeklyReport(id)

  if (!report) {
    notFound()
  }

  const stats = report.stats

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-2">
        <Button variant="ghost" size="sm" asChild>
          <Link href="/reports">
            <ArrowLeft className="mr-1 h-4 w-4" />
            Voltar
          </Link>
        </Button>
      </div>

      <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-bold">Relatório Semanal</h1>
          <p className="flex items-center gap-1 text-sm text-muted-foreground">
            <Calendar className="h-4 w-4" />
            {formatDate(report.week_start)} — {formatDate(report.week_end)}
          </p>
        </div>
        <div className="flex gap-2">
          {report.sent_whatsapp && (
            <Badge variant="secondary">Enviado via WhatsApp</Badge>
          )}
          {report.sent_email && (
            <Badge variant="secondary">Enviado via Email</Badge>
          )}
        </div>
      </div>

      {/* Stats summary */}
      <div className="grid gap-4 grid-cols-2 sm:grid-cols-4">
        <Card>
          <CardContent className="p-4 text-center">
            <p className="text-3xl font-bold">{stats.total_calls ?? 0}</p>
            <p className="text-sm text-muted-foreground">Calls Auditadas</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <p className="text-3xl font-bold">
              {stats.score_avg?.toFixed(1) ?? "—"}
            </p>
            <p className="text-sm text-muted-foreground">Score Médio</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <p className="text-3xl font-bold">
              {stats.taxa_fechamento != null ? `${stats.taxa_fechamento}%` : "—"}
            </p>
            <p className="text-sm text-muted-foreground">Taxa Fechamento</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-4 text-center">
            <p className="text-3xl font-bold">
              {stats.score_avg_prev?.toFixed(1) ?? "—"}
            </p>
            <p className="text-sm text-muted-foreground">Score Sem. Anterior</p>
          </CardContent>
        </Card>
      </div>

      {/* Full report */}
      <Card>
        <CardHeader>
          <CardTitle>Relatório Completo</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="prose prose-sm dark:prose-invert max-w-none">
            <ReactMarkdown remarkPlugins={[remarkGfm]}>
              {report.report_markdown}
            </ReactMarkdown>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
