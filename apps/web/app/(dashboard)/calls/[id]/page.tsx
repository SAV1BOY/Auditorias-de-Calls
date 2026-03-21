import { notFound } from "next/navigation"
import { getAuditDetail } from "@/lib/actions/calls"
import { AuditHeader } from "@/components/calls/audit-header"
import { CallDetailClient } from "@/components/calls/call-detail-client"

interface CallDetailPageProps {
  params: Promise<{ id: string }>
}

export default async function CallDetailPage({ params }: CallDetailPageProps) {
  const { id } = await params
  const audit = await getAuditDetail(id)

  if (!audit) {
    notFound()
  }

  return (
    <div className="space-y-6">
      <AuditHeader audit={audit} />
      <CallDetailClient audit={audit} />
    </div>
  )
}
