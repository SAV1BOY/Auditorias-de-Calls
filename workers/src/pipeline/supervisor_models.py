"""Data models for the supervisor analysis pipeline."""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class SupervisorStageResult:
    """Result for a single stage evaluation."""

    stage_key: str
    stage_name: str
    stage_order: int
    score: float
    max_score: float = 10.0
    weight: float = 0.0
    status: str = "ok"  # excellent, ok, warning, critical, skipped
    justification: str = ""
    evidence_excerpt: str | None = None
    missed_actions: list[str] = field(default_factory=list)
    suggested_fix: list[str] = field(default_factory=list)


@dataclass
class NegotiationResult:
    """Result for the negotiation evaluation."""

    table_price_presented: bool = False
    silence_applied: bool = False
    who_spoke_first: str = "unknown"  # closer, lead, unknown
    protagonist_transition_quality: float = 0.0
    cac_explained: bool = False
    negotiation_firmness: float = 0.0
    downsell_used: bool = False
    downsell_narrative_quality: float | None = None


@dataclass
class DetectedObjection:
    """An objection detected during the call."""

    type: str = ""
    text: str = ""
    handled: bool = False
    quality: str = "poor"  # good, poor


@dataclass
class TrainingAction:
    """A recommended training action for the closer."""

    weakness_key: str = ""
    stage_key: str | None = None
    recommendation: str = ""
    priority: str = "medium"  # high, medium, low


@dataclass
class SupervisorAnalysisResult:
    """Parsed result from Claude's supervisor analysis.

    Attributes:
        protocol_version: Version of the protocol used.
        overall_score: Weighted average score (0-10).
        overall_label: Short label describing the call quality.
        classification: EXCELENTE, BOA, REGULAR, FRACA, CRITICA.
        executive_summary: 3-6 line summary of the analysis.
        stages: List of stage evaluations (16 stages).
        negotiation: Negotiation evaluation details.
        objections_detected: List of objections found.
        priority_improvements: List of top improvement areas.
        training_actions: List of recommended training actions.
        raw_json: The complete JSON output from Claude.
        tokens_input: Number of input tokens.
        tokens_output: Number of output tokens.
    """

    protocol_version: str = "v1.0"
    overall_score: float = 0.0
    overall_label: str = ""
    classification: str = "REGULAR"
    executive_summary: str = ""
    stages: list[SupervisorStageResult] = field(default_factory=list)
    negotiation: NegotiationResult = field(default_factory=NegotiationResult)
    objections_detected: list[DetectedObjection] = field(default_factory=list)
    priority_improvements: list[str] = field(default_factory=list)
    training_actions: list[TrainingAction] = field(default_factory=list)
    raw_json: dict = field(default_factory=dict)
    tokens_input: int = 0
    tokens_output: int = 0
