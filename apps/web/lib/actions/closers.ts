"use server"

import { revalidatePath } from "next/cache"
import { createClient } from "@/lib/supabase/server"
import { requireRole } from "@/lib/auth/require-role"
import type { CloserRow } from "@/lib/types/audit"

export async function getClosersList(): Promise<CloserRow[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("closers")
    .select("*")
    .order("name")
  return (data as CloserRow[]) ?? []
}

export async function getCloserById(
  id: string
): Promise<CloserRow | null> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("closers")
    .select("*")
    .eq("id", id)
    .maybeSingle()
  return (data as CloserRow) ?? null
}

interface CloserPerformance {
  closer_id: string
  closer_name: string
  total_calls: number
  media_score: number | null
  pior_score: number | null
  melhor_score: number | null
  fechamentos: number
  [key: string]: string | number | null
}

export async function getCloserPerformance(
  closerId: string
): Promise<CloserPerformance | null> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("v_closer_performance")
    .select("*")
    .eq("closer_id", closerId)
    .maybeSingle()
  return (data as CloserPerformance) ?? null
}

function groupByDateAvg(
  rows: Array<{ call_date: string; score_final: number | null }> | null
): Array<{ date: string; score: number }> {
  if (!rows || rows.length === 0) return []

  const groups = new Map<string, number[]>()
  for (const row of rows) {
    if (row.score_final === null) continue
    const existing = groups.get(row.call_date) ?? []
    existing.push(row.score_final)
    groups.set(row.call_date, existing)
  }

  return Array.from(groups.entries())
    .map(([date, scores]) => ({
      date,
      score:
        Math.round(
          (scores.reduce((a, b) => a + b, 0) / scores.length) * 10
        ) / 10,
    }))
    .sort((a, b) => a.date.localeCompare(b.date))
}

export async function getCloserScoreEvolution(
  closerId: string
): Promise<Array<{ date: string; score: number }>> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("call_audits")
    .select("call_date, score_final")
    .eq("closer_id", closerId)
    .not("score_final", "is", null)
    .order("call_date", { ascending: true })

  return groupByDateAvg(data)
}

export async function createCloser(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin", "supervisor"])

  const name = formData.get("name")?.toString().trim()
  if (!name) return { error: "Nome é obrigatório." }

  const supabase = await createClient()
  const { error } = await supabase.from("closers").insert({
    name,
    email: formData.get("email")?.toString().trim() || null,
    whatsapp: formData.get("whatsapp")?.toString().trim() || null,
    avatar_url: formData.get("avatar_url")?.toString().trim() || null,
    organization_id: organizationId,
  })

  if (error) return { error: "Erro ao criar closer." }

  revalidatePath("/closers")
  return { success: true }
}

export async function updateCloser(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin", "supervisor"])

  const id = formData.get("id")?.toString()
  const name = formData.get("name")?.toString().trim()
  if (!id) return { error: "ID do closer não informado." }
  if (!name) return { error: "Nome é obrigatório." }

  const supabase = await createClient()
  const { error } = await supabase
    .from("closers")
    .update({
      name,
      email: formData.get("email")?.toString().trim() || null,
      whatsapp: formData.get("whatsapp")?.toString().trim() || null,
      avatar_url: formData.get("avatar_url")?.toString().trim() || null,
    })
    .eq("id", id)

  if (error) return { error: "Erro ao atualizar closer." }

  revalidatePath("/closers")
  revalidatePath(`/closers/${id}`)
  return { success: true }
}

export async function toggleCloserActive(
  closerId: string,
  active: boolean
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin", "supervisor"])

  const supabase = await createClient()
  const { error } = await supabase
    .from("closers")
    .update({ active })
    .eq("id", closerId)

  if (error) return { error: "Erro ao alterar status do closer." }

  revalidatePath("/closers")
  return { success: true }
}
