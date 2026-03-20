"use client"

import { Button } from "@/components/ui/button"

export default function RootError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="flex min-h-screen items-center justify-center p-4">
      <div className="text-center space-y-4 max-w-md">
        <h1 className="text-2xl font-bold">Algo deu errado</h1>
        <p className="text-muted-foreground">
          {error.message || "Ocorreu um erro inesperado. Tente novamente ou volte à página inicial."}
        </p>
        <div className="flex justify-center gap-2">
          <Button onClick={reset}>Tentar novamente</Button>
          <Button variant="outline" onClick={() => (window.location.href = "/")}>
            Página inicial
          </Button>
        </div>
      </div>
    </div>
  )
}
