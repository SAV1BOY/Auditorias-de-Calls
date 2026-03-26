"use server"

import { createClient } from "@/lib/supabase/server"
import { requireRole, requireAuth } from "@/lib/auth/require-role"
import { createCompetitionSchema } from "@/lib/validations/schemas"
import type {
  BadgeRow,
  CompetitionRow,
  CompetitionStanding,
  CompetitionWithStandings,
  LeaderboardEntry,
} from "@/lib/types/audit"

// Helper: access new tables not yet in generated Supabase types
/* eslint-disable @typescript-eslint/no-explicit-any */
function db(supabase: any): { from: (table: string) => any } {
  return supabase
}
/* eslint-enable @typescript-eslint/no-explicit-any */

function getDateFilter(period: "week" | "month" | "all"): string | null {
  if (period === "all") return null
  const now = new Date()
  if (period === "week") {
    const d = new Date(now)
    d.setDate(d.getDate() - 7)
    return d.toISOString().split("T")[0]
  }
  // month
  const d = new Date(now)
  d.setMonth(d.getMonth() - 1)
  return d.toISOString().split("T")[0]
}

function getPreviousPeriodDates(
  period: "week" | "month" | "all"
): { from: string; to: string } | null {
  if (period === "all") return null
  const now = new Date()
  if (period === "week") {
    const to = new Date(now)
    to.setDate(to.getDate() - 7)
    const from = new Date(to)
    from.setDate(from.getDate() - 7)
    return { from: from.toISOString().split("T")[0], to: to.toISOString().split("T")[0] }
  }
  // month
  const to = new Date(now)
  to.setMonth(to.getMonth() - 1)
  const from = new Date(to)
  from.setMonth(from.getMonth() - 1)
  return { from: from.toISOString().split("T")[0], to: to.toISOString().split("T")[0] }
}

export async function getLeaderboard(
  period: "week" | "month" | "all",
  metric: "score_avg" | "volume" | "taxa_fechamento"
): Promise<LeaderboardEntry[]> {
  await requireAuth()
  const supabase = await createClient()

  // Fetch closers
  const { data: closers } = await supabase
    .from("closers")
    .select("id, name, avatar_url")

  if (!closers || closers.length === 0) return []

  const closerIds = closers.map((c) => c.id)
  const dateFilter = getDateFilter(period)
  const prevDates = getPreviousPeriodDates(period)

  // Batch: fetch all current period audits in ONE query
  let currentQuery = supabase
    .from("call_audits")
    .select("closer_id, score_final, resultado")
    .in("closer_id", closerIds)
    .eq("status", "completed")

  if (dateFilter) {
    currentQuery = currentQuery.gte("call_date", dateFilter)
  }

  const { data: allAudits } = await currentQuery

  // Batch: fetch all previous period audits in ONE query
  let allPrevAudits: typeof allAudits = null
  if (prevDates) {
    const { data } = await supabase
      .from("call_audits")
      .select("closer_id, score_final, resultado")
      .in("closer_id", closerIds)
      .eq("status", "completed")
      .gte("call_date", prevDates.from)
      .lt("call_date", prevDates.to)
    allPrevAudits = data
  }

  // Batch: fetch badge counts per closer in ONE query
  const { data: badgeRows } = await db(supabase)
    .from("closer_badges")
    .select("closer_id")
    .in("closer_id", closerIds)

  // Group badge counts by closer_id
  const badgeCounts = new Map<string, number>()
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  for (const row of (badgeRows ?? []) as any[]) {
    const cid = row.closer_id as string
    badgeCounts.set(cid, (badgeCounts.get(cid) ?? 0) + 1)
  }

  // Group audits by closer_id
  const auditsByCloser = new Map<string, typeof allAudits>()
  for (const audit of allAudits ?? []) {
    const cid = audit.closer_id as string
    if (!auditsByCloser.has(cid)) auditsByCloser.set(cid, [])
    auditsByCloser.get(cid)!.push(audit)
  }

  const prevByCloser = new Map<string, typeof allPrevAudits>()
  for (const audit of allPrevAudits ?? []) {
    const cid = audit.closer_id as string
    if (!prevByCloser.has(cid)) prevByCloser.set(cid, [])
    prevByCloser.get(cid)!.push(audit)
  }

  function calcMetric(audits: NonNullable<typeof allAudits>): number {
    if (metric === "score_avg") {
      const scores = audits
        .map((a) => a.score_final)
        .filter((s): s is number => s !== null)
      return scores.length > 0
        ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
        : 0
    } else if (metric === "volume") {
      return audits.length
    } else {
      const fechamentos = audits.filter((a) => a.resultado === "fechamento").length
      return Math.round((fechamentos / audits.length) * 100)
    }
  }

  const entries: LeaderboardEntry[] = []

  for (const closer of closers) {
    const audits = auditsByCloser.get(closer.id)
    if (!audits || audits.length === 0) continue

    const value = calcMetric(audits)

    let trend: "up" | "down" | "stable" = "stable"
    const prevAudits = prevByCloser.get(closer.id)
    if (prevAudits && prevAudits.length > 0) {
      const prevValue = calcMetric(prevAudits)
      if (value > prevValue) trend = "up"
      else if (value < prevValue) trend = "down"
    }

    entries.push({
      rank: 0,
      closer_id: closer.id,
      closer_name: closer.name,
      avatar_url: closer.avatar_url ?? null,
      value,
      badges_count: badgeCounts.get(closer.id) ?? 0,
      trend,
    })
  }

  // Sort descending by value
  entries.sort((a, b) => b.value - a.value)

  // Assign ranks
  entries.forEach((entry, idx) => {
    entry.rank = idx + 1
  })

  return entries
}

