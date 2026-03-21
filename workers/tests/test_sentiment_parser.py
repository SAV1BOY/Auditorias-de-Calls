"""Tests for sentiment parsing functions in the parser module."""

from __future__ import annotations

import pytest

from src.pipeline.parser import parse_sentiment, parse_objections


SAMPLE_SENTIMENT_SECTION = """
## 10. ANÁLISE DE SENTIMENTO DO LEAD

### Sentimento Geral
- **Sentimento:** positivo
- **Score de Sentimento:** 0,65
- **Nível de Engajamento:** alto

### Timeline de Sentimento
| Trecho | Sentimento | Confiança (0-1) | Momento-Chave |
|--------|-----------|-----------------|---------------|
| 00:00-05:00 | neutro | 0,8 | Abertura da call |
| 05:00-15:00 | positivo | 0,7 | Engajamento no diagnóstico |
| 15:00-25:00 | negativo | 0,6 | Objeção de preço |

### Objeções Detectadas
1. **Timestamp:** 15:30 | **Objeção:** "Está muito caro" | **Resposta do Closer:** "Entendo, vamos comparar" | **Efetividade:** boa
2. **Timestamp:** 22:00 | **Objeção:** "Preciso pensar" | **Resposta do Closer:** "Claro, quando pode?" | **Efetividade:** ruim
"""


class TestParseSentiment:
    """Tests for parse_sentiment function."""

    def test_parse_overall_sentiment(self) -> None:
        """Should extract overall sentiment correctly."""
        result = parse_sentiment(SAMPLE_SENTIMENT_SECTION)
        assert result["sentiment_overall"] == "positive"

    def test_parse_sentiment_score(self) -> None:
        """Should extract sentiment score with comma decimal."""
        result = parse_sentiment(SAMPLE_SENTIMENT_SECTION)
        assert abs(result["sentiment_score"] - 0.65) < 0.01

    def test_parse_engagement_level(self) -> None:
        """Should extract engagement level."""
        result = parse_sentiment(SAMPLE_SENTIMENT_SECTION)
        assert result["engagement_level"] == "high"

    def test_parse_timeline(self) -> None:
        """Should extract timeline entries."""
        result = parse_sentiment(SAMPLE_SENTIMENT_SECTION)
        timeline = result["sentiment_timeline"]
        assert len(timeline) == 3
        assert timeline[0]["sentiment"] == "neutral"
        assert timeline[1]["sentiment"] == "positive"
        assert timeline[2]["sentiment"] == "negative"

    def test_missing_section_returns_defaults(self) -> None:
        """Should return defaults when section 10 is missing."""
        result = parse_sentiment("## 1. SCORECARD\nJust a scorecard here.")
        assert result["sentiment_overall"] == "neutral"
        assert result["sentiment_score"] == 0.0
        assert result["engagement_level"] == "medium"
        assert result["sentiment_timeline"] == []

    def test_malformed_section(self) -> None:
        """Should handle malformed section gracefully."""
        text = "## 10. ANÁLISE DE SENTIMENTO DO LEAD\n\nSome garbled text without proper format."
        result = parse_sentiment(text)
        assert result["sentiment_overall"] == "neutral"
        assert result["sentiment_timeline"] == []


class TestParseObjections:
    """Tests for parse_objections function."""

    def test_parse_objections_count(self) -> None:
        """Should extract correct number of objections."""
        result = parse_objections(SAMPLE_SENTIMENT_SECTION)
        assert len(result) == 2

    def test_parse_objection_fields(self) -> None:
        """Should extract all fields from an objection."""
        result = parse_objections(SAMPLE_SENTIMENT_SECTION)
        obj = result[0]
        assert "15:30" in obj["timestamp"]
        assert "caro" in obj["objection"].lower()
        assert obj["effectiveness"] == "good"

    def test_parse_poor_effectiveness(self) -> None:
        """Should correctly parse 'ruim' as 'poor'."""
        result = parse_objections(SAMPLE_SENTIMENT_SECTION)
        assert result[1]["effectiveness"] == "poor"

    def test_no_objections_section(self) -> None:
        """Should return empty list when no objections section."""
        result = parse_objections("## 1. SCORECARD\nNo objections here.")
        assert result == []

    def test_empty_text(self) -> None:
        """Should return empty list for empty text."""
        result = parse_objections("")
        assert result == []
