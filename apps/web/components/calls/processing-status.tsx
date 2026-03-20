"use client"

import { Badge } from "@/components/ui/badge"
import { Loader2 } from "lucide-react"
import { useRealtimeAudit } from "@/hooks/use-realtime-audit"
import type { AuditStatus } from "@/lib/types/audit"
import { getStatusColor } from "@/lib/utils/colors"
import { STATUS_LABELS } from "@/lib/utils/constants"

const PROCESSING_STATUSES = new Set([
  "uploaded",
  "transcribing",
  "transcribed",
  "analyzing",
  "notifying",
])

interface ProcessingStatusProps {
  auditId: string
  initialStatus: AuditStatus
}

export function ProcessingStatus({
  auditId,
  initialStatus,
}: ProcessingStatusProps) {
  const { audit: realtimeAudit } = useRealtimeAudit(auditId)
  const currentStatus = (realtimeAudit?.status as AuditStatus) ?? initialStatus
  const isProcessing = PROCESSING_STATUSES.has(currentStatus)

  return (
    <Badge variant="secondary" className={getStatusColor(currentStatus)}>
      {isProcessing && <Loader2 className="mr-1 h-3 w-3 animate-spin" />}
      {STATUS_LABELS[currentStatus] ?? currentStatus}
    </Badge>
  )
}
