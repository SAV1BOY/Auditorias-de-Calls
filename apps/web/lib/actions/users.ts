"use server"

import { createAdminClient } from "@/lib/supabase/admin"
import { createClient } from "@/lib/supabase/server"
import { requireRole } from "@/lib/auth/require-role"
import { rateLimit } from "@/lib/security/rate-limit"

// ─── Types ───

export interface UserProfile {
  id: string
  full_name: string
  role: string
  avatar_url: string | null
  created_at: string
  email?: string
}

export interface CreateUserResult {
  success?: boolean
  error?: string
  userId?: string
}

// ─── List Users ───

export async function listUsers(): Promise<UserProfile[]> {
  await requireRole(["admin"])
  const supabase = await createClient()

  const { data } = await supabase
    .from("profiles")
    .select("id, full_name, role, avatar_url, created_at")
    .order("created_at", { ascending: false })

  if (!data) return []

  // Fetch emails from auth (admin client needed)
  const admin = createAdminClient()
  const { data: authUsers } = await admin.auth.admin.listUsers({ perPage: 1000 })

  const emailMap = new Map<string, string>()
  if (authUsers?.users) {
    for (const u of authUsers.users) {
      if (u.email) emailMap.set(u.id, u.email)
    }
  }

  return data.map((profile) => ({
    ...profile,
    email: emailMap.get(profile.id) ?? undefined,
  }))
}

// ─── Create User ───

export async function createUser(formData: FormData): Promise<CreateUserResult> {
  const { userId } = await requireRole(["admin"])

  // Rate limit: 5 user creations per hour
  const rl = rateLimit(`create_user:${userId}`, { interval: 60 * 60 * 1000, maxRequests: 5 })
  if (!rl.success) {
    return { error: "Muitas criações em pouco tempo. Aguarde." }
  }

  const email = formData.get("email")?.toString()?.trim()
  const password = formData.get("password")?.toString()
  const fullName = formData.get("full_name")?.toString()?.trim()
  const role = formData.get("role")?.toString()

  // Validate inputs
  if (!email || !password || !fullName || !role) {
    return { error: "Todos os campos são obrigatórios." }
  }

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    return { error: "Email inválido." }
  }

  if (password.length < 8) {
    return { error: "Senha deve ter pelo menos 8 caracteres." }
  }

  // SECURITY: Cannot create admin users
  const allowedRoles = ["supervisor", "closer", "viewer"]
  if (!allowedRoles.includes(role)) {
    return { error: "Role inválido. Permitidos: supervisor, closer, viewer." }
  }

  try {
    const admin = createAdminClient()

    // 1. Create auth user
    const { data: authData, error: authError } = await admin.auth.admin.createUser({
      email,
      password,
      email_confirm: true, // Auto-confirm email
    })

    if (authError) {
      if (authError.message?.includes("already")) {
        return { error: "Este email já está cadastrado." }
      }
      return { error: "Erro ao criar usuário. Tente novamente." }
    }

    if (!authData.user) {
      return { error: "Erro inesperado na criação do usuário." }
    }

    // 2. Create profile
    const { error: profileError } = await admin.from("profiles").insert({
      id: authData.user.id,
      full_name: fullName,
      role,
    })

    if (profileError) {
      // Rollback: delete auth user if profile creation fails
      await admin.auth.admin.deleteUser(authData.user.id)
      return { error: "Erro ao criar perfil. Tente novamente." }
    }

    return { success: true, userId: authData.user.id }
  } catch {
    return { error: "Erro inesperado. Tente novamente." }
  }
}

// ─── Update User Role ───

export async function updateUserRole(
  targetUserId: string,
  newRole: string
): Promise<{ success?: boolean; error?: string }> {
  await requireRole(["admin"])

  const allowedRoles = ["supervisor", "closer", "viewer"]
  if (!allowedRoles.includes(newRole)) {
    return { error: "Role inválido." }
  }

  const supabase = await createClient()
  const { error } = await supabase
    .from("profiles")
    .update({ role: newRole as "admin" | "supervisor" | "closer" | "viewer" })
    .eq("id", targetUserId)

  if (error) return { error: "Erro ao atualizar role." }
  return { success: true }
}
