import { z } from "zod"

// ─── Comments ───

export const createCommentSchema = z.object({
  auditId: z.string().uuid("ID da auditoria inválido"),
  content: z.string().min(1, "Conteúdo obrigatório").max(5000, "Conteúdo muito longo (máx. 5000 caracteres)"),
  timestampSec: z.number().int().min(0).optional(),
  parentId: z.string().uuid().optional(),
})

export type CreateCommentInput = z.infer<typeof createCommentSchema>

// ─── Settings ───

const phoneRegex = /^\+?\d{10,15}$/

export const notificationConfigSchema = z.object({
  whatsapp_numbers: z.array(
    z.string().regex(phoneRegex, "Número de WhatsApp inválido. Use formato: +5511999999999")
  ),
  email_addresses: z.array(
    z.string().email("Endereço de email inválido")
  ),
})

export type NotificationConfigInput = z.infer<typeof notificationConfigSchema>

// ─── Competitions ───

const validMetrics = ["score_avg", "score_count_above", "taxa_fechamento", "volume", "improvement"] as const

export const createCompetitionSchema = z.object({
  title: z.string().min(1, "Título obrigatório").max(200, "Título muito longo"),
  description: z.string().max(1000).nullable().optional(),
  metric: z.enum(validMetrics, { error: "Métrica inválida" }),
  start_date: z.string().date("Data de início inválida"),
  end_date: z.string().date("Data de fim inválida"),
}).refine((data) => data.end_date > data.start_date, {
  message: "Data de fim deve ser posterior à data de início",
  path: ["end_date"],
})

export type CreateCompetitionInput = z.infer<typeof createCompetitionSchema>

// ─── Upload ───

const validResultados = ["fechamento", "nao_fechou", "reagendar", "outro"] as const

export const uploadMetadataSchema = z.object({
  closerId: z.string().uuid("Closer inválido"),
  leadName: z.string().min(1, "Nome do lead obrigatório").max(255).trim(),
  callDate: z.string().date("Data da call inválida"),
  resultado: z.enum(validResultados).nullable().optional(),
  valorFechamento: z.number().positive("Valor deve ser positivo").finite("Valor inválido").nullable().optional(),
})

export type UploadMetadataInput = z.infer<typeof uploadMetadataSchema>

// ─── Goals ───

const goalMetrics = ["score_avg", "score_min", "volume", "taxa_fechamento", "dimension_avg"] as const
const goalStatuses = ["active", "achieved", "missed"] as const

export const createGoalSchema = z.object({
  title: z.string().min(1, "Título obrigatório").max(200),
  metric: z.enum(goalMetrics, { error: "Métrica inválida" }),
  target_value: z.number().positive("Meta deve ser um valor positivo").finite(),
  deadline: z.string().date("Data limite inválida"),
  closer_id: z.string().uuid().nullable().optional(),
  dimension_id: z.string().nullable().optional(),
})

export type CreateGoalInput = z.infer<typeof createGoalSchema>

export const updateGoalStatusSchema = z.object({
  goalId: z.string().uuid("ID do goal inválido"),
  status: z.enum(goalStatuses, { error: "Status inválido" }),
})
