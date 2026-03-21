import { Card, CardContent } from "@/components/ui/card"

export default function LibraryLoading() {
  return (
    <div className="space-y-6">
      <div>
        <div className="h-8 w-64 rounded bg-muted animate-pulse" />
        <div className="mt-2 h-4 w-80 rounded bg-muted animate-pulse" />
      </div>

      <div className="flex gap-3">
        {[1, 2, 3].map((i) => (
          <div key={i} className="h-9 w-[180px] rounded bg-muted animate-pulse" />
        ))}
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {[1, 2, 3, 4, 5, 6].map((i) => (
          <Card key={i}>
            <CardContent className="p-4 space-y-3">
              <div className="h-5 w-3/4 rounded bg-muted animate-pulse" />
              <div className="h-4 w-1/2 rounded bg-muted animate-pulse" />
              <div className="flex gap-1">
                <div className="h-5 w-20 rounded bg-muted animate-pulse" />
                <div className="h-5 w-16 rounded bg-muted animate-pulse" />
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
