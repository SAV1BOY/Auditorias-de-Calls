import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  getClosersComparison,
  getDimensionTrends,
  getGoals,
  createGoal,
  updateGoalStatus,
  deleteGoal,
} from "@/lib/actions/analytics"
import { mockGoal } from "../fixtures/audit"

// ─── Helpers ───

function mockChain(result: { data?: any; count?: number | null; error?: any }) {
  const chain: any = {}
  const methods = [
    "select", "insert", "update", "delete", "eq", "neq", "gte", "lte",
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
    storage: {
      from: vi.fn().mockReturnValue({
        upload: vi.fn().mockResolvedValue({ error: null }),
        createSignedUrl: vi.fn().mockResolvedValue({
          data: { signedUrl: "https://signed" },
          error: null,
        }),
      }),
    },
    _chain: chain,
  }
}

// ─── Tests ───

describe("getClosersComparison", () => {
  it("returns empty array for empty closerIds", async () => {
    const result = await getClosersComparison([])

    expect(result).toEqual([])
  })

  it("returns comparison data from view", async () => {
    const viewData = [
      {
        closer_id: "closer-001",
        closer_name: "Evelyn",
        media_score: 8.1,
        total_calls: 20,
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
      },
    ]
    const client = makeMockClient({ data: viewData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getClosersComparison(["closer-001"])

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(1)
    expect(result[0].closer_id).toBe("closer-001")
    expect(result[0].closer_name).toBe("Evelyn")
    expect(result[0]).toHaveProperty("media_score")
    expect(result[0]).toHaveProperty("total_calls")
    expect(result[0]).toHaveProperty("dimensions")
    expect(Array.isArray(result[0].dimensions)).toBe(true)
    expect(client.from).toHaveBeenCalledWith("v_closer_performance")
    expect(client._chain.in).toHaveBeenCalledWith("closer_id", ["closer-001"])
  })
})

describe("getDimensionTrends", () => {
  it("returns trend points", async () => {
    const callData = [
      { call_date: "2026-03-10", score_final: 7.5, d01_frame: 8.0 },
      { call_date: "2026-03-11", score_final: 8.0, d01_frame: 8.5 },
      { call_date: "2026-03-12", score_final: 9.0, d01_frame: 9.0 },
    ]
    const client = makeMockClient({ data: callData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getDimensionTrends("d01_frame")

    expect(Array.isArray(result)).toBe(true)
    // Each point should have date, score, and optionally teamAvg
    for (const point of result) {
      expect(point).toHaveProperty("date")
      expect(point).toHaveProperty("score")
    }
  })

  it("returns empty array when no data", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getDimensionTrends("d01_frame")

    expect(result).toEqual([])
  })
})

describe("getGoals", () => {
  it("returns goals with progress", async () => {
    const goalData = [
      {
        id: "a0000000-0000-4000-8000-000000000010",
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
      },
    ]
    // The chain returns goals first, then call_audits for calculateCurrentValue
    const client = makeMockClient({ data: goalData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getGoals()

    expect(Array.isArray(result)).toBe(true)
    expect(client.from).toHaveBeenCalledWith("goals")
  })
})

describe("createGoal", () => {
  it("creates goal with valid data", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const fd = new FormData()
    fd.append("title", "Meta de Score")
    fd.append("type", "team")
    fd.append("metric", "score_avg")
    fd.append("target_value", "8.0")
    fd.append("start_date", "2026-03-01")
    fd.append("end_date", "2026-03-31")

    const result = await createGoal(fd)

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("goals")
    expect(client._chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        title: "Meta de Score",
        type: "team",
        metric: "score_avg",
        target_value: 8.0,
      })
    )
  })

  it("rejects empty title", async () => {
    const fd = new FormData()
    fd.append("title", "  ")
    fd.append("type", "team")
    fd.append("metric", "score_avg")
    fd.append("target_value", "8.0")
    fd.append("start_date", "2026-03-01")
    fd.append("end_date", "2026-03-31")

    const result = await createGoal(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("obrigat")
  })

  it("rejects missing required fields", async () => {
    const fd = new FormData()
    fd.append("title", "Meta")

    const result = await createGoal(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toBeTruthy()
  })
})

describe("updateGoalStatus", () => {
  it("updates status successfully", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await updateGoalStatus("a0000000-0000-4000-8000-000000000010", "completed")

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("goals")
    expect(client._chain.update).toHaveBeenCalledWith({ status: "completed" })
    expect(client._chain.eq).toHaveBeenCalledWith("id", "a0000000-0000-4000-8000-000000000010")
  })

  it("returns error on failure", async () => {
    const client = makeMockClient({ data: null, error: { message: "db error" } })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await updateGoalStatus("a0000000-0000-4000-8000-000000000010", "failed")

    expect(result.error).toBeDefined()
    expect(result.error).toContain("meta")
  })
})

describe("deleteGoal", () => {
  it("deletes goal successfully", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await deleteGoal("a0000000-0000-4000-8000-000000000010")

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("goals")
    expect(client._chain.delete).toHaveBeenCalled()
    expect(client._chain.eq).toHaveBeenCalledWith("id", "a0000000-0000-4000-8000-000000000010")
  })

  it("returns error on failure", async () => {
    const client = makeMockClient({ data: null, error: { message: "db error" } })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await deleteGoal("a0000000-0000-4000-8000-000000000010")

    expect(result.error).toBeDefined()
    expect(result.error).toContain("excluir")
  })
})
