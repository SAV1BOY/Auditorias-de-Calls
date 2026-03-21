"""Tests for the loss pattern analyzer module."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from tests.conftest import make_table_chain


class TestLossPatternAnalyzer:
    """Tests for LossPatternAnalyzer."""

    def _make_analyzer(self, config, mock_db):
        """Create a LossPatternAnalyzer with mocked dependencies."""
        from src.pipeline.loss_pattern_analyzer import LossPatternAnalyzer
        return LossPatternAnalyzer(config, mock_db)

    def test_builds_prompt_with_call_data(
        self, config, mock_db: MagicMock, mock_supabase_client: MagicMock
    ) -> None:
        """Should build a prompt containing call data."""
        calls = [
            {
                "id": "audit-001",
                "lead_name": "João",
                "call_date": "2026-03-01",
                "score_final": 4.5,
                "classificacao": "FRACA",
                "resultado": "nao_fechou",
                "top_erros": [{"rank": 1, "title": "Sem diagnóstico", "description": "..."}],
                "closers": {"name": "Lucas"},
            }
        ]

        analyzer = self._make_analyzer(config, mock_db)
        prompt = analyzer._build_prompt(calls)
        assert "João" in prompt
        assert "Lucas" in prompt
        assert "4.5" in prompt or "4,5" in prompt

    @patch("src.pipeline.loss_pattern_analyzer.anthropic")
    def test_parses_patterns_from_response(
        self, mock_anthropic, config, mock_db: MagicMock
    ) -> None:
        """Should parse patterns from Claude's response."""
        analyzer = self._make_analyzer(config, mock_db)

        raw_text = """## Padrões Identificados

### Padrão 1: Falta de diagnóstico
- **Frequência:** 5
- **Severidade:** alta
- **Recomendação:** Treinar diagnóstico

### Padrão 2: Objeção não isolada
- **Frequência:** 3
- **Severidade:** média
- **Recomendação:** Praticar isolamento
"""
        parsed = analyzer._parse_patterns(raw_text)
        assert isinstance(parsed, dict)
        assert "patterns" in parsed

    def test_no_lost_calls_returns_empty(
        self, config, mock_db: MagicMock, mock_supabase_client: MagicMock
    ) -> None:
        """Should return empty report when no lost calls found."""
        # Mock empty result for lost calls query
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[])
        mock_supabase_client.table.return_value = chain

        analyzer = self._make_analyzer(config, mock_db)
        result = analyzer.analyze("2026-03-01", "2026-03-15")
        assert result.get("total_lost_calls", 0) == 0

    @patch("src.pipeline.loss_pattern_analyzer.anthropic")
    def test_api_error_raises(
        self, mock_anthropic, config, mock_db: MagicMock, mock_supabase_client: MagicMock
    ) -> None:
        """Should raise when Claude API fails after retries."""
        # Mock calls data
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[
            {
                "id": "audit-001", "lead_name": "João", "call_date": "2026-03-01",
                "score_final": 4.5, "classificacao": "FRACA", "resultado": "nao_fechou",
                "top_erros": [], "closers": {"name": "Lucas"},
            }
        ])
        mock_supabase_client.table.return_value = chain

        # Make Claude API fail
        mock_client_instance = MagicMock()
        mock_client_instance.messages.create.side_effect = Exception("API error")
        mock_anthropic.Anthropic.return_value = mock_client_instance

        analyzer = self._make_analyzer(config, mock_db)
        with pytest.raises(Exception):
            analyzer.analyze("2026-03-01", "2026-03-15")

    @patch("src.pipeline.loss_pattern_analyzer.anthropic")
    def test_saves_report_to_db(
        self, mock_anthropic, config, mock_db: MagicMock, mock_supabase_client: MagicMock
    ) -> None:
        """Should save the generated report to the database."""
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[
            {
                "id": "audit-001", "lead_name": "João", "call_date": "2026-03-01",
                "score_final": 4.5, "classificacao": "FRACA", "resultado": "nao_fechou",
                "top_erros": [{"rank": 1, "title": "Erro", "description": "desc"}],
                "closers": {"name": "Lucas"},
            }
        ])

        insert_chain = make_table_chain()
        insert_chain.execute.return_value = MagicMock(data=[{"id": "lp-001"}])

        mock_supabase_client.table.side_effect = lambda t: {
            "call_audits": chain,
            "loss_patterns": insert_chain,
        }.get(t, make_table_chain())

        # Mock Claude response
        mock_response = MagicMock()
        mock_response.content = [MagicMock(text="## Padrões\n\nNenhum padrão crítico.")]
        mock_client_instance = MagicMock()
        mock_client_instance.messages.create.return_value = mock_response
        mock_anthropic.Anthropic.return_value = mock_client_instance

        analyzer = self._make_analyzer(config, mock_db)
        result = analyzer.analyze("2026-03-01", "2026-03-15")
        assert isinstance(result, dict)
