import { describe, it, expect, beforeEach, vi } from "vitest"
import { rateLimit, resetRateLimit, RATE_LIMITS } from "@/lib/security/rate-limit"

describe("rateLimit", () => {
  beforeEach(() => {
    // Reset all rate limits between tests
    resetRateLimit("test:user1")
    resetRateLimit("test:user2")
    resetRateLimit("test:userA")
    resetRateLimit("test:userB")
  })

  it("allows requests within limit", () => {
    const result = rateLimit("test:user1", { interval: 60000, maxRequests: 5 })
    expect(result.success).toBe(true)
    expect(result.remaining).toBe(4)
  })

  it("decrements remaining count correctly", () => {
    const config = { interval: 60000, maxRequests: 3 }
    const r1 = rateLimit("test:user1", config)
    const r2 = rateLimit("test:user1", config)
    const r3 = rateLimit("test:user1", config)

    expect(r1.remaining).toBe(2)
    expect(r2.remaining).toBe(1)
    expect(r3.remaining).toBe(0)
  })

  it("blocks requests exceeding limit", () => {
    const config = { interval: 60000, maxRequests: 2 }
    rateLimit("test:user2", config)
    rateLimit("test:user2", config)
    const result = rateLimit("test:user2", config)

    expect(result.success).toBe(false)
    expect(result.remaining).toBe(0)
    expect(result.retryAfter).toBeGreaterThan(0)
  })

  it("isolates different keys", () => {
    const config = { interval: 60000, maxRequests: 1 }
    rateLimit("test:userA", config)
    const result = rateLimit("test:userB", config)
    expect(result.success).toBe(true)
  })

  it("resets after window expires", () => {
    vi.useFakeTimers()
    const config = { interval: 1000, maxRequests: 1 }

    rateLimit("test:user1", config)
    const blocked = rateLimit("test:user1", config)
    expect(blocked.success).toBe(false)

    // Advance time past the window
    vi.advanceTimersByTime(1100)

    const allowed = rateLimit("test:user1", config)
    expect(allowed.success).toBe(true)

    vi.useRealTimers()
  })

  it("resetRateLimit clears the counter", () => {
    const config = { interval: 60000, maxRequests: 1 }
    rateLimit("test:user1", config)
    resetRateLimit("test:user1")
    const result = rateLimit("test:user1", config)
    expect(result.success).toBe(true)
  })

  it("login config allows 5 attempts per 15 minutes", () => {
    expect(RATE_LIMITS.login.maxRequests).toBe(5)
    expect(RATE_LIMITS.login.interval).toBe(15 * 60 * 1000)
  })

  it("upload config allows 10 per hour", () => {
    expect(RATE_LIMITS.upload.maxRequests).toBe(10)
    expect(RATE_LIMITS.upload.interval).toBe(60 * 60 * 1000)
  })

  it("analysis config allows 5 per hour", () => {
    expect(RATE_LIMITS.analysis.maxRequests).toBe(5)
    expect(RATE_LIMITS.analysis.interval).toBe(60 * 60 * 1000)
  })
})
