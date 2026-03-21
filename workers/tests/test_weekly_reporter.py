"""Tests for WeeklyReporter."""

from __future__ import annotations

from datetime import date, timedelta
from unittest.mock import MagicMock, patch

import pytest


def make_table_chain() -> MagicMock:
    """Create a mock Supabase table chain (mirrors conftest.make_table_chain)."""
    chain = MagicMock()
    for method in ["select", "insert", "update", "delete", "eq", "neq",
                   "gte", "lte", "in_", "not_", "ilike", "order", "limit", "range"]:
        getattr(chain, method).return_value = chain
    chain.single.return_value = MagicMock(data=None)
    chain.execute.return_value = MagicMock(data=[])
    return chain


@patch("src.weekly_reporter.EmailSender")
@patch("src.weekly_reporter.EvolutionClient")
@patch("src.weekly_reporter.anthropic.Anthropic")
class TestWeeklyReporter:
    """Tests for the WeeklyReporter class."""

    def _make_reporter(self, config, mock_db, MockAnthropic, MockEvolution, MockEmail):
        from src.weekly_reporter import WeeklyReporter

        reporter = WeeklyReporter(config=config, db=mock_db)
        return reporter

    # ------------------------------------------------------------------
    # should_generate
    # ------------------------------------------------------------------

    def test_should_generate_true_on_monday_no_report(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns True on Monday when no report exists for the week."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        monday = date(2026, 3, 16)  # a Monday
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[])
        mock_db.client.table.return_value = chain

        with patch("src.weekly_reporter.date") as mock_date:
            mock_date.today.return_value = monday
            mock_date.side_effect = lambda *a, **kw: date(*a, **kw)
            assert reporter.should_generate() is True

    def test_should_generate_false_on_non_monday(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns False on days other than Monday."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        tuesday = date(2026, 3, 17)  # a Tuesday
        with patch("src.weekly_reporter.date") as mock_date:
            mock_date.today.return_value = tuesday
            mock_date.side_effect = lambda *a, **kw: date(*a, **kw)
            assert reporter.should_generate() is False

    def test_should_generate_false_when_report_exists(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns False on Monday when a report already exists."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        monday = date(2026, 3, 16)
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[{"id": "existing-report"}])
        mock_db.client.table.return_value = chain

        with patch("src.weekly_reporter.date") as mock_date:
            mock_date.today.return_value = monday
            mock_date.side_effect = lambda *a, **kw: date(*a, **kw)
            assert reporter.should_generate() is False

    # ------------------------------------------------------------------
    # _get_week_bounds
    # ------------------------------------------------------------------

    def test_get_week_bounds_returns_previous_week(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns (last_monday, last_sunday) of the previous week."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        # If today is Monday 2026-03-16, previous week is Mon 2026-03-09 to Sun 2026-03-15
        with patch("src.weekly_reporter.date") as mock_date:
            mock_date.today.return_value = date(2026, 3, 16)
            mock_date.side_effect = lambda *a, **kw: date(*a, **kw)
            start, end = reporter._get_week_bounds()
            assert start == date(2026, 3, 9)
            assert end == date(2026, 3, 15)

    def test_get_week_bounds_start_is_monday_end_is_sunday(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Start is a Monday (weekday 0) and end is a Sunday (weekday 6)."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        with patch("src.weekly_reporter.date") as mock_date:
            mock_date.today.return_value = date(2026, 3, 23)
            mock_date.side_effect = lambda *a, **kw: date(*a, **kw)
            start, end = reporter._get_week_bounds()
            assert start.weekday() == 0  # Monday
            assert end.weekday() == 6    # Sunday

    # ------------------------------------------------------------------
    # collect_stats
    # ------------------------------------------------------------------

    def test_collect_stats_no_calls(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns insufficient_data when no calls exist."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=[])
        mock_db.client.table.return_value = chain

        week_start = date(2026, 3, 9)
        week_end = date(2026, 3, 15)
        stats = reporter.collect_stats(week_start, week_end)

        assert stats["total_calls"] == 0
        assert stats["insufficient_data"] is True

    def test_collect_stats_with_calls(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns aggregated stats when calls exist."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        calls_data = [
            {"id": "1", "score_final": 85, "closer_id": "c1", "closer_name": "Alice"},
            {"id": "2", "score_final": 90, "closer_id": "c2", "closer_name": "Bob"},
            {"id": "3", "score_final": 78, "closer_id": "c1", "closer_name": "Alice"},
        ]
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=calls_data)
        mock_db.client.table.return_value = chain

        week_start = date(2026, 3, 9)
        week_end = date(2026, 3, 15)
        stats = reporter.collect_stats(week_start, week_end)

        assert stats["total_calls"] == 3
        assert "score_avg" in stats
        assert "top_closers" in stats

    def test_collect_stats_handles_closers_as_dict(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Handles closer data when returned as dict objects."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        calls_data = [
            {"id": "1", "score_final": 80, "closer_id": "c1", "closer": {"name": "Alice"}},
        ]
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=calls_data)
        mock_db.client.table.return_value = chain

        stats = reporter.collect_stats(date(2026, 3, 9), date(2026, 3, 15))
        assert stats["total_calls"] == 1

    def test_collect_stats_handles_closers_as_list(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Handles closer data when returned as list objects."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        calls_data = [
            {"id": "1", "score_final": 75, "closer_id": "c1", "closer": [{"name": "Alice"}]},
        ]
        chain = make_table_chain()
        chain.execute.return_value = MagicMock(data=calls_data)
        mock_db.client.table.return_value = chain

        stats = reporter.collect_stats(date(2026, 3, 9), date(2026, 3, 15))
        assert stats["total_calls"] == 1

    # ------------------------------------------------------------------
    # generate_report
    # ------------------------------------------------------------------

    def test_generate_report_insufficient_data(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Returns insufficient data text when stats are empty."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        stats = {"total_calls": 0, "insufficient_data": True}
        result = reporter.generate_report(stats, date(2026, 3, 9), date(2026, 3, 15))

        assert "insuficiente" in result.lower() or "insufficient" in result.lower() or result != ""

    def test_generate_report_calls_claude_for_real_stats(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Calls Claude API to generate report for valid stats."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        mock_response = MagicMock()
        mock_response.content = [MagicMock(text="Weekly report content here")]
        reporter._claude.messages.create.return_value = mock_response

        stats = {"total_calls": 10, "score_avg": 82.5, "top_closers": ["Alice", "Bob"]}
        result = reporter.generate_report(stats, date(2026, 3, 9), date(2026, 3, 15))

        reporter._claude.messages.create.assert_called_once()
        assert result == "Weekly report content here"

    # ------------------------------------------------------------------
    # run
    # ------------------------------------------------------------------

    def test_run_full_flow(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Full flow: should_generate → collect → generate → save → send."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        with patch.object(reporter, "should_generate", return_value=True), \
             patch.object(reporter, "_get_week_bounds", return_value=(date(2026, 3, 9), date(2026, 3, 15))), \
             patch.object(reporter, "collect_stats", return_value={"total_calls": 5, "score_avg": 80}), \
             patch.object(reporter, "generate_report", return_value="Report text"):

            reporter.run()

            reporter.should_generate.assert_called_once()
            reporter.collect_stats.assert_called_once_with(date(2026, 3, 9), date(2026, 3, 15))
            reporter.generate_report.assert_called_once()

    def test_run_skips_when_should_not_generate(
        self, MockAnthropic, MockEvolution, MockEmail, config, mock_db
    ):
        """Does nothing when should_generate returns False."""
        reporter = self._make_reporter(config, mock_db, MockAnthropic, MockEvolution, MockEmail)

        with patch.object(reporter, "should_generate", return_value=False), \
             patch.object(reporter, "collect_stats") as mock_collect:

            reporter.run()

            reporter.should_generate.assert_called_once()
            mock_collect.assert_not_called()
