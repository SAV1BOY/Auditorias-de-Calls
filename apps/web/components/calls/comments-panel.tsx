"use client"

import { useCallback, useEffect, useState, useTransition } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { CheckCircle2, CircleDot, Clock, MessageSquare, Trash2, Undo2 } from "lucide-react"
import type { CallComment } from "@/lib/types/audit"
import { getComments, resolveComment, unresolveComment, deleteComment } from "@/lib/actions/comments"
import { CommentForm } from "./comment-form"
import { cn } from "@/lib/utils"

interface CommentsPanelProps { auditId: string; currentTime?: number; onSeek?: (sec: number) => void }

function formatTimestamp(sec: number | null): string {
  if (sec === null) return ""
  const m = Math.floor(sec / 60); const s = Math.floor(sec % 60)
  return `${m}:${s.toString().padStart(2, "0")}`
}

function CommentThread({ comment, auditId, onSeek, onRefresh }: { comment: CallComment; auditId: string; onSeek?: (sec: number) => void; onRefresh: () => void }) {
  const [showReply, setShowReply] = useState(false)
  const [pending, startTransition] = useTransition()

  function handleResolve() { startTransition(async () => { if (comment.resolved) { await unresolveComment(comment.id) } else { await resolveComment(comment.id) }; onRefresh() }) }
  function handleDelete() { startTransition(async () => { await deleteComment(comment.id); onRefresh() }) }

  return (
    <div className={cn("rounded-lg bg-surface-container-high/30 p-3 space-y-2", comment.resolved && "opacity-60")}>
      <div className="flex items-start justify-between gap-2">
        <div className="flex items-center gap-2 text-sm">
          <span className="font-medium">{comment.author?.full_name ?? "Usu\u00e1rio"}</span>
          {comment.author?.role && <Badge variant="outline" className="text-xs">{comment.author.role}</Badge>}
          {comment.timestamp_sec !== null && (
            <button className="flex items-center gap-1 text-xs text-on-surface-variant hover:text-primary transition-colors" onClick={() => onSeek?.(comment.timestamp_sec!)}>
              <Clock className="h-3 w-3" />{formatTimestamp(comment.timestamp_sec)}
            </button>
          )}
        </div>
        <div className="flex items-center gap-1">
          <Button variant="ghost" size="icon" className="h-6 w-6" onClick={handleResolve} disabled={pending} title={comment.resolved ? "Reabrir" : "Resolver"}>{comment.resolved ? <Undo2 className="h-3 w-3" /> : <CheckCircle2 className="h-3 w-3" />}</Button>
          <Button variant="ghost" size="icon" className="h-6 w-6 text-destructive" onClick={handleDelete} disabled={pending} title="Excluir"><Trash2 className="h-3 w-3" /></Button>
        </div>
      </div>
      <p className="text-sm">{comment.content}</p>
      {comment.resolved && <p className="text-xs text-emerald-400 flex items-center gap-1"><CheckCircle2 className="h-3 w-3" />Resolvido</p>}
      {comment.replies && comment.replies.length > 0 && (
        <div className="ml-4 space-y-2 pl-3" style={{ borderLeft: '2px solid #292a2d' }}>
          {comment.replies.map((reply) => (
            <div key={reply.id} className="space-y-1">
              <div className="flex items-center gap-2 text-sm">
                <span className="font-medium">{reply.author?.full_name ?? "Usu\u00e1rio"}</span>
                {reply.timestamp_sec !== null && <button className="text-xs text-on-surface-variant hover:text-primary transition-colors" onClick={() => onSeek?.(reply.timestamp_sec!)}>{formatTimestamp(reply.timestamp_sec)}</button>}
              </div>
              <p className="text-sm">{reply.content}</p>
            </div>
          ))}
        </div>
      )}
      <div>
        {!showReply ? (
          <button className="text-xs text-muted-foreground hover:text-foreground flex items-center gap-1" onClick={() => setShowReply(true)}><MessageSquare className="h-3 w-3" />Responder</button>
        ) : (
          <div className="mt-2"><CommentForm auditId={auditId} parentId={comment.id} placeholder="Escreva uma resposta..." onSubmitted={() => { setShowReply(false); onRefresh() }} /></div>
        )}
      </div>
    </div>
  )
}

export function CommentsPanel({ auditId, currentTime, onSeek }: CommentsPanelProps) {
  const [comments, setComments] = useState<CallComment[]>([])
  const [loading, setLoading] = useState(true)
  const refresh = useCallback(async () => { const data = await getComments(auditId); setComments(data); setLoading(false) }, [auditId])
  useEffect(() => { refresh() }, [refresh])
  useEffect(() => {
    const supabase = createClient()
    const channel = supabase.channel(`comments-${auditId}`).on("postgres_changes", { event: "*", schema: "public", table: "call_comments", filter: `audit_id=eq.${auditId}` }, () => { refresh() }).subscribe()
    return () => { supabase.removeChannel(channel) }
  }, [auditId, refresh])

  if (loading) return <div className="py-8 text-center text-muted-foreground animate-amber-pulse">Carregando coment\u00e1rios...</div>

  return (
    <div className="space-y-4">
      <CommentForm auditId={auditId} currentTimestamp={currentTime} placeholder="Adicionar feedback no momento atual..." onSubmitted={refresh} />
      {comments.length === 0 ? (
        <div className="py-8 text-center text-muted-foreground"><CircleDot className="mx-auto h-10 w-10 mb-2 opacity-20" /><p>Nenhum coment\u00e1rio ainda.</p><p className="text-sm mt-1">Adicione feedback em momentos espec\u00edficos do \u00e1udio.</p></div>
      ) : (
        <div className="space-y-3">{comments.map((comment) => (<CommentThread key={comment.id} comment={comment} auditId={auditId} onSeek={onSeek} onRefresh={refresh} />))}</div>
      )}
    </div>
  )
}
