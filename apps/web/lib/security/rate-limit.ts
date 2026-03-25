/**
 * In-memory rate limiter with sliding window.
 *
 * For production at scale, replace with Upstash Redis (@upstash/ratelimit).
 * Current implementation is sufficient for <100 req/min (single instance).
 *
 * ADR-006: In-memory rate limiting for MVP.
 */

export interface RateLimitConfig {
  /** Window duration in milliseconds */
  interval: number
  /** Max requests allowed per window */
  maxRequests: number
}

export interface RateLimitResult {
  /** Whether the request is allowed */
  success: boolean
  /** Remaining requests in current window */
  remaining: number
  /** Seconds until window resets (only if blocked) */
  retryAfter?: number
}

const store = new Map<string, { count: number; resetTime: number }>()

// Cleanup stale entries every 5 minutes
if (typeof setInterval !== "undefined") {
  setInterval(() => {
    const now = Date.now()
    store.forEach((entry, key) => {
      if (now > entry.resetTime) {
        store.delete(key)
      }
    })
  }, 5 * 60 * 1000)
}

/**
 * Check rate limit for a given key.
 *
 * @param key - Unique identifier (e.g., "login:192.168.1.1" or "upload:user-uuid")
 * @param config - Rate limit configuration
 * @returns Result with success status and remaining count
 */
export function rateLimit(
  key: string,
  config: RateLimitConfig
): RateLimitResult {
  const now = Date.now()
  const entry = store.get(key)

  // No entry or window expired — start fresh
  if (!entry || now > entry.resetTime) {
    store.set(key, { count: 1, resetTime: now + config.interval })
    return { success: true, remaining: config.maxRequests - 1 }
  }

  // Within window but under limit
  if (entry.count < config.maxRequests) {
    entry.count++
    return { success: true, remaining: config.maxRequests - entry.count }
  }

  // Rate limited
  const retryAfter = Math.ceil((entry.resetTime - now) / 1000)
  return { success: false, remaining: 0, retryAfter }
}

/** Predefined rate limit configurations */
export const RATE_LIMITS = {
  /** 5 login attempts per 15 minutes per IP */
  login: { interval: 15 * 60 * 1000, maxRequests: 5 },
  /** 10 uploads per hour per user */
  upload: { interval: 60 * 60 * 1000, maxRequests: 10 },
  /** 5 supervisor analysis requests per hour per user */
  analysis: { interval: 60 * 60 * 1000, maxRequests: 5 },
} as const

/**
 * Reset rate limit for a key (e.g., after successful login).
 */
export function resetRateLimit(key: string): void {
  store.delete(key)
}
