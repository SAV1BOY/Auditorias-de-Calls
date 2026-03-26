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
import { useToast } from "@/components/ui/use-toast"
import { createUser, type UserProfile } from "@/lib/actions/users"

interface UserCreateDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  onCreated: (user: UserProfile) => void
}

export function UserCreateDialog({ open, onOpenChange, onCreated }: UserCreateDialogProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()
  const [error, setError] = useState<string | null>(null)

  function handleOpenChange(isOpen: boolean) {
    if (!isOpen) setError(null)
    onOpenChange(isOpen)
  }

  function handleSubmit(formData: FormData) {
    setError(null)
    startTransition(async () => {
      const result = await createUser(formData)
      if (result.error) {
        setError(result.error)
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: "Usuário criado com sucesso!" })
        onCreated({
          id: result.userId ?? "",
          full_name: formData.get("full_name")?.toString() ?? "",
          role: formData.get("role")?.toString() ?? "viewer",
          avatar_url: null,
          created_at: new Date().toISOString(),
          email: formData.get("email")?.toString(),
        })
      }
    })
  }

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <span className="material-symbols-outlined text-primary text-lg">person_add</span>
            Novo Usuário
          </DialogTitle>
        </DialogHeader>

        <form action={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="create_email">Email</Label>
            <Input
              id="create_email"
              name="email"
              type="email"
              placeholder="usuario@empresa.com"
              required
              autoComplete="off"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="create_password">Senha</Label>
            <Input
              id="create_password"
              name="password"
              type="password"
              placeholder="Mínimo 8 caracteres"
              required
              minLength={8}
              autoComplete="new-password"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="create_name">Nome Completo</Label>
            <Input
              id="create_name"
              name="full_name"
              type="text"
              placeholder="Nome do usuário"
              required
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="create_role">Função</Label>
            <select
              id="create_role"
              name="role"
              required
              className="w-full bg-surface-container-high border border-transparent rounded-lg px-4 py-3 text-sm font-body focus:border-primary/30 focus:ring-1 focus:ring-ring focus:outline-none"
            >
              <option value="supervisor">Supervisor</option>
              <option value="closer">Closer</option>
              <option value="viewer">Viewer (Somente Leitura)</option>
            </select>
            <p className="text-[10px] text-stone-500">
              Supervisores e closers acessam todas as funcionalidades. Viewers apenas visualizam.
            </p>
          </div>

          {error && (
            <div className="rounded-lg bg-red-500/10 border border-red-500/20 p-3">
              <p className="text-sm text-red-400">{error}</p>
            </div>
          )}

          <DialogFooter>
            <Button variant="outline" type="button" onClick={() => onOpenChange(false)}>
              Cancelar
            </Button>
            <Button type="submit" disabled={isPending}>
              {isPending ? "Criando..." : "Criar Usuário"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
