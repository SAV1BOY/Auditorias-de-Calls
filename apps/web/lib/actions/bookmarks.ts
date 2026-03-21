"use server"

import { createClient } from "@/lib/supabase/server"
import { requireAuth } from "@/lib/auth/require-role"
import type { CallBookmark, HighlightTimestamp } from "@/lib/types/audit"

export async function toggleBookmark(
  auditId: string,
  data: {
    tags: string[]
    highlightTimestamps: HighlightTimestamp[]
    notes?: string
  }
): Promise<{ success: boolean }> {
  const supabase = await createClient()

  const { data: existing } = await supabase
    .from("call_bookmarks")
    .select("id")
    .eq("audit_id", auditId)
    .maybeSingle()

  if (existing) {
    // Update
    await supabase
      .from("call_bookmarks")
      .update({
        tags: data.tags,
        highlight_timestamps: data.highlightTimestamps as unknown as import("@/lib/types/database").Json,
        notes: data.notes ?? null,
      })
      .eq("audit_id", auditId)
  } else {
    // Insert
    const { userId, organizationId } = await requireAuth()

    await supabase.from("call_bookmarks").insert({
      audit_id: auditId,
      bookmarked_by: userId,
      tags: data.tags,
      highlight_timestamps: data.highlightTimestamps as unknown as import("@/lib/types/database").Json,
      notes: data.notes ?? null,
      organization_id: organizationId,
    })
  }

  return { success: true }
}

export async function removeBookmark(
  auditId: string
): Promise<{ success: boolean }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) throw new Error("Not authenticated")

  // Check ownership: only the user who bookmarked can remove
  const { data: bookmark } = await supabase
    .from("call_bookmarks")
    .select("bookmarked_by")
    .eq("audit_id", auditId)
    .maybeSingle()

  if (!bookmark) return { success: true } // Already removed

  if (bookmark.bookmarked_by !== user.id) {
    // Not owner — must be admin/supervisor
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single()

    if (!profile || !["admin", "supervisor"].includes(profile.role)) {
      throw new Error("Sem permissão para remover este bookmark")
    }
  }

  await supabase.from("call_bookmarks").delete().eq("audit_id", auditId)
  return { success: true }
}

export async function getBookmark(
  auditId: string
): Promise<CallBookmark | null> {
  const supabase = await createClient()
  const { data } = await supabase
    .from("call_bookmarks")
    .select("*")
    .eq("audit_id", auditId)
    .maybeSingle()

  if (!data) return null
  return {
    ...data,
    highlight_timestamps: (data.highlight_timestamps ?? []) as unknown as HighlightTimestamp[],
  }
}

export async function getBookmarkedCalls(filters: {
  tags?: string[]
  closerId?: string
  classificacao?: string
}): Promise<CallBookmark[]> {
  const supabase = await createClient()

  let query = supabase
    .from("call_bookmarks")
    .select(
      "*, call_audits!inner(id, lead_name, call_date, score_final, classificacao, closers(name))"
    )
    .order("created_at", { ascending: false })

  if (filters.tags && filters.tags.length > 0) {
    query = query.overlaps("tags", filters.tags)
  }

  if (filters.closerId) {
    query = query.eq("call_audits.closer_id", filters.closerId)
  }

  if (filters.classificacao) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    query = query.eq("call_audits.classificacao", filters.classificacao as any)
  }

  const { data } = await query

  return (data ?? []).map((row) => ({
    ...row,
    highlight_timestamps: (row.highlight_timestamps ?? []) as unknown as HighlightTimestamp[],
  })) as unknown as CallBookmark[]
}
