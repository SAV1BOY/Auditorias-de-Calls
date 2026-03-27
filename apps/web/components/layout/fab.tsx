import Link from "next/link"

export function FloatingActionButton() {
  return (
    <div className="fixed bottom-8 right-8 z-50">
      <Link href="/calls/upload">
        <button aria-label="Nova Auditoria" className="w-16 h-16 bg-[#ffa600] rounded-full shadow-[0_0_30px_rgba(255,166,0,0.4)] flex items-center justify-center text-[#2a1800] hover:scale-110 transition-transform active:scale-95 group">
          <span className="material-symbols-outlined text-3xl font-bold">add</span>
        </button>
        <div className="absolute right-20 bg-[#1a1c1e] px-4 py-2 rounded-lg border border-[#ffa600]/30 opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none whitespace-nowrap">
          <span className="text-[#ffa600] text-xs font-bold tracking-widest uppercase">
            Nova Auditoria
          </span>
        </div>
      </Link>
    </div>
  )
}
