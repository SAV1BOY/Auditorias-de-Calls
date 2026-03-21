import { createClient } from "@/lib/supabase/server"

export type UserRole = "admin" | "supervisor" | "closer" | "viewer"

export interface AuthContext {
  userId: string
  role: UserRole
  organizationId: string | null
}

/**
 * Verifies authentication and checks if the user has one of the allowed roles.
 *
 * @throws Error if user is not authenticated or lacks the required role.
 */
export async function requireRole(allowedRoles: UserRole[]): Promise<AuthContext> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    throw new Error("Não autenticado")
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("role, organization_id")
    .eq("id", user.id)
    .single()

  if (!profile) {
    throw new Error("Perfil não encontrado")
  }

  const role = profile.role as UserRole
  if (!allowedRoles.includes(role)) {
    throw new Error("Sem permissão para esta ação")
  }

  return {
    userId: user.id,
    role,
    organizationId: profile.organization_id,
  }
}

/**
 * Verifies authentication only (no role check). Returns user context.
 */
export async function requireAuth(): Promise<AuthContext> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    throw new Error("Não autenticado")
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("role, organization_id")
    .eq("id", user.id)
    .single()

  return {
    userId: user.id,
    role: (profile?.role as UserRole) ?? "viewer",
    organizationId: profile?.organization_id ?? null,
  }
}
