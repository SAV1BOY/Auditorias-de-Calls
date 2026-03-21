"""Badge evaluation after each call analysis."""

from __future__ import annotations

import logging
from datetime import datetime, timezone
from typing import Any

from src.db import DB

logger = logging.getLogger(__name__)

# Dimension column names in call_audits table
DIMENSION_COLUMNS = [
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

# Score-based badge definitions: slug -> minimum ELITE count required
# Must match slugs in supabase/migrations/005_gamification.sql seed data
SCORE_BADGES: dict[str, int] = {
    "first_elite": 1,
    "triple_elite": 3,
    "ten_elite": 10,
}

# Streak-based badge definitions: slug -> minimum streak count
# Must match slugs in supabase/migrations/005_gamification.sql seed data
STREAK_BADGES: dict[str, int] = {
    "streak_3": 3,
    "streak_5": 5,
    "streak_10": 10,
}

# Threshold for a "good" score that continues a streak
STREAK_THRESHOLD = 7.0


class BadgeEvaluator:
    """Evaluates and awards badges to closers after each audit analysis."""

    def __init__(self, db: DB) -> None:
        """Initialize the badge evaluator.

        Args:
            db: Database wrapper instance.
        """
        self._db = db

    def evaluate(self, audit_id: str) -> list[str]:
        """Evaluate all badge criteria for the closer of the given audit.

        Args:
            audit_id: The call_audit ID that was just analyzed.

        Returns:
            List of badge slugs that were newly earned.
        """
        try:
            # Fetch the audit to get closer_id and scores
            audit = self._db.get_audit(audit_id)
            if not audit:
                logger.warning("Audit %s not found for badge evaluation", audit_id)
                return []

            closer_id = audit.get("closer_id")
            if not closer_id:
                logger.debug("Audit %s has no closer_id, skipping badges", audit_id)
                return []

            classificacao = audit.get("classificacao", "")
            score_final = audit.get("score_final")

            earned: list[str] = []

            # Check score-based badges (ELITE count milestones)
            earned.extend(self._check_score_badges(closer_id, classificacao))

            # Update streaks and check streak badges
            if score_final is not None:
                earned.extend(
                    self._update_streaks(closer_id, float(score_final), audit_id)
                )

            # Check dimension-specific badges (perfect 10.0)
            dimensions: dict[str, float] = {}
            for col in DIMENSION_COLUMNS:
                val = audit.get(col)
                if val is not None:
                    dimensions[col] = float(val)
            earned.extend(self._check_dimension_badges(closer_id, dimensions))

            return earned

        except Exception as e:
            logger.error("Badge evaluation error for audit %s: %s", audit_id, e)
            return []

    def _check_score_badges(self, closer_id: str, classificacao: str) -> list[str]:
        """Check ELITE count milestone badges.

        Args:
            closer_id: The closer's ID.
            classificacao: The classification of the current audit.

        Returns:
            List of newly earned badge slugs.
        """
        earned: list[str] = []
        try:
            if classificacao != "ELITE":
                return []

            # Count total ELITE audits for this closer
            result = (
                self._db.client.table("call_audits")
                .select("id", count="exact")
                .eq("closer_id", closer_id)
                .eq("classificacao", "ELITE")
                .execute()
            )
            elite_count = result.count or 0

            # Get already-earned badge slugs for this closer
            existing = self._get_earned_slugs(closer_id)

            for slug, threshold in SCORE_BADGES.items():
                if elite_count >= threshold and slug not in existing:
                    self._award_badge(closer_id, slug)
                    earned.append(slug)

        except Exception as e:
            logger.error("Score badge check failed for closer %s: %s", closer_id, e)

        return earned

    def _update_streaks(
        self, closer_id: str, score: float, audit_id: str
    ) -> list[str]:
        """Update streak counters and check streak badges.

        Args:
            closer_id: The closer's ID.
            score: The final score of the current audit.
            audit_id: The current audit ID.

        Returns:
            List of newly earned badge slugs.
        """
        earned: list[str] = []
        try:
            streak_type = "daily_above_7"

            # Fetch current streak
            result = (
                self._db.client.table("closer_streaks")
                .select("*")
                .eq("closer_id", closer_id)
                .eq("streak_type", streak_type)
                .limit(1)
                .execute()
            )

            if score >= STREAK_THRESHOLD:
                if result.data:
                    # Update existing streak
                    row = result.data[0]
                    new_count = row["current_count"] + 1
                    new_best = max(row["best_count"], new_count)
                    (
                        self._db.client.table("closer_streaks")
                        .update({
                            "current_count": new_count,
                            "best_count": new_best,
                            "last_updated": datetime.now(timezone.utc).isoformat(),
                        })
                        .eq("id", row["id"])
                        .execute()
                    )
                    current_streak = new_count
                else:
                    # Create new streak
                    (
                        self._db.client.table("closer_streaks")
                        .insert({
                            "closer_id": closer_id,
                            "streak_type": streak_type,
                            "current_count": 1,
                            "best_count": 1,
                        })
                        .execute()
                    )
                    current_streak = 1
            else:
                # Break the streak
                if result.data:
                    (
                        self._db.client.table("closer_streaks")
                        .update({
                            "current_count": 0,
                            "last_updated": datetime.now(timezone.utc).isoformat(),
                        })
                        .eq("id", result.data[0]["id"])
                        .execute()
                    )
                current_streak = 0

            # Check streak badges
            if current_streak > 0:
                existing = self._get_earned_slugs(closer_id)
                for slug, threshold in STREAK_BADGES.items():
                    if current_streak >= threshold and slug not in existing:
                        self._award_badge(closer_id, slug, audit_id)
                        earned.append(slug)

        except Exception as e:
            logger.error("Streak update failed for closer %s: %s", closer_id, e)

        return earned

    def _check_dimension_badges(
        self, closer_id: str, dimensions: dict[str, float]
    ) -> list[str]:
        """Check for perfect 10.0 dimension badges.

        Args:
            closer_id: The closer's ID.
            dimensions: Dict mapping dimension column names to scores.

        Returns:
            List of newly earned badge slugs.
        """
        earned: list[str] = []
        try:
            existing = self._get_earned_slugs(closer_id)

            # The seed has a single "perfect_dimension" badge for any dimension with 10.0
            slug = "perfect_dimension"
            if slug not in existing:
                has_perfect = any(score >= 10.0 for score in dimensions.values())
                if has_perfect:
                    self._award_badge(closer_id, slug)
                    earned.append(slug)

        except Exception as e:
            logger.error(
                "Dimension badge check failed for closer %s: %s", closer_id, e
            )

        return earned

    def _get_earned_slugs(self, closer_id: str) -> set[str]:
        """Get all badge slugs already earned by a closer.

        Args:
            closer_id: The closer's ID.

        Returns:
            Set of earned badge slugs.
        """
        result = (
            self._db.client.table("closer_badges")
            .select("badges(slug)")
            .eq("closer_id", closer_id)
            .execute()
        )
        slugs: set[str] = set()
        for row in result.data or []:
            badge_data = row.get("badges")
            if isinstance(badge_data, dict):
                slug = badge_data.get("slug")
                if slug:
                    slugs.add(slug)
        return slugs

    def _award_badge(
        self, closer_id: str, slug: str, audit_id: str | None = None
    ) -> None:
        """Award a badge to a closer.

        Args:
            closer_id: The closer's ID.
            slug: The badge slug to award.
            audit_id: Optional audit ID that triggered the badge.
        """
        # Lookup badge ID by slug
        badge_result = (
            self._db.client.table("badges")
            .select("id")
            .eq("slug", slug)
            .limit(1)
            .execute()
        )
        if not badge_result.data:
            logger.warning("Badge with slug '%s' not found in badges table", slug)
            return

        badge_id = badge_result.data[0]["id"]
        insert_data: dict[str, Any] = {
            "closer_id": closer_id,
            "badge_id": badge_id,
        }
        if audit_id:
            insert_data["audit_id"] = audit_id

        self._db.client.table("closer_badges").insert(insert_data).execute()
        logger.info("Awarded badge '%s' to closer %s", slug, closer_id)
