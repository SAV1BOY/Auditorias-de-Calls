"""Contract tests: validate parser output matches call_audits DB schema.

These tests ensure no drift between what the parser produces and
what the database expects. If a column is renamed in migrations
or added to the parser, these tests catch the mismatch.
"""

import pytest

from src.pipeline.parser import DIMENSION_KEYS, DIMENSION_WEIGHTS
from src.pipeline.loss_pattern_analyzer import DIMENSION_NAMES
from src.pipeline.badge_evaluator import DIMENSION_COLUMNS


# The canonical column names from call_audits (001_initial_schema.sql lines 56-68)
DB_DIMENSION_COLUMNS = [
    "d01_frame",
    "d02_qualificacao",
    "d03_diag_quantitativo",
    "d04_diag_qualitativo",
    "d05_consequencia",
    "d06_ensino",
    "d07_identidade",
    "d08_ancoragem",
    "d09_isolamento",
    "d10_proporcao_fala",
    "d11_promessas",
    "d12_checkpoints",
    "d13_fechamento",
]


class TestParserDBContract:
    """Verify parser DIMENSION_KEYS match DB column names."""

    def test_dimension_keys_count(self) -> None:
        assert len(DIMENSION_KEYS) == 13

    def test_dimension_keys_match_db(self) -> None:
        parser_columns = sorted(DIMENSION_KEYS.values())
        db_columns = sorted(DB_DIMENSION_COLUMNS)
        assert parser_columns == db_columns

    def test_dimension_weights_count(self) -> None:
        assert len(DIMENSION_WEIGHTS) == 13

    def test_dimension_weights_keys_match_db(self) -> None:
        weight_columns = sorted(DIMENSION_WEIGHTS.keys())
        db_columns = sorted(DB_DIMENSION_COLUMNS)
        assert weight_columns == db_columns

    def test_dimension_weights_sum_to_one(self) -> None:
        total = sum(DIMENSION_WEIGHTS.values())
        assert abs(total - 1.0) < 0.001, f"Weights sum to {total}, expected 1.0"


class TestLossPatternDBContract:
    """Verify loss_pattern_analyzer DIMENSION_NAMES match DB columns."""

    def test_dimension_names_count(self) -> None:
        assert len(DIMENSION_NAMES) == 13

    def test_dimension_names_keys_match_db(self) -> None:
        analyzer_columns = sorted(DIMENSION_NAMES.keys())
        db_columns = sorted(DB_DIMENSION_COLUMNS)
        assert analyzer_columns == db_columns


class TestBadgeEvaluatorDBContract:
    """Verify badge_evaluator DIMENSION_COLUMNS match DB columns."""

    def test_dimension_columns_count(self) -> None:
        assert len(DIMENSION_COLUMNS) == 13

    def test_dimension_columns_match_db(self) -> None:
        evaluator_columns = sorted(DIMENSION_COLUMNS)
        db_columns = sorted(DB_DIMENSION_COLUMNS)
        assert evaluator_columns == db_columns


class TestCrossModuleConsistency:
    """Verify all modules agree on the same dimension names."""

    def test_parser_and_loss_analyzer_agree(self) -> None:
        parser_set = set(DIMENSION_KEYS.values())
        analyzer_set = set(DIMENSION_NAMES.keys())
        assert parser_set == analyzer_set

    def test_parser_and_badge_evaluator_agree(self) -> None:
        parser_set = set(DIMENSION_KEYS.values())
        badge_set = set(DIMENSION_COLUMNS)
        assert parser_set == badge_set

    def test_all_three_modules_agree(self) -> None:
        parser_set = set(DIMENSION_KEYS.values())
        analyzer_set = set(DIMENSION_NAMES.keys())
        badge_set = set(DIMENSION_COLUMNS)
        assert parser_set == analyzer_set == badge_set
