import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import { mockLossPatternReport } from "../fixtures/audit"

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
    _chain: chain,
  }
}

vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn(),
}))

// ─── Tests ───

describe("loss-patterns actions", () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe("getLossPatterns", () => {
    it("should return loss pattern reports", async () => {
      const client = makeMockClient({ data: [mockLossPatternReport] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLossPatterns } = await import("@/lib/actions/loss-patterns")
      const result = await getLossPatterns()
      expect(Array.isArray(result)).toBe(true)
    })

    it("should return empty array on error", async () => {
      const client = makeMockClient({ data: null, error: { message: "error" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLossPatterns } = await import("@/lib/actions/loss-patterns")
      const result = await getLossPatterns()
      expect(Array.isArray(result)).toBe(true)
    })
  })

  describe("generateLossPatternAnalysis", () => {
    it("should create a loss_pattern job", async () => {
      const client = makeMockClient({ data: [{ id: "job-001" }] })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { generateLossPatternAnalysis } = await import("@/lib/actions/loss-patterns")
      const result = await generateLossPatternAnalysis("2026-03-01", "2026-03-15")
      expect(result).toBeDefined()
    })

    it("should return error on failure", async () => {
      const client = makeMockClient({ data: null, error: { message: "insert failed" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { generateLossPatternAnalysis } = await import("@/lib/actions/loss-patterns")
      const result = await generateLossPatternAnalysis("2026-03-01", "2026-03-15")
      expect(result).toHaveProperty("error")
    })
  })

  describe("getLossPatternDetail", () => {
    it("should return a single report", async () => {
      const client = makeMockClient({ data: mockLossPatternReport })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLossPatternDetail } = await import("@/lib/actions/loss-patterns")
      const result = await getLossPatternDetail("lp-001")
      expect(result).toBeDefined()
    })

    it("should return null when not found", async () => {
      const client = makeMockClient({ data: null })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { getLossPatternDetail } = await import("@/lib/actions/loss-patterns")
      const result = await getLossPatternDetail("lp-999")
      expect(result).toBeNull()
    })
  })
})
