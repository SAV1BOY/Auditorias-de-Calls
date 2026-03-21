import React from "react"
import { Document, Page, Text, View } from "@react-pdf/renderer"
import { styles } from "./pdf-styles"
import { PdfHeader } from "./pdf-header"
import { PdfScorecard } from "./pdf-scorecard"
import { PdfErrorsWins } from "./pdf-errors-wins"
import { PdfActionPlan } from "./pdf-action-plan"
import { PdfSentiment } from "./pdf-sentiment"
import type { CallAuditWithCloser } from "@/lib/types/audit"
import { DIMENSIONS } from "@/lib/utils/constants"
import { RESULTADO_LABELS } from "@/lib/utils/constants"

interface AuditReportDocumentProps {
  audit: CallAuditWithCloser
}

export function AuditReportDocument({ audit }: AuditReportDocumentProps) {
  const closerName = audit.closers?.name ?? "Desconhecido"
  const resultado = audit.resultado
    ? RESULTADO_LABELS[audit.resultado] ?? audit.resultado
    : null

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const auditData = audit as any
  const dimensions: Record<string, number | null> = {}
  for (const dim of DIMENSIONS) {
    dimensions[dim.id] = auditData[dim.id] as number | null
  }

  const topErros = (audit.top_erros as Array<{ rank: number; title: string; description: string; severity?: string }>) ?? []
  const topAcertos = (audit.top_acertos as Array<{ rank: number; title: string; description: string }>) ?? []
  const planoAcao = (audit.plano_acao as Array<{
    rank: number; title: string; o_que_fazer?: string
    por_que?: string; como_treinar?: string; prioridade?: string
  }>) ?? []

  const sentimentTimeline = (auditData.sentiment_timeline as Array<{
    timestamp_range: string; sentiment: string; confidence: number; key_moment: string
  }>) ?? []
  const objectionsDetected = (auditData.objections_detected as Array<{
    timestamp: string; objection: string; closer_response: string; effectiveness: string
  }>) ?? []

  return (
    <Document>
      <Page size="A4" style={styles.page}>
        <PdfHeader
          closerName={closerName}
          leadName={audit.lead_name}
          callDate={audit.call_date}
          durationMinutes={audit.duration_minutes}
          resultado={resultado}
          scoreFinal={audit.score_final}
          classificacao={audit.classificacao}
        />

        <PdfScorecard dimensions={dimensions} />

        <PdfErrorsWins topErros={topErros} topAcertos={topAcertos} />

        <View style={styles.footer}>
          <Text>
            CallAudit — Relatório gerado automaticamente •{" "}
            {new Date().toLocaleDateString("pt-BR")}
          </Text>
        </View>
      </Page>

      <Page size="A4" style={styles.page}>
        <PdfActionPlan items={planoAcao} />

        <PdfSentiment
          sentimentOverall={auditData.sentiment_overall as string | null}
          sentimentScore={auditData.sentiment_score as number | null}
          engagementLevel={auditData.engagement_level as string | null}
          timeline={sentimentTimeline}
          objections={objectionsDetected}
        />

        <View style={styles.footer}>
          <Text>
            CallAudit — Relatório gerado automaticamente •{" "}
            {new Date().toLocaleDateString("pt-BR")}
          </Text>
        </View>
      </Page>
    </Document>
  )
}
