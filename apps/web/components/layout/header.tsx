"use client"

import { usePathname } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Sheet, SheetContent, SheetTrigger, SheetTitle } from "@/components/ui/sheet"
import { Menu } from "lucide-react"
import { Sidebar } from "./sidebar"

const pageTitles: Record<string, string> = {
  "/": "Dashboard",
  "/calls": "Calls",
  "/calls/upload": "Upload de Call",
  "/closers": "Closers",
  "/analytics": "Analytics",
  "/settings": "Configurações",
}

export function Header() {
  const pathname = usePathname()

  const title =
    pageTitles[pathname] ??
    Object.entries(pageTitles).find(([path]) =>
      pathname.startsWith(path) && path !== "/"
    )?.[1] ??
    "CallAudit"

  return (
    <header className="flex h-14 items-center gap-4 border-b bg-card px-4 lg:px-6">
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="ghost" size="icon" className="lg:hidden">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-64 p-0">
          <SheetTitle className="sr-only">Menu de navegação</SheetTitle>
          <Sidebar />
        </SheetContent>
      </Sheet>

      <h1 className="text-lg font-semibold">{title}</h1>
    </header>
  )
}
