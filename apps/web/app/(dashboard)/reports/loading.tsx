import { Card, CardContent } from "@/components/ui/card"

export default function ReportsLoading() {
  return (
    <div className="space-y-6">
      <div>
        <div className="h-8 w-56 rounded bg-muted animate-pulse" />
        <div className="mt-2 h-4 w-96 rounded bg-muted animate-pulse" />
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {[1, 2, 3].map((i) => (
          <Card key={i}>
            <CardContent className="p-4 space-y-3">
              <div className="h-4 w-3/4 rounded bg-muted animate-pulse" />
              <div className="grid grid-cols-3 gap-2">
                {[1, 2, 3].map((j) => (
                  <div key={j} className="text-center space-y-1">
                    <div className="h-8 w-12 mx-auto rounded bg-muted animate-pulse" />
                    <div className="h-3 w-16 mx-auto rounded bg-muted animate-pulse" />
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
