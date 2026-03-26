import { notFound } from "next/navigation"
import Link from "next/link"
import { getSupervisorAnalysis } from "@/lib/actions/supervisor"
import { AnalysisResult } from "@/components/supervisor/analysis-result"

interface SupervisorAnalysisDetailPageProps {
  params: Promise<{ id: string }>
}

export default async function SupervisorAnalysisDetailPage({
  params,
}: SupervisorAnalysisDetailPageProps) {
  const { id } = await params
  const analysis = await getSupervisorAnalysis(id)

  if (!analysis) {
    notFound()
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-2">
        <Link
          href="/supervisor"
          className="flex items-center gap-1 text-stone-400 hover:text-[#ffa600] transition-colors text-sm"
        >
          <span className="material-symbols-outlined text-sm">arrow_back</span>
          Voltar
        </Link>
      </div>

      <AnalysisResult analysis={analysis} />
    </div>
  )
}
