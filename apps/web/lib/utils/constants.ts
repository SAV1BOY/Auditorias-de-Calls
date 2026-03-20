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

export const MAX_FILE_SIZE_MB = 500
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
