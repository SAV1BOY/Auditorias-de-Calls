import { Badge } from "@/components/ui/badge"

interface ApiStatusCardProps {
  status: {
    supabase: boolean
    googleDrive: boolean
  }
}

const WORKER_APIS = [
  { name: "WhatsApp (Evolution API)", key: "evolution" },
  { name: "Email (Resend)", key: "resend" },
  { name: "OpenAI (Whisper)", key: "openai" },
  { name: "Anthropic (Claude)", key: "anthropic" },
]

export function ApiStatusCard({ status }: ApiStatusCardProps) {
  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between">
        <span className="text-sm font-technical">Supabase</span>
        <Badge
          variant="secondary"
          className={
            status.supabase
              ? "bg-emerald-900/30 text-emerald-400"
              : "bg-surface-interaction text-muted-foreground"
          }
        >
          {status.supabase ? "Configurado" : "N\u00e3o configurado"}
        </Badge>
      </div>

      <div className="flex items-center justify-between">
        <span className="text-sm font-technical">Google Drive</span>
        <Badge
          variant="secondary"
          className={
            status.googleDrive
              ? "bg-emerald-900/30 text-emerald-400"
              : "bg-surface-interaction text-muted-foreground"
          }
        >
          {status.googleDrive ? "Configurado" : "N\u00e3o configurado"}
        </Badge>
      </div>

      {WORKER_APIS.map((api) => (
        <div key={api.key} className="flex items-center justify-between">
          <span className="text-sm font-technical">{api.name}</span>
          <Badge
            variant="secondary"
            className="bg-amber-900/30 text-amber-400"
          >
            Configurado no Worker
          </Badge>
        </div>
      ))}
    </div>
  )
}
