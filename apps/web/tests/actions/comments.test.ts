import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import {
  createComment,
  resolveComment,
  unresolveComment,
  deleteComment,
  getComments,
} from "@/lib/actions/comments"
import { mockComment } from "../fixtures/audit"

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

describe("createComment", () => {
  it("creates comment with timestamp", async () => {
    const client = makeMockClient({ data: { id: "comment-new" } })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await createComment({
      auditId: "audit-001",
      timestampSec: 120,
      content: "Boa ancoragem neste ponto",
    })

    expect(result).toEqual({ id: "comment-new" })
    expect(client.from).toHaveBeenCalledWith("call_comments")
    expect(client._chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        audit_id: "audit-001",
        author_id: "user-001",
        timestamp_sec: 120,
        content: "Boa ancoragem neste ponto",
        parent_id: null,
      })
    )
    expect(client._chain.select).toHaveBeenCalledWith("id")
    expect(client._chain.single).toHaveBeenCalled()
  })

  it("creates reply with parentId", async () => {
    const client = makeMockClient({ data: { id: "comment-reply" } })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await createComment({
      auditId: "audit-001",
      content: "Concordo com o comentário",
      parentId: "comment-001",
    })

    expect(result).toEqual({ id: "comment-reply" })
    expect(client._chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        audit_id: "audit-001",
        parent_id: "comment-001",
        timestamp_sec: null,
      })
    )
  })

  it("throws when not authenticated", async () => {
    const client = makeMockClient({ data: null, error: null })
    client.auth.getUser = vi.fn().mockResolvedValue({
      data: { user: null },
      error: null,
    })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(
      createComment({ auditId: "audit-001", content: "test" })
    ).rejects.toThrow("Not authenticated")
  })
})

describe("resolveComment", () => {
  it("sets resolved to true", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await resolveComment("comment-001")

    expect(client.from).toHaveBeenCalledWith("call_comments")
    expect(client._chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        resolved: true,
        resolved_by: "user-001",
      })
    )
    expect(client._chain.eq).toHaveBeenCalledWith("id", "comment-001")
  })
})

describe("unresolveComment", () => {
  it("sets resolved to false", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await unresolveComment("comment-001")

    expect(client.from).toHaveBeenCalledWith("call_comments")
    expect(client._chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        resolved: false,
        resolved_by: null,
        resolved_at: null,
      })
    )
    expect(client._chain.eq).toHaveBeenCalledWith("id", "comment-001")
  })
})

describe("deleteComment", () => {
  it("deletes comment by id", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    await deleteComment("comment-001")

    expect(client.from).toHaveBeenCalledWith("call_comments")
    expect(client._chain.delete).toHaveBeenCalled()
    expect(client._chain.eq).toHaveBeenCalledWith("id", "comment-001")
  })
})

describe("getComments", () => {
  it("returns thread structure with replies", async () => {
    const commentRows = [
      {
        id: "comment-001",
        audit_id: "audit-001",
        author_id: "user-001",
        parent_id: null,
        content: "Ótima ancoragem",
        timestamp_sec: 120,
        resolved: false,
        resolved_by: null,
        resolved_at: null,
        created_at: "2026-03-15T12:00:00Z",
        author: { full_name: "Carlos", avatar_url: null, role: "supervisor" },
      },
      {
        id: "comment-002",
        audit_id: "audit-001",
        author_id: "user-002",
        parent_id: "comment-001",
        content: "Concordo",
        timestamp_sec: null,
        resolved: false,
        resolved_by: null,
        resolved_at: null,
        created_at: "2026-03-15T12:05:00Z",
        author: { full_name: "Ana", avatar_url: null, role: "manager" },
      },
    ]
    const client = makeMockClient({ data: commentRows })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getComments("audit-001")

    expect(Array.isArray(result)).toBe(true)
    // Only top-level comments at root
    expect(result).toHaveLength(1)
    expect(result[0].id).toBe("comment-001")
    // Reply should be nested
    expect(result[0].replies).toHaveLength(1)
    expect(result[0].replies![0].id).toBe("comment-002")
    expect(client.from).toHaveBeenCalledWith("call_comments")
    expect(client._chain.eq).toHaveBeenCalledWith("audit_id", "audit-001")
    expect(client._chain.order).toHaveBeenCalledWith("created_at", { ascending: true })
  })

  it("returns empty array for no comments", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await getComments("audit-001")

    expect(result).toEqual([])
  })
})
