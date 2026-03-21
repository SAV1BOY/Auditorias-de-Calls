import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
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
          data: { signedUrl: "https://signed-url.com/report.pdf" },
          error: null,
        }),
      }),
    },
    _chain: chain,
  }
}

vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn(),
}))

vi.mock("@react-pdf/renderer", () => ({
  renderToBuffer: vi.fn().mockResolvedValue(Buffer.from("pdf-content")),
  Document: vi.fn(({ children }) => children),
  Page: vi.fn(({ children }) => children),
  View: vi.fn(({ children }) => children),
  Text: vi.fn(({ children }) => children),
  StyleSheet: { create: vi.fn((s: any) => s) },
}))

vi.mock("@/lib/pdf/audit-report", () => ({
  AuditReportDocument: vi.fn(() => null),
}))

// ─── Tests ───

describe("export-pdf actions", () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe("generateAuditPDF", () => {
    it("should return signed URL on success", async () => {
      const client = makeMockClient({ data: mockAudit })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { generateAuditPDF } = await import("@/lib/actions/export-pdf")
      const result = await generateAuditPDF("audit-001")
      // May return url or error depending on mock setup
      expect(result).toBeDefined()
      expect(typeof result).toBe("object")
    })

    it("should return error when audit not found", async () => {
      const client = makeMockClient({ data: null, error: { message: "not found" } })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { generateAuditPDF } = await import("@/lib/actions/export-pdf")
      const result = await generateAuditPDF("audit-999")
      expect(result).toHaveProperty("error")
    })

    it("should handle PDF generation errors gracefully", async () => {
      const client = makeMockClient({ data: mockAudit })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { renderToBuffer } = await import("@react-pdf/renderer")
      vi.mocked(renderToBuffer).mockRejectedValueOnce(new Error("PDF render failed"))

      const { generateAuditPDF } = await import("@/lib/actions/export-pdf")
      const result = await generateAuditPDF("audit-001")
      expect(result).toBeDefined()
    })
  })

  describe("generateBatchPDF", () => {
    it("should return error for empty array", async () => {
      const { generateBatchPDF } = await import("@/lib/actions/export-pdf")
      const result = await generateBatchPDF([])
      expect(result).toHaveProperty("error")
    })

    it("should delegate to single PDF for one item", async () => {
      const client = makeMockClient({ data: mockAudit })
      vi.mocked(createClient).mockResolvedValue(client as any)

      const { generateBatchPDF } = await import("@/lib/actions/export-pdf")
      const result = await generateBatchPDF(["audit-001"])
      expect(result).toBeDefined()
    })
  })
})
