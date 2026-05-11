import { createServerClient } from "@supabase/ssr"
import { NextResponse, type NextRequest } from "next/server"

export async function middleware(request: NextRequest) {
  // ─── CSP Configuration ───
  // NOTE: Nonce-based CSP is NOT used because Next.js 14 does not propagate
  // nonce attributes to its own inline bootstrap scripts. When a nonce is
  // present in script-src, CSP Level 3 browsers IGNORE 'unsafe-inline',
  // which blocks ALL inline scripts and kills React hydration entirely.
  // Using 'unsafe-inline' + 'unsafe-eval' without nonce is the correct
  // approach for Next.js 14 until nonce propagation is properly supported.

  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || ""
  const supabaseWs = supabaseUrl.replace(/^https?:\/\//, "wss://")
  const connectSrc = [
    "'self'",
    supabaseUrl,
    supabaseWs,
    "https://*.supabase.co",
    "wss://*.supabase.co",
  ].filter(Boolean).join(" ")

  const csp = [
    "default-src 'self'",
    // 'unsafe-inline' required for Next.js inline hydration/bootstrap scripts
    // 'unsafe-eval' required for WebGL shader compilation (shader-animation.tsx)
    "script-src 'self' 'unsafe-inline' 'unsafe-eval'",
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
    "img-src 'self' data: https:",
    "font-src 'self' https://fonts.gstatic.com",
    `connect-src ${connectSrc}`,
    `media-src 'self' ${supabaseUrl} https://*.supabase.co`,
    "object-src 'none'",
    "base-uri 'self'",
    "form-action 'self'",
    "frame-ancestors 'none'",
  ].join("; ")

  // ─── Supabase Auth ───
  // IMPORTANT: This pattern is from the official Supabase Next.js docs.
  // The supabaseResponse object MUST be returned with its cookies intact —
  // any redirect must explicitly copy cookies from supabaseResponse, otherwise
  // the browser and server go out of sync and the session is terminated.
  let supabaseResponse = NextResponse.next({ request })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          )
          supabaseResponse = NextResponse.next({ request })
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  const incomingCookies = request.cookies.getAll()
  const sbCookies = incomingCookies.filter((c) => c.name.startsWith("sb-"))

  // Do NOT run code between createServerClient and supabase.auth.getUser().
  // A token refresh may set new cookies via setAll(); we must call getUser()
  // immediately so the refreshed cookies land on supabaseResponse.
  const {
    data: { user },
    error: userError,
  } = await supabase.auth.getUser()

  console.log("[middleware]", {
    path: request.nextUrl.pathname,
    method: request.method,
    sbCookieCount: sbCookies.length,
    sbCookieNames: sbCookies.map((c) => c.name),
    user: user ? { id: user.id, email: user.email } : null,
    userError: userError ? { message: userError.message, status: userError.status } : null,
  })

  // Helper: build a redirect response that PRESERVES cookies from supabaseResponse.
  // CRITICAL: without this, refresh tokens set by getUser() are dropped on the
  // redirect response, terminating the session and causing the login loop.
  function redirectWithCookies(pathname: string) {
    const url = request.nextUrl.clone()
    url.pathname = pathname
    const redirectResponse = NextResponse.redirect(url)
    supabaseResponse.cookies.getAll().forEach(({ name, value, ...options }) => {
      redirectResponse.cookies.set(name, value, options)
    })
    return redirectResponse
  }

  // Redirect unauthenticated users to /login
  if (
    !user &&
    !request.nextUrl.pathname.startsWith("/login") &&
    !request.nextUrl.pathname.startsWith("/_next") &&
    !request.nextUrl.pathname.startsWith("/favicon")
  ) {
    return redirectWithCookies("/login")
  }

  // Redirect authenticated users away from /login
  if (user && request.nextUrl.pathname.startsWith("/login")) {
    return redirectWithCookies("/")
  }

  // ─── Set Security Headers ───
  supabaseResponse.headers.set("Content-Security-Policy", csp)
  supabaseResponse.headers.set("X-Content-Type-Options", "nosniff")
  supabaseResponse.headers.set("Referrer-Policy", "strict-origin-when-cross-origin")
  supabaseResponse.headers.set("Permissions-Policy", "camera=(), microphone=(), geolocation=()")

  return supabaseResponse
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
}
