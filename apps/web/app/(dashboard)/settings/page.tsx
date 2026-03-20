import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Settings } from "lucide-react"

export default function SettingsPage() {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Settings className="h-5 w-5" />
          Configurações
        </CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-muted-foreground">
          Configurações do sistema — disponível no Sprint 6.
        </p>
      </CardContent>
    </Card>
  )
}
