"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import type { CallAuditRow } from "@/lib/types/audit"

export function useRealtimeAudit(auditId: string) {
  const [audit, setAudit] = useState<Partial<CallAuditRow> | null>(null)
  const [subscriptionError, setSubscriptionError] = useState(false)

  useEffect(() => {
    const supabase = createClient()

    const channel = supabase
      .channel(`audit-${auditId}`)
      .on(
        "postgres_changes",
        {
          event: "UPDATE",
          schema: "public",
          table: "call_audits",
          filter: `id=eq.${auditId}`,
        },
        (payload) => {
          setAudit(payload.new as Partial<CallAuditRow>)
        }
      )
      .subscribe((status) => {
        if (status === "CHANNEL_ERROR" || status === "TIMED_OUT") {
          setSubscriptionError(true)
        }
      })

    return () => {
      supabase.removeChannel(channel)
    }
  }, [auditId])

  return { audit, subscriptionError }
}
