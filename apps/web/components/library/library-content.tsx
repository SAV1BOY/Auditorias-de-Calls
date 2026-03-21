"use client"

import { useState, useTransition } from "react"
import Link from "next/link"
import { Card, CardContent } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Star, ExternalLink } from "lucide-react"
import type { CallBookmark } from "@/lib/types/audit"
import { getBookmarkedCalls } from "@/lib/actions/bookmarks"
import { formatDate, formatScore } from "@/lib/utils/format"
import { getClassificacaoColor } from "@/lib/utils/colors"

interface LibraryContentProps {
  initialBookmarks: CallBookmark[]
  closers: { id: string; name: string }[]
  allTags: string[]
}

export function LibraryContent({
  initialBookmarks,
  closers,
  allTags,
}: LibraryContentProps) {
  const [bookmarks, setBookmarks] = useState(initialBookmarks)
  const [selectedTag, setSelectedTag] = useState<string>("")
  const [selectedCloser, setSelectedCloser] = useState<string>("")
  const [selectedClassificacao, setSelectedClassificacao] = useState<string>("")
  const [pending, startTransition] = useTransition()

  function applyFilters(tag?: string, closer?: string, classificacao?: string) {
    const t = tag ?? selectedTag
    const c = closer ?? selectedCloser
    const cl = classificacao ?? selectedClassificacao

    startTransition(async () => {
      const result = await getBookmarkedCalls({
        tags: t ? [t] : undefined,
        closerId: c || undefined,
        classificacao: cl || undefined,
      })
      setBookmarks(result)
    })
  }

  return (
    <div className="space-y-4">
      {/* Filters */}
      <div className="flex flex-wrap gap-3">
        <Select
          value={selectedTag}
          onValueChange={(v) => {
            const val = v === "all" ? "" : v
            setSelectedTag(val)
            applyFilters(val, undefined, undefined)
          }}
        >
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Filtrar por tag" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todas as tags</SelectItem>
            {allTags.map((tag) => (
              <SelectItem key={tag} value={tag}>
                {tag}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select
          value={selectedCloser}
          onValueChange={(v) => {
            const val = v === "all" ? "" : v
            setSelectedCloser(val)
            applyFilters(undefined, val, undefined)
          }}
        >
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Filtrar por closer" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todos os closers</SelectItem>
            {closers.map((c) => (
              <SelectItem key={c.id} value={c.id}>
                {c.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        <Select
          value={selectedClassificacao}
          onValueChange={(v) => {
            const val = v === "all" ? "" : v
            setSelectedClassificacao(val)
            applyFilters(undefined, undefined, val)
          }}
        >
          <SelectTrigger className="w-[180px]">
            <SelectValue placeholder="Classificação" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todas</SelectItem>
            <SelectItem value="ELITE">Elite</SelectItem>
            <SelectItem value="FORTE">Forte</SelectItem>
            <SelectItem value="MEDIANA">Mediana</SelectItem>
            <SelectItem value="FRACA">Fraca</SelectItem>
          </SelectContent>
        </Select>
      </div>

      {/* Results */}
      {pending ? (
        <div className="py-12 text-center text-muted-foreground animate-pulse">
          Carregando...
        </div>
      ) : bookmarks.length === 0 ? (
        <div className="py-12 text-center text-muted-foreground">
          <Star className="mx-auto h-12 w-12 mb-3 opacity-20" />
          <p>Nenhuma call modelo encontrada.</p>
          <p className="text-sm mt-1">
            Marque calls como modelo na página de detalhe.
          </p>
        </div>
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {bookmarks.map((bm) => {
            const audit = bm.call_audits
            return (
              <Link key={bm.id} href={`/calls/${bm.audit_id}`}>
                <Card className="hover:border-primary/50 transition-colors cursor-pointer h-full">
                  <CardContent className="p-4 space-y-3">
                    <div className="flex items-start justify-between">
                      <div>
                        <p className="font-medium">
                          {audit?.lead_name ?? "—"}
                        </p>
                        <p className="text-sm text-muted-foreground">
                          {audit?.closers?.name ?? "—"} &middot;{" "}
                          {audit?.call_date
                            ? formatDate(audit.call_date)
                            : "—"}
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        {audit?.classificacao && (
                          <Badge
                            className={getClassificacaoColor(
                              audit.classificacao
                            )}
                          >
                            {audit.classificacao}
                          </Badge>
                        )}
                        <span className="font-bold text-lg">
                          {formatScore(audit?.score_final ?? null)}
                        </span>
                      </div>
                    </div>

                    {bm.tags.length > 0 && (
                      <div className="flex flex-wrap gap-1">
                        {bm.tags.map((tag) => (
                          <Badge
                            key={tag}
                            variant="outline"
                            className="text-xs"
                          >
                            {tag}
                          </Badge>
                        ))}
                      </div>
                    )}

                    {bm.notes && (
                      <p className="text-xs text-muted-foreground line-clamp-2">
                        {bm.notes}
                      </p>
                    )}

                    <div className="flex items-center text-xs text-muted-foreground">
                      <ExternalLink className="h-3 w-3 mr-1" />
                      Ver detalhes
                    </div>
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
