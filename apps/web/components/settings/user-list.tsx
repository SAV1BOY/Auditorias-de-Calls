"use client"

import { useState } from "react"
import type { UserProfile } from "@/lib/actions/users"
import { UserCreateDialog } from "./user-create-dialog"

const ROLE_BADGES: Record<string, string> = {
  admin: "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20",
  supervisor: "bg-emerald-500/10 text-emerald-500 border-emerald-500/20",
  closer: "bg-blue-400/10 text-blue-400 border-blue-400/20",
  viewer: "bg-stone-500/10 text-stone-400 border-stone-500/20",
}

interface UserListProps {
  users: UserProfile[]
}

export function UserList({ users: initialUsers }: UserListProps) {
  const [users, setUsers] = useState(initialUsers)
  const [showCreate, setShowCreate] = useState(false)

  function handleUserCreated(newUser: UserProfile) {
    setUsers((prev) => [newUser, ...prev])
    setShowCreate(false)
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <span className="text-sm text-stone-400">
          {users.length} usuário(s) cadastrado(s)
        </span>
        <button
          onClick={() => setShowCreate(true)}
          className="bg-[#ffa600] text-[#2a1800] px-4 py-2 rounded-lg text-xs font-bold tracking-widest uppercase hover:brightness-110 transition-all flex items-center gap-2"
        >
          <span className="material-symbols-outlined text-sm">person_add</span>
          Novo Usuário
        </button>
      </div>

      <div className="bg-[#1a1c1e] rounded-xl border border-white/5 overflow-hidden">
        <table className="w-full text-left border-collapse">
          <thead className="bg-[#292a2d]/30 text-stone-500 text-[10px] font-bold uppercase tracking-[0.2em] border-b border-white/5">
            <tr>
              <th className="px-6 py-3">Nome</th>
              <th className="px-6 py-3">Email</th>
              <th className="px-6 py-3">Role</th>
              <th className="px-6 py-3">Criado em</th>
            </tr>
          </thead>
          <tbody className="text-sm divide-y divide-white/5">
            {users.map((user) => (
              <tr key={user.id} className="hover:bg-[#ffa600]/5 transition-colors">
                <td className="px-6 py-3 font-bold">{user.full_name}</td>
                <td className="px-6 py-3 text-stone-400 font-mono text-xs">
                  {user.email ?? "—"}
                </td>
                <td className="px-6 py-3">
                  <span
                    className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase ${
                      ROLE_BADGES[user.role] ?? ROLE_BADGES.viewer
                    }`}
                  >
                    {user.role}
                  </span>
                </td>
                <td className="px-6 py-3 text-stone-500 text-xs">
                  {new Date(user.created_at).toLocaleDateString("pt-BR")}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <UserCreateDialog
        open={showCreate}
        onOpenChange={setShowCreate}
        onCreated={handleUserCreated}
      />
    </div>
  )
}
