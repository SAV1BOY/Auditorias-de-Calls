import { StyleSheet } from "@react-pdf/renderer"

export const styles = StyleSheet.create({
  page: {
    padding: 40,
    fontSize: 10,
    fontFamily: "Helvetica",
    color: "#1a1a1a",
  },
  header: {
    marginBottom: 20,
    borderBottom: "2px solid #2563eb",
    paddingBottom: 12,
  },
  title: {
    fontSize: 20,
    fontFamily: "Helvetica-Bold",
    color: "#1e293b",
    marginBottom: 4,
  },
  subtitle: {
    fontSize: 11,
    color: "#64748b",
  },
  metaRow: {
    flexDirection: "row",
    gap: 20,
    marginTop: 8,
    fontSize: 9,
    color: "#475569",
  },
  metaItem: {
    flexDirection: "row",
    gap: 4,
  },
  sectionTitle: {
    fontSize: 14,
    fontFamily: "Helvetica-Bold",
    color: "#1e293b",
    marginTop: 16,
    marginBottom: 8,
    borderBottom: "1px solid #e2e8f0",
    paddingBottom: 4,
  },
  scoreBox: {
    alignItems: "center",
    justifyContent: "center",
    padding: 12,
    marginBottom: 12,
    backgroundColor: "#f8fafc",
    borderRadius: 6,
  },
  scoreValue: {
    fontSize: 32,
    fontFamily: "Helvetica-Bold",
  },
  scoreLabel: {
    fontSize: 10,
    color: "#64748b",
    marginTop: 2,
  },
  table: {
    marginTop: 4,
    marginBottom: 12,
  },
  tableHeader: {
    flexDirection: "row",
    backgroundColor: "#f1f5f9",
    padding: 6,
    borderBottom: "1px solid #cbd5e1",
  },
  tableRow: {
    flexDirection: "row",
    padding: 5,
    borderBottom: "1px solid #f1f5f9",
  },
  tableCell: {
    fontSize: 9,
  },
  dimName: {
    width: "35%",
  },
  dimWeight: {
    width: "12%",
    textAlign: "center",
  },
  dimScore: {
    width: "12%",
    textAlign: "center",
    fontFamily: "Helvetica-Bold",
  },
  dimBar: {
    width: "41%",
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  listItem: {
    flexDirection: "row",
    marginBottom: 6,
    gap: 6,
  },
  listRank: {
    fontSize: 9,
    fontFamily: "Helvetica-Bold",
    color: "#2563eb",
    width: 16,
  },
  listContent: {
    flex: 1,
  },
  listTitle: {
    fontSize: 9,
    fontFamily: "Helvetica-Bold",
    marginBottom: 2,
  },
  listDesc: {
    fontSize: 8,
    color: "#475569",
  },
  actionItem: {
    marginBottom: 10,
    padding: 8,
    backgroundColor: "#f8fafc",
    borderRadius: 4,
    borderLeft: "3px solid #2563eb",
  },
  actionTitle: {
    fontSize: 10,
    fontFamily: "Helvetica-Bold",
    marginBottom: 4,
  },
  actionField: {
    fontSize: 8,
    color: "#475569",
    marginBottom: 2,
  },
  actionFieldLabel: {
    fontFamily: "Helvetica-Bold",
    color: "#334155",
  },
  sentimentRow: {
    flexDirection: "row",
    gap: 16,
    marginBottom: 8,
    padding: 8,
    backgroundColor: "#f8fafc",
    borderRadius: 4,
  },
  sentimentLabel: {
    fontSize: 9,
    fontFamily: "Helvetica-Bold",
    color: "#334155",
  },
  sentimentValue: {
    fontSize: 9,
    color: "#475569",
  },
  footer: {
    position: "absolute",
    bottom: 20,
    left: 40,
    right: 40,
    fontSize: 7,
    color: "#94a3b8",
    textAlign: "center",
    borderTop: "1px solid #e2e8f0",
    paddingTop: 6,
  },
})

export function getScoreColorPdf(score: number | null): string {
  if (score === null) return "#94a3b8"
  if (score >= 8.5) return "#16a34a"
  if (score >= 7.0) return "#2563eb"
  if (score >= 5.5) return "#f59e0b"
  return "#ef4444"
}

export function getClassificacaoColorPdf(classificacao: string): string {
  switch (classificacao) {
    case "ELITE":
      return "#16a34a"
    case "FORTE":
      return "#2563eb"
    case "MEDIANA":
      return "#f59e0b"
    case "FRACA":
      return "#ef4444"
    default:
      return "#94a3b8"
  }
}
