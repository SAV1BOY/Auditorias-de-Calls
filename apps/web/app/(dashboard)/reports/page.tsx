import Link from "next/link"
import { getWeeklyReports } from "@/lib/actions/reports"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { FileText, Calendar } from "lucide-react"
import { formatDate } from "@/lib/utils/format"

export default async function ReportsPage() {
  const reports = await getWeeklyReports()

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Relatórios Semanais</h1>
        <p className="text-muted-foreground">
          Resumos executivos gerados automaticamente toda segunda-feira
        </p>
      </div>

      {reports.length === 0 ? (
        <div className="py-16 text-center text-muted-foreground">
          <FileText className="mx-auto h-12 w-12 mb-3 opacity-20" />
          <p>Nenhum relatório semanal gerado ainda.</p>
          <p className="text-sm mt-1">
            O primeiro relatório será gerado automaticamente na próxima
            segunda-feira.
          </p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {reports.map((report) => {
            const stats = report.stats
            return (
              <Link key={report.id} href={`/reports/${report.id}`}>
                <Card className="hover:border-primary/50 transition-colors cursor-pointer h-full">
                  <CardContent className="p-4 space-y-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2 text-sm text-muted-foreground">
                        <Calendar className="h-4 w-4" />
                        {formatDate(report.week_start)} —{" "}
                        {formatDate(report.week_end)}
                      </div>
                      <div className="flex gap-1">
                        {report.sent_whatsapp && (
                          <Badge variant="outline" className="text-xs">
                            WhatsApp
                          </Badge>
                        )}
                        {report.sent_email && (
                          <Badge variant="outline" className="text-xs">
                            Email
                          </Badge>
                        )}
                      </div>
                    </div>

                    <div className="grid grid-cols-3 gap-2 text-center">
                      <div>
                        <p className="text-2xl font-bold">
                          {stats.total_calls ?? 0}
                        </p>
                        <p className="text-xs text-muted-foreground">Calls</p>
                      </div>
                      <div>
                        <p className="text-2xl font-bold">
                          {stats.score_avg?.toFixed(1) ?? "—"}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          Score Médio
                        </p>
                      </div>
                      <div>
                        <p className="text-2xl font-bold">
                          {stats.taxa_fechamento != null
                            ? `${stats.taxa_fechamento}%`
                            : "—"}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          Fechamento
                        </p>
                      </div>
                    </div>

                    {stats.top_closers && stats.top_closers.length > 0 && (
                      <div className="text-xs text-muted-foreground">
                        Top: {stats.top_closers.map((c) => c.name).join(", ")}
                      </div>
                    )}
                  </CardContent>
                </Card>
              </Link>
            )
          })}
        </div>
      )}
    </div>
  )
}
