import type { SupervisorAnalysis } from "@/lib/types/supervisor"
import { getSupervisorClassificationColor } from "@/lib/types/supervisor"
import { StageScoreCard } from "./stage-score-card"
import { StageTimeline } from "./stage-timeline"
import { NegotiationPanel } from "./negotiation-panel"

interface AnalysisResultProps {
  analysis: SupervisorAnalysis
}

export function AnalysisResult({ analysis }: AnalysisResultProps) {
  return (
    <div className="space-y-8">
      {/* Block 1: Header */}
      <div className="bg-[#292a2d]/40 p-8 rounded-xl border border-white/5">
        <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
          <div className="space-y-2">
            <p className="font-label text-xs tracking-[0.2em] text-stone-500 uppercase">
              Análise do Supervisor — {analysis.protocol_version}
            </p>
            <h2 className="font-headline text-2xl font-bold">
              {analysis.call_audits?.closers?.name ?? "—"} x{" "}
              <span className="text-[#ffa600]">{analysis.call_audits?.lead_name ?? "—"}</span>
            </h2>
            <p className="text-sm text-stone-400">{analysis.call_audits?.call_date ?? "—"}</p>
          </div>
          <div className="flex flex-col items-center gap-1">
            <span className="text-5xl font-headline font-bold text-[#ffa600]">
              {analysis.overall_score?.toFixed(1) ?? "—"}
            </span>
            <span className="text-sm text-stone-500 font-headline">/10</span>
            {analysis.classification && (
              <span
                className={`mt-1 px-3 py-0.5 rounded-full border text-xs font-bold uppercase ${getSupervisorClassificationColor(analysis.classification)}`}
              >
                {analysis.classification}
              </span>
            )}
          </div>
        </div>
        {analysis.overall_label && (
          <p className="mt-4 text-sm text-[#d8c3ac]">{analysis.overall_label}</p>
        )}
      </div>

      {/* Block 2: Executive Summary */}
      {analysis.executive_summary && (
        <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6">
          <h3 className="font-headline font-bold text-sm mb-3">
            Executive <span className="text-[#ffa600]">SUMMARY</span>
          </h3>
          <p className="text-sm text-[#d8c3ac] leading-relaxed whitespace-pre-line">
            {analysis.executive_summary}
          </p>
        </div>
      )}

      {/* Block 3: Timeline */}
      {analysis.stages.length > 0 && <StageTimeline stages={analysis.stages} />}

      {/* Block 4: Score per Stage */}
      {analysis.stages.length > 0 && (
        <div className="space-y-3">
          <h3 className="font-headline font-bold text-sm">
            Stage <span className="text-[#ffa600]">SCORES</span>
            <span className="text-stone-500 font-normal ml-2">({analysis.stages.length} etapas)</span>
          </h3>
          {analysis.stages
            .sort((a, b) => a.stage_order - b.stage_order)
            .map((stage) => (
              <StageScoreCard key={stage.stage_key} stage={stage} />
            ))}
        </div>
      )}

      {/* Block 5: Negotiation */}
      <NegotiationPanel negotiation={analysis.negotiation} />

      {/* Block 6: Objections */}
      {analysis.objections_detected.length > 0 && (
        <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6">
          <h3 className="font-headline font-bold text-sm mb-4">
            Detected <span className="text-[#ffa600]">OBJECTIONS</span>
          </h3>
          <div className="space-y-3">
            {analysis.objections_detected.map((obj, i) => (
              <div key={i} className="bg-[#121316]/50 rounded-lg p-3 flex items-start justify-between gap-4">
                <div className="space-y-1">
                  <p className="text-sm text-[#d8c3ac]">{`"${obj.text}"`}</p>
                  <p className="text-[10px] text-stone-500 uppercase tracking-widest">{obj.type}</p>
                </div>
                <span
                  className={`px-2 py-0.5 rounded-full border text-[10px] font-bold uppercase flex-shrink-0 ${
                    obj.handled
                      ? "bg-emerald-500/10 text-emerald-500 border-emerald-500/20"
                      : "bg-red-500/10 text-red-500 border-red-500/20"
                  }`}
                >
                  {obj.handled ? "Handled" : "Not Handled"}
                </span>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Block 7: Priority Improvements */}
      {analysis.priority_improvements.length > 0 && (
        <div className="bg-[#1a1c1e] rounded-xl border border-white/5 p-6">
          <h3 className="font-headline font-bold text-sm mb-4">
            Priority <span className="text-[#ffa600]">IMPROVEMENTS</span>
          </h3>
          <ol className="space-y-2">
            {analysis.priority_improvements.map((item, i) => (
              <li key={i} className="flex items-start gap-3 text-sm">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-[#ffa600]/10 text-[10px] font-bold text-[#ffa600]">
                  {i + 1}
                </span>
                <span className="text-[#d8c3ac]">{String(item)}</span>
              </li>
            ))}
          </ol>
        </div>
      )}
    </div>
  )
}
