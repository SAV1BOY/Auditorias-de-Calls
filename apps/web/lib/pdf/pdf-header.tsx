import React from "react"
import { View, Text } from "@react-pdf/renderer"
import { styles, getScoreColorPdf, getClassificacaoColorPdf } from "./pdf-styles"

interface PdfHeaderProps {
  closerName: string
  leadName: string
  callDate: string
  durationMinutes: number | null
  resultado: string | null
  scoreFinal: number | null
  classificacao: string | null
}

export function PdfHeader({
  closerName,
  leadName,
  callDate,
  durationMinutes,
  resultado,
  scoreFinal,
  classificacao,
}: PdfHeaderProps) {
  return (
    <View style={styles.header}>
      <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "flex-start" }}>
        <View style={{ flex: 1 }}>
          <Text style={styles.title}>Auditoria de Call</Text>
          <Text style={styles.subtitle}>
            {closerName} × {leadName}
          </Text>
          <View style={styles.metaRow}>
            <View style={styles.metaItem}>
              <Text>Data: {callDate}</Text>
            </View>
            {durationMinutes && (
              <View style={styles.metaItem}>
                <Text>Duração: {durationMinutes} min</Text>
              </View>
            )}
            {resultado && (
              <View style={styles.metaItem}>
                <Text>Resultado: {resultado}</Text>
              </View>
            )}
          </View>
        </View>

        <View style={styles.scoreBox}>
          <Text
            style={{
              ...styles.scoreValue,
              color: getScoreColorPdf(scoreFinal),
            }}
          >
            {scoreFinal !== null ? scoreFinal.toFixed(1) : "—"}
          </Text>
          <Text style={styles.scoreLabel}>/10</Text>
          {classificacao && (
            <Text
              style={{
                fontSize: 11,
                fontFamily: "Helvetica-Bold",
                color: getClassificacaoColorPdf(classificacao),
                marginTop: 4,
              }}
            >
              {classificacao}
            </Text>
          )}
        </View>
      </View>
    </View>
  )
}
