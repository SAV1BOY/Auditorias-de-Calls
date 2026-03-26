"use client"

import { useState, useTransition } from "react"
import { Plus, Trash2, Check, X } from "lucide-react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { useToast } from "@/components/ui/use-toast"
import type { CloserRow, GoalWithProgress } from "@/lib/types/audit"
import { updateGoalStatus, deleteGoal } from "@/lib/actions/analytics"
import { getGoalProgressColor, getDaysRemaining, getTotalDays } from "@/lib/utils/analytics"
import { GoalFormDialog } from "./goal-form-dialog"

const METRIC_LABELS: Record<string, string> = { score_avg: "Score M\u00e9dio", score_min: "Score M\u00ednimo", classificacao_count: "Calls n\u00e3o-Fracas", taxa_fechamento: "Taxa Fechamento", dimension_avg: "Dimens\u00e3o M\u00e9dia" }
const TYPE_LABELS: Record<string, string> = { individual: "Individual", team: "Time", dimension: "Dimens\u00e3o" }

interface GoalsDashboardProps { goals: GoalWithProgress[]; closers: CloserRow[] }

export function GoalsDashboard({ goals, closers }: GoalsDashboardProps) {
  const [showForm, setShowForm] = useState(false)
  const [showCompleted, setShowCompleted] = useState(false)
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  const activeGoals = goals.filter((g) => g.status === "active")
  const completedGoals = goals.filter((g) => g.status !== "active")

  function handleStatusChange(goalId: string, status: "active" | "completed" | "failed") {
    startTransition(async () => { const r = await updateGoalStatus(goalId, status); if (r.error) toast({ title: "Erro", description: r.error, variant: "destructive" }) })
  }
  function handleDelete(goalId: string) {
    startTransition(async () => { const r = await deleteGoal(goalId); if (r.error) toast({ title: "Erro", description: r.error, variant: "destructive" }) })
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-lg font-semibold font-headline">Metas Ativas ({activeGoals.length})</h2>
        <Button onClick={() => setShowForm(true)} size="sm"><Plus className="mr-1 h-4 w-4" />Nova Meta</Button>
      </div>
      {activeGoals.length === 0 && <p className="py-12 text-center text-sm text-muted-foreground">Nenhuma meta ativa. Crie sua primeira meta!</p>}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{activeGoals.map((goal) => (<GoalCard key={goal.id} goal={goal} isPending={isPending} onStatusChange={handleStatusChange} onDelete={handleDelete} />))}</div>
      {completedGoals.length > 0 && (
        <div className="space-y-4">
          <Button variant="ghost" onClick={() => setShowCompleted(!showCompleted)} className="text-muted-foreground">{showCompleted ? "Ocultar" : "Mostrar"} Metas Conclu\u00eddas ({completedGoals.length})</Button>
          {showCompleted && <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">{completedGoals.map((goal) => (<GoalCard key={goal.id} goal={goal} isPending={isPending} onStatusChange={handleStatusChange} onDelete={handleDelete} />))}</div>}
        </div>
      )}
      <GoalFormDialog closers={closers} open={showForm} onOpenChange={setShowForm} />
    </div>
  )
}

function GoalCard({ goal, isPending, onStatusChange, onDelete }: { goal: GoalWithProgress; isPending: boolean; onStatusChange: (id: string, status: "active" | "completed" | "failed") => void; onDelete: (id: string) => void }) {
  const daysRemaining = getDaysRemaining(goal.end_date)
  const totalDays = getTotalDays(goal.start_date, goal.end_date)
  const progressColor = getGoalProgressColor(goal.progress, daysRemaining, totalDays)
  const isMetric = goal.metric === "taxa_fechamento"
  const displayCurrent = isMetric ? `${goal.current_value}%` : goal.current_value.toFixed(1)
  const displayTarget = isMetric ? `${goal.target_value}%` : goal.target_value.toFixed(1)

  return (
    <Card className={goal.status !== "active" ? "opacity-60" : ""}>
      <CardHeader className="pb-2">
        <div className="flex items-start justify-between gap-2">
          <CardTitle className="text-sm font-medium leading-tight">{goal.title}</CardTitle>
          <div className="flex gap-1 flex-shrink-0">
            {goal.status === "active" && (<><Button variant="ghost" size="icon" className="h-6 w-6" disabled={isPending} onClick={() => onStatusChange(goal.id, "completed")} title="Marcar como conclu\u00edda"><Check className="h-3 w-3" /></Button><Button variant="ghost" size="icon" className="h-6 w-6" disabled={isPending} onClick={() => onStatusChange(goal.id, "failed")} title="Marcar como falha"><X className="h-3 w-3" /></Button></>)}
            <Button variant="ghost" size="icon" className="h-6 w-6 text-destructive" disabled={isPending} onClick={() => onDelete(goal.id)} title="Excluir meta"><Trash2 className="h-3 w-3" /></Button>
          </div>
        </div>
        <div className="flex flex-wrap gap-1">
          <Badge variant="outline" className="text-xs">{TYPE_LABELS[goal.type] ?? goal.type}</Badge>
          <Badge variant="outline" className="text-xs">{METRIC_LABELS[goal.metric] ?? goal.metric}</Badge>
          {goal.closer_name && <Badge variant="secondary" className="text-xs">{goal.closer_name}</Badge>}
          {goal.status === "completed" && <Badge className="bg-emerald-900/30 text-emerald-400 text-xs">Conclu\u00edda</Badge>}
          {goal.status === "failed" && <Badge className="bg-red-900/30 text-red-400 text-xs">N\u00e3o Atingida</Badge>}
        </div>
      </CardHeader>
      <CardContent className="space-y-3">
        <div className="space-y-1">
          <div className="flex justify-between text-xs text-muted-foreground font-body"><span>{displayCurrent} / {displayTarget}</span><span>{goal.progress}%</span></div>
          <div className="h-2 rounded-full bg-surface-container-high overflow-hidden"><div className={`h-full rounded-full transition-all ${progressColor}`} style={{ width: `${Math.min(goal.progress, 100)}%` }} /></div>
        </div>
        {goal.status === "active" && <p className="text-xs text-muted-foreground">{daysRemaining === 0 ? "Encerra hoje" : `${daysRemaining} dia${daysRemaining !== 1 ? "s" : ""} restante${daysRemaining !== 1 ? "s" : ""}`}</p>}
      </CardContent>
    </Card>
  )
}
