import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  getDashboardStats,
  getRecentCalls,
  getAudits,
  getAuditDetail,
  resendNotification,
} from "@/lib/actions/calls"
import { mockAudit } from "../fixtures/audit"

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

describe("getDashboardStats", () => {
  it("returns correct shape with all fields", async () => {
    const viewChain = mockChain({
      data: {
        total_calls: 42,
        media_score: 7.5,
        taxa_fechamento_pct: 35,
        calls_elite: 5,
        calls_forte: 15,
        calls_mediana: 12,
        calls_fraca: 10,
      },
    })
    const auditsChain = mockChain({
      data: [{ call_date: "2026-03-10", score_final: 8.0 }],
      count: 8,
    })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "v_dashboard_stats") return viewChain
        return auditsChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const stats = await getDashboardStats()

    expect(stats).toHaveProperty("totalCalls", 42)
    expect(stats).toHaveProperty("mediaScore", 7.5)
    expect(stats).toHaveProperty("taxaFechamento", 35)
    expect(stats).toHaveProperty("callsEstaSemana")
    expect(stats.porClassificacao).toEqual({
      elite: 5,
      forte: 15,
      mediana: 12,
      fraca: 10,
    })
    expect(stats).toHaveProperty("evolucaoScore")
    expect(Array.isArray(stats.evolucaoScore)).toBe(true)
  })

  it("returns zeroed stats when no data", async () => {
    const client = makeMockClient({ data: null, count: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const stats = await getDashboardStats()

    expect(stats.totalCalls).toBe(0)
    expect(stats.mediaScore).toBeNull()
    expect(stats.taxaFechamento).toBeNull()
    expect(stats.callsEstaSemana).toBe(0)
    expect(stats.porClassificacao).toEqual({
      elite: 0,
      forte: 0,
      mediana: 0,
      fraca: 0,
    })
    expect(stats.evolucaoScore).toEqual([])
  })
})

describe("getRecentCalls", () => {
  it("returns array and applies limit(10)", async () => {
    const client = makeMockClient({ data: [mockAudit] })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getRecentCalls()

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(1)
    expect(client._chain.limit).toHaveBeenCalledWith(10)
    expect(client._chain.order).toHaveBeenCalledWith("call_date", {
      ascending: false,
    })
  })
})

describe("getAudits", () => {
  it("uses default pagination (page 1, pageSize 20)", async () => {
    const client = makeMockClient({ data: [mockAudit], count: 1 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getAudits()

    expect(result.page).toBe(1)
    expect(result.pageSize).toBe(20)
    expect(client._chain.range).toHaveBeenCalledWith(0, 19)
  })

  it("applies closerId filter via eq", async () => {
    const client = makeMockClient({ data: [], count: 0 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getAudits({ closerId: "closer-001" })

    expect(client._chain.eq).toHaveBeenCalledWith("closer_id", "closer-001")
  })

  it("applies dateFrom/dateTo via gte/lte", async () => {
    const client = makeMockClient({ data: [], count: 0 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getAudits({ dateFrom: "2026-01-01", dateTo: "2026-03-31" })

    expect(client._chain.gte).toHaveBeenCalledWith("call_date", "2026-01-01")
    expect(client._chain.lte).toHaveBeenCalledWith("call_date", "2026-03-31")
  })

  it("applies classificacao filter", async () => {
    const client = makeMockClient({ data: [], count: 0 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getAudits({ classificacao: "ELITE" })

    expect(client._chain.eq).toHaveBeenCalledWith("classificacao", "ELITE")
  })

  it("rejects unknown sort column and falls back to call_date", async () => {
    const client = makeMockClient({ data: [], count: 0 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getAudits({ sortBy: "DROP TABLE" as any })

    expect(client._chain.order).toHaveBeenCalledWith("call_date", {
      ascending: false,
    })
  })

  it("returns correct pagination metadata", async () => {
    const client = makeMockClient({ data: [mockAudit], count: 55 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getAudits({ page: 2, pageSize: 10 })

    expect(result.page).toBe(2)
    expect(result.pageSize).toBe(10)
    expect(result.total).toBe(55)
    expect(result.totalPages).toBe(6)
    expect(client._chain.range).toHaveBeenCalledWith(10, 19)
  })

  it("applies resultado filter via eq", async () => {
    const client = makeMockClient({ data: [], count: 0 })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getAudits({ resultado: "fechamento" })

    expect(client._chain.eq).toHaveBeenCalledWith("resultado", "fechamento")
  })
})

describe("getAuditDetail", () => {
  it("returns audit for valid ID", async () => {
    const client = makeMockClient({ data: mockAudit })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getAuditDetail("audit-001")

    expect(result).toBeTruthy()
    expect(result?.id).toBe("audit-001")
    expect(client._chain.eq).toHaveBeenCalledWith("id", "audit-001")
    expect(client._chain.single).toHaveBeenCalled()
  })

  it("returns null when data is null", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getAuditDetail("nonexistent")

    expect(result).toBeNull()
  })
})

describe("resendNotification", () => {
  it("creates notify job for completed audit", async () => {
    const chain = mockChain({ data: { id: "audit-001", status: "completed" } })
    const insertChain = mockChain({ data: null, error: null })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "job_queue") return insertChain
        return chain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await resendNotification("audit-001")

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("job_queue")
    expect(insertChain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        audit_id: "audit-001",
        job_type: "notify",
        status: "pending",
      })
    )
  })

  it("creates notify job for analyzed audit", async () => {
    const chain = mockChain({ data: { id: "audit-002", status: "analyzed" } })
    const insertChain = mockChain({ data: null, error: null })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "job_queue") return insertChain
        return chain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await resendNotification("audit-002")

    expect(result).toEqual({ success: true })
  })

  it("rejects audit with wrong status", async () => {
    const client = makeMockClient({
      data: { id: "audit-001", status: "uploaded" },
    })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await resendNotification("audit-001")

    expect(result.error).toBeDefined()
    expect(result.error).toContain("completa")
  })

  it("returns error when audit not found", async () => {
    const client = makeMockClient({ data: null, error: { message: "not found" } })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await resendNotification("nonexistent")

    expect(result.error).toBeDefined()
    expect(result.error).toContain("encontrada")
  })
})
