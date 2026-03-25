export default function SupervisorLoading() {
  return (
    <div className="space-y-8 animate-pulse">
      {/* Hero skeleton */}
      <div className="space-y-3 max-w-lg">
        <div className="h-12 bg-[#292a2d] rounded-lg w-3/4" />
        <div className="h-5 bg-[#292a2d] rounded w-full" />
      </div>

      {/* KPI Cards skeleton */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6 space-y-4">
            <div className="h-12 w-12 bg-[#292a2d] rounded-xl" />
            <div className="h-3 bg-[#292a2d] rounded w-1/2" />
            <div className="h-8 bg-[#292a2d] rounded w-1/3" />
          </div>
        ))}
      </div>

      {/* Chart skeleton */}
      <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-8">
        <div className="h-5 bg-[#292a2d] rounded w-1/4 mb-6" />
        <div className="h-64 bg-[#292a2d]/50 rounded" />
      </div>
    </div>
  )
}
