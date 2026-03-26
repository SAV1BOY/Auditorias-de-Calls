"use client"

import dynamic from "next/dynamic"

const ShaderAnimation = dynamic(
  () => import("@/components/ui/shader-animation").then((mod) => ({ default: mod.ShaderAnimation })),
  { ssr: false, loading: () => <div className="fixed inset-0 bg-black" /> }
)

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="relative h-screen w-screen overflow-hidden bg-black">
      {/* Shader background — fixed fullscreen */}
      <div className="fixed inset-0 z-0 h-screen w-screen">
        <ShaderAnimation />
      </div>
      {/* Login panel overlay */}
      <div className="relative z-10 flex h-screen w-screen items-center justify-center">
        {children}
      </div>
    </div>
  )
}
