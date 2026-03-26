import Link from "next/link"
import { AmberGlassButton } from "@/components/ui/amber-glass-button"

export function FloatingActionButton() {
  return (
    <div className="fixed bottom-8 right-8 z-50">
      <Link href="/calls/upload">
        <AmberGlassButton variant="icon" aria-label="Nova Auditoria" className="shadow-[0_0_30px_rgba(255,166,0,0.3)]">
          <span className="material-symbols-outlined text-3xl font-bold">add</span>
        </AmberGlassButton>
        <div className="absolute right-20 bg-[#1a1c1e] px-4 py-2 rounded-lg border border-[#ffa600]/30 opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none whitespace-nowrap">
          <span className="text-[#ffa600] text-xs font-bold tracking-widest uppercase">
            Nova Auditoria
          </span>
        </div>
      </Link>
    </div>
  )
}
