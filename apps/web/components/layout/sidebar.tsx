"use client"

import Link from "next/link"
import { usePathname, useRouter } from "next/navigation"
import { createClient } from "@/lib/supabase/client"
import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"
import {
  LayoutDashboard,
  Phone,
  Users,
  Upload,
  Settings,
  LogOut,
  BarChart3,
  TrendingUp,
  BookMarked,
  FileText,
  Trophy,
} from "lucide-react"

const navItems = [
  { href: "/", label: "Dashboard", icon: LayoutDashboard },
  { href: "/calls", label: "Calls", icon: Phone },
  { href: "/closers", label: "Closers", icon: Users },
  { href: "/analytics", label: "Analytics", icon: TrendingUp },
  { href: "/library", label: "Biblioteca", icon: BookMarked },
  { href: "/reports", label: "Relat\u00f3rios", icon: FileText },
  { href: "/ranking", label: "Ranking", icon: Trophy },
  { href: "/calls/upload", label: "Upload", icon: Upload },
  { href: "/settings", label: "Configura\u00e7\u00f5es", icon: Settings },
]

interface SidebarProps {
  className?: string
}

export function Sidebar({ className }: SidebarProps) {
  const pathname = usePathname()
  const router = useRouter()

  async function handleLogout() {
    const supabase = createClient()
    await supabase.auth.signOut()
    router.push("/login")
    router.refresh()
  }

  return (
    <div className={cn("flex h-full flex-col bg-surface-secondary", className)}>
      <div className="flex h-14 items-center px-4">
        <Link href="/" className="flex items-center gap-2 font-display font-bold">
          <BarChart3 className="h-6 w-6 text-primary" />
          <span className="text-accent-foreground">Call</span>
          <span className="text-primary-light">Audit</span>
        </Link>
      </div>

      <nav className="flex-1 space-y-1 p-2">
        {navItems.map((item) => {
          const isActive =
            item.href === "/"
              ? pathname === "/"
              : pathname.startsWith(item.href)
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium font-display transition-all duration-200",
                isActive
                  ? "bg-surface-interaction text-accent-foreground border-l-[3px] border-primary"
                  : "text-muted-foreground hover:bg-surface-interaction hover:text-foreground"
              )}
            >
              <item.icon className={cn("h-4 w-4", isActive && "text-primary")} />
              {item.label}
            </Link>
          )
        })}
      </nav>

      <div className="p-2">
        <Button
          variant="ghost"
          className="w-full justify-start gap-3 text-muted-foreground"
          onClick={handleLogout}
        >
          <LogOut className="h-4 w-4" />
          Sair
        </Button>
      </div>
    </div>
  )
}
