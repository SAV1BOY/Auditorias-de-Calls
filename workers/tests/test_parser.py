"""Tests for the analysis parser module."""

from __future__ import annotations

import pytest

from src.pipeline.models import AnalysisResult
from src.pipeline.parser import (
    DIMENSION_KEYS,
    DIMENSION_WEIGHTS,
    _classify,
    _normalize_decimal,
    calculate_weighted_score,
    parse_analysis,
    parse_dimensions,
    parse_frases_proibidas,
    parse_mapa_frameworks,
    parse_plano_acao,
    parse_reescrita_falas,
    parse_score_final,
    parse_top_items,
)
from src.pipeline.whatsapp import generate_whatsapp_summary


class TestNormalizeDecimal:
    """Tests for decimal normalization (comma vs dot)."""

    def test_normalize_dot(self) -> None:
        assert _normalize_decimal("6.8") == 6.8

    def test_normalize_comma(self) -> None:
        assert _normalize_decimal("6,8") == 6.8

    def test_normalize_with_spaces(self) -> None:
        assert _normalize_decimal(" 7,5 ") == 7.5


class TestClassify:
    """Tests for classification thresholds."""

    def test_elite(self) -> None:
        assert _classify(8.5) == "ELITE"
        assert _classify(10.0) == "ELITE"

    def test_forte(self) -> None:
        assert _classify(7.0) == "FORTE"
        assert _classify(8.4) == "FORTE"

    def test_mediana(self) -> None:
        assert _classify(5.5) == "MEDIANA"
        assert _classify(6.9) == "MEDIANA"

    def test_fraca(self) -> None:
        assert _classify(5.4) == "FRACA"
        assert _classify(0.0) == "FRACA"


class TestParseScoreFinal:
    """Tests for score and classification extraction."""

    def test_parse_score_from_standard_format(self) -> None:
        """Extract score from the standard SCORE FINAL line."""
        text = "**SCORE FINAL: 6,8/10 — CALL MEDIANA**"
        score, classificacao = parse_score_final(text)
        assert score == 6.8
        assert classificacao == "MEDIANA"

    def test_parse_score_with_dot_separator(self) -> None:
        """Extract score with dot decimal separator."""
        text = "**SCORE FINAL: 7.2/10 — CALL FORTE**"
        score, classificacao = parse_score_final(text)
        assert score == 7.2
        assert classificacao == "FORTE"

    def test_parse_score_elite(self) -> None:
        text = "**SCORE FINAL: 9,0/10 — CALL DE ELITE**"
        score, classificacao = parse_score_final(text)
        assert score == 9.0
        assert classificacao == "ELITE"

    def test_parse_score_fraca(self) -> None:
        text = "SCORE FINAL: 4,2/10 — FRACA"
        score, classificacao = parse_score_final(text)
        assert score == 4.2
        assert classificacao == "FRACA"

    def test_parse_score_fallback_when_no_standard_line(self) -> None:
        """Fallback extraction from scattered text."""
        text = "O score final ficou em 7,5/10. A call foi FORTE."
        score, classificacao = parse_score_final(text)
        assert score == 7.5
        assert classificacao == "FORTE"

    def test_parse_score_returns_default_on_empty(self) -> None:
        score, classificacao = parse_score_final("")
        assert score == 0.0
        assert classificacao == "FRACA"


