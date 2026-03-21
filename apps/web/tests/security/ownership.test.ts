/**
 * Ownership tests — verify that delete/modify operations
 * enforce ownership or elevated role requirements.
 */
import { vi, describe, it, expect, beforeEach } from "vitest"
import { createClient } from "@/lib/supabase/server"
import { deleteComment } from "@/lib/actions/comments"
import { removeBookmark } from "@/lib/actions/bookmarks"

function mockChain(result: { data?: any; error?: any }) {
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
  chain.error = result.error ?? null
  chain.then = undefined
  return chain
}

describe("deleteComment ownership", () => {
  beforeEach(() => vi.clearAllMocks())

  it("author can delete own comment", async () => {
    const ownerChain = mockChain({ data: { author_id: "user-001" } })
    const deleteChain = mockChain({ data: null, error: null })
    let callNum = 0
    const client = {
      from: vi.fn().mockImplementation(() => {
        callNum++
        return callNum <= 1 ? ownerChain : deleteChain
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

    await deleteComment("comment-001")
    expect(deleteChain.delete).toHaveBeenCalled()
  })

  it("admin can delete another user's comment", async () => {
    const ownerChain = mockChain({ data: { author_id: "other-user" } })
    const profileChain = mockChain({ data: { role: "admin" } })
    const deleteChain = mockChain({ data: null, error: null })
    let callNum = 0
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        callNum++
        if (table === "profiles") return profileChain
        if (callNum <= 1) return ownerChain
        return deleteChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-admin" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await deleteComment("comment-001")
    expect(deleteChain.delete).toHaveBeenCalled()
  })

  it("supervisor can delete another user's comment", async () => {
    const ownerChain = mockChain({ data: { author_id: "other-user" } })
    const profileChain = mockChain({ data: { role: "supervisor" } })
    const deleteChain = mockChain({ data: null, error: null })
    let callNum = 0
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        callNum++
        if (table === "profiles") return profileChain
        if (callNum <= 1) return ownerChain
        return deleteChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-sup" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await deleteComment("comment-001")
    expect(deleteChain.delete).toHaveBeenCalled()
  })

  it("viewer cannot delete another user's comment", async () => {
    const ownerChain = mockChain({ data: { author_id: "other-user" } })
    const profileChain = mockChain({ data: { role: "viewer" } })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "profiles") return profileChain
        return ownerChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-viewer" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(deleteComment("comment-001")).rejects.toThrow("permissão")
  })

  it("closer cannot delete another user's comment", async () => {
    const ownerChain = mockChain({ data: { author_id: "other-user" } })
    const profileChain = mockChain({ data: { role: "closer" } })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "profiles") return profileChain
        return ownerChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-closer" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(deleteComment("comment-001")).rejects.toThrow("permissão")
  })

  it("rejects unauthenticated delete", async () => {
    const client = {
      from: vi.fn(),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: null },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(deleteComment("comment-001")).rejects.toThrow("authenticated")
  })
})

describe("removeBookmark ownership", () => {
  beforeEach(() => vi.clearAllMocks())

  it("owner can remove own bookmark", async () => {
    const selectChain = mockChain({ data: { bookmarked_by: "user-001" } })
    const deleteChain = mockChain({ data: null, error: null })
    let callNum = 0
    const client = {
      from: vi.fn().mockImplementation(() => {
        callNum++
        return callNum <= 1 ? selectChain : deleteChain
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
  })

  it("viewer cannot remove another user's bookmark", async () => {
    const selectChain = mockChain({ data: { bookmarked_by: "other-user" } })
    const profileChain = mockChain({ data: { role: "viewer" } })
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "profiles") return profileChain
        return selectChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-viewer" } },
          error: null,
        }),
      },
      storage: { from: vi.fn() },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(removeBookmark("audit-001")).rejects.toThrow("permissão")
  })

  it("returns success for already-removed bookmark", async () => {
    const chain = mockChain({ data: null })
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

    const result = await removeBookmark("audit-001")
    expect(result).toEqual({ success: true })
  })
})
