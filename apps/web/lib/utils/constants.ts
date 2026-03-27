export const DIMENSIONS = [
  { id: "d01_frame", name: "Frame e Liderança", peso: 0.08 },
  { id: "d02_qualificacao", name: "Qualificação Preliminar", peso: 0.10 },
  { id: "d03_diag_quantitativo", name: "Diagnóstico Quantitativo", peso: 0.12 },
  { id: "d04_diag_qualitativo", name: "Diagnóstico Qualitativo", peso: 0.08 },
  { id: "d05_consequencia", name: "Perguntas de Consequência", peso: 0.10 },
  { id: "d06_ensino", name: "Ensino Comercial", peso: 0.05 },
  { id: "d07_identidade", name: "Reframe de Identidade", peso: 0.05 },
  { id: "d08_ancoragem", name: "Ancoragem de Valor", peso: 0.10 },
  { id: "d09_isolamento", name: "Isolamento de Objeção", peso: 0.10 },
  { id: "d10_proporcao_fala", name: "Proporção de Fala", peso: 0.08 },
  { id: "d11_promessas", name: "Segurança de Promessas", peso: 0.08 },
  { id: "d12_checkpoints", name: "Checkpoints", peso: 0.03 },
  { id: "d13_fechamento", name: "Controle e Fechamento", peso: 0.03 },
] as const

export type DimensionId = (typeof DIMENSIONS)[number]["id"]

export const CLASSIFICACAO_THRESHOLDS = {
  ELITE: 8.5,
  FORTE: 7.0,
  MEDIANA: 5.5,
} as const

export const AUDIO_FORMATS = [
  ".ogg",
  ".mp3",
  ".mp4",
  ".webm",
  ".wav",
  ".m4a",
] as const

export const TRANSCRIPTION_FORMATS = [
  ".md",
  ".txt",
  ".pdf",
  ".docx",
] as const

export const MAX_FILE_SIZE_MB = 500
export const MAX_TRANSCRIPTION_FILE_SIZE_MB = 50
export const MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024

export const STATUS_LABELS: Record<string, string> = {
  uploaded: "Enviado",
  transcribing: "Transcrevendo",
  transcribed: "Transcrito",
  analyzing: "Analisando",
  analyzed: "Analisado",
  notifying: "Notificando",
  completed: "Completo",
  error: "Erro",
}

export const RESULTADO_LABELS: Record<string, string> = {
  fechamento: "Fechamento",
  nao_fechou: "Não Fechou",
  reagendar: "Reagendar",
  outro: "Outro",
}

export const RADAR_LABELS: Record<string, string> = {
  d01_frame: "Frame",
  d02_qualificacao: "Qualif.",
  d03_diag_quantitativo: "Diag.Quant.",
  d04_diag_qualitativo: "Diag.Qual.",
  d05_consequencia: "Conseq.",
  d06_ensino: "Ensino",
  d07_identidade: "Ident.",
  d08_ancoragem: "Ancor.",
  d09_isolamento: "Isol.",
  d10_proporcao_fala: "Prop.Fala",
  d11_promessas: "Promessas",
  d12_checkpoints: "Checkp.",
  d13_fechamento: "Fech.",
}

export const DIM_INDEX_MAP: Record<string, string> = {
  d01_frame: "avg_d01",
  d02_qualificacao: "avg_d02",
  d03_diag_quantitativo: "avg_d03",
  d04_diag_qualitativo: "avg_d04",
  d05_consequencia: "avg_d05",
  d06_ensino: "avg_d06",
  d07_identidade: "avg_d07",
  d08_ancoragem: "avg_d08",
  d09_isolamento: "avg_d09",
  d10_proporcao_fala: "avg_d10",
  d11_promessas: "avg_d11",
  d12_checkpoints: "avg_d12",
  d13_fechamento: "avg_d13",
}

// ─── Sprint 11: Gamification Constants ───

export const BADGE_CATEGORIES: Record<string, string> = {
  score: "Score",
  streak: "Sequência",
  volume: "Volume",
  dimension: "Dimensão",
  special: "Especial",
}

export const LEADERBOARD_METRICS: { value: string; label: string }[] = [
  { value: "score_avg", label: "Média de Score" },
  { value: "volume", label: "Volume de Calls" },
  { value: "taxa_fechamento", label: "Taxa de Fechamento" },
]

export const LEADERBOARD_PERIODS: { value: string; label: string }[] = [
  { value: "week", label: "Esta Semana" },
  { value: "month", label: "Este Mês" },
  { value: "all", label: "Todos os Tempos" },
]

// ─── Sprint 11: Sentiment Constants ───

export const SENTIMENT_LABELS: Record<string, string> = {
  positive: "Positivo",
  neutral: "Neutro",
  negative: "Negativo",
  mixed: "Misto",
}

export const SENTIMENT_COLORS: Record<string, string> = {
  positive: "#22c55e",
  neutral: "#a3a3a3",
  negative: "#ef4444",
  mixed: "#f59e0b",
}

export const ENGAGEMENT_LABELS: Record<string, string> = {
  high: "Alto",
  medium: "Médio",
  low: "Baixo",
}

export const ENGAGEMENT_COLORS: Record<string, string> = {
  high: "#22c55e",
  medium: "#f59e0b",
  low: "#ef4444",
}
