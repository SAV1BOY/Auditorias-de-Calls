import React from "react"
import { View, Text } from "@react-pdf/renderer"
import { styles } from "./pdf-styles"
import { SENTIMENT_COLORS } from "@/lib/utils/constants"

interface SentimentTimelineEntry {
  timestamp_range: string
  sentiment: string
  confidence: number
  key_moment: string
}

interface DetectedObjection {
  timestamp: string
  objection: string
  closer_response: string
  effectiveness: string
}

interface PdfSentimentProps {
  sentimentOverall: string | null
  sentimentScore: number | null
  engagementLevel: string | null
  timeline: SentimentTimelineEntry[]
  objections: DetectedObjection[]
}

const SENTIMENT_LABELS_PT: Record<string, string> = {
  positive: "Positivo",
  neutral: "Neutro",
  negative: "Negativo",
  mixed: "Misto",
}

const ENGAGEMENT_LABELS_PT: Record<string, string> = {
  high: "Alto",
  medium: "Médio",
  low: "Baixo",
}

export function PdfSentiment({
  sentimentOverall,
  sentimentScore,
  engagementLevel,
  timeline,
  objections,
}: PdfSentimentProps) {
  if (!sentimentOverall) return null

  return (
    <View>
      <Text style={styles.sectionTitle}>Análise de Sentimento</Text>

      <View style={styles.sentimentRow}>
        <View>
          <Text style={styles.sentimentLabel}>Sentimento Geral</Text>
          <Text
            style={{
              ...styles.sentimentValue,
              color: SENTIMENT_COLORS[sentimentOverall] || "#94a3b8",
              fontFamily: "Helvetica-Bold",
            }}
          >
            {SENTIMENT_LABELS_PT[sentimentOverall] || sentimentOverall}
          </Text>
        </View>
        {sentimentScore !== null && (
          <View>
            <Text style={styles.sentimentLabel}>Score</Text>
            <Text style={styles.sentimentValue}>
              {sentimentScore.toFixed(2)}
            </Text>
          </View>
        )}
        {engagementLevel && (
          <View>
            <Text style={styles.sentimentLabel}>Engajamento</Text>
            <Text style={styles.sentimentValue}>
              {ENGAGEMENT_LABELS_PT[engagementLevel] || engagementLevel}
            </Text>
          </View>
        )}
      </View>

      {timeline.length > 0 && (
        <View style={styles.table}>
          <View style={styles.tableHeader}>
            <Text style={{ ...styles.tableCell, width: "25%", fontFamily: "Helvetica-Bold" }}>
              Trecho
            </Text>
            <Text style={{ ...styles.tableCell, width: "20%", fontFamily: "Helvetica-Bold" }}>
              Sentimento
            </Text>
            <Text style={{ ...styles.tableCell, width: "15%", fontFamily: "Helvetica-Bold" }}>
              Confiança
            </Text>
            <Text style={{ ...styles.tableCell, width: "40%", fontFamily: "Helvetica-Bold" }}>
              Momento-Chave
            </Text>
          </View>
          {timeline.map((entry, i) => (
            <View key={i} style={styles.tableRow}>
              <Text style={{ ...styles.tableCell, width: "25%" }}>
                {entry.timestamp_range}
              </Text>
              <Text
                style={{
                  ...styles.tableCell,
                  width: "20%",
                  color: SENTIMENT_COLORS[entry.sentiment] || "#94a3b8",
                }}
              >
                {SENTIMENT_LABELS_PT[entry.sentiment] || entry.sentiment}
              </Text>
              <Text style={{ ...styles.tableCell, width: "15%", textAlign: "center" }}>
                {(entry.confidence * 100).toFixed(0)}%
              </Text>
              <Text style={{ ...styles.tableCell, width: "40%" }}>
                {entry.key_moment}
              </Text>
            </View>
          ))}
        </View>
      )}

      {objections.length > 0 && (
        <View>
          <Text style={{ ...styles.sectionTitle, fontSize: 11, marginTop: 8 }}>
            Objeções Detectadas
          </Text>
          {objections.map((obj, i) => (
            <View key={i} style={styles.actionItem}>
              <Text style={{ fontSize: 8, color: "#64748b", marginBottom: 2 }}>
                {obj.timestamp}
              </Text>
              <Text style={{ fontSize: 9, fontFamily: "Helvetica-Bold", marginBottom: 2 }}>
                {obj.objection}
              </Text>
              <Text style={{ fontSize: 8, color: "#475569", marginBottom: 2 }}>
                Resposta: {obj.closer_response}
              </Text>
              <Text
                style={{
                  fontSize: 8,
                  color: obj.effectiveness === "good" ? "#16a34a" : "#ef4444",
                  fontFamily: "Helvetica-Bold",
                }}
              >
                {obj.effectiveness === "good" ? "Boa resposta" : "Resposta fraca"}
              </Text>
            </View>
          ))}
        </View>
      )}
    </View>
  )
}
