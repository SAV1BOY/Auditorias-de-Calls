"use client"

import { useTransition } from "react"
import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { useToast } from "@/components/ui/use-toast"
import type { CloserRow } from "@/lib/types/audit"
import { createCloser, updateCloser } from "@/lib/actions/closers"

interface CloserFormDialogProps {
  closer?: CloserRow
  open: boolean
  onOpenChange: (open: boolean) => void
}

export function CloserFormDialog({
  closer,
  open,
  onOpenChange,
}: CloserFormDialogProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()
  const isEdit = !!closer

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const action = isEdit ? updateCloser : createCloser
      if (isEdit && closer) {
        formData.set("id", closer.id)
      }
      const result = await action(formData)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: isEdit ? "Closer atualizado" : "Closer criado" })
        onOpenChange(false)
      }
    })
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{isEdit ? "Editar Closer" : "Novo Closer"}</DialogTitle>
        </DialogHeader>
        <form action={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">Nome *</Label>
            <Input
              id="name"
              name="name"
              required
              defaultValue={closer?.name ?? ""}
              placeholder="Nome do closer"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="email">Email</Label>
            <Input
              id="email"
              name="email"
              type="email"
              defaultValue={closer?.email ?? ""}
              placeholder="email@exemplo.com"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="whatsapp">WhatsApp</Label>
            <Input
              id="whatsapp"
              name="whatsapp"
              defaultValue={closer?.whatsapp ?? ""}
              placeholder="5511999999999"
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="avatar_url">URL do Avatar</Label>
            <Input
              id="avatar_url"
              name="avatar_url"
              defaultValue={closer?.avatar_url ?? ""}
              placeholder="https://..."
            />
          </div>
          <DialogFooter>
            <Button type="submit" disabled={isPending}>
              {isPending ? "Salvando..." : isEdit ? "Salvar" : "Criar"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
