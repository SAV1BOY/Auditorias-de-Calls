"use client"

import { usePathname } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Sheet, SheetContent, SheetTrigger, SheetTitle } from "@/components/ui/sheet"
import { Menu } from "lucide-react"
import { Sidebar } from "./sidebar"

export function Header() {
  const pathname = usePathname()

  return (
    <header className="fixed top-0 w-full z-50 bg-[#050608]/80 backdrop-blur-xl shadow-[0_40px_40px_-10px_rgba(0,0,0,0.4)]">
      <div className="flex justify-between items-center px-8 h-16 md:ml-64">
        <div className="flex items-center gap-8">
          {/* Mobile menu */}
          <Sheet>
            <SheetTrigger asChild>
              <Button variant="ghost" size="icon" className="md:hidden">
                <Menu className="h-5 w-5" />
                <span className="sr-only">Menu</span>
              </Button>
            </SheetTrigger>
            <SheetContent side="left" className="w-64 p-0 bg-[#1a1c1e] border-none">
              <SheetTitle className="sr-only">Menu de navegação</SheetTitle>
              <Sidebar className="!flex !relative !pt-8 !shadow-none" />
            </SheetContent>
          </Sheet>
          <span className="text-xl font-bold tracking-[0.1em] text-amber-500 font-headline">
            SYSTEM DIGITAL
          </span>
          <nav className="hidden md:flex gap-6">
            <span className="text-stone-400 font-medium hover:text-amber-400 transition-colors duration-300 text-sm cursor-default">
              Command Center
            </span>
          </nav>
        </div>
        <div className="flex items-center gap-6">
          <button aria-label="Notificações" className="p-2 rounded-full hover:bg-white/5 transition-all">
            <span className="material-symbols-outlined text-stone-400 hover:text-amber-500">
              notifications
            </span>
          </button>
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-[#292a2d] border border-[#a08e79]/10">
            <span className="flex h-2 w-2 rounded-full bg-[#ffa600] animate-pulse" />
            <span className="font-label text-[10px] tracking-widest uppercase font-bold text-[#d8c3ac]">
              System Online
            </span>
          </div>
          <div className="w-10 h-10 rounded-full border border-amber-500/30 overflow-hidden bg-[#292a2d] flex items-center justify-center">
            <span className="material-symbols-outlined text-amber-500/60">
              account_circle
            </span>
          </div>
        </div>
      </div>
    </header>
  )
}
