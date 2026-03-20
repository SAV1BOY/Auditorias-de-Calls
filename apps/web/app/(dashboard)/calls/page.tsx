import Link from "next/link"
import { Suspense } from "react"
import { Button } from "@/components/ui/button"
import { Skeleton } from "@/components/ui/skeleton"
import { Plus } from "lucide-react"
import { getAudits, getClosers } from "@/lib/actions/calls"
import { CallFilters } from "@/components/calls/call-filters"
import { CallList } from "@/components/calls/call-list"
import { Pagination } from "@/components/calls/pagination"
import type { AuditFilters, Classificacao } from "@/lib/types/audit"

interface CallsPageProps {
  searchParams: Promise<Record<string, string>>
}

export default async function CallsPage({ searchParams }: CallsPageProps) {
  const params = await searchParams

  const filters: AuditFilters = {
    closerId: params.closerId || undefined,
    dateFrom: params.dateFrom || undefined,
    dateTo: params.dateTo || undefined,
    classificacao: (params.classificacao as Classificacao) || undefined,
    resultado: params.resultado || undefined,
    status: params.status || undefined,
    sortBy: params.sortBy || "call_date",
    sortOrder: (params.sortOrder as "asc" | "desc") || "desc",
    page: params.page ? parseInt(params.page) : 1,
    pageSize: 20,
  }

  const [result, closers] = await Promise.all([
    getAudits(filters),
    getClosers(),
  ])

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">Calls</h1>
        <Button asChild>
          <Link href="/calls/upload">
            <Plus className="mr-1 h-4 w-4" />
            Nova Call
          </Link>
        </Button>
      </div>

      <Suspense fallback={<Skeleton className="h-10 w-full" />}>
        <CallFilters closers={closers} currentFilters={filters} />
      </Suspense>

      <CallList
        audits={result.data}
        sortBy={filters.sortBy}
        sortOrder={filters.sortOrder}
      />

      <Pagination
        total={result.total}
        page={result.page}
        pageSize={result.pageSize}
        totalPages={result.totalPages}
      />
    </div>
  )
}
