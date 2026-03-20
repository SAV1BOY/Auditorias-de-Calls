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
        <span className="text-sm">Supabase</span>
        <Badge
          variant="secondary"
          className={
            status.supabase
              ? "bg-emerald-100 text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300"
              : "bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400"
          }
        >
          {status.supabase ? "Configurado" : "Não configurado"}
        </Badge>
      </div>

      <div className="flex items-center justify-between">
        <span className="text-sm">Google Drive</span>
        <Badge
          variant="secondary"
          className={
            status.googleDrive
              ? "bg-emerald-100 text-emerald-700 dark:bg-emerald-900 dark:text-emerald-300"
              : "bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400"
          }
        >
          {status.googleDrive ? "Configurado" : "Não configurado"}
        </Badge>
      </div>

      {WORKER_APIS.map((api) => (
        <div key={api.key} className="flex items-center justify-between">
          <span className="text-sm">{api.name}</span>
          <Badge
            variant="secondary"
            className="bg-amber-100 text-amber-700 dark:bg-amber-900 dark:text-amber-300"
          >
            Configurado no Worker
          </Badge>
        </div>
      ))}
    </div>
  )
}
