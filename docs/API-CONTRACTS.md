# Contratos de API — Server Actions

Todas as mutações usam Server Actions (não API routes). Leituras também são Server Actions chamadas no server-side.

## Convenções

- **Sucesso em mutações:** `{ success: true }` ou `{ auditId: string }`
- **Erro em mutações:** `{ error: string }` ou `throw new Error(mensagem)`
- **Leituras:** retornam o tipo diretamente ou `null`
- **Autenticação:** via `requireAuth()` ou `requireRole([...])`
- **Validação:** Zod schemas em `lib/validations/`

---

## calls.ts

### `getDashboardStats()`
- **Auth:** requireAuth
- **Retorno:** `{ total_calls, avg_score, calls_this_week, score_trend }`

### `getRecentCalls()`
- **Auth:** requireAuth
- **Retorno:** `CallAuditWithCloser[]` (últimas 10)

### `getAudits(filters?)`
- **Auth:** requireAuth
- **Params:** `{ status?, closerId?, classificacao?, dateFrom?, dateTo?, page?, pageSize? }`
- **Retorno:** `{ data: CallAuditWithCloser[], total: number, page: number, pageSize: number }`

### `getAuditDetail(id)`
- **Auth:** requireAuth
- **Retorno:** `CallAuditWithCloser | null`

### `resendNotification(auditId)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ success: true } | { error: string }`

---

## upload.ts

### `uploadCall(formData)`
- **Auth:** requireRole(["admin", "supervisor", "closer"])
- **FormData:** `audio` (File), `closer_id` (string), `lead_name?`, `call_date?`, `resultado?`
- **Retorno:** `{ auditId: string } | { error: string }`

---

## closers.ts

### `getClosersList()`
- **Auth:** requireAuth
- **Retorno:** `CloserRow[]`

### `getCloserById(id)`
- **Auth:** requireAuth
- **Retorno:** `CloserRow | null`

### `getCloserPerformance(closerId)`
- **Auth:** requireAuth
- **Retorno:** `CloserPerformance | null` (médias por dimensão, evolução)

### `getCloserScoreEvolution(closerId)`
- **Auth:** requireAuth
- **Retorno:** `Array<{ date: string, score: number }>`

### `createCloser(formData)`
- **Auth:** requireRole(["admin", "supervisor"])
- **FormData:** `name`, `email?`, `phone?`
- **Retorno:** `{ success: true } | { error: string }`

### `updateCloser(formData)`
- **Auth:** requireRole(["admin", "supervisor"])
- **FormData:** `id`, `name`, `email?`, `phone?`, `active?`
- **Retorno:** `{ success: true } | { error: string }`

### `toggleCloserActive(closerId, active)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ success: true } | { error: string }`

---

## comments.ts

### `getComments(auditId)`
- **Auth:** requireAuth
- **Retorno:** `CallComment[]` (com author info)

### `createComment(data)`
- **Auth:** requireAuth
- **Params:** `{ auditId, content, timestampSec?, parentId? }`
- **Retorno:** `{ id: string }`

### `resolveComment(commentId)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** void

### `unresolveComment(commentId)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** void

### `deleteComment(commentId)`
- **Auth:** requireAuth + ownership check (autor ou admin/supervisor)
- **Retorno:** void
- **Erros:** "Not authenticated", "Sem permissão"

---

## bookmarks.ts

### `toggleBookmark(auditId, data)`
- **Auth:** requireAuth
- **Params:** `{ tags: string[], highlightTimestamps: HighlightTimestamp[], notes? }`
- **Retorno:** `{ success: true }`

### `removeBookmark(auditId)`
- **Auth:** requireAuth + ownership check
- **Retorno:** `{ success: true }`
- **Erros:** "Sem permissão"

### `getBookmark(auditId)`
- **Auth:** requireAuth
- **Retorno:** `CallBookmark | null`

### `getBookmarkedCalls(filters)`
- **Auth:** requireAuth
- **Params:** `{ tags?, closerId?, classificacao? }`
- **Retorno:** `CallBookmark[]`

---

## analytics.ts

### `getClosersComparison(closerIds, dateFrom?, dateTo?)`
- **Auth:** requireAuth
- **Retorno:** `CloserComparison[]` (médias por dimensão para cada closer)

### `getDimensionTrends(dimensionId, closerId?, days?)`
- **Auth:** requireAuth
- **Retorno:** `DimensionTrendPoint[]`

### `getGoals()`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `GoalWithProgress[]`

### `createGoal(formData)`
- **Auth:** requireRole(["admin", "supervisor"])
- **FormData:** `type`, `target_value`, `closer_id?`, `dimension?`, `deadline`
- **Retorno:** `{ success: true } | { error: string }`

### `updateGoalStatus(goalId, status)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ success: true } | { error: string }`

### `deleteGoal(goalId)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ success: true } | { error: string }`

---

## gamification.ts

### `getLeaderboard(period, metric)`
- **Auth:** requireAuth
- **Params:** period `"week"|"month"|"all"`, metric `"score_avg"|"volume"|"taxa_fechamento"`
- **Retorno:** `LeaderboardEntry[]`

### `getCloserBadges(closerId)`
- **Auth:** requireAuth
- **Retorno:** `CloserBadgeWithInfo[]`

### `getAllBadges()`
- **Auth:** requireAuth
- **Retorno:** `BadgeRow[]`

### `getCompetitions()`
- **Auth:** requireAuth
- **Retorno:** `CompetitionWithStandings[]`

### `createCompetition(formData)`
- **Auth:** requireRole(["admin", "supervisor"])
- **FormData:** `name`, `metric`, `start_date`, `end_date`, `closer_ids[]`
- **Retorno:** `{ success: true } | { error: string }`

### `getCompetitionStandings(competitionId)`
- **Auth:** requireAuth
- **Retorno:** `CompetitionStanding[]`

---

## settings.ts

### `getNotificationConfig()`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ whatsapp_numbers: string[], email_addresses: string[] }`

### `updateNotificationConfig(formData)`
- **Auth:** requireRole(["admin", "supervisor"])
- **FormData:** `whatsapp_numbers` (comma-separated), `email_addresses` (comma-separated)
- **Retorno:** `{ success: true } | { error: string }`

### `getApiStatus()`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ supabase: boolean, googleDrive: boolean }`

---

## reports.ts

### `getWeeklyReports()`
- **Auth:** requireAuth
- **Retorno:** `WeeklyReport[]`

### `getWeeklyReport(id)`
- **Auth:** requireAuth
- **Retorno:** `WeeklyReport | null`

---

## loss-patterns.ts

### `getLossPatterns(dateFrom?, dateTo?)`
- **Auth:** requireAuth
- **Retorno:** `LossPatternReport[]`

### `generateLossPatternAnalysis(dateFrom, dateTo)`
- **Auth:** requireRole(["admin", "supervisor"])
- **Retorno:** `{ success: true, reportId: string } | { error: string }`

### `getLossPatternDetail(id)`
- **Auth:** requireAuth
- **Retorno:** `LossPatternReport | null`

---

## export-pdf.ts

### `generateAuditPDF(auditId)`
- **Auth:** requireAuth
- **Retorno:** `{ url: string } | { error: string }`

### `generateBatchPDF(auditIds)`
- **Auth:** requireAuth
- **Retorno:** `{ url: string } | { error: string }`
