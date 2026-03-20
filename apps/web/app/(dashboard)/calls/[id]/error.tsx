"use client"

import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { AlertTriangle, ArrowLeft } from "lucide-react"

export default function AuditDetailError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="space-y-4">
      <Button variant="ghost" size="sm" asChild>
        <Link href="/calls">
          <ArrowLeft className="mr-1 h-4 w-4" />
          Voltar para Calls
        </Link>
      </Button>
      <Card className="max-w-md mx-auto">
        <CardContent className="pt-6 text-center space-y-4">
          <AlertTriangle className="mx-auto h-10 w-10 text-destructive" />
          <h2 className="text-xl font-semibold">Erro ao carregar auditoria</h2>
          <p className="text-sm text-muted-foreground">
            {error.message || "Não foi possível carregar os detalhes desta auditoria."}
          </p>
          <Button onClick={reset} className="w-full">
            Tentar novamente
          </Button>
        </CardContent>
      </Card>
    </div>
  )
}
