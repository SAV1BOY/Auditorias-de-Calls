import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  getWeeklyReports,
  getWeeklyReport,
} from "@/lib/actions/reports"
import { mockWeeklyReport } from "../fixtures/audit"

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

describe("getWeeklyReports", () => {
  it("returns list ordered by week_start desc", async () => {
    const reportsData = [
      {
        id: "report-001",
        organization_id: null,
        week_start: "2026-03-09",
        week_end: "2026-03-15",
        report_markdown: "# Resumo Semanal",
        stats: { total_calls: 10, score_avg: 7.8 },
        generated_at: "2026-03-16T08:00:00Z",
        sent_whatsapp: true,
        sent_email: true,
        created_at: "2026-03-16T08:00:00Z",
      },
      {
        id: "report-002",
        organization_id: null,
        week_start: "2026-03-02",
        week_end: "2026-03-08",
        report_markdown: "# Resumo Semanal 2",
        stats: { total_calls: 8, score_avg: 7.2 },
        generated_at: "2026-03-09T08:00:00Z",
        sent_whatsapp: true,
        sent_email: false,
        created_at: "2026-03-09T08:00:00Z",
      },
    ]
    const client = makeMockClient({ data: reportsData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getWeeklyReports()

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(2)
    expect(result[0].id).toBe("report-001")
    expect(result[0]).toHaveProperty("stats")
    expect(client.from).toHaveBeenCalledWith("weekly_reports")
    expect(client._chain.order).toHaveBeenCalledWith("week_start", { ascending: false })
  })

  it("returns empty array when no reports", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getWeeklyReports()

    expect(result).toEqual([])
  })
})

describe("getWeeklyReport", () => {
  it("returns report with stats for valid id", async () => {
    const reportData = {
      id: "report-001",
      organization_id: null,
      week_start: "2026-03-09",
      week_end: "2026-03-15",
      report_markdown: "# Resumo Semanal\n\n10 calls auditadas...",
      stats: {
        total_calls: 10,
        score_avg: 7.8,
        score_avg_prev: 7.2,
        top_closers: [{ id: "closer-001", name: "Evelyn", score: 8.5 }],
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
    const client = makeMockClient({ data: reportData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getWeeklyReport("report-001")

    expect(result).toBeTruthy()
    expect(result?.id).toBe("report-001")
    expect(result?.stats).toHaveProperty("total_calls", 10)
    expect(result?.stats).toHaveProperty("score_avg", 7.8)
    expect(result?.week_start).toBe("2026-03-09")
    expect(client.from).toHaveBeenCalledWith("weekly_reports")
    expect(client._chain.eq).toHaveBeenCalledWith("id", "report-001")
    expect(client._chain.single).toHaveBeenCalled()
  })

  it("returns null for unknown id", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getWeeklyReport("nonexistent")

    expect(result).toBeNull()
  })
})
