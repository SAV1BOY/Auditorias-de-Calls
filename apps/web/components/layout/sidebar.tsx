"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
import { logoutAction } from "@/lib/actions/auth"

const navItems = [
  { href: "/", icon: "terminal", label: "Dashboard" },
  { href: "/calls", icon: "phone_in_talk", label: "Calls" },
  { href: "/calls/upload", icon: "cloud_upload", label: "Upload" },
  { href: "/closers", icon: "group", label: "Closers" },
  { href: "/analytics", icon: "query_stats", label: "Analytics" },
  { href: "/library", icon: "bookmark", label: "Biblioteca" },
  { href: "/reports", icon: "description", label: "Relatórios" },
  { href: "/ranking", icon: "emoji_events", label: "Ranking" },
  { href: "/supervisor", icon: "supervisor_account", label: "Supervisor" },
  { href: "/settings", icon: "settings", label: "Settings" },
]

interface SidebarProps {
  className?: string
}

export function Sidebar({ className }: SidebarProps) {
  const pathname = usePathname()

  async function handleLogout() {
    await logoutAction()
  }

  return (
    <aside
      className={`fixed left-0 top-0 h-full w-64 z-40 bg-[#1a1c1e] shadow-2xl shadow-black flex-col pt-24 pb-8 hidden md:flex ${className ?? ""}`}
    >
      <div className="px-6 mb-8">
        <h2 className="text-lg font-black text-amber-500 font-headline uppercase">
          CALLAUDIT
        </h2>
        <p className="font-label text-[10px] font-semibold uppercase tracking-[0.2em] text-[#d8c3ac]/60">
          Audit Intelligence
        </p>
      </div>

      <nav className="flex-1 font-headline text-xs font-semibold uppercase tracking-widest">
        {navItems.map((item) => {
          const isActive =
            item.href === "/"
              ? pathname === "/"
              : pathname.startsWith(item.href)
          return (
            <Link
              key={item.href}
              href={item.href}
              className={
                isActive
                  ? "bg-amber-500/10 text-amber-500 border-r-4 border-amber-500 py-4 px-6 flex items-center gap-4 hover:translate-x-1 transition-transform cursor-pointer"
                  : "text-[#d8c3ac]/60 py-4 px-6 flex items-center gap-4 hover:text-amber-200 hover:bg-[#292a2d] transition-all duration-300 hover:translate-x-1 cursor-pointer"
              }
            >
              <span className="material-symbols-outlined">{item.icon}</span>
              {item.label}
            </Link>
          )
        })}
      </nav>

      <div className="px-6 mt-auto">
        <Link href="/calls/upload">
          <button className="w-full bg-[#ffa600] text-[#2a1800] py-3 rounded-lg text-[10px] font-bold tracking-[0.2em] uppercase hover:brightness-110 active:scale-95 transition-all mb-8">
            Nova Auditoria
          </button>
        </Link>
        <button
          className="flex items-center gap-4 w-full font-headline text-xs font-semibold uppercase tracking-widest text-[#d8c3ac]/40 cursor-pointer hover:text-amber-200 transition-colors bg-transparent border-none"
          onClick={handleLogout}
        >
          <span className="material-symbols-outlined">logout</span>
          Sair
        </button>
      </div>
    </aside>
  )
}
