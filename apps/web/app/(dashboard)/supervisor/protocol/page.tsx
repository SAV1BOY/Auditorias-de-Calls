import { getProtocolRules } from "@/lib/actions/supervisor"
import { ProtocolEditor } from "@/components/supervisor/protocol-editor"

export default async function SupervisorProtocolPage() {
  const rules = await getProtocolRules()

  return (
    <div className="space-y-8">
      <header>
        <h1 className="font-headline text-3xl font-bold tracking-tight mb-2">
          Protocol <span className="text-[#ffa600]">CONFIGURATION</span>
        </h1>
        <p className="text-[#d8c3ac]">
          Configure as 16 etapas do protocolo System Digital. Ative/desative etapas
          e visualize comportamentos esperados e de falha.
        </p>
      </header>

      <ProtocolEditor rules={rules} />
    </div>
  )
}
