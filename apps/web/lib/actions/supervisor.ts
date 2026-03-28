"use server"

import { createClient } from "@/lib/supabase/server"
import { requireRole, requireAuth } from "@/lib/auth/require-role"

import type {
  SupervisorAnalysis,
  SupervisorDashboardStats,
  SupervisorStageScore,
  ProtocolRule,
  TrainingAction,
  NegotiationAnalysis,
} from "@/lib/types/supervisor"

// ─── Row mapper: DB row → SupervisorAnalysis ───

function mapRowToAnalysis(row: Record<string, unknown>, stages: SupervisorStageScore[] = []): SupervisorAnalysis {
  return {
    ...(row as Record<string, unknown>),
    stages,
    negotiation: {
      table_price_presented: (row.table_price_presented as boolean) ?? false,
      silence_applied: (row.silence_applied as boolean) ?? false,
      who_spoke_first: (row.who_spoke_first as string) ?? "unknown",
      protagonist_transition_quality: (row.protagonist_transition_quality as number) ?? 0,
      cac_explained: (row.cac_explained as boolean) ?? false,
      negotiation_firmness: (row.negotiation_firmness as number) ?? 0,
      downsell_used: (row.downsell_used as boolean) ?? false,
      downsell_narrative_quality: row.downsell_narrative_quality as number | undefined,
    } as NegotiationAnalysis,
    priority_improvements: ((row.priority_improvements ?? []) as unknown[]),
    training_actions: ((row.training_actions ?? []) as SupervisorAnalysis["training_actions"]),
    objections_detected: ((row.objections_detected ?? []) as SupervisorAnalysis["objections_detected"]),
  } as SupervisorAnalysis
}
