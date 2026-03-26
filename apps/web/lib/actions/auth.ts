"use server"

import { headers } from "next/headers"
import { createClient } from "@/lib/supabase/server"
import { rateLimit, resetRateLimit, RATE_LIMITS } from "@/lib/security/rate-limit"

export interface LoginResult {
  success?: boolean
  error?: string
  retryAfter?: number
}

/**
 * Server Action for login with rate limiting.
 *
 * Rate limited to 5 attempts per 15 minutes per IP address.
 * On success, resets the rate limit counter.
 */
export async function loginAction(
  email: string,
  password: string
): Promise<LoginResult> {
  // Get client IP for rate limiting
  const headersList = await headers()
  const forwarded = headersList.get("x-forwarded-for")
  const ip = forwarded?.split(",")[0]?.trim() || "unknown"

  // Check rate limit
  const rl = rateLimit(`login:${ip}`, RATE_LIMITS.login)
  if (!rl.success) {
    return {
      error: `Muitas tentativas. Aguarde ${rl.retryAfter} segundos.`,
      retryAfter: rl.retryAfter,
    }
  }

  // Attempt login
  const supabase = await createClient()
  const { error } = await supabase.auth.signInWithPassword({
    email,
    password,
  })

  if (error) {
    return { error: "Email ou senha incorretos." }
  }

  // Verify session was actually created and cookies persisted
  const { data: { user: sessionUser } } = await supabase.auth.getUser()
  if (!sessionUser) {
    return { error: "Erro ao criar sessão. Tente novamente." }
  }

  // Success — reset rate limit for this IP
  resetRateLimit(`login:${ip}`)
  return { success: true }
}
