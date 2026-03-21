import "@testing-library/jest-dom"
import { vi } from "vitest"

// ─── Mock next/navigation ───
vi.mock("next/navigation", () => ({
  useRouter: () => ({
    push: vi.fn(),
    replace: vi.fn(),
    back: vi.fn(),
    refresh: vi.fn(),
    prefetch: vi.fn(),
  }),
  usePathname: () => "/",
  useSearchParams: () => new URLSearchParams(),
  redirect: vi.fn(),
}))

// ─── Mock next/headers ───
vi.mock("next/headers", () => ({
  cookies: vi.fn().mockResolvedValue({
    getAll: () => [],
    set: vi.fn(),
  }),
}))

// ─── Mock next/cache ───
vi.mock("next/cache", () => ({
  revalidatePath: vi.fn(),
  revalidateTag: vi.fn(),
}))

// ─── Supabase mock helpers ───

export interface MockChain {
  select: ReturnType<typeof vi.fn>
  insert: ReturnType<typeof vi.fn>
  update: ReturnType<typeof vi.fn>
  delete: ReturnType<typeof vi.fn>
  upsert: ReturnType<typeof vi.fn>
  eq: ReturnType<typeof vi.fn>
  neq: ReturnType<typeof vi.fn>
  gte: ReturnType<typeof vi.fn>
  lte: ReturnType<typeof vi.fn>
  in: ReturnType<typeof vi.fn>
  not: ReturnType<typeof vi.fn>
  overlaps: ReturnType<typeof vi.fn>
  order: ReturnType<typeof vi.fn>
  limit: ReturnType<typeof vi.fn>
  range: ReturnType<typeof vi.fn>
  single: ReturnType<typeof vi.fn>
  maybeSingle: ReturnType<typeof vi.fn>
  execute: ReturnType<typeof vi.fn>
  data: unknown
  count: number | null
  error: unknown
}

export function createMockChain(overrides?: { data?: unknown; count?: number | null; error?: unknown }): MockChain {
  const result = {
    data: overrides?.data ?? [],
    count: overrides?.count ?? null,
    error: overrides?.error ?? null,
  }

  const chain: MockChain = {
    data: result.data,
    count: result.count,
    error: result.error,
    select: vi.fn(),
    insert: vi.fn(),
    update: vi.fn(),
    delete: vi.fn(),
    upsert: vi.fn(),
    eq: vi.fn(),
    neq: vi.fn(),
    gte: vi.fn(),
    lte: vi.fn(),
    in: vi.fn(),
    not: vi.fn(),
    overlaps: vi.fn(),
    order: vi.fn(),
    limit: vi.fn(),
    range: vi.fn(),
    single: vi.fn(),
    maybeSingle: vi.fn(),
    execute: vi.fn(),
  }

  // Make all methods chainable and resolve to result
  for (const key of Object.keys(chain) as (keyof MockChain)[]) {
    if (typeof chain[key] === "function") {
      (chain[key] as ReturnType<typeof vi.fn>).mockReturnValue(chain)
    }
  }

  // Terminal methods return the result object
  chain.single.mockReturnValue(result)
  chain.maybeSingle.mockReturnValue(result)
  chain.execute.mockReturnValue(result)

  // select with count option should also maintain the chain
  chain.select.mockImplementation((_cols?: string, _opts?: { count?: string; head?: boolean }) => {
    // After select, subsequent chain calls still return chain
    // but the final result includes count if requested
    return chain
  })

  return chain
}

export function createMockSupabaseClient(chainOverrides?: Parameters<typeof createMockChain>[0]) {
  const chain = createMockChain(chainOverrides)

  const client = {
    from: vi.fn().mockReturnValue(chain),
    auth: {
      getUser: vi.fn().mockResolvedValue({
        data: { user: { id: "user-001", email: "test@test.com" } },
        error: null,
      }),
    },
    storage: {
      from: vi.fn().mockReturnValue({
        upload: vi.fn().mockResolvedValue({ error: null }),
        download: vi.fn().mockResolvedValue({ data: new Blob(), error: null }),
        createSignedUrl: vi.fn().mockResolvedValue({
          data: { signedUrl: "https://test.supabase.co/signed-url" },
          error: null,
        }),
      }),
    },
    channel: vi.fn().mockReturnValue({
      on: vi.fn().mockReturnThis(),
      subscribe: vi.fn().mockReturnThis(),
    }),
    removeChannel: vi.fn(),
    _chain: chain, // expose for test assertions
  }

  return client
}

// ─── Mock auth helpers ───
vi.mock("@/lib/auth/require-role", () => ({
  requireRole: vi.fn().mockResolvedValue({ userId: "user-001", role: "admin", organizationId: "org-001" }),
  requireAuth: vi.fn().mockResolvedValue({ userId: "user-001", role: "admin", organizationId: "org-001" }),
}))

// ─── Mock Supabase server client ───
const defaultMockClient = createMockSupabaseClient()

vi.mock("@/lib/supabase/server", () => ({
  createClient: vi.fn().mockResolvedValue(defaultMockClient),
}))

// ─── Mock Supabase browser client ───
vi.mock("@/lib/supabase/client", () => ({
  createClient: vi.fn().mockReturnValue(defaultMockClient),
}))

// Export for use in tests that need to override
export { defaultMockClient }
