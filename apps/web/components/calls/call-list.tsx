"use client"

import { useRouter, usePathname, useSearchParams } from "next/navigation"
import { useCallback } from "react"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { ChevronUp, ChevronDown } from "lucide-react"
import type { CallAuditWithCloser } from "@/lib/types/audit"
import { formatDate, formatScore, formatDuration } from "@/lib/utils/format"
import {
  getClassificacaoColor,
  getScoreColor,
  getStatusColor,
} from "@/lib/utils/colors"
import { STATUS_LABELS } from "@/lib/utils/constants"

interface CallListProps {
  audits: CallAuditWithCloser[]
  sortBy?: string
  sortOrder?: string
}

const columns = [
  { key: "closers", label: "Closer", sortable: false },
  { key: "lead_name", label: "Lead", sortable: true },
  { key: "call_date", label: "Data", sortable: true },
  { key: "duration_minutes", label: "Dura\u00e7\u00e3o", sortable: true },
  { key: "score_final", label: "Score", sortable: true },
  { key: "classificacao", label: "Classifica\u00e7\u00e3o", sortable: true },
  { key: "status", label: "Status", sortable: true },
]

export function CallList({ audits, sortBy, sortOrder }: CallListProps) {
  const router = useRouter()
  const pathname = usePathname()
  const searchParams = useSearchParams()

  const handleSort = useCallback(
    (column: string) => {
      const params = new URLSearchParams(searchParams.toString())
      if (sortBy === column) {
        params.set("sortOrder", sortOrder === "asc" ? "desc" : "asc")
      } else {
        params.set("sortBy", column)
        params.set("sortOrder", "desc")
      }
      router.push(`${pathname}?${params.toString()}`)
    },
    [router, pathname, searchParams, sortBy, sortOrder]
  )

  const handleRowClick = useCallback(
    (id: string) => {
      router.push(`/calls/${id}`)
    },
    [router]
  )

  if (audits.length === 0) {
    return (
      <p className="py-12 text-center text-muted-foreground">
        Nenhuma call encontrada.
      </p>
    )
  }

  return (
    <div className="rounded-md overflow-x-auto">
      <Table>
        <TableHeader>
          <TableRow>
            {columns.map((col) => (
              <TableHead
                key={col.key}
                className={`${col.sortable ? "cursor-pointer select-none hover:text-on-surface-variant transition-colors" : ""} ${
                  col.key === "duration_minutes" || col.key === "classificacao"
                    ? "hidden sm:table-cell"
                    : ""
                }`}
                onClick={() => col.sortable && handleSort(col.key)}
              >
                <div className="flex items-center gap-1">
                  {col.label}
                  {col.sortable && sortBy === col.key && (
                    sortOrder === "asc" ? (
                      <ChevronUp className="h-4 w-4 text-primary" />
                    ) : (
                      <ChevronDown className="h-4 w-4 text-primary" />
                    )
                  )}
                </div>
              </TableHead>
            ))}
          </TableRow>
        </TableHeader>
        <TableBody>
          {audits.map((audit) => (
            <TableRow
              key={audit.id}
              className="cursor-pointer"
              onClick={() => handleRowClick(audit.id)}
            >
              <TableCell className="font-medium">
                {audit.closers?.name ?? "\u2014"}
              </TableCell>
              <TableCell>{audit.lead_name}</TableCell>
              <TableCell className="font-body text-muted-foreground">{formatDate(audit.call_date)}</TableCell>
              <TableCell className="hidden sm:table-cell font-body text-muted-foreground">
                {formatDuration(audit.duration_minutes)}
              </TableCell>
              <TableCell>
                <span className={getScoreColor(audit.score_final)}>
                  {formatScore(audit.score_final)}
                </span>
              </TableCell>
              <TableCell className="hidden sm:table-cell">
                {audit.classificacao ? (
                  <Badge
                    variant="secondary"
                    className={getClassificacaoColor(audit.classificacao)}
                  >
                    {audit.classificacao}
                  </Badge>
                ) : (
                  "\u2014"
                )}
              </TableCell>
              <TableCell>
                <Badge
                  variant="secondary"
                  className={getStatusColor(audit.status)}
                >
                  {STATUS_LABELS[audit.status] ?? audit.status}
                </Badge>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  )
}
