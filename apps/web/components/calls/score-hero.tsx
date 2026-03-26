interface ScoreHeroProps {
  score: number
  classificacao: string
  mediaAnterior?: number
}

const CLASSIFICATION_COLORS: Record<string, string> = {
  ELITE: "text-emerald-500",
  FORTE: "text-[#ffa600]",
  MEDIANA: "text-amber-400",
  FRACA: "text-red-500",
}

export function ScoreHero({ score, classificacao, mediaAnterior }: ScoreHeroProps) {
  const diff = mediaAnterior ? score - mediaAnterior : null

  return (
    <div className="bg-surface-container-high/40 p-8 rounded-xl border border-white/5 backdrop-blur-md">
      <span className="font-label text-xs tracking-[0.2em] text-stone-500 uppercase">
        Score Final Ponderado
      </span>
      <div className="flex items-baseline gap-2 mt-2">
        <span className="text-6xl font-headline font-bold text-[#ffa600]">
          {score.toFixed(1)}
        </span>
        <span className="text-2xl font-headline font-bold text-[#ffa600]/50">/10</span>
      </div>
      <div
        className={`text-2xl font-headline font-bold mt-2 ${
          CLASSIFICATION_COLORS[classificacao] || "text-on-surface"
        }`}
      >
        CALL {classificacao}
      </div>
      {diff !== null && (
        <div
          className={`flex items-center gap-2 mt-4 text-sm ${
            diff >= 0 ? "text-emerald-500" : "text-red-500"
          }`}
        >
          <span className="material-symbols-outlined text-sm">
            {diff >= 0 ? "trending_up" : "trending_down"}
          </span>
          <span className="font-bold">
            {diff >= 0 ? "+" : ""}
            {diff.toFixed(1)} vs média do closer
          </span>
        </div>
      )}
    </div>
  )
}
