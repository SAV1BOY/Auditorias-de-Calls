"use server"

import { createClient } from "@/lib/supabase/server"
import type { CallComment } from "@/lib/types/audit"
import { createCommentSchema } from "@/lib/validations/schemas"
import { requireRole } from "@/lib/auth/require-role"

export async function createComment(data: {
  auditId: string
  timestampSec?: number
  content: string
  parentId?: string
}): Promise<{ id: string }> {
  const parsed = createCommentSchema.safeParse(data)
  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message ?? "Dados inválidos")
  }

  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) throw new Error("Not authenticated")

  const { data: row, error } = await supabase
    .from("call_comments")
    .insert({
      audit_id: parsed.data.auditId,
      author_id: user.id,
      timestamp_sec: parsed.data.timestampSec ?? null,
      content: parsed.data.content,
      parent_id: parsed.data.parentId ?? null,
    })
    .select("id")
    .single()

  if (error) throw new Error(error.message)
  return { id: row.id }
}

export async function resolveComment(commentId: string): Promise<void> {
  const { userId } = await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

  await supabase
    .from("call_comments")
    .update({
      resolved: true,
      resolved_by: userId,
      resolved_at: new Date().toISOString(),
    })
    .eq("id", commentId)
}

export async function unresolveComment(commentId: string): Promise<void> {
  await requireRole(["admin", "supervisor"])
  const supabase = await createClient()

  await supabase
    .from("call_comments")
    .update({
      resolved: false,
      resolved_by: null,
      resolved_at: null,
    })
    .eq("id", commentId)
}

export async function deleteComment(commentId: string): Promise<void> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) throw new Error("Not authenticated")

  // Check ownership: only author or admin/supervisor can delete
  const { data: comment } = await supabase
    .from("call_comments")
    .select("author_id")
    .eq("id", commentId)
    .single()

  if (!comment) throw new Error("Comentário não encontrado")

  if (comment.author_id !== user.id) {
    // Not the author — must be admin or supervisor
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single()

    if (!profile || !["admin", "supervisor"].includes(profile.role)) {
      throw new Error("Sem permissão para excluir este comentário")
    }
  }

  await supabase.from("call_comments").delete().eq("id", commentId)
}

export async function getComments(auditId: string): Promise<CallComment[]> {
  const supabase = await createClient()

  const { data } = await supabase
    .from("call_comments")
    .select("*, author:profiles!call_comments_author_id_fkey(full_name, avatar_url, role)")
    .eq("audit_id", auditId)
    .order("created_at", { ascending: true })

  if (!data) return []

  // Build thread structure: top-level comments with nested replies
  const byId = new Map<string, CallComment>()
  const topLevel: CallComment[] = []

  for (const row of data) {
    const comment: CallComment = {
      ...row,
      author: row.author as unknown as CallComment["author"],
      replies: [],
    }
    byId.set(comment.id, comment)
  }

  for (const comment of Array.from(byId.values())) {
    if (comment.parent_id && byId.has(comment.parent_id)) {
      byId.get(comment.parent_id)!.replies!.push(comment)
    } else {
      topLevel.push(comment)
    }
  }

  return topLevel
}
