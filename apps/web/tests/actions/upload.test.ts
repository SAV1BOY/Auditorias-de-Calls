import { vi } from "vitest"
import { createClient } from "@/lib/supabase/server"
import { uploadCall } from "@/lib/actions/upload"

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

function makeFormData(overrides: Record<string, any> = {}): FormData {
  const fd = new FormData()
  const defaults: Record<string, any> = {
    file: new File(["audio-content"], "call.mp3", { type: "audio/mpeg" }),
    closerId: "closer-001",
    leadName: "Elane Lima",
    callDate: "2026-03-15",
    resultado: "fechamento",
  }
  const merged = { ...defaults, ...overrides }
  for (const [key, value] of Object.entries(merged)) {
    if (value !== null && value !== undefined) {
      fd.append(key, value)
    }
  }
  return fd
}

// ─── Tests ───

describe("uploadCall", () => {
  it("rejects when no file", async () => {
    const fd = makeFormData({ file: undefined })
    fd.delete("file")

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("arquivo")
  })

  it("rejects file > 500MB", async () => {
    const bigFile = new File(["x"], "call.mp3", { type: "audio/mpeg" })
    Object.defineProperty(bigFile, "size", { value: 501 * 1024 * 1024 })

    const fd = makeFormData({ file: bigFile })

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("500")
  })

  it("rejects invalid format", async () => {
    const badFile = new File(["content"], "call.exe", { type: "application/octet-stream" })
    const fd = makeFormData({ file: badFile })

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("Formato")
  })

  it("rejects missing closerId", async () => {
    const fd = makeFormData({ closerId: undefined })
    fd.delete("closerId")

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("closer")
  })

  it("rejects missing leadName", async () => {
    const fd = makeFormData({ leadName: undefined })
    fd.delete("leadName")

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("lead")
  })

  it("rejects missing callDate", async () => {
    const fd = makeFormData({ callDate: undefined })
    fd.delete("callDate")

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("Data")
  })

  it("rejects invalid resultado", async () => {
    const fd = makeFormData({ resultado: "invalid_value" })

    const result = await uploadCall(fd)

    expect(result.error).toBeDefined()
    expect(result.error).toContain("Resultado")
  })

  it("successful upload creates audit, uploads file, and creates job", async () => {
    const auditChain = mockChain({ data: { id: "audit-new" } })
    const jobChain = mockChain({ data: null, error: null })
    const updateChain = mockChain({ data: null, error: null })

    let callCount = 0
    const client = {
      from: vi.fn().mockImplementation((table: string) => {
        if (table === "job_queue") return jobChain
        // First call_audits call is insert, second is update
        callCount++
        if (callCount > 1) return updateChain
        return auditChain
      }),
      auth: {
        getUser: vi.fn().mockResolvedValue({
          data: { user: { id: "user-001" } },
          error: null,
        }),
      },
      storage: {
        from: vi.fn().mockReturnValue({
          upload: vi.fn().mockResolvedValue({ error: null }),
        }),
      },
    }
    vi.mocked(createClient).mockResolvedValue(client as any)

    const fd = makeFormData()
    const result = await uploadCall(fd)

    expect(result.auditId).toBe("audit-new")
    expect(result.error).toBeUndefined()
    // Verify audit was inserted
    expect(client.from).toHaveBeenCalledWith("call_audits")
    expect(auditChain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        closer_id: "closer-001",
        lead_name: "Elane Lima",
        call_date: "2026-03-15",
        status: "uploaded",
      })
    )
    // Verify storage upload
    expect(client.storage.from).toHaveBeenCalledWith("audios")
    // Verify job was created
    expect(client.from).toHaveBeenCalledWith("job_queue")
    expect(jobChain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        audit_id: "audit-new",
        job_type: "transcribe",
        status: "pending",
      })
    )
  })
})
