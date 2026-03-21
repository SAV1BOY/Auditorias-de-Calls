import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  mockLeaderboard,
  mockBadges,
  mockCloserBadge,
  mockStreak,
  mockCompetition,
} from "../fixtures/audit"

// ─── Helpers ───

function mockChain(result: { data?: any; count?: number | null; error?: any }) {
  const chain: any = {}
  const methods = [
    "select", "insert", "update", "delete", "eq", "neq", "gt", "gte", "lt", "lte",
    "in", "not", "overlaps", "order", "limit", "range", "single", "maybeSingle",
  ]
  for (const m of methods) {
    chain[m] = vi.fn().mockReturnValue(chain)
  }
  chain.single.mockReturnValue(result)
  chain.maybeSingle.mockReturnValue(result)
  chain.data = result.data ?? null
  chain.count = result.count ?? null
  chain.error = result.error ?? null
  chain.then = undefined
  return chain
}

function makeMockClient(chainResult: Parameters<typeof mockChain>[0]) {
  const chain = mockChain(chainResult)
  return {
    from: vi.fn().mockReturnValue(chain),
    auth: {
      getUser: vi.fn().mockResolvedValue({
        data: { user: { id: "user-001" } },
        error: null,
      }),
    },
    rpc: vi.fn().mockResolvedValue({ data: [], error: null }),
    _chain: chain,
  }
}

vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn(),
}))

// ─── Tests ───

describe("gamification actions", () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe("getLeaderboard", () => {
    it("should return leaderboard entries for week period", async () => {
      const client = makeMockClient({ data: [] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLeaderboard } = await import("@/lib/actions/gamification")
      const result = await getLeaderboard("week", "score_avg")
      expect(Array.isArray(result)).toBe(true)
    })

    it("should return leaderboard entries for month period", async () => {
      const client = makeMockClient({ data: [] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLeaderboard } = await import("@/lib/actions/gamification")
      const result = await getLeaderboard("month", "score_avg")
      expect(Array.isArray(result)).toBe(true)
    })

    it("should return empty array on error", async () => {
      const client = makeMockClient({ data: null, error: { message: "DB error" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLeaderboard } = await import("@/lib/actions/gamification")
      const result = await getLeaderboard("all", "volume")
      expect(Array.isArray(result)).toBe(true)
    })
  })

  describe("getCloserBadges", () => {
    it("should return badges for a closer", async () => {
      const client = makeMockClient({ data: [mockCloserBadge] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getCloserBadges } = await import("@/lib/actions/gamification")
      const result = await getCloserBadges("closer-001")
      expect(Array.isArray(result)).toBe(true)
    })

    it("should return empty array when closer has no badges", async () => {
      const client = makeMockClient({ data: [] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getCloserBadges } = await import("@/lib/actions/gamification")
      const result = await getCloserBadges("closer-999")
      expect(result).toEqual([])
    })
  })

  describe("getCompetitions", () => {
    it("should return active competitions", async () => {
      const client = makeMockClient({ data: [] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getCompetitions } = await import("@/lib/actions/gamification")
      const result = await getCompetitions()
      expect(Array.isArray(result)).toBe(true)
    })

    it("should return empty array when no competitions", async () => {
      const client = makeMockClient({ data: [] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getCompetitions } = await import("@/lib/actions/gamification")
      const result = await getCompetitions()
      expect(result).toEqual([])
    })
  })

  describe("createCompetition", () => {
    it("should create a competition successfully", async () => {
      const client = makeMockClient({ data: [{ id: "comp-new" }] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { createCompetition } = await import("@/lib/actions/gamification")
      const formData = new FormData()
      formData.append("title", "Desafio Abril")
      formData.append("metric", "score_avg")
      formData.append("start_date", "2026-04-01")
      formData.append("end_date", "2026-04-30")

      const result = await createCompetition(formData)
      expect(result).toHaveProperty("success")
    })

    it("should return error for missing fields", async () => {
      const client = makeMockClient({ data: null, error: { message: "Missing fields" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { createCompetition } = await import("@/lib/actions/gamification")
      const formData = new FormData()
      formData.append("title", "")
      const result = await createCompetition(formData)
      expect(result).toHaveProperty("error")
    })

    it("should return error on database failure", async () => {
      const client = makeMockClient({ data: null, error: { message: "Insert failed" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { createCompetition } = await import("@/lib/actions/gamification")
      const formData = new FormData()
      formData.append("title", "Test")
      formData.append("metric", "volume")
      formData.append("start_date", "2026-04-01")
      formData.append("end_date", "2026-04-30")

      const result = await createCompetition(formData)
      expect(result).toHaveProperty("error")
    })
  })
})