class TestParseDimensions:
    """Tests for scorecard dimension extraction."""

    def test_parse_13_dimensions_from_table(self, sample_analysis_report: str) -> None:
        """Extract all 13 dimension scores from the fixture."""
        dimensions = parse_dimensions(sample_analysis_report)
        assert len(dimensions) == 13
        for key in DIMENSION_KEYS.values():
            assert key in dimensions, f"Missing dimension: {key}"
            assert 0 <= dimensions[key] <= 10, f"Invalid score for {key}: {dimensions[key]}"

    def test_parse_specific_dimension_values(self, sample_analysis_report: str) -> None:
        """Verify specific dimension values from the fixture."""
        dimensions = parse_dimensions(sample_analysis_report)
        assert dimensions["d01_frame"] == 8.5
        assert dimensions["d03_diag_quantitativo"] == 4.0
        assert dimensions["d09_isolamento"] == 9.0

    def test_parse_dimensions_empty_on_missing_table(self) -> None:
        """Return empty dict when no scorecard table found."""
        dimensions = parse_dimensions("No scorecard here.")
        assert dimensions == {}

    def test_parse_handles_malformed_table(self) -> None:
        """Gracefully handle malformed table rows."""
        text = """## 2. SCORECARD
| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|---|---|---|---|---|
| 1 | Frame | 8% | 8,0 | 0,64 | evidence |
| bad row here |
| 3 | Diag Quant | 12% | 5,5 | 0,66 | evidence |
"""
        dimensions = parse_dimensions(text)
        assert dimensions.get("d01_frame") == 8.0
        assert dimensions.get("d03_diag_quantitativo") == 5.5
        # Malformed row skipped, partial results returned


class TestParseTopItems:
    """Tests for top errors and wins extraction."""

    def test_parse_top_erros(self, sample_analysis_report: str) -> None:
        """Extract top errors with severity."""
        erros = parse_top_items(sample_analysis_report, "TOP 5 ERROS")
        assert len(erros) >= 1
        assert erros[0]["title"]
        assert "severity" in erros[0]  # Should have severity tag

    def test_parse_top_acertos(self, sample_analysis_report: str) -> None:
        """Extract top wins."""
        acertos = parse_top_items(sample_analysis_report, "TOP 5 ACERTOS")
        assert len(acertos) >= 1
        assert acertos[0]["title"]

    def test_parse_top_items_empty_section(self) -> None:
        """Return empty list when section not found."""
        result = parse_top_items("No such section", "TOP 5 ERROS")
        assert result == []


class TestParsePlanoAcao:
    """Tests for action plan extraction."""

    def test_parse_plano_acao(self, sample_analysis_report: str) -> None:
        """Extract action plan recommendations."""
        plano = parse_plano_acao(sample_analysis_report)
        assert len(plano) >= 1
        first = plano[0]
        assert "title" in first
        assert "prioridade" in first

    def test_parse_plano_acao_empty(self) -> None:
        result = parse_plano_acao("No action plan here.")
        assert result == []


class TestParseFrasesProibidas:
    """Tests for prohibited phrases extraction."""

    def test_parse_frases_proibidas(self, sample_analysis_report: str) -> None:
        """Extract flagged phrases from the fixture."""
        frases = parse_frases_proibidas(sample_analysis_report)
        assert isinstance(frases, list)
        # The fixture has 3 promise alerts
        assert len(frases) >= 1

    def test_parse_frases_proibidas_empty(self) -> None:
        result = parse_frases_proibidas("No alerts here.")
        assert result == []


class TestParseReescritaFalas:
    """Tests for critical moments rewrite extraction."""

    def test_parse_reescrita_falas(self, sample_analysis_report: str) -> None:
        """Extract rewritten moments from the fixture."""
        reescrita = parse_reescrita_falas(sample_analysis_report)
        assert len(reescrita) >= 1
        first = reescrita[0]
        assert "original" in first
        assert "rewritten" in first

    def test_parse_reescrita_empty(self) -> None:
        result = parse_reescrita_falas("No rewrite section.")
        assert result == []


class TestParseMapaFrameworks:
    """Tests for frameworks map extraction."""

    def test_parse_mapa_frameworks(self, sample_analysis_report: str) -> None:
        """Extract frameworks map from the fixture."""
        frameworks = parse_mapa_frameworks(sample_analysis_report)
        assert len(frameworks) >= 1
        # Check a specific framework
        for name, data in frameworks.items():
            assert "score" in data
            assert 0 <= data["score"] <= 10

    def test_parse_mapa_frameworks_empty(self) -> None:
        result = parse_mapa_frameworks("No framework map.")
        assert result == {}


