import type {
  CallAuditWithCloser,
  CallBookmark,
  CallComment,
  GoalWithProgress,
  WeeklyReport,
  BadgeRow,
  CloserBadgeWithInfo,
  CloserStreakRow,
  LeaderboardEntry,
  CompetitionWithStandings,
  LossPatternReport,
  SentimentTimelineEntry,
  DetectedObjection,
} from "@/lib/types/audit"

export const mockCloser = {
  id: "closer-001",
  name: "Evelyn",
  email: "evelyn@test.com",
  whatsapp: "5511999999999",
  avatar_url: null,
  active: true,
  organization_id: null,
  created_at: "2026-01-01T00:00:00Z",
}

export const mockAudit: CallAuditWithCloser = {
  id: "audit-001",
  organization_id: null,
  closer_id: "closer-001",
  lead_name: "Elane Lima",
  call_date: "2026-03-15",
  status: "completed",
  audio_path: "audit-001/call.ogg",
  transcricao: "Olá, tudo bem? Meu nome é Evelyn...",
  relatorio_completo: "# Relatório\n\nAnálise completa...",
  score_final: 8.2,
  classificacao: "FORTE",
  resultado: "fechamento",
  valor_fechamento: 5000,
  duration_minutes: 45,
  audio_duration_seconds: 2700,
  d01_frame: 8.5,
  d02_qualificacao: 7.8,
  d03_diag_quantitativo: 8.0,
  d04_diag_qualitativo: 7.5,
  d05_consequencia: 8.2,
  d06_ensino: 9.0,
  d07_identidade: 7.0,
  d08_ancoragem: 8.8,
  d09_isolamento: 8.5,
  d10_proporcao_fala: 7.2,
  d11_promessas: 8.0,
  d12_checkpoints: 9.2,
  d13_fechamento: 8.5,
  top_erros: [
    { titulo: "Erro 1", descricao: "Desc", trecho: "trecho", impacto: "alto" },
  ],
  top_acertos: [
    { titulo: "Acerto 1", descricao: "Desc", trecho: "trecho", impacto: "alto" },
  ],
  reescrita_falas: [
    { fala_original: "original", fala_reescrita: "reescrita", motivo: "motivo", impacto: "alto" },
  ],
  plano_acao: [
    { acao: "ação 1", prioridade: "alta", dimensao: "frame" },
  ],
  frases_proibidas: [],
  mapa_frameworks: {},
  fases_analise: {},
  resumo_whatsapp: "Resumo para WhatsApp...",
  drive_file_id: null,
  drive_url: null,
  drive_report_url: null,
  error_message: null,
  modelo_transcricao: "whisper-1",
  modelo_analise: "claude-sonnet-4-20250514",
  tokens_input: 15000,
  tokens_output: 8000,
  custo_estimado: 0.12,
  uploaded_at: "2026-03-15T09:00:00Z",
  transcribed_at: "2026-03-15T09:15:00Z",
  analyzed_at: "2026-03-15T10:00:00Z",
  notified_at: "2026-03-15T10:05:00Z",
  completed_at: "2026-03-15T10:05:00Z",
  created_at: "2026-03-15T10:00:00Z",
  updated_at: "2026-03-15T10:30:00Z",
  closers: { name: "Evelyn" },
}

export const mockBookmark: CallBookmark = {
  id: "bookmark-001",
  audit_id: "audit-001",
  bookmarked_by: "user-001",
  tags: ["excelente-ancoragem", "fechamento-perfeito"],
  highlight_timestamps: [
    { start_sec: 120, end_sec: 180, label: "Ancoragem exemplar" },
  ],
  notes: "Call modelo para treinamento de ancoragem",
  created_at: "2026-03-15T12:00:00Z",
  call_audits: {
    id: "audit-001",
    lead_name: "Elane Lima",
    call_date: "2026-03-15",
    score_final: 8.2,
    classificacao: "FORTE",
    closers: { name: "Evelyn" },
  },
}