export async function getAllBadges(): Promise<BadgeRow[]> {
  await requireAuth()
  const supabase = await createClient()

  const { data } = await db(supabase)
    .from("badges")
    .select("*")
    .order("category")

  return (data as BadgeRow[]) ?? []
}

export async function getAllEarnedBadgeIds(): Promise<string[]> {
  await requireAuth()
  const supabase = await createClient()

  const { data } = await db(supabase)
    .from("closer_badges")
    .select("badge_id")

  if (!data) return []

  // Return unique badge IDs that have been earned by any closer
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const ids = new Set<string>(data.map((row: any) => row.badge_id as string))
  return Array.from(ids)
}

export async function getCompetitions(): Promise<CompetitionWithStandings[]> {
  await requireAuth()
  const supabase = await createClient()

  const today = new Date().toISOString().split("T")[0]

  // Auto-complete expired competitions
  await db(supabase)
    .from("competitions")
    .update({ status: "completed" })
    .eq("status", "active")
    .lt("end_date", today)

  const { data: competitions } = await db(supabase)
    .from("competitions")
    .select("*")
    .in("status", ["active", "upcoming"])
    .order("start_date", { ascending: false })

  if (!competitions || competitions.length === 0) return []

  const result: CompetitionWithStandings[] = []

  for (const comp of competitions as CompetitionRow[]) {
    // Inline standings calculation
    const { data: closers } = await supabase
      .from("closers")
      .select("id, name")

    const standings: CompetitionStanding[] = []

    if (closers && closers.length > 0) {
      const closerIds = closers.map((c) => c.id)

      const { data: allAudits } = await supabase
        .from("call_audits")
        .select("closer_id, score_final, resultado")
        .in("closer_id", closerIds)
        .eq("status", "completed")
        .gte("call_date", comp.start_date)
        .lte("call_date", comp.end_date)

      const auditsByCloser = new Map<string, NonNullable<typeof allAudits>>()
      for (const audit of allAudits ?? []) {
        const cid = audit.closer_id as string
        if (!auditsByCloser.has(cid)) auditsByCloser.set(cid, [])
        auditsByCloser.get(cid)!.push(audit)
      }

      for (const closer of closers) {
        const audits = auditsByCloser.get(closer.id)
        if (!audits || audits.length === 0) continue

        let value = 0
        if (comp.metric === "score_avg") {
          const scores = audits
            .map((a) => a.score_final)
            .filter((s): s is number => s !== null)
          value = scores.length > 0
            ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
            : 0
        } else if (comp.metric === "volume") {
          value = audits.length
        } else if (comp.metric === "taxa_fechamento") {
          const fechamentos = audits.filter((a) => a.resultado === "fechamento").length
          value = Math.round((fechamentos / audits.length) * 100)
        }

        standings.push({
          closer_id: closer.id,
          closer_name: closer.name,
          rank: 0,
          value,
        })
      }

      standings.sort((a, b) => b.value - a.value)
      standings.forEach((s, idx) => {
        s.rank = idx + 1
      })
    }

    result.push({ ...comp, standings })
  }

  return result
}

export async function createCompetition(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const { organizationId } = await requireRole(["admin", "supervisor"])

  const { rateLimit: rl } = await import("@/lib/security/rate-limit")
  const check = rl(`competition:${(await requireAuth()).userId}`, { interval: 3600000, maxRequests: 5 })
  if (!check.success) return { error: "Rate limited" }

  const supabase = await createClient()

  const title = formData.get("title") as string
  const description = formData.get("description") as string | null
  const metric = formData.get("metric") as string
  const startDate = formData.get("start_date") as string
  const endDate = formData.get("end_date") as string

  const parsed = createCompetitionSchema.safeParse({
    title,
    description: description || null,
    metric,
    start_date: startDate,
    end_date: endDate,
  })
  if (!parsed.success) {
    return { error: parsed.error.issues[0]?.message ?? "Dados inválidos." }
  }

  const now = new Date().toISOString().split("T")[0]
  const status = parsed.data.start_date <= now ? "active" : "upcoming"

  const { error } = await db(supabase).from("competitions").insert({
    title: parsed.data.title,
    description: parsed.data.description || null,
    metric: parsed.data.metric,
    metric_params: {},
    start_date: parsed.data.start_date,
    end_date: parsed.data.end_date,
    status,
    organization_id: organizationId,
  })

  if (error) {
    return { error: "Erro ao criar competição." }
  }

  return { success: true }
}
