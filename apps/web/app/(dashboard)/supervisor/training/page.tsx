import { getTrainingActions } from "@/lib/actions/supervisor"
import { TrainingList } from "@/components/supervisor/training-list"

export default async function SupervisorTrainingPage() {
  const actions = await getTrainingActions()

  return (
    <div className="space-y-8">
      <header>
        <h1 className="font-headline text-3xl font-bold tracking-tight mb-2">
          Training <span className="text-[#ffa600]">ACTIONS</span>
        </h1>
        <p className="text-[#d8c3ac]">
          Ações de treinamento geradas automaticamente para closers com etapas abaixo de 6.
        </p>
      </header>

      <TrainingList actions={actions} />
    </div>
  )
}
