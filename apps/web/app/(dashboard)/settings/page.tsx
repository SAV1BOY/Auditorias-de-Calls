import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Bell, Settings, ShieldAlert, Wifi } from "lucide-react"
import { getNotificationConfig, getApiStatus, getDimensionWeights, getWebhookConfig } from "@/lib/actions/settings"
import { NotificationConfigForm } from "@/components/settings/notification-config-form"
import { ApiStatusCard } from "@/components/settings/api-status-card"
import { DimensionWeightsEditor } from "@/components/settings/dimension-weights-editor"
import { WebhookConfig } from "@/components/settings/webhook-config"
import { UserList } from "@/components/settings/user-list"
import { listUsers } from "@/lib/actions/users"
import { requireRole } from "@/lib/auth/require-role"

export default async function SettingsPage() {
  let config
  let apiStatus
  let dimensionWeights
  let webhookConfig
  let isAdmin = false
  let users: Awaited<ReturnType<typeof listUsers>> = []

  try {
    const ctx = await requireRole(["admin", "supervisor"])
    isAdmin = ctx.role === "admin"

    const promises: Promise<unknown>[] = [
      getNotificationConfig(),
      getApiStatus(),
      getDimensionWeights(),
      getWebhookConfig(),
    ]

    if (isAdmin) {
      promises.push(listUsers())
    }

    const results = await Promise.all(promises)
    config = results[0] as Awaited<ReturnType<typeof getNotificationConfig>>
    apiStatus = results[1] as Awaited<ReturnType<typeof getApiStatus>>
    dimensionWeights = results[2] as Awaited<ReturnType<typeof getDimensionWeights>>
    webhookConfig = results[3] as Awaited<ReturnType<typeof getWebhookConfig>>
    if (isAdmin && results[4]) {
      users = results[4] as Awaited<ReturnType<typeof listUsers>>
    }
  } catch {
    return (
      <div className="space-y-6">
        <h1 className="flex items-center gap-2 text-2xl font-bold font-headline">
          <Settings className="h-6 w-6 text-primary" />
          <span className="amber-keyword">Configura\u00e7\u00f5es</span>
        </h1>
        <div className="py-16 text-center text-muted-foreground">
          <ShieldAlert className="mx-auto h-12 w-12 mb-3 opacity-20" />
          <p>Sem permiss\u00e3o para acessar configura\u00e7\u00f5es.</p>
          <p className="text-sm mt-1">
            Solicite acesso ao administrador do sistema.
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <h1 className="flex items-center gap-2 text-2xl font-bold font-headline">
        <Settings className="h-6 w-6 text-primary" />
        <span className="amber-keyword">Configura\u00e7\u00f5es</span>
      </h1>

      {/* User Management — Admin Only */}
      {isAdmin && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <span className="material-symbols-outlined text-primary text-lg">manage_accounts</span>
              Gest\u00e3o de Usu\u00e1rios
            </CardTitle>
          </CardHeader>
          <CardContent>
            <UserList users={users} />
          </CardContent>
        </Card>
      )}

      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <Bell className="h-4 w-4 text-primary" />
              Destinat\u00e1rios de Notifica\u00e7\u00f5es
            </CardTitle>
          </CardHeader>
          <CardContent>
            <NotificationConfigForm config={config} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <Wifi className="h-4 w-4 text-primary" />
              Status das Integra\u00e7\u00f5es
            </CardTitle>
          </CardHeader>
          <CardContent>
            <ApiStatusCard status={apiStatus} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <span className="material-symbols-outlined text-primary text-lg">tune</span>
              Pesos das Dimens\u00f5es (Scorecard)
            </CardTitle>
          </CardHeader>
          <CardContent>
            <DimensionWeightsEditor weights={dimensionWeights} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-base">
              <span className="material-symbols-outlined text-primary text-lg">webhook</span>
              Webhook CRM
            </CardTitle>
          </CardHeader>
          <CardContent>
            <WebhookConfig config={webhookConfig} />
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
