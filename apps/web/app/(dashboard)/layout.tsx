import { Header } from "@/components/layout/header"
import { Sidebar } from "@/components/layout/sidebar"
import { FloatingActionButton } from "@/components/layout/fab"

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <>
      <Header />
      <Sidebar />
      <main className="md:ml-64 pt-24 px-6 md:px-12 pb-28 min-h-screen max-w-7xl mx-auto">
        {children}
      </main>
      <FloatingActionButton />
      <footer className="fixed bottom-0 left-0 md:left-64 right-0 h-16 bg-[#0d0e11] flex justify-between items-center px-8 border-t border-white/5 z-40">
        <div className="flex items-center gap-8">
          <span className="font-label text-xs font-bold text-amber-500 tracking-[0.2em] uppercase">
            SYSTEM DIGITAL
          </span>
          <span className="text-[10px] font-bold text-stone-700 uppercase tracking-widest">
            CallAudit v1.0
          </span>
        </div>
        <span className="font-headline font-bold text-sm text-[#d8c3ac] tracking-tighter">
          FACE 100K
        </span>
      </footer>
    </>
  )
}
