"use client"

import { Button } from "@/components/ui/button"

export default function RankingError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  console.error("Ranking page error:", error)
  return (
    <div className="flex flex-col items-center justify-center py-20 text-center">
      <h2 className="text-xl font-semibold mb-2">Erro ao carregar ranking</h2>
      <p className="text-muted-foreground mb-4">
        Ocorreu um erro ao carregar os dados de ranking.
      </p>
      <Button onClick={reset}>Tentar novamente</Button>
    </div>
  )
}
