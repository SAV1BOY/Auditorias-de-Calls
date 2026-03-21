import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  getClosersList,
  getCloserById,
  getCloserPerformance,
  getCloserScoreEvolution,
  createCloser,
  updateCloser,
  toggleCloserActive,
} from "@/lib/actions/closers"
import { mockCloser } from "../fixtures/audit"

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

describe("getClosersList", () => {
  it("returns list of closers", async () => {
    const client = makeMockClient({ data: [mockCloser] })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getClosersList()

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(1)
    expect(result[0].name).toBe("Evelyn")
    expect(client.from).toHaveBeenCalledWith("closers")
    expect(client._chain.order).toHaveBeenCalledWith("name")
  })
})

describe("getCloserById", () => {
  it("returns closer for valid id", async () => {
    const client = makeMockClient({ data: mockCloser })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getCloserById("closer-001")

    expect(result).toBeTruthy()
    expect(result?.id).toBe("closer-001")
    expect(client._chain.eq).toHaveBeenCalledWith("id", "closer-001")
    expect(client._chain.maybeSingle).toHaveBeenCalled()
  })

  it("returns null for unknown id", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getCloserById("nonexistent")

    expect(result).toBeNull()
  })
})

describe("getCloserPerformance", () => {
  it("returns performance data from view", async () => {
    const perfData = {
      closer_id: "closer-001",
      closer_name: "Evelyn",
      total_calls: 20,
      media_score: 8.1,
      pior_score: 5.5,
      melhor_score: 9.5,
      fechamentos: 8,
    }
    const client = makeMockClient({ data: perfData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getCloserPerformance("closer-001")

    expect(result).toBeTruthy()
    expect(result?.closer_id).toBe("closer-001")
    expect(result?.total_calls).toBe(20)
    expect(client.from).toHaveBeenCalledWith("v_closer_performance")
    expect(client._chain.eq).toHaveBeenCalledWith("closer_id", "closer-001")
  })
})

describe("getCloserScoreEvolution", () => {
  it("returns array of {date, score}", async () => {
    const client = makeMockClient({
      data: [
        { call_date: "2026-03-10", score_final: 7.5 },
        { call_date: "2026-03-10", score_final: 8.5 },
        { call_date: "2026-03-11", score_final: 9.0 },
      ],
    })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getCloserScoreEvolution("closer-001")

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(2)
    expect(result[0]).toHaveProperty("date")
    expect(result[0]).toHaveProperty("score")
    // First date should be averaged: (7.5+8.5)/2 = 8.0
    expect(result[0].date).toBe("2026-03-10")
    expect(result[0].score).toBe(8)
    expect(result[1].score).toBe(9)
  })
})

describe("createCloser", () => {
  it("creates closer with valid name", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const fd = new FormData()
    fd.append("name", "Nova Closer")
    fd.append("email", "nova@test.com")

    const result = await createCloser(fd)

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("closers")
    expect(client._chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({ name: "Nova Closer" })
    )
  })

  it("rejects empty name", async () => {
    const fd = new FormData()
    fd.append("name", "  ")

    const result = await createCloser(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("Nome")
  })
})

describe("updateCloser", () => {
  it("updates closer fields", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const fd = new FormData()
    fd.append("id", "closer-001")
    fd.append("name", "Updated Name")
    fd.append("email", "updated@test.com")

    const result = await updateCloser(fd)

    expect(result).toEqual({ success: true })
    expect(client._chain.update).toHaveBeenCalledWith(
      expect.objectContaining({ name: "Updated Name" })
    )
    expect(client._chain.eq).toHaveBeenCalledWith("id", "closer-001")
  })

  it("rejects missing id", async () => {
    const fd = new FormData()
    fd.append("name", "Some Name")

    const result = await updateCloser(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("ID")
  })
})

describe("toggleCloserActive", () => {
  it("toggles active flag", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await toggleCloserActive("closer-001", false)

    expect(result).toEqual({ success: true })
    expect(client._chain.update).toHaveBeenCalledWith({ active: false })
    expect(client._chain.eq).toHaveBeenCalledWith("id", "closer-001")
  })
})
