import { createServerClient } from "@supabase/ssr"
import { NextResponse, type NextRequest } from "next/server"

export async function middleware(request: NextRequest) {
  // ─── CSP Nonce Generation ───
  const nonce = Buffer.from(crypto.getRandomValues(new Uint8Array(16))).toString("base64")

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
    `script-src 'self' 'nonce-${nonce}'`,
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

  // Do NOT run code between createServerClient and supabase.auth.getUser().
  // A token refresh may set new cookies via setAll(); we must call getUser()
  // immediately so the refreshed cookies land on supabaseResponse.
  const {
    data: { user },
  } = await supabase.auth.getUser()

  // Helper: build a redirect response that PRESERVES cookies from supabaseResponse.
  // This is critical for token-refresh scenarios — without it, refresh tokens
  // set by getUser() would be dropped, terminating the session.
  function redirectWithCookies(pathname: string) {
    const url = request.nextUrl.clone()
    url.pathname = pathname
    const redirectResponse = NextResponse.redirect(url)
    supabaseResponse.cookies.getAll().forEach((cookie) => {
      redirectResponse.cookies.set(cookie.name, cookie.value, cookie)
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
  supabaseResponse.headers.set("x-nonce", nonce)

  return supabaseResponse
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
}
