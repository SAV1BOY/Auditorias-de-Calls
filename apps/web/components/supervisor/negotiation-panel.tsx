import type { NegotiationAnalysis } from "@/lib/types/supervisor"

interface NegotiationPanelProps {
  negotiation: NegotiationAnalysis
}

function BoolIndicator({ value, label }: { value: boolean; label: string }) {
  return (
    <div className="bg-[#121316]/50 rounded-lg p-3 flex items-center justify-between">
      <span className="text-sm text-[#d8c3ac]">{label}</span>
      <span className={`material-symbols-outlined text-lg ${value ? "text-emerald-500" : "text-red-500"}`}>
        {value ? "check_circle" : "cancel"}
      </span>
    </div>
  )
}

function ScoreIndicator({ value, label, max = 10 }: { value: number; label: string; max?: number }) {
  const pct = (value / max) * 100
  return (
    <div className="bg-[#121316]/50 rounded-lg p-3 space-y-2">
      <div className="flex items-center justify-between">
        <span className="text-sm text-[#d8c3ac]">{label}</span>
        <span className={`font-headline font-bold ${value >= 7 ? "text-emerald-500" : value >= 5 ? "text-[#ffa600]" : "text-red-500"}`}>
          {value.toFixed(1)}
        </span>
      </div>
      <div className="h-1 bg-[#343538] rounded-full overflow-hidden">
        <div
          className={`h-full rounded-full ${value >= 7 ? "bg-emerald-500" : value >= 5 ? "bg-[#ffa600]" : "bg-red-500"}`}
          style={{ width: `${pct}%` }}
        />
      </div>
    </div>
  )
}

export function NegotiationPanel({ negotiation }: NegotiationPanelProps) {
  return (
    <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6">
      <h3 className="font-headline font-bold text-sm mb-4">
        Negotiation <span className="text-[#ffa600]">ANALYSIS</span>
      </h3>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        <BoolIndicator value={negotiation.table_price_presented} label="Preço de Tabela" />
        <BoolIndicator value={negotiation.silence_applied} label="Silêncio Aplicado" />
        <BoolIndicator value={negotiation.cac_explained} label="CAC Explicado" />
        <BoolIndicator value={negotiation.downsell_used} label="Down Sell Usado" />

        <div className="bg-[#121316]/50 rounded-lg p-3 flex items-center justify-between">
          <span className="text-sm text-[#d8c3ac]">Quem Falou Primeiro</span>
          <span className={`font-headline font-bold text-sm uppercase ${
            negotiation.who_spoke_first === "lead" ? "text-emerald-500" : "text-red-500"
          }`}>
            {negotiation.who_spoke_first === "closer" ? "Closer" : negotiation.who_spoke_first === "lead" ? "Lead" : "—"}
          </span>
        </div>

        <ScoreIndicator value={negotiation.protagonist_transition_quality} label="Transição Protagonista" />
        <ScoreIndicator value={negotiation.negotiation_firmness} label="Firmeza Negociação" />
        {negotiation.downsell_narrative_quality !== null && (
          <ScoreIndicator value={negotiation.downsell_narrative_quality} label="Narrativa Down Sell" />
        )}
      </div>
    </div>
  )
}
