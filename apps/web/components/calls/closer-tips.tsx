import type { CallAuditWithCloser } from "@/lib/types/audit"

interface TopItem { rank: number; title: string; description: string }
interface ReescritaItem { description?: string; original?: string; rewritten?: string; reason?: string; impact?: string }
interface PlanoItem { rank?: number; title?: string; o_que_fazer?: string; por_que?: string; como_treinar?: string; prioridade?: string }

function getClassBadge(classificacao: string | null): { label: string; color: string } {
  switch (classificacao) {
    case "ELITE": return { label: "ELITE", color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" }
    case "FORTE": return { label: "FORTE", color: "bg-[#ffa600]/10 text-[#ffa600] border-[#ffa600]/20" }
    case "MEDIANA": return { label: "MEDIANA", color: "bg-amber-400/10 text-amber-400 border-amber-400/20" }
    case "FRACA": return { label: "FRACA", color: "bg-red-500/10 text-red-400 border-red-500/20" }
    default: return { label: "—", color: "bg-stone-500/10 text-stone-400 border-stone-500/20" }
  }
}

export function CloserTips({ audit }: { audit: CallAuditWithCloser }) {
  const raw = audit as unknown as Record<string, unknown>
  const topErros = (raw.top_erros ?? []) as TopItem[]
  const topAcertos = (raw.top_acertos ?? []) as TopItem[]
  const reescritaFalas = (raw.reescrita_falas ?? []) as ReescritaItem[]
  const planoAcao = (raw.plano_acao ?? []) as PlanoItem[]
  const scoreFinal = audit.score_final
  const classificacao = audit.classificacao
  const engagement = (raw.engagement_level as string) ?? null

  const hasData = topErros.length > 0 || topAcertos.length > 0 || reescritaFalas.length > 0

  if (!hasData) {
    return (
      <div className="py-12 text-center space-y-3">
        <span className="material-symbols-outlined text-4xl text-stone-600 block">lightbulb</span>
        <p className="text-stone-500">Dicas estarão disponíveis após a análise ser concluída.</p>
      </div>
    )
  }

  const topErro = topErros[0]
  const topAcerto = topAcertos[0]
  const topReescrita = reescritaFalas[0]
  const topPlano = planoAcao[0]
  const badge = getClassBadge(classificacao)

  return (
    <div className="space-y-5">
      {/* Header */}
      <div className="flex items-center gap-3 mb-2">
        <span className="material-symbols-outlined text-[#ffa600] text-2xl">psychology</span>
        <div>
          <h3 className="font-headline font-bold text-lg">Coach Pessoal</h3>
          <p className="text-[10px] text-stone-500 uppercase tracking-widest">Leitura de 3 minutos</p>
        </div>
      </div>

      {/* Block 1: Alavanca #1 */}
      {(topErro || topPlano) && (
        <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] p-5">
          <div className="flex items-center gap-2 mb-3">
            <span className="material-symbols-outlined text-[#ffa600] text-lg">target</span>
            <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-[#ffa600]">Alavanca #1</span>
          </div>
          {topErro && (
            <div className="mb-3">
              <p className="font-bold text-sm text-white mb-1">{topErro.title}</p>
              <p className="text-sm text-[#d8c3ac] leading-relaxed">{topErro.description}</p>
            </div>
          )}
          {topPlano && (
            <div className="bg-[#ffa600]/5 rounded-lg p-3 border border-[#ffa600]/10">
              <p className="text-[10px] font-bold uppercase tracking-widest text-[#ffa600] mb-1">O que fazer</p>
              <p className="text-sm text-[#d8c3ac]">{topPlano.o_que_fazer || topPlano.title}</p>
              {topPlano.como_treinar && (
                <p className="text-xs text-stone-500 mt-1">Treino: {topPlano.como_treinar}</p>
              )}
            </div>
          )}
        </div>
      )}

      {/* Block 2: O que você dominou */}
      {topAcerto && (
        <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] p-5">
          <div className="flex items-center gap-2 mb-3">
            <span className="material-symbols-outlined text-emerald-400 text-lg">check_circle</span>
            <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-emerald-400">O que você dominou</span>
          </div>
          <p className="font-bold text-sm text-white mb-1">{topAcerto.title}</p>
          <p className="text-sm text-[#d8c3ac] leading-relaxed">{topAcerto.description}</p>
        </div>
      )}

      {/* Block 3: Swap de Script */}
      {topReescrita && (
        <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] p-5">
          <div className="flex items-center gap-2 mb-3">
            <span className="material-symbols-outlined text-blue-400 text-lg">swap_horiz</span>
            <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-blue-400">Swap de Script</span>
          </div>
          <div className="grid gap-3 md:grid-cols-2">
            {topReescrita.original && (
              <div className="bg-red-500/5 rounded-lg p-3 border border-red-500/10">
                <p className="text-[9px] font-bold uppercase tracking-widest text-red-400 mb-1">O que foi dito</p>
                <p className="text-sm text-stone-300 italic">&ldquo;{topReescrita.original}&rdquo;</p>
              </div>
            )}
            {topReescrita.rewritten && (
              <div className="bg-emerald-500/5 rounded-lg p-3 border border-emerald-500/10">
                <p className="text-[9px] font-bold uppercase tracking-widest text-emerald-400 mb-1">O que deveria ter sido dito</p>
                <p className="text-sm text-stone-300 italic">&ldquo;{topReescrita.rewritten}&rdquo;</p>
              </div>
            )}
          </div>
          {topReescrita.reason && (
            <p className="text-xs text-stone-500 mt-2">Por quê: {topReescrita.reason}</p>
          )}
        </div>
      )}

      {/* Block 4: Trend / Score */}
      <div className="bg-[#1a1c1e]/85 backdrop-blur-sm rounded-xl border border-white/[0.08] p-5">
        <div className="flex items-center gap-2 mb-3">
          <span className="material-symbols-outlined text-[#ffa600] text-lg">trending_up</span>
          <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-[#ffa600]">Seu resultado</span>
        </div>
        <div className="flex items-center gap-4">
          <div className="text-center">
            <span className="text-3xl font-headline font-bold text-[#ffa600]">
              {scoreFinal?.toFixed(1) ?? "—"}
            </span>
            <span className="text-sm text-stone-500 font-headline">/10</span>
          </div>
          {classificacao && (
            <span className={`px-3 py-1 rounded-full border text-xs font-bold uppercase ${badge.color}`}>
              {badge.label}
            </span>
          )}
          {engagement && (
            <span className="text-xs text-stone-500">
              Engajamento: <span className="text-[#d8c3ac] capitalize">{engagement}</span>
            </span>
          )}
        </div>
      </div>

      {/* Privacy badge */}
      <div className="flex items-center gap-2 text-[10px] text-stone-600">
        <span className="material-symbols-outlined text-sm">lock</span>
        Visível apenas para você — seus dados são privados.
      </div>
    </div>
  )
}
