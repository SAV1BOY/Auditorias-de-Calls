import React from "react"
import { View, Text } from "@react-pdf/renderer"
import { styles } from "./pdf-styles"

interface ActionItem {
  rank: number
  title: string
  o_que_fazer?: string
  por_que?: string
  como_treinar?: string
  prioridade?: string
}

interface PdfActionPlanProps {
  items: ActionItem[]
}

export function PdfActionPlan({ items }: PdfActionPlanProps) {
  if (!items || items.length === 0) return null

  return (
    <View>
      <Text style={styles.sectionTitle}>Plano de Ação</Text>
      {items.map((item) => (
        <View key={item.rank} style={styles.actionItem}>
          <Text style={styles.actionTitle}>
            {item.rank}. {item.title}
          </Text>
          {item.o_que_fazer && (
            <Text style={styles.actionField}>
              <Text style={styles.actionFieldLabel}>O que fazer: </Text>
              {item.o_que_fazer}
            </Text>
          )}
          {item.por_que && (
            <Text style={styles.actionField}>
              <Text style={styles.actionFieldLabel}>Por quê: </Text>
              {item.por_que}
            </Text>
          )}
          {item.como_treinar && (
            <Text style={styles.actionField}>
              <Text style={styles.actionFieldLabel}>Como treinar: </Text>
              {item.como_treinar}
            </Text>
          )}
          {item.prioridade && (
            <Text style={styles.actionField}>
              <Text style={styles.actionFieldLabel}>Prioridade: </Text>
              {item.prioridade}
            </Text>
          )}
        </View>
      ))}
    </View>
  )
}
