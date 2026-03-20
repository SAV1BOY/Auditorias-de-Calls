"""Data models for the analysis pipeline."""

from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class AnalysisResult:
    """Parsed result from Claude's analysis of a call transcription.

    Attributes:
        raw_text: Full markdown report from Claude.
        score_final: Weighted average score (0-10).
        classificacao: Classification (ELITE, FORTE, MEDIANA, FRACA).
        dimensions: Dict mapping dimension keys (d01_frame..d13_fechamento) to scores.
        top_erros: List of top errors found in the call.
        top_acertos: List of top wins found in the call.
        plano_acao: List of action plan recommendations.
        frases_proibidas: List of flagged dangerous promises.
        reescrita_falas: List of rewritten critical moments.
        mapa_frameworks: Dict mapping framework names to their analysis.
        tokens_input: Number of input tokens used in the API call.
        tokens_output: Number of output tokens used in the API call.
    """

    raw_text: str
    score_final: float
    classificacao: str
    dimensions: dict[str, float] = field(default_factory=dict)
    top_erros: list[dict] = field(default_factory=list)
    top_acertos: list[dict] = field(default_factory=list)
    plano_acao: list[dict] = field(default_factory=list)
    frases_proibidas: list[dict] = field(default_factory=list)
    reescrita_falas: list[dict] = field(default_factory=list)
    mapa_frameworks: dict = field(default_factory=dict)
    tokens_input: int = 0
    tokens_output: int = 0
