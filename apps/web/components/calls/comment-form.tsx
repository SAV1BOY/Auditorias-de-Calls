"use client"

import { useState, useTransition } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Clock, Send } from "lucide-react"
import { createComment } from "@/lib/actions/comments"

interface CommentFormProps {
  auditId: string
  parentId?: string
  currentTimestamp?: number
  placeholder?: string
  onSubmitted?: () => void
}

function formatTimestamp(sec: number): string {
  const m = Math.floor(sec / 60)
  const s = Math.floor(sec % 60)
  return `${m}:${s.toString().padStart(2, "0")}`
}

export function CommentForm({
  auditId,
  parentId,
  currentTimestamp,
  placeholder = "Escreva um comentário...",
  onSubmitted,
}: CommentFormProps) {
  const [content, setContent] = useState("")
  const [attachTimestamp, setAttachTimestamp] = useState(true)
  const [pending, startTransition] = useTransition()

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!content.trim()) return

    startTransition(async () => {
      await createComment({
        auditId,
        content: content.trim(),
        parentId,
        timestampSec:
          attachTimestamp && currentTimestamp !== undefined
            ? Math.round(currentTimestamp * 10) / 10
            : undefined,
      })
      setContent("")
      onSubmitted?.()
    })
  }

  return (
    <form onSubmit={handleSubmit} className="flex items-center gap-2">
      <div className="relative flex-1">
        <Input
          placeholder={placeholder}
          value={content}
          onChange={(e) => setContent(e.target.value)}
          disabled={pending}
        />
      </div>

      {!parentId && currentTimestamp !== undefined && (
        <Button
          type="button"
          variant={attachTimestamp ? "secondary" : "ghost"}
          size="sm"
          className="h-9 gap-1 text-xs shrink-0"
          onClick={() => setAttachTimestamp(!attachTimestamp)}
          title={
            attachTimestamp
              ? "Comentário será vinculado ao timestamp"
              : "Comentário sem timestamp"
          }
        >
          <Clock className="h-3 w-3" />
          {formatTimestamp(currentTimestamp)}
        </Button>
      )}

      <Button
        type="submit"
        size="icon"
        className="h-9 w-9 shrink-0"
        disabled={pending || !content.trim()}
      >
        <Send className="h-4 w-4" />
      </Button>
    </form>
  )
}
