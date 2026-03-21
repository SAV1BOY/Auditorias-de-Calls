/**
 * RBAC (Role-Based Access Control) tests.
 * Verifies that server actions enforce role checks correctly.
 */
import { vi, describe, it, expect, beforeEach } from "vitest"
import { createClient } from "@/lib/supabase/server"
import { requireRole, requireAuth } from "@/lib/auth/require-role"

// Override the global mock to test requireRole directly
vi.unmock("@/lib/auth/require-role")

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

describe("requireRole", () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it("allows admin to access admin-only actions", async () => {
    const chain = mockChain({ data: { role: "admin", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-admin" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const ctx = await requireRole(["admin"])
    expect(ctx.userId).toBe("user-admin")
    expect(ctx.role).toBe("admin")
    expect(ctx.organizationId).toBe("org-001")
  })

  it("allows supervisor to access supervisor+admin actions", async () => {
    const chain = mockChain({ data: { role: "supervisor", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-sup" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const ctx = await requireRole(["admin", "supervisor"])
    expect(ctx.role).toBe("supervisor")
  })

  it("rejects viewer from admin-only actions", async () => {
    const chain = mockChain({ data: { role: "viewer", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-viewer" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireRole(["admin"])).rejects.toThrow("permissão")
  })

  it("rejects closer from admin+supervisor actions", async () => {
    const chain = mockChain({ data: { role: "closer", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-closer" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireRole(["admin", "supervisor"])).rejects.toThrow("permissão")
  })

  it("rejects unauthenticated users", async () => {
    const client = {
      from: vi.fn(),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: null },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireRole(["admin"])).rejects.toThrow("autenticado")
  })

  it("rejects when profile not found", async () => {
    const chain = mockChain({ data: null })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-no-profile" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireRole(["admin"])).rejects.toThrow("Perfil")
  })

  it("allows closer to upload calls", async () => {
    const chain = mockChain({ data: { role: "closer", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-closer" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    // Closers should be able to upload (admin, supervisor, closer)
    const ctx = await requireRole(["admin", "supervisor", "closer"])
    expect(ctx.role).toBe("closer")
  })

  it("rejects viewer from uploading calls", async () => {
    const chain = mockChain({ data: { role: "viewer", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-viewer" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireRole(["admin", "supervisor", "closer"])).rejects.toThrow("permissão")
  })
})

describe("requireAuth", () => {
  it("returns context for authenticated user", async () => {
    const chain = mockChain({ data: { role: "viewer", organization_id: "org-001" } })
    const client = {
      from: vi.fn().mockReturnValue(chain),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const ctx = await requireAuth()
    expect(ctx.userId).toBe("user-001")
    expect(ctx.role).toBe("viewer")
  })

  it("rejects unauthenticated user", async () => {
    const client = {
      from: vi.fn(),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: null },
          error: null,
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    await expect(requireAuth()).rejects.toThrow("autenticado")
  })
})
