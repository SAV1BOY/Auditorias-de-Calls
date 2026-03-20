import Link from "next/link"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import type { CallAuditWithCloser } from "@/lib/types/audit"
import { formatDate, formatScore } from "@/lib/utils/format"
import { getClassificacaoColor, getScoreColor, getStatusColor } from "@/lib/utils/colors"
import { STATUS_LABELS } from "@/lib/utils/constants"

interface RecentCallsProps {
  calls: CallAuditWithCloser[]
}

export function RecentCalls({ calls }: RecentCallsProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Calls Recentes</CardTitle>
      </CardHeader>
      <CardContent>
        {calls.length === 0 ? (
          <p className="py-8 text-center text-muted-foreground">
            Nenhuma call auditada ainda.
          </p>
        ) : (
          <div className="overflow-x-auto">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Closer</TableHead>
                <TableHead>Lead</TableHead>
                <TableHead>Data</TableHead>
                <TableHead>Score</TableHead>
                <TableHead>Classificação</TableHead>
                <TableHead>Status</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {calls.map((call) => (
                <TableRow key={call.id}>
                  <TableCell className="font-medium">
                    <Link
                      href={`/calls/${call.id}`}
                      className="hover:underline"
                    >
                      {call.closers?.name ?? "—"}
                    </Link>
                  </TableCell>
                  <TableCell>{call.lead_name}</TableCell>
                  <TableCell>{formatDate(call.call_date)}</TableCell>
                  <TableCell>
                    <span className={getScoreColor(call.score_final)}>
                      {formatScore(call.score_final)}
                    </span>
                  </TableCell>
                  <TableCell>
                    {call.classificacao ? (
                      <Badge
                        variant="secondary"
                        className={getClassificacaoColor(call.classificacao)}
                      >
                        {call.classificacao}
                      </Badge>
                    ) : (
                      "—"
                    )}
                  </TableCell>
                  <TableCell>
                    <Badge
                      variant="secondary"
                      className={getStatusColor(call.status)}
                    >
                      {STATUS_LABELS[call.status] ?? call.status}
                    </Badge>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
          </div>
        )}
      </CardContent>
    </Card>
  )
}