export const mockComment: CallComment = {
  id: "comment-001",
  audit_id: "audit-001",
  author_id: "user-001",
  parent_id: null,
  content: "Ótima ancoragem neste momento",
  timestamp_sec: 120,
  resolved: false,
  resolved_by: null,
  resolved_at: null,
  created_at: "2026-03-15T12:00:00Z",
  author: {
    full_name: "Carlos Supervisor",
    avatar_url: null,
    role: "supervisor",
  },
  replies: [
    {
      id: "comment-002",
      audit_id: "audit-001",
      author_id: "user-002",
      parent_id: "comment-001",
      content: "Concordo, pode ser usada como exemplo",
      timestamp_sec: null,
      resolved: false,
      resolved_by: null,
      resolved_at: null,
      created_at: "2026-03-15T12:05:00Z",
      author: {
        full_name: "Ana Manager",
        avatar_url: null,
        role: "manager",
      },
    },
  ],
}

export const mockWeeklyReport: WeeklyReport = {
  id: "report-001",
  organization_id: null,
  week_start: "2026-03-09",
  week_end: "2026-03-15",
  report_markdown: "# Resumo Semanal\n\n10 calls auditadas...",
  stats: {
    total_calls: 10,
    score_avg: 7.8,
    score_avg_prev: 7.2,
    top_closers: [
      { id: "closer-001", name: "Evelyn", score: 8.5 },
      { id: "closer-002", name: "Lucas", score: 7.9 },
    ],
    weakest_dimension: { id: "d07", name: "Reframe de Identidade", avg: 5.8 },
    best_call: { id: "audit-001", lead_name: "Elane Lima", closer_name: "Evelyn", score: 9.2 },
    worst_call: { id: "audit-005", lead_name: "João Silva", closer_name: "Lucas", score: 4.5 },
    taxa_fechamento: 40,
    total_prev_calls: 8,
  },
  generated_at: "2026-03-16T08:00:00Z",
  sent_whatsapp: true,
  sent_email: true,
  created_at: "2026-03-16T08:00:00Z",
}

export const mockGoal: GoalWithProgress = {
  id: "goal-001",
  organization_id: null,
  title: "Score médio acima de 8.0",
  type: "team",
  metric: "score_avg",
  target_value: 8.0,
  dimension_id: null,
  closer_id: null,
  start_date: "2026-03-01",
  end_date: "2026-03-31",
  status: "active",
  created_at: "2026-03-01T00:00:00Z",
  updated_at: "2026-03-01T00:00:00Z",
  current_value: 7.8,
  progress: 98,
}

// ─── Sprint 11: Gamification Fixtures ───

export const mockBadge: BadgeRow = {
  id: "badge-001",
  slug: "first_elite",
  name: "Primeira ELITE",
  description: "Primeira call classificada como ELITE",
  icon: "award",
  category: "score",
  criteria: { type: "classificacao", value: "ELITE", count: 1 },
}

export const mockBadges: BadgeRow[] = [
  mockBadge,
  {
    id: "badge-002",
    slug: "streak_3",
    name: "Sequência de 3",
    description: "3 calls consecutivas acima de 7.0",
    icon: "flame",
    category: "streak",
    criteria: { type: "streak_above", threshold: 7.0, count: 3 },
  },
  {
    id: "badge-003",
    slug: "perfect_dimension",
    name: "Dimensão Perfeita",
    description: "Qualquer dimensão com nota 10.0",
    icon: "star",
    category: "dimension",
    criteria: { type: "dimension_perfect", value: 10.0 },
  },
]

export const mockCloserBadge: CloserBadgeWithInfo = {
  id: "cb-001",
  closer_id: "closer-001",
  badge: mockBadge,
  audit_id: "audit-001",
  earned_at: "2026-03-15T10:00:00Z",
}

export const mockStreak: CloserStreakRow = {
  id: "streak-001",
  closer_id: "closer-001",
  streak_type: "daily_above_7",
  current_count: 5,
  best_count: 8,
  last_updated: "2026-03-15T10:00:00Z",
}

