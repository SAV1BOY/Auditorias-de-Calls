import { createClient } from "@supabase/supabase-js"

/**
 * Supabase client with Service Role Key for admin operations.
 *
 * SECURITY: This client bypasses RLS. Only use in Server Actions
 * with requireRole(["admin"]) check. NEVER import in client components.
 *
 * Used for: user creation (auth.admin.createUser), profile management
 */
export function createAdminClient() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY

  if (!url || !key) {
    throw new Error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY for admin operations")
  }

  return createClient(url, key, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  })
}
