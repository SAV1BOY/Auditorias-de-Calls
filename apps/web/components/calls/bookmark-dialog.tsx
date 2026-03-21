"use client"

import { useState, useTransition } from "react"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Badge } from "@/components/ui/badge"
import { X } from "lucide-react"
import { toggleBookmark } from "@/lib/actions/bookmarks"
import type { CallBookmark } from "@/lib/types/audit"

interface BookmarkDialogProps {
  auditId: string
  open: boolean
  onOpenChange: (open: boolean) => void
  onSaved: (bookmark: CallBookmark) => void
}

const SUGGESTED_TAGS = [
  "excelente-ancoragem",
  "objecao-preco",
  "diagnostico-exemplar",
  "fechamento-perfeito",
  "rapport-alto",
  "frame-forte",
]

export function BookmarkDialog({
  auditId,
  open,
  onOpenChange,
  onSaved,
}: BookmarkDialogProps) {
  const [tags, setTags] = useState<string[]>([])
  const [tagInput, setTagInput] = useState("")
  const [notes, setNotes] = useState("")
  const [pending, startTransition] = useTransition()

  function addTag(tag: string) {
    const clean = tag.trim().toLowerCase().replace(/\s+/g, "-")
    if (clean && !tags.includes(clean)) {
      setTags([...tags, clean])
    }
    setTagInput("")
  }

  function removeTag(tag: string) {
    setTags(tags.filter((t) => t !== tag))
  }

  function handleKeyDown(e: React.KeyboardEvent) {
    if (e.key === "Enter" || e.key === ",") {
      e.preventDefault()
      addTag(tagInput)
    }
  }

  function handleSave() {
    startTransition(async () => {
      await toggleBookmark(auditId, {
        tags,
        highlightTimestamps: [],
        notes: notes || undefined,
      })
      onSaved({
        id: "",
        audit_id: auditId,
        organization_id: null,
        bookmarked_by: null,
        tags,
        highlight_timestamps: [],
        notes: notes || null,
        created_at: new Date().toISOString(),
      })
    })
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>Marcar como Call Modelo</DialogTitle>
        </DialogHeader>

        <div className="space-y-4">
          <div className="space-y-2">
            <Label>Tags</Label>
            <div className="flex flex-wrap gap-1.5 mb-2">
              {tags.map((tag) => (
                <Badge key={tag} variant="secondary" className="gap-1">
                  {tag}
                  <button onClick={() => removeTag(tag)}>
                    <X className="h-3 w-3" />
                  </button>
                </Badge>
              ))}
            </div>
            <Input
              placeholder="Adicionar tag e pressionar Enter..."
              value={tagInput}
              onChange={(e) => setTagInput(e.target.value)}
              onKeyDown={handleKeyDown}
            />
            <div className="flex flex-wrap gap-1 mt-1">
              {SUGGESTED_TAGS.filter((t) => !tags.includes(t)).map((tag) => (
                <button
                  key={tag}
                  className="text-xs text-muted-foreground hover:text-foreground border rounded px-1.5 py-0.5"
                  onClick={() => addTag(tag)}
                >
                  + {tag}
                </button>
              ))}
            </div>
          </div>

          <div className="space-y-2">
            <Label>Notas (opcional)</Label>
            <Input
              placeholder="Por que essa call é modelo?"
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)}>
            Cancelar
          </Button>
          <Button onClick={handleSave} disabled={pending}>
            {pending ? "Salvando..." : "Salvar"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  )
}
