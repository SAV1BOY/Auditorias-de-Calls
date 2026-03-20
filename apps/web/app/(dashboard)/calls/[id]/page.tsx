import { notFound } from "next/navigation"
import { getAuditDetail } from "@/lib/actions/calls"
import { AuditHeader } from "@/components/calls/audit-header"
import { AuditTabs } from "@/components/calls/audit-tabs"

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
      <AuditTabs audit={audit} />
    </div>
  )
}
