"""Supervisor analysis pipeline step.

Evaluates call transcriptions against the System Digital protocol
(16 stages) using Claude API. Runs in parallel with the standard
13-dimension analysis.
"""

from __future__ import annotations

import json
import logging
from typing import Any

import anthropic
from tenacity import retry, stop_after_attempt, wait_exponential

from src.config import Config
from src.db import DB
from src.pipeline.supervisor_models import SupervisorAnalysisResult
from src.pipeline.supervisor_parser import parse_supervisor_analysis
from src.prompts.supervisor_prompt import SUPERVISOR_SYSTEM_PROMPT, SUPERVISOR_PROMPT_VERSION

logger = logging.getLogger(__name__)

MODEL = "claude-sonnet-4-20250514"
MAX_TOKENS = 16000

# Anthropic pricing (Claude Sonnet 4): input $3/MTok, output $15/MTok
COST_INPUT_PER_MTOK = 3.0
COST_OUTPUT_PER_MTOK = 15.0


class SupervisorAnalyzer:
    """Handles supervisor protocol analysis via Anthropic Claude API."""

    def __init__(self, config: Config, db: DB) -> None:
        """Initialize the supervisor analyzer.

        Args:
            config: Application configuration.
            db: Database wrapper.
        """
        self._config = config
        self._db = db
        self._client = anthropic.Anthropic(api_key=config.anthropic_api_key)

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=2, min=4, max=30),
    )
    def _call_claude(self, transcription: str, protocol_context: str) -> tuple[str, int, int]:
        """Call Claude API with the supervisor prompt.

        Args:
            transcription: Full call transcription text.
            protocol_context: Protocol rules formatted as context.

        Returns:
            Tuple of (response_text, input_tokens, output_tokens).
        """
        user_message = (
            f"## PROTOCOLO ATIVO\n\n{protocol_context}\n\n"
            f"## TRANSCRIÇÃO DA CALL\n\n{transcription}"
        )

        response = self._client.messages.create(
            model=MODEL,
            max_tokens=MAX_TOKENS,
            system=SUPERVISOR_SYSTEM_PROMPT,
            messages=[{"role": "user", "content": user_message}],
        )

        text = response.content[0].text if response.content else ""
        input_tokens = response.usage.input_tokens
        output_tokens = response.usage.output_tokens

        return text, input_tokens, output_tokens

    def _build_protocol_context(self, audit_id: str) -> str:
        """Build protocol context string from protocol_rules table.

        Args:
            audit_id: The audit ID (used to get organization_id).

        Returns:
            Formatted protocol context string.
        """
        # Fetch protocol rules (org-specific or global defaults)
        rows = self._db.client.table("protocol_rules").select("*").eq(
            "is_active", True
        ).order("stage_order").execute()

        if not rows.data:
            return "Protocolo padrão System Digital v1.0 (16 etapas conforme system prompt)"

        lines = ["### Etapas do Protocolo\n"]
        for rule in rows.data:
            expected = json.loads(rule["expected_behaviors"]) if isinstance(rule["expected_behaviors"], str) else rule["expected_behaviors"]
            failure = json.loads(rule["failure_behaviors"]) if isinstance(rule["failure_behaviors"], str) else rule["failure_behaviors"]
            lines.append(
                f"**{rule['stage_order']}. {rule['stage_name']}** "
                f"(stage_key: {rule['stage_key']}, peso: {rule['scoring_weight']})\n"
                f"  Esperado: {', '.join(expected)}\n"
                f"  Falha: {', '.join(failure)}\n"
            )

        # Fetch negotiation rules if available
        neg_rows = self._db.client.table("negotiation_rules").select("*").limit(1).execute()
        if neg_rows.data:
            neg = neg_rows.data[0]
            lines.append("\n### Regras de Negociação\n")
            if neg.get("max_discount_pct"):
                lines.append(f"- Desconto máximo: {neg['max_discount_pct']}%")
            if neg.get("max_installments"):
                lines.append(f"- Parcelas máximas: {neg['max_installments']}")
            if neg.get("what_is_good_negotiation"):
                lines.append(f"- Boa negociação: {neg['what_is_good_negotiation']}")
            if neg.get("what_is_good_downsell"):
                lines.append(f"- Bom down sell: {neg['what_is_good_downsell']}")

        return "\n".join(lines)

    def analyze(self, audit_id: str) -> SupervisorAnalysisResult | None:
        """Run supervisor analysis for a call audit.

        Args:
            audit_id: UUID of the call_audits record.

        Returns:
            SupervisorAnalysisResult if successful, None if transcription missing.
        """
        # 1. Fetch transcription
        try:
            audit = self._db.client.table("call_audits").select(
                "id, transcricao, organization_id, closer_id"
        ).eq("id", audit_id).single().execute()
        except Exception as e:
            logger.error("Failed to fetch audit %s: %s", audit_id, e)
            return None

        if not audit.data or not audit.data.get("transcricao"):
            logger.warning("No transcription found for audit %s", audit_id)
            return None

        transcription = audit.data["transcricao"]
        org_id = audit.data.get("organization_id")
        closer_id = audit.data.get("closer_id")

        # 2. Build protocol context
        protocol_context = self._build_protocol_context(audit_id)

        # 3. Call Claude
        logger.info("Starting supervisor analysis for audit %s", audit_id)
        raw_text, input_tokens, output_tokens = self._call_claude(
            transcription, protocol_context
        )

        # 4. Parse result
        result = parse_supervisor_analysis(raw_text)
        result.tokens_input = input_tokens
        result.tokens_output = output_tokens

        # 5. Calculate cost
        cost = (
            (input_tokens / 1_000_000) * COST_INPUT_PER_MTOK
            + (output_tokens / 1_000_000) * COST_OUTPUT_PER_MTOK
        )

        # 5b. Check for parse errors before saving
        if isinstance(result.raw_json, dict) and "_parse_error" in result.raw_json:
            logger.error(
                "Supervisor analysis parse error for audit %s: %s",
                audit_id, result.raw_json.get("_parse_error"),
            )
            return None  # Don't save broken analysis — job runner can retry

        if not result.stages:
            logger.error("Supervisor analysis returned 0 stages for audit %s", audit_id)
            return None

        if not result.classification:
            logger.warning("No classification for audit %s, skipping save", audit_id)
            return None

        # 6. Save supervisor_analyses
        analysis_data: dict[str, Any] = {
            "audit_id": audit_id,
            "organization_id": org_id,
            "protocol_version": result.protocol_version,
            "prompt_version": SUPERVISOR_PROMPT_VERSION,
            "overall_score": result.overall_score,
            "overall_label": result.overall_label,
            "classification": result.classification,
            "executive_summary": result.executive_summary,
            "raw_json": result.raw_json,
            "table_price_presented": result.negotiation.table_price_presented,
            "silence_applied": result.negotiation.silence_applied,
            "who_spoke_first": result.negotiation.who_spoke_first,
            "protagonist_transition_quality": result.negotiation.protagonist_transition_quality,
            "cac_explained": result.negotiation.cac_explained,
            "negotiation_firmness": result.negotiation.negotiation_firmness,
            "downsell_used": result.negotiation.downsell_used,
            "downsell_narrative_quality": result.negotiation.downsell_narrative_quality,
            "priority_improvements": result.priority_improvements,
            "training_actions": [
                {"weakness_key": a.weakness_key, "stage_key": a.stage_key,
                 "recommendation": a.recommendation, "priority": a.priority}
                for a in result.training_actions
            ],
            "objections_detected": [
                {"type": o.type, "text": o.text, "handled": o.handled, "quality": o.quality}
                for o in result.objections_detected
            ],
            "modelo_analise": MODEL,
            "tokens_input": input_tokens,
            "tokens_output": output_tokens,
            "custo_estimado": round(cost, 4),
        }

        insert_result = self._db.client.table("supervisor_analyses").insert(
            analysis_data
        ).execute()

        if not insert_result.data:
            logger.error("Failed to save supervisor analysis for audit %s", audit_id)
            return result

        analysis_id = insert_result.data[0]["id"]

        # 7. Save stage scores
        stage_rows = []
        for stage in result.stages:
            stage_rows.append({
                "analysis_id": analysis_id,
                "stage_key": stage.stage_key,
                "stage_name": stage.stage_name,
                "stage_order": stage.stage_order,
                "score": stage.score,
                "max_score": stage.max_score,
                "weight": stage.weight,
                "status": stage.status,
                "justification": stage.justification,
                "evidence_excerpt": stage.evidence_excerpt,
                "missed_actions": stage.missed_actions,
                "suggested_fix": stage.suggested_fix,
            })

        if stage_rows:
            self._db.client.table("supervisor_stage_scores").insert(stage_rows).execute()

        # 8. Generate training actions for stages with score < 6
        if closer_id:
            training_rows = []
            for action in result.training_actions:
                training_rows.append({
                    "closer_id": closer_id,
                    "source_analysis_id": analysis_id,
                    "weakness_key": action.weakness_key,
                    "stage_key": action.stage_key,
                    "recommendation": action.recommendation,
                    "priority": action.priority,
                    "status": "pending",
                })
            if training_rows:
                self._db.client.table("closer_training_actions").insert(
                    training_rows
                ).execute()

        logger.info(
            "Supervisor analysis complete for audit %s: score=%.1f, classification=%s",
            audit_id, result.overall_score, result.classification,
        )

        return result
