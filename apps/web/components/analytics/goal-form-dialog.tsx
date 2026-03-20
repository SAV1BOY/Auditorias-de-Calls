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
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { useToast } from "@/components/ui/use-toast"
import type { CloserRow } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { createGoal } from "@/lib/actions/analytics"

interface GoalFormDialogProps {
  closers: CloserRow[]
  open: boolean
  onOpenChange: (open: boolean) => void
}

export function GoalFormDialog({
  closers,
  open,
  onOpenChange,
}: GoalFormDialogProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const result = await createGoal(formData)
      if (result.error) {
        toast({
          title: "Erro",
          description: result.error,
          variant: "destructive",
        })
      } else {
        toast({ title: "Meta criada com sucesso" })
        onOpenChange(false)
      }
    })
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>Nova Meta</DialogTitle>
        </DialogHeader>
        <form action={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="title">Título *</Label>
            <Input
              id="title"
              name="title"
              required
              placeholder="Ex: Score médio acima de 8.0"
            />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="type">Tipo *</Label>
              <Select name="type" required>
                <SelectTrigger>
                  <SelectValue placeholder="Selecione" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="individual">Individual</SelectItem>
                  <SelectItem value="team">Time</SelectItem>
                  <SelectItem value="dimension">Dimensão</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="metric">Métrica *</Label>
              <Select name="metric" required>
                <SelectTrigger>
                  <SelectValue placeholder="Selecione" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="score_avg">Score Médio</SelectItem>
                  <SelectItem value="score_min">Score Mínimo</SelectItem>
                  <SelectItem value="taxa_fechamento">Taxa Fechamento (%)</SelectItem>
                  <SelectItem value="classificacao_count">Calls não-Fracas</SelectItem>
                  <SelectItem value="dimension_avg">Dimensão Média</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <div className="space-y-2">
            <Label htmlFor="target_value">Valor Alvo *</Label>
            <Input
              id="target_value"
              name="target_value"
              type="number"
              step="0.1"
              min="0"
              required
              placeholder="Ex: 8.0"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="closer_id">Closer (para metas individuais)</Label>
            <Select name="closer_id">
              <SelectTrigger>
                <SelectValue placeholder="Todos (meta do time)" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">Todos (Time)</SelectItem>
                {closers
                  .filter((c) => c.active)
                  .map((closer) => (
                    <SelectItem key={closer.id} value={closer.id}>
                      {closer.name}
                    </SelectItem>
                  ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="dimension_id">
              Dimensão (para metas de dimensão)
            </Label>
            <Select name="dimension_id">
              <SelectTrigger>
                <SelectValue placeholder="Não aplicável" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">Não aplicável</SelectItem>
                {DIMENSIONS.map((dim) => (
                  <SelectItem key={dim.id} value={dim.id}>
                    {dim.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="start_date">Data Início *</Label>
              <Input
                id="start_date"
                name="start_date"
                type="date"
                required
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="end_date">Data Fim *</Label>
              <Input
                id="end_date"
                name="end_date"
                type="date"
                required
              />
            </div>
          </div>

          <DialogFooter>
            <Button type="submit" disabled={isPending}>
              {isPending ? "Criando..." : "Criar Meta"}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