class TestParseHandlesEdgeCases:
    """Tests for parser robustness."""

    def test_parse_handles_missing_sections(self) -> None:
        """Missing sections return empty collections, no crash."""
        text = "**SCORE FINAL: 7,0/10 — FORTE**\nSome text without proper sections."
        result = parse_analysis(text, tokens_input=100, tokens_output=50)
        assert result.score_final == 7.0
        assert result.classificacao == "FORTE"
        assert result.top_erros == []
        assert result.top_acertos == []
        assert result.plano_acao == []
        assert result.frases_proibidas == []
        assert result.reescrita_falas == []
        assert result.mapa_frameworks == {}

    def test_parse_completely_empty_text(self) -> None:
        """Empty text returns zero defaults."""
        result = parse_analysis("", tokens_input=0, tokens_output=0)
        assert result.score_final == 0.0
        assert result.classificacao == "FRACA"
        assert result.dimensions == {}


class TestCalculateWeightedScore:
    """Tests for weighted score calculation."""

    def test_calculate_weighted_score(self) -> None:
        """Verify weighted average calculation."""
        # All dimensions at 10.0 should give 10.0
        dims = {k: 10.0 for k in DIMENSION_WEIGHTS}
        assert calculate_weighted_score(dims) == 10.0

    def test_calculate_weighted_score_empty(self) -> None:
        assert calculate_weighted_score({}) == 0.0


class TestScoreCrossCheck:
    """Tests for score cross-validation in parse_analysis."""

    def test_score_matches_weighted_average(self, sample_analysis_report: str) -> None:
        """Parsed score should be within 0.5 of calculated weighted average."""
        result = parse_analysis(sample_analysis_report, 15000, 8000)
        if result.dimensions:
            calculated = calculate_weighted_score(result.dimensions)
            assert abs(result.score_final - calculated) <= 0.5


class TestWhatsAppSummary:
    """Tests for WhatsApp summary generation."""

    def test_whatsapp_summary_length(self, sample_analysis_report: str) -> None:
        """Generated summary is ≤1000 characters."""
        result = parse_analysis(sample_analysis_report, 15000, 8000)
        metadata = {
            "closer_name": "Evelyn",
            "lead_name": "Elane Lima",
            "call_date": "2026-03-02",
            "duration_minutes": 164.0,
        }
        summary = generate_whatsapp_summary(result, metadata)
        assert len(summary) <= 1000

    def test_whatsapp_summary_contains_key_info(self, sample_analysis_report: str) -> None:
        """Summary contains score, names, and classification."""
        result = parse_analysis(sample_analysis_report, 15000, 8000)
        metadata = {
            "closer_name": "Evelyn",
            "lead_name": "Elane Lima",
            "call_date": "2026-03-02",
            "duration_minutes": 164.0,
        }
        summary = generate_whatsapp_summary(result, metadata)
        assert "Evelyn" in summary
        assert "Elane" in summary
        assert "MEDIANA" in summary or str(result.score_final) in summary


class TestParseFullFixture:
    """Integration test using the complete sample fixture."""

    def test_parse_sample_analysis(self, sample_analysis_report: str) -> None:
        """Full integration test against the Elane fixture."""
        result = parse_analysis(sample_analysis_report, 15000, 8000)

        # Score and classification
        assert 6.0 <= result.score_final <= 7.5
        assert result.classificacao in ("MEDIANA", "FORTE")

        # 13 dimensions
        assert len(result.dimensions) == 13

        # Structured sections populated
        assert len(result.top_erros) >= 1
        assert len(result.top_acertos) >= 1
        assert len(result.plano_acao) >= 1
        assert len(result.reescrita_falas) >= 1

        # Tokens preserved
        assert result.tokens_input == 15000
        assert result.tokens_output == 8000
