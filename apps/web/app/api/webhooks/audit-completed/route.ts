import { NextRequest, NextResponse } from "next/server"
import { createClient } from "@/lib/supabase/server"

/**
 * POST /api/webhooks/audit-completed
 *
 * Internal webhook endpoint called by the worker after an audit is completed.
 * Forwards audit data to configured external CRM webhook URL.
 *
 * Security: Requires X-API-Key header matching the configured webhook API key.
 */
export async function POST(request: NextRequest) {
  try {
    // Validate internal API key
    const apiKey = request.headers.get("x-api-key")
    const expectedKey = process.env.WEBHOOK_INTERNAL_API_KEY
    if (expectedKey && apiKey !== expectedKey) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      )
    }

    const body = await request.json()
    const { audit_id } = body

    if (!audit_id) {
      return NextResponse.json(
        { error: "audit_id is required" },
        { status: 400 }
      )
    }

    const supabase = await createClient()

    // Fetch webhook config
    const { data: config } = await supabase
      .from("app_config")
      .select("value")
      .eq("key", "webhook_crm")
      .maybeSingle()

    const webhookConfig = config?.value as {
      url?: string
      api_key?: string
      enabled?: boolean
    } | null

    if (!webhookConfig?.enabled || !webhookConfig?.url) {
      return NextResponse.json({ status: "webhook_disabled" })
    }

    // Fetch audit data
    const { data: audit } = await supabase
      .from("call_audits")
      .select("id, lead_name, call_date, score_final, classificacao, status, closers(name)")
      .eq("id", audit_id)
      .single()

    if (!audit) {
      return NextResponse.json(
        { error: "Audit not found" },
        { status: 404 }
      )
    }

    // Build payload (no sensitive data — no transcription)
    const payload = {
      event: "audit.completed",
      audit_id: audit.id,
      closer_name: (audit.closers as { name: string } | null)?.name ?? "Unknown",
      lead_name: audit.lead_name,
      call_date: audit.call_date,
      score_final: audit.score_final,
      classificacao: audit.classificacao,
      status: audit.status,
      timestamp: new Date().toISOString(),
    }

    // Send to external webhook
    const response = await fetch(webhookConfig.url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ...(webhookConfig.api_key
          ? { "X-API-Key": webhookConfig.api_key }
          : {}),
      },
      body: JSON.stringify(payload),
    })

    // Log delivery (cast to any — notifications table accepts webhook channel)
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    await (supabase as any).from("notifications").insert({
      audit_id,
      channel: "webhook",
      recipient: webhookConfig.url,
      content: JSON.stringify(payload),
      status: response.ok ? "sent" : "failed",
    })

    return NextResponse.json({
      status: response.ok ? "delivered" : "failed",
      http_status: response.status,
    })
  } catch (error) {
    console.error("Webhook error:", error)
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    )
  }
}
