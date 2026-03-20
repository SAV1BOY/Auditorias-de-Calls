import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Users } from "lucide-react"

export default function ClosersPage() {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Users className="h-5 w-5" />
          Closers
        </CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-muted-foreground">
          Gestão de closers e perfis — disponível no Sprint 6.
        </p>
      </CardContent>
    </Card>
  )
}
