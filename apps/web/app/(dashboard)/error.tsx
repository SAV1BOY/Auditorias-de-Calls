"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { AlertTriangle } from "lucide-react"

export default function DashboardError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="flex items-center justify-center py-20">
      <Card className="max-w-md w-full">
        <CardContent className="pt-6 text-center space-y-4">
          <AlertTriangle className="mx-auto h-10 w-10 text-destructive" />
          <h2 className="text-xl font-semibold">Erro ao carregar</h2>
          <p className="text-sm text-muted-foreground">
            {error.message || "Ocorreu um erro ao carregar esta página."}
          </p>
          <Button onClick={reset} className="w-full">
            Tentar novamente
          </Button>
        </CardContent>
      </Card>
    </div>
  )
}
