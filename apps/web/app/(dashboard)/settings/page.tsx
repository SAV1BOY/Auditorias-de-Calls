import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Bell, Settings, Wifi } from "lucide-react"
import { getNotificationConfig, getApiStatus } from "@/lib/actions/settings"
import { NotificationConfigForm } from "@/components/settings/notification-config-form"
import { ApiStatusCard } from "@/components/settings/api-status-card"

export default async function SettingsPage() {
  const [config, apiStatus] = await Promise.all([
    getNotificationConfig(),
    getApiStatus(),
  ])

  return (
    <div className="space-y-6">
      <h1 className="flex items-center gap-2 text-2xl font-bold">
        <Settings className="h-6 w-6" />
        Configurações
      </h1>

      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <Bell className="h-4 w-4" />
              Destinatários de Notificações
            </CardTitle>
          </CardHeader>
          <CardContent>
            <NotificationConfigForm config={config} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <Wifi className="h-4 w-4" />
              Status das Integrações
            </CardTitle>
          </CardHeader>
          <CardContent>
            <ApiStatusCard status={apiStatus} />
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
