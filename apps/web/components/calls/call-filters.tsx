"use client"

import { useRouter, usePathname, useSearchParams } from "next/navigation"
import { useCallback } from "react"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { X } from "lucide-react"
import type { AuditFilters, CloserRow } from "@/lib/types/audit"
import { STATUS_LABELS, RESULTADO_LABELS } from "@/lib/utils/constants"

interface CallFiltersProps {
  closers: Pick<CloserRow, "id" | "name">[]
  currentFilters: AuditFilters
}

export function CallFilters({ closers, currentFilters }: CallFiltersProps) {
  const router = useRouter()
  const pathname = usePathname()
  const searchParams = useSearchParams()

  const updateFilter = useCallback(
    (key: string, value: string | undefined) => {
      const params = new URLSearchParams(searchParams.toString())
      if (value) {
        params.set(key, value)
      } else {
        params.delete(key)
      }
      // Reset to page 1 when filters change
      params.delete("page")
      router.push(`${pathname}?${params.toString()}`)
    },
    [router, pathname, searchParams]
  )

  const clearFilters = useCallback(() => {
    router.push(pathname)
  }, [router, pathname])

  const hasFilters =
    currentFilters.closerId ||
    currentFilters.dateFrom ||
    currentFilters.dateTo ||
    currentFilters.classificacao ||
    currentFilters.resultado ||
    currentFilters.status

  return (
    <div className="space-y-2">
      <div className="grid grid-cols-2 gap-2 md:grid-cols-3 lg:grid-cols-6">
        {/* Closer */}
        <Select
          value={currentFilters.closerId ?? ""}
          onValueChange={(v) => updateFilter("closerId", v || undefined)}
        >
          <SelectTrigger>
            <SelectValue placeholder="Closer" />
          </SelectTrigger>
          <SelectContent>
            {closers.map((c) => (
              <SelectItem key={c.id} value={c.id}>
                {c.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {/* Classificação */}
        <Select
          value={currentFilters.classificacao ?? ""}
          onValueChange={(v) => updateFilter("classificacao", v || undefined)}
        >
          <SelectTrigger>
            <SelectValue placeholder="Classificação" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="ELITE">ELITE</SelectItem>
            <SelectItem value="FORTE">FORTE</SelectItem>
            <SelectItem value="MEDIANA">MEDIANA</SelectItem>
            <SelectItem value="FRACA">FRACA</SelectItem>
          </SelectContent>
        </Select>

        {/* Resultado */}
        <Select
          value={currentFilters.resultado ?? ""}
          onValueChange={(v) => updateFilter("resultado", v || undefined)}
        >
          <SelectTrigger>
            <SelectValue placeholder="Resultado" />
          </SelectTrigger>
          <SelectContent>
            {Object.entries(RESULTADO_LABELS).map(([value, label]) => (
              <SelectItem key={value} value={value}>
                {label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {/* Status */}
        <Select
          value={currentFilters.status ?? ""}
          onValueChange={(v) => updateFilter("status", v || undefined)}
        >
          <SelectTrigger>
            <SelectValue placeholder="Status" />
          </SelectTrigger>
          <SelectContent>
            {Object.entries(STATUS_LABELS).map(([value, label]) => (
              <SelectItem key={value} value={value}>
                {label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>

        {/* Date From */}
        <Input
          type="date"
          placeholder="De"
          value={currentFilters.dateFrom ?? ""}
          onChange={(e) => updateFilter("dateFrom", e.target.value || undefined)}
        />

        {/* Date To */}
        <Input
          type="date"
          placeholder="Até"
          value={currentFilters.dateTo ?? ""}
          onChange={(e) => updateFilter("dateTo", e.target.value || undefined)}
        />
      </div>

      {hasFilters && (
        <Button
          variant="ghost"
          size="sm"
          onClick={clearFilters}
          className="text-muted-foreground"
        >
          <X className="mr-1 h-4 w-4" />
          Limpar filtros
        </Button>
      )}
    </div>
  )
}
