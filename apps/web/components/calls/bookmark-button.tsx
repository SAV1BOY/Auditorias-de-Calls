"use client"

import { useEffect, useState, useTransition } from "react"
import { Star } from "lucide-react"
import { Button } from "@/components/ui/button"
import { BookmarkDialog } from "./bookmark-dialog"
import { getBookmark, removeBookmark } from "@/lib/actions/bookmarks"
import type { CallBookmark } from "@/lib/types/audit"
import { cn } from "@/lib/utils"

interface BookmarkButtonProps {
  auditId: string
}

export function BookmarkButton({ auditId }: BookmarkButtonProps) {
  const [bookmark, setBookmark] = useState<CallBookmark | null>(null)
  const [dialogOpen, setDialogOpen] = useState(false)
  const [pending, startTransition] = useTransition()

  useEffect(() => {
    getBookmark(auditId).then(setBookmark)
  }, [auditId])

  const isBookmarked = bookmark !== null

  function handleClick() {
    if (isBookmarked) {
      startTransition(async () => {
        await removeBookmark(auditId)
        setBookmark(null)
      })
    } else {
      setDialogOpen(true)
    }
  }

  return (
    <>
      <Button
        variant="ghost"
        size="icon"
        onClick={handleClick}
        disabled={pending}
        title={isBookmarked ? "Remover dos modelos" : "Marcar como call modelo"}
      >
        <Star
          className={cn(
            "h-5 w-5",
            isBookmarked
              ? "fill-amber-400 text-amber-400"
              : "text-muted-foreground"
          )}
        />
      </Button>
      <BookmarkDialog
        auditId={auditId}
        open={dialogOpen}
        onOpenChange={setDialogOpen}
        onSaved={(bm) => {
          setBookmark(bm)
          setDialogOpen(false)
        }}
      />
    </>
  )
}
