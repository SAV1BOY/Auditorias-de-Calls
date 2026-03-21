"use client"

import { useState, useTransition } from "react"
import { Button } from "@/components/ui/button"
import { FileText, Loader2 } from "lucide-react"
import { generateAuditPDF } from "@/lib/actions/export-pdf"

interface ExportPdfButtonProps {
  auditId: string
}

export function ExportPdfButton({ auditId }: ExportPdfButtonProps) {
  const [isPending, startTransition] = useTransition()
  const [error, setError] = useState<string | null>(null)

  function handleExport() {
    setError(null)
    startTransition(async () => {
      const result = await generateAuditPDF(auditId)
      if (result.error) {
        setError(result.error)
        setTimeout(() => setError(null), 3000)
      } else if (result.url) {
        window.open(result.url, "_blank")
      }
    })
  }

  return (
    <div className="flex items-center gap-2">
      <Button
        variant="outline"
        size="sm"
        onClick={handleExport}
        disabled={isPending}
      >
        {isPending ? (
          <Loader2 className="mr-1 h-4 w-4 animate-spin" />
        ) : (
          <FileText className="mr-1 h-4 w-4" />
        )}
        {isPending ? "Gerando PDF..." : "Exportar PDF"}
      </Button>
      {error && (
        <span className="text-xs text-destructive">{error}</span>
      )}
    </div>
  )
}
