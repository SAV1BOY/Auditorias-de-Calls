"use client"

import { useTransition } from "react"
import { useToast } from "@/components/ui/use-toast"
import { updateWebhookConfig } from "@/lib/actions/settings"

interface WebhookConfigProps {
  config: {
    url: string
    api_key: string
    enabled: boolean
  }
}

export function WebhookConfig({ config }: WebhookConfigProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const result = await updateWebhookConfig(formData)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({ title: "Webhook configurado" })
      }
    })
  }

  return (
    <form action={handleSubmit} className="space-y-4">
      <div className="space-y-2">
        <label className="font-label text-[10px] uppercase tracking-widest font-bold text-stone-500">
          URL do Webhook (HTTPS)
        </label>
        <input
          name="webhook_url"
          type="url"
          defaultValue={config.url}
          placeholder="https://seu-crm.com/webhooks/callaudit"
          className="w-full bg-surface-container-high border border-transparent rounded-lg px-4 py-3 text-sm font-body focus:border-primary/30 focus:ring-1 focus:ring-ring focus:outline-none"
        />
      </div>

      <div className="space-y-2">
        <label className="font-label text-[10px] uppercase tracking-widest font-bold text-stone-500">
          API Key (opcional)
        </label>
        <input
          name="webhook_api_key"
          type="password"
          defaultValue={config.api_key}
          placeholder="Chave de autenticacao do CRM"
          className="w-full bg-surface-container-high border border-transparent rounded-lg px-4 py-3 text-sm font-body focus:border-primary/30 focus:ring-1 focus:ring-ring focus:outline-none"
        />
      </div>

      <div className="flex items-center gap-3">
        <input
          name="webhook_enabled"
          type="checkbox"
          value="true"
          defaultChecked={config.enabled}
          className="h-4 w-4 rounded border-stone-600 bg-surface-container-high text-primary-container focus:ring-ring"
        />
        <label className="text-sm font-body">Webhook habilitado</label>
      </div>

      <button
        type="submit"
        disabled={isPending}
        className="bg-[#ffa600] text-[#2a1800] px-4 py-2 rounded-lg text-xs font-bold tracking-widest uppercase hover:brightness-110 transition-all disabled:opacity-50"
      >
        {isPending ? "Salvando..." : "Salvar Webhook"}
      </button>
    </form>
  )
}
