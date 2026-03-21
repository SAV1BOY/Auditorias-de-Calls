import React from "react"
import { View, Text } from "@react-pdf/renderer"
import { styles, getScoreColorPdf } from "./pdf-styles"
import { DIMENSIONS } from "@/lib/utils/constants"

interface PdfScorecardProps {
  dimensions: Record<string, number | null>
}

export function PdfScorecard({ dimensions }: PdfScorecardProps) {
  return (
    <View>
      <Text style={styles.sectionTitle}>Scorecard — 13 Dimensões</Text>
      <View style={styles.table}>
        <View style={styles.tableHeader}>
          <Text style={{ ...styles.tableCell, ...styles.dimName, fontFamily: "Helvetica-Bold" }}>
            Dimensão
          </Text>
          <Text style={{ ...styles.tableCell, ...styles.dimWeight, fontFamily: "Helvetica-Bold" }}>
            Peso
          </Text>
          <Text style={{ ...styles.tableCell, ...styles.dimScore, fontFamily: "Helvetica-Bold" }}>
            Nota
          </Text>
          <Text style={{ ...styles.tableCell, ...styles.dimBar, fontFamily: "Helvetica-Bold" }}>
            Ponderada
          </Text>
        </View>
        {DIMENSIONS.map((dim) => {
          const score = dimensions[dim.id] as number | null
          const weighted = score !== null && score !== undefined ? score * dim.peso : 0
          return (
            <View key={dim.id} style={styles.tableRow}>
              <Text style={{ ...styles.tableCell, ...styles.dimName }}>
                {dim.name}
              </Text>
              <Text style={{ ...styles.tableCell, ...styles.dimWeight }}>
                {(dim.peso * 100).toFixed(0)}%
              </Text>
              <Text
                style={{
                  ...styles.tableCell,
                  ...styles.dimScore,
                  color: getScoreColorPdf(score ?? null),
                }}
              >
                {score !== null && score !== undefined ? score.toFixed(1) : "—"}
              </Text>
              <View style={styles.dimBar}>
                <View
                  style={{
                    width: `${Math.min(((score ?? 0) / 10) * 100, 100)}%`,
                    height: 8,
                    backgroundColor: getScoreColorPdf(score ?? null),
                    borderRadius: 2,
                    maxWidth: "80%",
                  }}
                />
                <Text style={{ fontSize: 8, color: "#64748b" }}>
                  {weighted.toFixed(2)}
                </Text>
              </View>
            </View>
          )
        })}
      </View>
    </View>
  )
}
