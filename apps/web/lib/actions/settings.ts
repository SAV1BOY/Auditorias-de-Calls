"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"
import { requireAuth, requireRole } from "@/lib/auth/require-role"
import { notificationConfigSchema } from "@/lib/validations/schemas"

interface NotificationConfig {
  whatsapp_numbers: string[]
  email_addresses: string[]
}

export async function getNotificationConfig(): Promise<NotificationConfig> {
  const { organizationId } = await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

  let query = supabase
    .from("app_config")
    .select("value")
    .eq("key", "notification_recipients")

  if (organizationId) {
    query = query.eq("organization_id", organizationId)
  }

  const { data } = await query.maybeSingle()

  if (data?.value && typeof data.value === "object") {
    const v = data.value as Record<string, unknown>
    return {
      whatsapp_numbers: Array.isArray(v.whatsapp_numbers)
        ? (v.whatsapp_numbers as string[])
        : [],
      email_addresses: Array.isArray(v.email_addresses)
        ? (v.email_addresses as string[])
        : [],
    }
  }

  return { whatsapp_numbers: [], email_addresses: [] }
}

export async function updateNotificationConfig(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin"])

  const whatsappRaw = formData.get("whatsapp_numbers")?.toString() ?? ""
  const emailRaw = formData.get("email_addresses")?.toString() ?? ""

  const whatsapp_numbers = whatsappRaw
    .split("\n")
    .map((s) => s.trim())
    .filter(Boolean)
  const email_addresses = emailRaw
    .split("\n")
    .map((s) => s.trim())
    .filter(Boolean)

  const parsed = notificationConfigSchema.safeParse({ whatsapp_numbers, email_addresses })
  if (!parsed.success) {
    const msg = parsed.error.issues[0]?.message ?? "Dados inválidos"
    return { error: msg }
  }

  const supabase = await createClient()

  const { error } = await supabase.from("app_config").upsert(
    {
      key: "notification_recipients",
      organization_id: organizationId,
      value: { whatsapp_numbers, email_addresses },
    },
    { onConflict: "organization_id,key" }
  )

  if (error) return { error: "Erro ao salvar configurações." }

  revalidatePath("/settings")
  return { success: true }
}

interface ApiStatus {
  supabase: boolean
  googleDrive: boolean
}

export async function getApiStatus(): Promise<ApiStatus> {
  await requireAuth()
  return {
    supabase: !!process.env.NEXT_PUBLIC_SUPABASE_URL,
    googleDrive: !!process.env.GOOGLE_SERVICE_ACCOUNT_JSON,
  }
}

// ─── Dimension Weights ───

interface DimensionWeights {
  [dimensionId: string]: number
}

export async function getDimensionWeights(): Promise<DimensionWeights> {
  const { organizationId } = await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

  let query = supabase
    .from("app_config")
    .select("value")
    .eq("key", "dimension_weights")

  if (organizationId) {
    query = query.eq("organization_id", organizationId)
  }

  const { data } = await query.maybeSingle()

  if (data?.value && typeof data.value === "object") {
    return data.value as DimensionWeights
  }

  // Default weights from constants
  return {
    d01_frame: 8, d02_qualificacao: 10, d03_diag_quantitativo: 12,
    d04_diag_qualitativo: 8, d05_consequencia: 10, d06_ensino: 5,
    d07_identidade: 5, d08_ancoragem: 10, d09_isolamento: 10,
    d10_proporcao_fala: 8, d11_promessas: 8, d12_checkpoints: 3,
    d13_fechamento: 3,
  }
}

export async function updateDimensionWeights(
  weights: DimensionWeights
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin"])

  // Validate sum = 100
  const total = Object.values(weights).reduce((a, b) => a + b, 0)
  if (Math.abs(total - 100) > 0.1) {
    return { error: `Soma dos pesos deve ser 100%. Atual: ${total.toFixed(1)}%` }
  }

  const supabase = await createClient()

  const { error } = await supabase.from("app_config").upsert(
    {
      key: "dimension_weights",
      organization_id: organizationId,
      value: weights,
    },
    { onConflict: "organization_id,key" }
  )

  if (error) return { error: "Erro ao salvar pesos." }

  revalidatePath("/settings")
  return { success: true }
}

// ─── Webhook CRM Config ───

interface WebhookConfig {
  url: string
  api_key: string
  enabled: boolean
}

export async function getWebhookConfig(): Promise<WebhookConfig> {
  const { organizationId } = await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

  let query = supabase
    .from("app_config")
    .select("value")
    .eq("key", "webhook_crm")

  if (organizationId) {
    query = query.eq("organization_id", organizationId)
  }

  const { data } = await query.maybeSingle()

  if (data?.value && typeof data.value === "object") {
    const v = data.value as Record<string, unknown>
    return {
      url: (v.url as string) ?? "",
      api_key: (v.api_key as string) ?? "",
      enabled: (v.enabled as boolean) ?? false,
    }
  }

  return { url: "", api_key: "", enabled: false }
}

export async function updateWebhookConfig(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin"])

  const url = formData.get("webhook_url")?.toString() ?? ""
  const apiKey = formData.get("webhook_api_key")?.toString() ?? ""
  const enabled = formData.get("webhook_enabled") === "true"

  if (enabled && !url) {
    return { error: "URL do webhook é obrigatória quando habilitado." }
  }

  if (enabled && url && !url.startsWith("https://")) {
    return { error: "URL do webhook deve usar HTTPS." }
  }

  const supabase = await createClient()

  const { error } = await supabase.from("app_config").upsert(
    {
      key: "webhook_crm",
      organization_id: organizationId,
      value: { url, api_key: apiKey, enabled },
    },
    { onConflict: "organization_id,key" }
  )

  if (error) return { error: "Erro ao salvar configuração do webhook." }

  revalidatePath("/settings")
  return { success: true }
}
