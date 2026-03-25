import type { Metadata } from "next"
import { Plus_Jakarta_Sans, Manrope } from "next/font/google"
import { Toaster } from "@/components/ui/toaster"
import "./globals.css"

const plusJakarta = Plus_Jakarta_Sans({
  subsets: ["latin"],
  variable: "--font-plus-jakarta",
  weight: ["400", "500", "600", "700"],
  display: "swap",
})

const manrope = Manrope({
  subsets: ["latin"],
  variable: "--font-manrope",
  weight: ["400", "500", "600", "700"],
  display: "swap",
})

export const metadata: Metadata = {
  title: "CallAudit \u2014 Auditoria de Calls",
  description:
    "Sistema de auditoria autom\u00e1tica de calls de fechamento high ticket",
  themeColor: "#121316",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="pt-BR" className="dark">
      <body
        className={`${plusJakarta.variable} ${manrope.variable} font-technical antialiased`}
      >
        <div className="content-above-overlays min-h-screen">
          {children}
        </div>
        <Toaster />
      </body>
    </html>
  )
}
