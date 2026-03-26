"use client"

export default function Loading() {
  return (
    <div className="space-y-8 animate-pulse">
      <div className="space-y-3 max-w-lg">
        <div className="h-8 bg-[#292a2d] rounded-lg w-3/4" />
        <div className="h-4 bg-[#292a2d] rounded w-full" />
      </div>
      <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8 space-y-4">
        <div className="h-4 bg-[#292a2d] rounded w-1/3" />
        <div className="h-10 bg-[#292a2d] rounded w-full" />
        <div className="h-10 bg-[#292a2d] rounded w-full" />
        <div className="h-10 bg-[#292a2d] rounded w-2/3" />
      </div>
    </div>
  )
}

