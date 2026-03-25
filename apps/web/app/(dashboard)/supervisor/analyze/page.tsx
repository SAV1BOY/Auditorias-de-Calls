import { createClient } from "@/lib/supabase/server"
import { AnalyzeForm } from "@/components/supervisor/analyze-form"

async function getTranscribedCalls() {
  const supabase = await createClient()
  const { data } = await supabase
    .from("call_audits")
    .select("id, lead_name, call_date, status, closers(name)")
    .in("status", ["completed", "analyzed"])
    .order("call_date", { ascending: false })
    .limit(50)

  return (data ?? []).map((row) => ({
    id: row.id,
    lead_name: row.lead_name,
    closer_name: (row.closers as { name: string } | null)?.name ?? "—",
    call_date: row.call_date,
    status: row.status,
  }))
}

export default async function SupervisorAnalyzePage() {
  const calls = await getTranscribedCalls()

  return (
    <div className="space-y-8 max-w-2xl mx-auto">
      <header>
        <h1 className="font-headline text-3xl font-bold tracking-tight mb-2">
          Nova <span className="text-[#ffa600]">ANÁLISE</span>
        </h1>
        <p className="text-[#d8c3ac]">
          Selecione uma call já transcrita para gerar a análise do supervisor.
        </p>
      </header>

      <AnalyzeForm calls={calls} />
    </div>
  )
}
