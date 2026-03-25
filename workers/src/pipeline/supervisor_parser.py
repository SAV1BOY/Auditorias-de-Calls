"""Parser for supervisor analysis JSON output from Claude."""

from __future__ import annotations

import json
import logging
from typing import Any

from src.pipeline.supervisor_models import (
    DetectedObjection,
    NegotiationResult,
    SupervisorAnalysisResult,
    SupervisorStageResult,
    TrainingAction,
)

logger = logging.getLogger(__name__)


def parse_supervisor_analysis(raw_text: str) -> SupervisorAnalysisResult:
    """Parse Claude's JSON output into a SupervisorAnalysisResult.

    Args:
        raw_text: Raw text response from Claude (should be JSON).

    Returns:
        Parsed SupervisorAnalysisResult. If parsing fails, returns a result
        with raw_json populated and default values for other fields.
    """
    # Strip any markdown code fences if present
    text = raw_text.strip()
    if text.startswith("```"):
        lines = text.split("\n")
        text = "\n".join(lines[1:-1] if lines[-1].strip() == "```" else lines[1:])
        text = text.strip()

    try:
        data: dict[str, Any] = json.loads(text)
    except json.JSONDecodeError as e:
        logger.error("Failed to parse supervisor JSON: %s", e)
        return SupervisorAnalysisResult(
            raw_json={"_raw_text": raw_text, "_parse_error": str(e)},
            overall_label="Erro no parsing do JSON",
        )

    # Parse stages
    stages: list[SupervisorStageResult] = []
    for s in data.get("stages", []):
        stages.append(
            SupervisorStageResult(
                stage_key=s.get("stage_key", ""),
                stage_name=s.get("stage_name", ""),
                stage_order=s.get("stage_order", 0),
                score=float(s.get("score", 0)),
                max_score=float(s.get("max_score", 10)),
                weight=float(s.get("weight", 0)),
                status=s.get("status", "ok"),
                justification=s.get("justification", ""),
                evidence_excerpt=s.get("evidence_excerpt"),
                missed_actions=s.get("missed_actions", []),
                suggested_fix=s.get("suggested_fix", []),
            )
        )

    # Parse negotiation
    neg_data = data.get("negotiation", {})
    negotiation = NegotiationResult(
        table_price_presented=neg_data.get("table_price_presented", False),
        silence_applied=neg_data.get("silence_applied", False),
        who_spoke_first=neg_data.get("who_spoke_first", "unknown"),
        protagonist_transition_quality=float(neg_data.get("protagonist_transition_quality", 0)),
        cac_explained=neg_data.get("cac_explained", False),
        negotiation_firmness=float(neg_data.get("negotiation_firmness", 0)),
        downsell_used=neg_data.get("downsell_used", False),
        downsell_narrative_quality=(
            float(neg_data["downsell_narrative_quality"])
            if neg_data.get("downsell_narrative_quality") is not None
            else None
        ),
    )

    # Parse objections
    objections: list[DetectedObjection] = []
    for o in data.get("objections_detected", []):
        objections.append(
            DetectedObjection(
                type=o.get("type", ""),
                text=o.get("text", ""),
                handled=o.get("handled", False),
                quality=o.get("quality", "poor"),
            )
        )

    # Parse training actions
    actions: list[TrainingAction] = []
    for a in data.get("training_actions", []):
        actions.append(
            TrainingAction(
                weakness_key=a.get("weakness_key", ""),
                stage_key=a.get("stage_key"),
                recommendation=a.get("recommendation", ""),
                priority=a.get("priority", "medium"),
            )
        )

    return SupervisorAnalysisResult(
        protocol_version=data.get("protocol_version", "v1.0"),
        overall_score=float(data.get("overall_score", 0)),
        overall_label=data.get("overall_label", ""),
        classification=data.get("classification", "REGULAR"),
        executive_summary=data.get("executive_summary", ""),
        stages=stages,
        negotiation=negotiation,
        objections_detected=objections,
        priority_improvements=data.get("priority_improvements", []),
        training_actions=actions,
        raw_json=data,
    )
