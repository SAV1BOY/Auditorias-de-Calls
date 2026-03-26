"use server"

import { createClient } from "@/lib/supabase/server"
import { requireAuth } from "@/lib/auth/require-role"
import type { WeeklyReport, WeeklyStats } from "@/lib/types/audit"

export async function getWeeklyReports(): Promise<WeeklyReport[]> {
  await requireAuth()
  const supabase = await createClient()

  const { data } = await supabase
    .from("weekly_reports")
    .select("*")
    .order("week_start", { ascending: false })

  return (data ?? []).map((row) => ({
    ...row,
    stats: (row.stats ?? {}) as unknown as WeeklyStats,
  }))
}

export async function getWeeklyReport(
  id: string
): Promise<WeeklyReport | null> {
  await requireAuth()
  const supabase = await createClient()

  const { data } = await supabase
    .from("weekly_reports")
    .select("*")
    .eq("id", id)
    .single()

  if (!data) return null

  return {
    ...data,
    stats: (data.stats ?? {}) as unknown as WeeklyStats,
  }
}
