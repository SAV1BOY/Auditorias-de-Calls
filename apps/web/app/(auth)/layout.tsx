"use client"

import dynamic from "next/dynamic"

const ShaderAnimation = dynamic(
  () => import("@/components/ui/shader-animation").then((mod) => ({ default: mod.ShaderAnimation })),
  { ssr: false }
)

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="relative min-h-screen overflow-hidden">
      {/* Shader background */}
      <div className="absolute inset-0 z-0">
        <ShaderAnimation />
      </div>
      {/* Login panel overlay */}
      <div className="relative z-10 flex min-h-screen items-center justify-center">
        {children}
      </div>
    </div>
  )
}
