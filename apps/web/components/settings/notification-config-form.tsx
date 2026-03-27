"use client"

import { useTransition } from "react"
import { Button } from "@/components/ui/button"
import { Label } from "@/components/ui/label"
import { useToast } from "@/components/ui/use-toast"
import { updateNotificationConfig } from "@/lib/actions/settings"

interface NotificationConfigFormProps {
  config: {
    whatsapp_numbers: string[]
    email_addresses: string[]
  }
}

export function NotificationConfigForm({
  config,
}: NotificationConfigFormProps) {
  const [isPending, startTransition] = useTransition()
  const { toast } = useToast()

  function handleSubmit(formData: FormData) {
    startTransition(async () => {
      const result = await updateNotificationConfig(formData)
      if (result.error) {
        toast({
          title: "Erro",
          description: result.error,
          variant: "destructive",
        })
      } else {
        toast({ title: "Configurações salvas" })
      }
    })
  }

  return (
    <form action={handleSubmit} className="space-y-4">
      <div className="space-y-2">
        <Label htmlFor="whatsapp_numbers">
          Números WhatsApp (um por linha)
        </Label>
        <textarea
          id="whatsapp_numbers"
          name="whatsapp_numbers"
          className="flex min-h-[80px] w-full rounded-md border border-transparent bg-surface-container-high px-3 py-2 text-sm font-body ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 transition-all duration-200"
          placeholder={"5511999999999\n5521988888888"}
          defaultValue={config.whatsapp_numbers.join("\n")}
        />
      </div>
      <div className="space-y-2">
        <Label htmlFor="email_addresses">
          Endereços de Email (um por linha)
        </Label>
        <textarea
          id="email_addresses"
          name="email_addresses"
          className="flex min-h-[80px] w-full rounded-md border border-transparent bg-surface-container-high px-3 py-2 text-sm font-body ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 transition-all duration-200"
          placeholder={"supervisor@empresa.com\ngestor@empresa.com"}
          defaultValue={config.email_addresses.join("\n")}
        />
      </div>
      <Button type="submit" disabled={isPending}>
        {isPending ? "Salvando..." : "Salvar Configurações"}
      </Button>
    </form>
  )
}
