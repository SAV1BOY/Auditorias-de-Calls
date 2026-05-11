"use server"

import { headers } from "next/headers"
import { redirect } from "next/navigation"
import { revalidatePath } from "next/cache"
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
 * On success, performs a server-side redirect to "/" so cookies set by
 * signInWithPassword are guaranteed to be on the response that triggers
 * the navigation (avoids client-side race condition where router.push
 * fires before browser commits the Set-Cookie headers).
 */
export async function loginAction(
  email: string,
  password: string
): Promise<LoginResult | never> {
  const headersList = await headers()
  const forwarded = headersList.get("x-forwarded-for")
  const ip = forwarded?.split(",")[0]?.trim() || "unknown"

  const rl = rateLimit(`login:${ip}`, RATE_LIMITS.login)
  if (!rl.success) {
    return {
      error: `Muitas tentativas. Aguarde ${rl.retryAfter} segundos.`,
      retryAfter: rl.retryAfter,
    }
  }

  const supabase = await createClient()
  const { error } = await supabase.auth.signInWithPassword({
    email,
    password,
  })

  if (error) {
    return { error: "Email ou senha incorretos." }
  }

  resetRateLimit(`login:${ip}`)

  // Invalidate any cached server-rendered pages so the next render
  // sees the authenticated session.
  revalidatePath("/", "layout")

  // CRITICAL: redirect() must be OUTSIDE any try/catch. It throws
  // NEXT_REDIRECT which Next.js handles to issue a 303 response with
  // Set-Cookie headers, atomically committing the session + navigation.
  redirect("/")
}

/**
 * Server Action for logout.
 *
 * Must run server-side (not via browser client) so the HTTP auth cookies
 * are properly cleared. Then redirect to /login.
 */
export async function logoutAction(): Promise<never> {
  const supabase = await createClient()
  await supabase.auth.signOut()
  revalidatePath("/", "layout")
  redirect("/login")
}
