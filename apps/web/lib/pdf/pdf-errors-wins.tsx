import React from "react"
import { View, Text } from "@react-pdf/renderer"
import { styles } from "./pdf-styles"

interface ListItem {
  rank: number
  title: string
  description: string
  severity?: string
}

interface PdfErrorsWinsProps {
  topErros: ListItem[]
  topAcertos: ListItem[]
}

function renderList(items: ListItem[], type: "error" | "win") {
  if (!items || items.length === 0) {
    return (
      <Text style={{ fontSize: 9, color: "#94a3b8", fontStyle: "italic" }}>
        Nenhum item identificado.
      </Text>
    )
  }

  return items.map((item) => (
    <View key={`${type}-${item.rank}`} style={styles.listItem}>
      <Text style={styles.listRank}>{item.rank}.</Text>
      <View style={styles.listContent}>
        <Text style={styles.listTitle}>
          {item.severity ? `[${item.severity}] ` : ""}
          {item.title}
        </Text>
        <Text style={styles.listDesc}>{item.description}</Text>
      </View>
    </View>
  ))
}

export function PdfErrorsWins({ topErros, topAcertos }: PdfErrorsWinsProps) {
  return (
    <View>
      <Text style={styles.sectionTitle}>Top 5 Erros Críticos</Text>
      {renderList(topErros, "error")}

      <Text style={styles.sectionTitle}>Top 5 Acertos</Text>
      {renderList(topAcertos, "win")}
    </View>
  )
}
