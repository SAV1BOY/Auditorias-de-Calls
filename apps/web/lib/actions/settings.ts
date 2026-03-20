"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"

interface NotificationConfig {
  whatsapp_numbers: string[]
  email_addresses: string[]
}

export async function getNotificationConfig(): Promise<NotificationConfig> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("app_config")
    .select("value")
    .eq("key", "notification_recipients")
    .maybeSingle()

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

  const supabase = await createClient()

  const { error } = await supabase.from("app_config").upsert(
    {
      key: "notification_recipients",
      organization_id: null,
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
  return {
    supabase: !!process.env.NEXT_PUBLIC_SUPABASE_URL,
    googleDrive: !!process.env.GOOGLE_SERVICE_ACCOUNT_JSON,
  }
}
