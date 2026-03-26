"use client"

import { useState, useTransition } from "react"
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
import { createCloser, updateCloser, updateCloserNotificationEmails } from "@/lib/actions/closers"

interface CloserFormDialogProps {
  closer?: CloserRow
  open: boolean
  onOpenChange: (open: boolean) => void
  isAdmin?: boolean
  notificationEmails?: string[]
}

export function CloserFormDialog({
  closer,
  open,
  onOpenChange,
  isAdmin = false,
  notificationEmails = [],
}: CloserFormDialogProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()
  const isEdit = !!closer
  const [emails, setEmails] = useState(notificationEmails.join("\n"))

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const action = isEdit ? updateCloser : createCloser
      if (isEdit && closer) {
        formData.set("id", closer.id)
      }
      const result = await action(formData)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
        return
      }

      // Save notification emails (admin only, edit mode)
      if (isAdmin && isEdit && closer) {
        const emailList = emails
          .split("\n")
          .map((e) => e.trim())
          .filter((e) => e.length > 0)
        const emailResult = await updateCloserNotificationEmails(closer.id, emailList)
        if (emailResult.error) {
          toast({ title: "Aviso", description: emailResult.error, variant: "destructive" })
        }
      }

      toast({ title: isEdit ? "Closer atualizado" : "Closer criado" })
      onOpenChange(false)
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

          {isAdmin && isEdit && (
            <div className="space-y-2">
              <Label htmlFor="notification_emails">
                Emails de Notificação
              </Label>
              <textarea
                id="notification_emails"
                value={emails}
                onChange={(e) => setEmails(e.target.value)}
                rows={3}
                className="w-full bg-surface-container-high border border-transparent rounded-lg px-4 py-3 text-sm font-body focus:border-primary/30 focus:ring-1 focus:ring-ring focus:outline-none resize-none"
                placeholder={"supervisor1@empresa.com\nsupervisor2@empresa.com"}
              />
              <p className="text-[10px] text-stone-500">
                Supervisores que recebem auditorias deste closer (um email por linha). Se vazio, usa configuração global.
              </p>
            </div>
          )}

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
