import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import { createAdminClient } from "@/lib/supabase/admin"
import { requireRole } from "@/lib/auth/require-role"
import { listUsers, createUser, updateUserRole } from "@/lib/actions/users"

// ─── Mock admin client ───

vi.mock("@/lib/supabase/admin", () => ({
  createAdminClient: vi.fn(),
}))

vi.mock("@/lib/security/rate-limit", () => ({
  rateLimit: vi.fn().mockReturnValue({ success: true, remaining: 4 }),
  RATE_LIMITS: { login: { interval: 900000, maxRequests: 5 } },
}))

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
    _chain: chain,
  }
}

function makeMockAdminClient(opts: {
  authUsers?: any[]
  createUserResult?: { data?: any; error?: any }
  profileInsertError?: any
} = {}) {
  const chain = mockChain({ data: null, error: opts.profileInsertError ?? null })
  return {
    from: vi.fn().mockReturnValue(chain),
    auth: {
      admin: {
        listUsers: vi.fn().mockResolvedValue({
          data: { users: opts.authUsers ?? [] },
          error: null,
        }),
        createUser: vi.fn().mockResolvedValue(
          opts.createUserResult ?? {
            data: { user: { id: "new-user-001" } },
            error: null,
          }
        ),
        deleteUser: vi.fn().mockResolvedValue({ error: null }),
      },
    },
    _chain: chain,
  }
}

// ─── Tests ───

describe("listUsers", () => {
  it("returns profiles with emails from auth", async () => {
    const profiles = [
      { id: "u1", full_name: "Alice", role: "admin", avatar_url: null, created_at: "2026-01-01" },
      { id: "u2", full_name: "Bob", role: "closer", avatar_url: null, created_at: "2026-01-02" },
    ]
    const client = makeMockClient({ data: profiles })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const adminClient = makeMockAdminClient({
      authUsers: [
        { id: "u1", email: "alice@test.com" },
        { id: "u2", email: "bob@test.com" },
      ],
    })
    vi.mocked(createAdminClient).mockReturnValue(adminClient as any)

    const result = await listUsers()

    expect(result).toHaveLength(2)
    expect(result[0].email).toBe("alice@test.com")
    expect(result[1].email).toBe("bob@test.com")
    expect(client.from).toHaveBeenCalledWith("profiles")
  })

  it("returns empty array when no profiles", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await listUsers()

    expect(result).toEqual([])
  })
})

describe("createUser", () => {
  it("creates auth user and profile", async () => {
    const client = makeMockClient({ data: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const adminClient = makeMockAdminClient()
    vi.mocked(createAdminClient).mockReturnValue(adminClient as any)

    const fd = new FormData()
    fd.append("email", "new@test.com")
    fd.append("password", "securePass123")
    fd.append("full_name", "New User")
    fd.append("role", "closer")

    const result = await createUser(fd)

    expect(result.success).toBe(true)
    expect(result.userId).toBe("new-user-001")
    expect(adminClient.auth.admin.createUser).toHaveBeenCalledWith({
      email: "new@test.com",
      password: "securePass123",
      email_confirm: true,
    })
    expect(adminClient.from).toHaveBeenCalledWith("profiles")
  })

  it("rejects missing fields", async () => {
    const fd = new FormData()
    fd.append("email", "test@test.com")

    const result = await createUser(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("obrigatórios")
  })

  it("rejects invalid email", async () => {
    const fd = new FormData()
    fd.append("email", "not-an-email")
    fd.append("password", "securePass123")
    fd.append("full_name", "Test")
    fd.append("role", "closer")

    const result = await createUser(fd)

    expect(result.error).toContain("Email")
  })

  it("rejects short password", async () => {
    const fd = new FormData()
    fd.append("email", "test@test.com")
    fd.append("password", "short")
    fd.append("full_name", "Test")
    fd.append("role", "closer")

    const result = await createUser(fd)

    expect(result.error).toContain("8 caracteres")
  })

  it("SECURITY: rejects admin role creation", async () => {
    const fd = new FormData()
    fd.append("email", "evil@test.com")
    fd.append("password", "securePass123")
    fd.append("full_name", "Evil Admin")
    fd.append("role", "admin")

    const result = await createUser(fd)

    expect(result.error).toContain("Role inválido")
  })

  it("rolls back auth user on profile creation failure", async () => {
    const adminClient = makeMockAdminClient({
      profileInsertError: { message: "duplicate" },
    })
    vi.mocked(createAdminClient).mockReturnValue(adminClient as any)

    const fd = new FormData()
    fd.append("email", "test@test.com")
    fd.append("password", "securePass123")
    fd.append("full_name", "Test User")
    fd.append("role", "supervisor")

    const result = await createUser(fd)

    expect(result.error).toContain("perfil")
    expect(adminClient.auth.admin.deleteUser).toHaveBeenCalledWith("new-user-001")
  })
})

describe("updateUserRole", () => {
  it("updates role for valid input", async () => {
    const client = makeMockClient({ data: null, error: null })
    vi.mocked(createClient).mockResolvedValue(client as any)

    const result = await updateUserRole("user-002", "supervisor")

    expect(result.success).toBe(true)
    expect(client.from).toHaveBeenCalledWith("profiles")
    expect(client._chain.update).toHaveBeenCalledWith(
      expect.objectContaining({ role: "supervisor" })
    )
    expect(client._chain.eq).toHaveBeenCalledWith("id", "user-002")
  })

  it("rejects invalid role", async () => {
    const result = await updateUserRole("user-002", "admin")

    expect(result.error).toContain("Role inválido")
  })

  it("rejects unknown role", async () => {
    const result = await updateUserRole("user-002", "superuser")

    expect(result.error).toContain("Role inválido")
  })
})
