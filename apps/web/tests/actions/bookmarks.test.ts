import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  toggleBookmark,
  removeBookmark,
  getBookmark,
  getBookmarkedCalls,
} from "@/lib/actions/bookmarks"
import { mockBookmark } from "../fixtures/audit"

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

describe("toggleBookmark", () => {
  it("creates new bookmark when none exists", async () => {
    // maybeSingle returns null (no existing bookmark), then insert is called
    const selectChain = mockChain({ data: null })
    const insertChain = mockChain({ data: null, error: null })

    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        // First call: select existing, second call: insert new
        return selectChain
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

    const result = await toggleBookmark("audit-001", {
      tags: ["bom-fechamento"],
      highlightTimestamps: [{ start_sec: 60, end_sec: 120, label: "Boa ancoragem" }],
      notes: "Call excelente",
    })

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("call_bookmarks")
  })

  it("updates existing bookmark", async () => {
    // maybeSingle returns existing bookmark, so update is called
    const chain = mockChain({ data: { id: "bookmark-001" } })

    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await toggleBookmark("audit-001", {
      tags: ["atualizado"],
      highlightTimestamps: [],
    })

    expect(result).toEqual({ success: true })
    expect(chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        tags: ["atualizado"],
      })
    )
  })
})

describe("removeBookmark", () => {
  it("removes own bookmark", async () => {
    // Mock: first select returns bookmark owned by user, then delete
    const selectChain = mockChain({ data: { bookmarked_by: "user-001" } })
    const deleteChain = mockChain({ data: null, error: null })
    let callCount = 0
    const client = {
      from: vi.fn().mockImplementation(() => {
        callCount++
        return callCount <= 1 ? selectChain : deleteChain
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

    const result = await removeBookmark("audit-001")

    expect(result).toEqual({ success: true })
    expect(client.from).toHaveBeenCalledWith("call_bookmarks")
  })

  it("returns success when bookmark already removed", async () => {
    // maybeSingle returns null → already removed
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await removeBookmark("audit-001")

    expect(result).toEqual({ success: true })
  })

  it("rejects removal by non-owner non-admin", async () => {
    const selectChain = mockChain({ data: { bookmarked_by: "other-user" } })
    const profileChain = mockChain({ data: { role: "viewer" } })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "profiles") return profileChain
        return selectChain
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

    await expect(removeBookmark("audit-001")).rejects.toThrow("permissão")
  })
})

describe("getBookmark", () => {
  it("returns bookmark for existing audit", async () => {
    const bookmarkData = {
      id: "bookmark-001",
      audit_id: "audit-001",
      bookmarked_by: "user-001",
      tags: ["excelente"],
      highlight_timestamps: [{ start_sec: 60, end_sec: 120, label: "Boa ancoragem" }],
      notes: "Call modelo",
      created_at: "2026-03-15T12:00:00Z",
    }
    const client = makeMockClient({ data: bookmarkData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getBookmark("audit-001")

    expect(result).toBeTruthy()
    expect(result?.audit_id).toBe("audit-001")
    expect(result?.tags).toEqual(["excelente"])
    expect(client.from).toHaveBeenCalledWith("call_bookmarks")
    expect(client._chain.eq).toHaveBeenCalledWith("audit_id", "audit-001")
    expect(client._chain.maybeSingle).toHaveBeenCalled()
  })

  it("returns null when not found", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getBookmark("nonexistent")

    expect(result).toBeNull()
  })
})

describe("getBookmarkedCalls", () => {
  it("returns list of bookmarked calls", async () => {
    const bookmarksData = [
      {
        id: "bookmark-001",
        audit_id: "audit-001",
        bookmarked_by: "user-001",
        tags: ["excelente"],
        highlight_timestamps: [],
        notes: null,
        created_at: "2026-03-15T12:00:00Z",
        call_audits: {
          id: "audit-001",
          lead_name: "Elane Lima",
          call_date: "2026-03-15",
          score_final: 8.2,
          classificacao: "FORTE",
          closers: { name: "Evelyn" },
        },
      },
    ]
    const client = makeMockClient({ data: bookmarksData })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getBookmarkedCalls({})

    expect(Array.isArray(result)).toBe(true)
    expect(result).toHaveLength(1)
    expect(client.from).toHaveBeenCalledWith("call_bookmarks")
    expect(client._chain.order).toHaveBeenCalledWith("created_at", { ascending: false })
  })

  it("applies tag filter via overlaps", async () => {
    const client = makeMockClient({ data: [] })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getBookmarkedCalls({ tags: ["excelente", "fechamento"] })

    expect(client._chain.overlaps).toHaveBeenCalledWith("tags", ["excelente", "fechamento"])
  })

  it("applies closer filter via eq", async () => {
    const client = makeMockClient({ data: [] })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await getBookmarkedCalls({ closerId: "closer-001" })

    expect(client._chain.eq).toHaveBeenCalledWith("call_audits.closer_id", "closer-001")
  })
})
