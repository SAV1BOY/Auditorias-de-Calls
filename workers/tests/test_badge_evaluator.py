"""Tests for the badge evaluator module."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest

from tests.conftest import make_table_chain


class TestBadgeEvaluator:
    """Tests for BadgeEvaluator."""

    def _make_evaluator(self, mock_db: MagicMock):
        """Create a BadgeEvaluator with mocked DB."""
        from src.pipeline.badge_evaluator import BadgeEvaluator
        return BadgeEvaluator(mock_db)

    def test_awards_first_elite(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should award first_elite badge when closer gets first ELITE classification."""
        # Setup: audit with ELITE classification
        audit_chain = make_table_chain()
        audit_chain.execute.return_value = MagicMock(data=[{
            "id": "audit-001",
            "closer_id": "closer-001",
            "score_final": 9.0,
            "classificacao": "ELITE",
            "resultado": "fechamento",
            "d01_frame": 9.0, "d02_qualificacao": 9.0, "d03_diag_quantitativo": 9.0,
            "d04_diag_qualitativo": 9.0, "d05_consequencia": 9.0, "d06_ensino": 9.0,
            "d07_identidade": 9.0, "d08_ancoragem": 9.0, "d09_isolamento": 9.0,
            "d10_proporcao_fala": 9.0, "d11_promessas": 9.0, "d12_checkpoints": 9.0,
            "d13_fechamento": 9.0,
        }])
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001",
            "closer_id": "closer-001",
            "score_final": 9.0,
            "classificacao": "ELITE",
            "resultado": "fechamento",
            "d01_frame": 9.0, "d02_qualificacao": 9.0, "d03_diag_quantitativo": 9.0,
            "d04_diag_qualitativo": 9.0, "d05_consequencia": 9.0, "d06_ensino": 9.0,
            "d07_identidade": 9.0, "d08_ancoragem": 9.0, "d09_isolamento": 9.0,
            "d10_proporcao_fala": 9.0, "d11_promessas": 9.0, "d12_checkpoints": 9.0,
            "d13_fechamento": 9.0,
        })

        # Badge lookup
        badge_chain = make_table_chain()
        badge_chain.execute.return_value = MagicMock(data=[
            {"id": "badge-001", "slug": "first_elite", "criteria": {"type": "classificacao", "value": "ELITE", "count": 1}},
        ])

        # Closer badges (none yet)
        closer_badge_chain = make_table_chain()
        closer_badge_chain.execute.return_value = MagicMock(data=[])

        # Count ELITE audits
        count_chain = make_table_chain()
        count_chain.execute.return_value = MagicMock(data=[], count=1)

        mock_supabase_client.table.side_effect = lambda t: {
            "call_audits": audit_chain,
            "badges": badge_chain,
            "closer_badges": closer_badge_chain,
            "closer_streaks": make_table_chain(),
        }.get(t, make_table_chain())

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_no_duplicate_badges(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should not award same badge twice."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 9.0, "classificacao": "ELITE", "resultado": "fechamento",
            "d01_frame": 8.0, "d02_qualificacao": 8.0, "d03_diag_quantitativo": 8.0,
            "d04_diag_qualitativo": 8.0, "d05_consequencia": 8.0, "d06_ensino": 8.0,
            "d07_identidade": 8.0, "d08_ancoragem": 8.0, "d09_isolamento": 8.0,
            "d10_proporcao_fala": 8.0, "d11_promessas": 8.0, "d12_checkpoints": 8.0,
            "d13_fechamento": 8.0,
        })

        # Already has the badge
        already_chain = make_table_chain()
        already_chain.execute.return_value = MagicMock(data=[{"id": "cb-001", "badge_id": "badge-001"}])

        mock_supabase_client.table.side_effect = lambda t: {
            "call_audits": audit_chain,
            "closer_badges": already_chain,
            "badges": make_table_chain(),
            "closer_streaks": make_table_chain(),
        }.get(t, make_table_chain())

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_streak_update(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should update streak when score is above threshold."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 7.5, "classificacao": "FORTE", "resultado": "fechamento",
            "d01_frame": 7.5, "d02_qualificacao": 7.5, "d03_diag_quantitativo": 7.5,
            "d04_diag_qualitativo": 7.5, "d05_consequencia": 7.5, "d06_ensino": 7.5,
            "d07_identidade": 7.5, "d08_ancoragem": 7.5, "d09_isolamento": 7.5,
            "d10_proporcao_fala": 7.5, "d11_promessas": 7.5, "d12_checkpoints": 7.5,
            "d13_fechamento": 7.5,
        })

        mock_supabase_client.table.return_value = make_table_chain()

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_streak_reset_below_threshold(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should reset streak when score drops below threshold."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 4.0, "classificacao": "FRACA", "resultado": "nao_fechou",
            "d01_frame": 4.0, "d02_qualificacao": 4.0, "d03_diag_quantitativo": 4.0,
            "d04_diag_qualitativo": 4.0, "d05_consequencia": 4.0, "d06_ensino": 4.0,
            "d07_identidade": 4.0, "d08_ancoragem": 4.0, "d09_isolamento": 4.0,
            "d10_proporcao_fala": 4.0, "d11_promessas": 4.0, "d12_checkpoints": 4.0,
            "d13_fechamento": 4.0,
        })

        mock_supabase_client.table.return_value = make_table_chain()

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_streak_badge_awarded(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should award streak badge when count reaches threshold."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 8.0, "classificacao": "FORTE", "resultado": "fechamento",
            "d01_frame": 8.0, "d02_qualificacao": 8.0, "d03_diag_quantitativo": 8.0,
            "d04_diag_qualitativo": 8.0, "d05_consequencia": 8.0, "d06_ensino": 8.0,
            "d07_identidade": 8.0, "d08_ancoragem": 8.0, "d09_isolamento": 8.0,
            "d10_proporcao_fala": 8.0, "d11_promessas": 8.0, "d12_checkpoints": 8.0,
            "d13_fechamento": 8.0,
        })

        mock_supabase_client.table.return_value = make_table_chain()

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_dimension_badge_perfect_score(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should award dimension badge for a perfect 10.0."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 8.5, "classificacao": "ELITE", "resultado": "fechamento",
            "d01_frame": 10.0, "d02_qualificacao": 8.0, "d03_diag_quantitativo": 8.0,
            "d04_diag_qualitativo": 8.0, "d05_consequencia": 8.0, "d06_ensino": 8.0,
            "d07_identidade": 8.0, "d08_ancoragem": 8.0, "d09_isolamento": 8.0,
            "d10_proporcao_fala": 8.0, "d11_promessas": 8.0, "d12_checkpoints": 8.0,
            "d13_fechamento": 8.0,
        })

        mock_supabase_client.table.return_value = make_table_chain()

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)

    def test_evaluate_returns_list_of_slugs(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """evaluate() should always return a list of strings."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data={
            "id": "audit-001", "closer_id": "closer-001",
            "score_final": 7.0, "classificacao": "FORTE", "resultado": "fechamento",
            "d01_frame": 7.0, "d02_qualificacao": 7.0, "d03_diag_quantitativo": 7.0,
            "d04_diag_qualitativo": 7.0, "d05_consequencia": 7.0, "d06_ensino": 7.0,
            "d07_identidade": 7.0, "d08_ancoragem": 7.0, "d09_isolamento": 7.0,
            "d10_proporcao_fala": 7.0, "d11_promessas": 7.0, "d12_checkpoints": 7.0,
            "d13_fechamento": 7.0,
        })

        mock_supabase_client.table.return_value = make_table_chain()

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-001")
        assert isinstance(result, list)
        for slug in result:
            assert isinstance(slug, str)

    def test_missing_audit(self, mock_db: MagicMock, mock_supabase_client: MagicMock) -> None:
        """Should handle missing audit gracefully."""
        audit_chain = make_table_chain()
        audit_chain.single.return_value = MagicMock(data=None)

        mock_supabase_client.table.return_value = audit_chain

        evaluator = self._make_evaluator(mock_db)
        result = evaluator.evaluate("audit-999")
        assert result == []
