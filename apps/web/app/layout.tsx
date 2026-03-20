import type { Metadata } from "next"
import "./globals.css"

export const metadata: Metadata = {
  title: "CallAudit — Auditoria de Calls",
  description:
    "Sistema de auditoria automática de calls de fechamento high ticket",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="pt-BR">
      <body className="font-sans antialiased">{children}</body>
    </html>
  )
}
