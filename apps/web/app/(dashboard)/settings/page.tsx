import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Bell, Settings, ShieldAlert, Wifi } from "lucide-react"
import { getNotificationConfig, getApiStatus, getDimensionWeights, getWebhookConfig } from "@/lib/actions/settings"
import { NotificationConfigForm } from "@/components/settings/notification-config-form"
import { ApiStatusCard } from "@/components/settings/api-status-card"
import { DimensionWeightsEditor } from "@/components/settings/dimension-weights-editor"
import { WebhookConfig } from "@/components/settings/webhook-config"

export default async function SettingsPage() {
  let config
  let apiStatus
  let dimensionWeights
  let webhookConfig

  try {
    ;[config, apiStatus, dimensionWeights, webhookConfig] = await Promise.all([
      getNotificationConfig(),
      getApiStatus(),
      getDimensionWeights(),
      getWebhookConfig(),
    ])
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
