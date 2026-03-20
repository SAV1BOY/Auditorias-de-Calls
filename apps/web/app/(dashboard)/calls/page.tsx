import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Phone } from "lucide-react"

export default function CallsPage() {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Phone className="h-5 w-5" />
          Lista de Calls
        </CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-muted-foreground">
          Lista de calls com filtros e paginação — disponível no Sprint 4.
        </p>
      </CardContent>
    </Card>
  )
}
