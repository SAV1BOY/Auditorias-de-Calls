"use server"

import { createClient } from "@/lib/supabase/server"
import type {
  BadgeRow,
  CloserBadgeWithInfo,
  CloserStreakRow,
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
  const supabase = await createClient()

  // Fetch closers
  const { data: closers } = await supabase
    .from("closers")
    .select("id, name, avatar_url")

  if (!closers || closers.length === 0) return []

  const dateFilter = getDateFilter(period)
  const prevDates = getPreviousPeriodDates(period)

  const entries: LeaderboardEntry[] = []

  for (const closer of closers) {
    // Current period audits
    let query = supabase
      .from("call_audits")
      .select("score_final, resultado")
      .eq("closer_id", closer.id)
      .eq("status", "completed")

    if (dateFilter) {
      query = query.gte("call_date", dateFilter)
    }

    const { data: audits } = await query

    if (!audits || audits.length === 0) continue

    // Calculate current metric value
    let value = 0
    if (metric === "score_avg") {
      const scores = audits
        .map((a) => a.score_final)
        .filter((s): s is number => s !== null)
      value = scores.length > 0
        ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
        : 0
    } else if (metric === "volume") {
      value = audits.length
    } else if (metric === "taxa_fechamento") {
      const fechamentos = audits.filter((a) => a.resultado === "fechamento").length
      value = Math.round((fechamentos / audits.length) * 100)
    }

    // Calculate previous period value for trend
    let prevValue = 0
    let hasPrev = false
    if (prevDates) {
      const { data: prevAudits } = await supabase
        .from("call_audits")
        .select("score_final, resultado")
        .eq("closer_id", closer.id)
        .eq("status", "completed")
        .gte("call_date", prevDates.from)
        .lt("call_date", prevDates.to)

      if (prevAudits && prevAudits.length > 0) {
        hasPrev = true
        if (metric === "score_avg") {
          const scores = prevAudits
            .map((a) => a.score_final)
            .filter((s): s is number => s !== null)
          prevValue = scores.length > 0
            ? scores.reduce((a, b) => a + b, 0) / scores.length
            : 0
        } else if (metric === "volume") {
          prevValue = prevAudits.length
        } else if (metric === "taxa_fechamento") {
          const fechamentos = prevAudits.filter(
            (a) => a.resultado === "fechamento"
          ).length
          prevValue = Math.round((fechamentos / prevAudits.length) * 100)
        }
      }
    }

    // Badges count
    const { count: badgesCount } = await db(supabase)
      .from("closer_badges")
      .select("id", { count: "exact", head: true })
      .eq("closer_id", closer.id)

    let trend: "up" | "down" | "stable" = "stable"
    if (hasPrev) {
      if (value > prevValue) trend = "up"
      else if (value < prevValue) trend = "down"
    }

    entries.push({
      rank: 0,
      closer_id: closer.id,
      closer_name: closer.name,
      avatar_url: closer.avatar_url ?? null,
      value,
      badges_count: badgesCount ?? 0,
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

export async function getCloserBadges(
  closerId: string
): Promise<CloserBadgeWithInfo[]> {
  const supabase = await createClient()

  const { data } = await db(supabase)
    .from("closer_badges")
    .select("id, closer_id, audit_id, earned_at, badges(id, slug, name, description, icon, category, criteria)")
    .eq("closer_id", closerId)
    .order("earned_at", { ascending: false })

  if (!data) return []

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return data.map((row: any) => ({
    id: row.id,
    closer_id: row.closer_id,
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    badge: row.badges as any as BadgeRow,
    audit_id: row.audit_id,
    earned_at: row.earned_at,
  }))
}

export async function getAllBadges(): Promise<BadgeRow[]> {
  const supabase = await createClient()

  const { data } = await db(supabase)
    .from("badges")
    .select("*")
    .order("category")

  return (data as BadgeRow[]) ?? []
}

export async function getAllEarnedBadgeIds(): Promise<string[]> {
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

export async function getCloserStreaks(
  closerId: string
): Promise<CloserStreakRow[]> {
  const supabase = await createClient()

  const { data } = await db(supabase)
    .from("closer_streaks")
    .select("*")
    .eq("closer_id", closerId)

  return (data as CloserStreakRow[]) ?? []
}

export async function getCompetitions(): Promise<CompetitionWithStandings[]> {
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
    const standings = await getCompetitionStandings(comp.id)
    result.push({ ...comp, standings })
  }

  return result
}

export async function createCompetition(
  formData: FormData
): Promise<{ success?: boolean; error?: string }> {
  const supabase = await createClient()

  const title = formData.get("title") as string
  const description = formData.get("description") as string | null
  const metric = formData.get("metric") as string
  const startDate = formData.get("start_date") as string
  const endDate = formData.get("end_date") as string

  if (!title || !metric || !startDate || !endDate) {
    return { error: "Preencha todos os campos obrigatórios." }
  }

  const now = new Date().toISOString().split("T")[0]
  const status = startDate <= now ? "active" : "upcoming"

  const { error } = await db(supabase).from("competitions").insert({
    title,
    description: description || null,
    metric,
    metric_params: {},
    start_date: startDate,
    end_date: endDate,
    status,
  })

  if (error) {
    return { error: "Erro ao criar competição." }
  }

  return { success: true }
}

export async function getCompetitionStandings(
  competitionId: string
): Promise<CompetitionStanding[]> {
  const supabase = await createClient()

  // Fetch competition details
  const { data: comp } = await db(supabase)
    .from("competitions")
    .select("*")
    .eq("id", competitionId)
    .single()

  if (!comp) return []

  const competition = comp as CompetitionRow

  // Fetch closers
  const { data: closers } = await supabase
    .from("closers")
    .select("id, name")

  if (!closers || closers.length === 0) return []

  const standings: CompetitionStanding[] = []

  for (const closer of closers) {
    const { data: audits } = await supabase
      .from("call_audits")
      .select("score_final, resultado")
      .eq("closer_id", closer.id)
      .eq("status", "completed")
      .gte("call_date", competition.start_date)
      .lte("call_date", competition.end_date)

    if (!audits || audits.length === 0) continue

    let value = 0
    if (competition.metric === "score_avg") {
      const scores = audits
        .map((a) => a.score_final)
        .filter((s): s is number => s !== null)
      value = scores.length > 0
        ? Math.round((scores.reduce((a, b) => a + b, 0) / scores.length) * 10) / 10
        : 0
    } else if (competition.metric === "volume") {
      value = audits.length
    } else if (competition.metric === "taxa_fechamento") {
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

  return standings
}
