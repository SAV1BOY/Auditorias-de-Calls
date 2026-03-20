"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import type { CallAuditRow } from "@/lib/types/audit"

export function useRealtimeAudit(auditId: string) {
  const [audit, setAudit] = useState<Partial<CallAuditRow> | null>(null)

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
      .subscribe()

    return () => {
      supabase.removeChannel(channel)
    }
  }, [auditId])

  return audit
}
