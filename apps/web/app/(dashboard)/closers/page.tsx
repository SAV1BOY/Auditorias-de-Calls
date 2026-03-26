import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Users } from "lucide-react"
import { getClosersList } from "@/lib/actions/closers"
import { CloserList } from "@/components/closers/closer-list"
import { CloserPageActions } from "@/components/closers/closer-page-actions"
import { requireAuth } from "@/lib/auth/require-role"

export default async function ClosersPage() {
  const [closers, ctx] = await Promise.all([getClosersList(), requireAuth()])
  const isAdmin = ctx.role === "admin"

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="flex items-center gap-2 text-2xl font-bold">
          <Users className="h-6 w-6" />
          Closers
        </h1>
        <CloserPageActions />
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">
            {closers.length} closer{closers.length !== 1 ? "s" : ""} cadastrado
            {closers.length !== 1 ? "s" : ""}
          </CardTitle>
        </CardHeader>
        <CardContent>
          <CloserList closers={closers} isAdmin={isAdmin} />
        </CardContent>
      </Card>
    </div>
  )
}
