import { Sidebar } from "@/components/layout/sidebar"
import { Header } from "@/components/layout/header"
import { FooterInstitutional } from "@/components/layout/footer-institutional"

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="flex h-screen">
      {/* Desktop sidebar */}
      <aside className="hidden w-64 lg:block">
        <Sidebar className="h-full" />
      </aside>

      {/* Main content */}
      <div className="flex flex-1 flex-col overflow-hidden">
        <Header />
        <main className="flex-1 overflow-auto p-4 lg:p-6">{children}</main>
        <FooterInstitutional />
      </div>
    </div>
  )
}