export const mockLeaderboardEntry: LeaderboardEntry = {
  rank: 1,
  closer_id: "closer-001",
  closer_name: "Evelyn",
  avatar_url: null,
  value: 8.5,
  badges_count: 3,
  trend: "up",
}

export const mockLeaderboard: LeaderboardEntry[] = [
  mockLeaderboardEntry,
  {
    rank: 2,
    closer_id: "closer-002",
    closer_name: "Lucas",
    avatar_url: null,
    value: 7.9,
    badges_count: 1,
    trend: "stable",
  },
  {
    rank: 3,
    closer_id: "closer-003",
    closer_name: "Ana",
    avatar_url: null,
    value: 7.2,
    badges_count: 0,
    trend: "down",
  },
]

export const mockCompetition: CompetitionWithStandings = {
  id: "comp-001",
  title: "Desafio de Março",
  description: "Maior média de score no mês",
  metric: "score_avg",
  metric_params: {},
  start_date: "2026-03-01",
  end_date: "2026-03-31",
  status: "active",
  standings: [
    { closer_id: "closer-001", closer_name: "Evelyn", rank: 1, value: 8.5 },
    { closer_id: "closer-002", closer_name: "Lucas", rank: 2, value: 7.9 },
  ],
}

// ─── Sprint 11: Loss Pattern Fixtures ───

export const mockLossPatternReport: LossPatternReport = {
  id: "lp-001",
  generated_at: "2026-03-16T08:00:00Z",
  period_start: "2026-03-01",
  period_end: "2026-03-15",
  total_lost_calls: 15,
  patterns: [
    {
      pattern: "Falta de diagnóstico quantitativo aprofundado",
      frequency: 8,
      severity: "high",
      affected_closers: ["closer-002", "closer-003"],
      example_audits: ["audit-005", "audit-008"],
      recommendation: "Treinar perguntas de diagnóstico quantitativo com role-play",
    },
    {
      pattern: "Objeção de preço não isolada corretamente",
      frequency: 6,
      severity: "medium",
      affected_closers: ["closer-001", "closer-003"],
      example_audits: ["audit-003"],
      recommendation: "Praticar técnica de isolamento com script específico",
    },
  ],
  common_objections: [
    { objection: "Está caro", count: 8, best_response: "Entendo. Comparando com o custo de não resolver..." },
    { objection: "Preciso pensar", count: 5, best_response: "O que especificamente você gostaria de avaliar?" },
  ],
  weakest_phases: [
    { phase: "Diagnóstico Quantitativo", avg_score: 4.8 },
    { phase: "Isolamento de Objeção", avg_score: 5.2 },
  ],
  report_markdown: "# Relatório de Padrões de Perda\n\n...",
}

// ─── Sprint 11: Sentiment Fixtures ───

export const mockSentimentTimeline: SentimentTimelineEntry[] = [
  { timestamp_range: "00:00-05:00", sentiment: "neutral", confidence: 0.8, key_moment: "Abertura da call" },
  { timestamp_range: "05:00-15:00", sentiment: "positive", confidence: 0.7, key_moment: "Engajamento no diagnóstico" },
  { timestamp_range: "15:00-25:00", sentiment: "negative", confidence: 0.6, key_moment: "Objeção de preço" },
  { timestamp_range: "25:00-35:00", sentiment: "positive", confidence: 0.8, key_moment: "Ancoragem de valor" },
]

export const mockObjections: DetectedObjection[] = [
  {
    timestamp: "15:30",
    objection: "Está muito caro para mim",
    closer_response: "Entendo sua preocupação. Vamos comparar com o custo de não resolver esse problema.",
    effectiveness: "good",
  },
  {
    timestamp: "22:00",
    objection: "Preciso falar com meu sócio",
    closer_response: "Claro, quando vocês podem conversar?",
    effectiveness: "poor",
  },
]
