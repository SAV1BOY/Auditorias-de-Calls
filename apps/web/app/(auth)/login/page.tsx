"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { createClient } from "@/lib/supabase/client"

export default function LoginPage() {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const router = useRouter()

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError(null)
    setLoading(true)

    const supabase = createClient()
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      setError("Email ou senha incorretos.")
      setLoading(false)
      return
    }

    router.push("/")
    router.refresh()
  }

  return (
    <div className="w-full max-w-sm bg-[#1a1c1e] rounded-xl border border-white/5 p-8 shadow-[0_40px_40px_-10px_rgba(0,0,0,0.4)]">
      <div className="text-center mb-8">
        <div className="flex justify-center mb-4">
          <span className="material-symbols-outlined text-4xl text-amber-500">
            analytics
          </span>
        </div>
        <h1 className="text-2xl font-headline font-bold">
          Call<span className="text-[#ffa600]">AUDIT</span>
        </h1>
        <p className="text-sm text-stone-500 mt-1">
          Sistema de Auditoria de Calls
        </p>
      </div>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-2">
          <label htmlFor="email" className="font-label text-[10px] uppercase tracking-widest font-bold text-stone-500">
            Email
          </label>
          <input
            id="email"
            type="email"
            autoComplete="email"
            placeholder="seu@email.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            aria-invalid={error ? "true" : undefined}
            className="w-full bg-[#292a2d] border border-white/5 rounded-lg px-4 py-3 text-sm text-[#e3e2e5] placeholder:text-stone-600 focus:border-[#ffa600]/50 focus:ring-1 focus:ring-[#ffa600]/50 focus:outline-none transition-all"
          />
        </div>
        <div className="space-y-2">
          <label htmlFor="password" className="font-label text-[10px] uppercase tracking-widest font-bold text-stone-500">
            Senha
          </label>
          <input
            id="password"
            type="password"
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            aria-invalid={error ? "true" : undefined}
            className="w-full bg-[#292a2d] border border-white/5 rounded-lg px-4 py-3 text-sm text-[#e3e2e5] placeholder:text-stone-600 focus:border-[#ffa600]/50 focus:ring-1 focus:ring-[#ffa600]/50 focus:outline-none transition-all"
          />
        </div>
        {error && (
          <p className="text-sm text-red-500">{error}</p>
        )}
        <button
          type="submit"
          disabled={loading}
          className="w-full bg-[#ffa600] text-[#2a1800] py-3 rounded-lg font-headline font-bold text-sm tracking-widest uppercase hover:brightness-110 active:scale-95 transition-all disabled:opacity-50"
        >
          {loading ? "Entrando..." : "Entrar"}
        </button>
      </form>
      <div className="flex items-center justify-between mt-6 pt-4 border-t border-white/5">
        <span className="text-[9px] font-label uppercase tracking-widest text-stone-600 font-bold">
          SYSTEM DIGITAL
        </span>
        <span className="text-[9px] font-label uppercase tracking-widest text-stone-600 font-bold">
          FACE 100K
        </span>
      </div>
    </div>
  )
}
