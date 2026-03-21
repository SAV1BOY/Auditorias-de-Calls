"""Analyzes patterns in lost/failed calls using Claude API."""

from __future__ import annotations

import json
import logging
import re
from datetime import datetime, timezone
from typing import Any

import anthropic
from tenacity import retry, stop_after_attempt, wait_exponential

from src.config import Config
from src.db import DB
from src.prompts.loss_pattern_prompt import LOSS_PATTERN_PROMPT

logger = logging.getLogger(__name__)

DIMENSION_NAMES: dict[str, str] = {
    "d01_frame": "Frame e Lideranca",
    "d02_qualificacao": "Qualificacao Preliminar",
    "d03_diag_quantitativo": "Diagnostico Quantitativo",
    "d04_diag_qualitativo": "Diagnostico Qualitativo",
    "d05_consequencia": "Perguntas de Consequencia",
    "d06_ensino": "Ensino Comercial",
    "d07_identidade": "Reframe de Identidade",
    "d08_ancoragem": "Ancoragem de Valor",
    "d09_isolamento": "Isolamento de Objecao",
    "d10_proporcao_fala": "Proporcao de Fala",
    "d11_promessas": "Seguranca de Promessas",
    "d12_checkpoints": "Checkpoints",
    "d13_fechamento": "Controle e Fechamento",
}


class LossPatternAnalyzer:
    """Analyzes patterns in lost/failed calls using Claude API."""

    MODEL = "claude-sonnet-4-20250514"

    def __init__(self, config: Config, db: DB) -> None:
        self._config = config
        self._db = db
        self._client = anthropic.Anthropic(api_key=config.anthropic_api_key)
        self._model = self.MODEL

    def analyze(self, date_from: str, date_to: str) -> dict[str, Any]:
        """Analyze loss patterns for a date range.

        Steps:
        1. Fetch all calls with resultado != 'fechamento' in date range
        2. If no calls, return empty
        3. Build prompt with call data
        4. Call Claude API
        5. Parse response
        6. Save to loss_patterns table
        7. Return the report

        Args:
            date_from: Start date (YYYY-MM-DD).
            date_to: End date (YYYY-MM-DD).

        Returns:
            Dict with report data including patterns, objections, phases.
        """
        calls = self._fetch_lost_calls(date_from, date_to)
        if not calls:
            logger.info("No lost calls found for period %s to %s", date_from, date_to)
            return {"total_lost_calls": 0, "patterns": [], "common_objections": [], "weakest_phases": []}

        logger.info("Found %d lost calls for analysis (%s to %s)", len(calls), date_from, date_to)

        user_message = self._build_prompt(calls)
        raw_text = self._call_claude(user_message)
        parsed = self._parse_patterns(raw_text)

        report_id = self._save_report(date_from, date_to, len(calls), parsed, raw_text)
        logger.info("Loss pattern report saved: %s (%d patterns found)", report_id, len(parsed.get("patterns", [])))

        return {
            "report_id": report_id,
            "total_lost_calls": len(calls),
            **parsed,
            "report_markdown": raw_text,
        }

    def process_pending_report(self) -> dict[str, Any] | None:
        """Find and process the oldest pending loss_patterns report.

        A pending report has total_lost_calls = 0 (placeholder created by frontend).

        Returns:
            The report data if processed, None if no pending reports.
        """
        result = (
            self._db.client.table("loss_patterns")
            .select("id, period_start, period_end")
            .eq("total_lost_calls", 0)
            .order("created_at", desc=False)
            .limit(1)
            .execute()
        )

        if not result.data:
            return None

        row = result.data[0]
        report_id = row["id"]
        date_from = row["period_start"]
        date_to = row["period_end"]

        logger.info("Processing pending loss pattern report %s (%s to %s)", report_id, date_from, date_to)

        calls = self._fetch_lost_calls(date_from, date_to)
        if not calls:
            logger.info("No lost calls found for report %s", report_id)
            self._db.client.table("loss_patterns").update({
                "total_lost_calls": 0,
                "patterns": [],
                "common_objections": [],
                "weakest_phases": [],
                "report_markdown": "Nenhuma call perdida encontrada no periodo.",
            }).eq("id", report_id).execute()
            return {"report_id": report_id, "total_lost_calls": 0}

        user_message = self._build_prompt(calls)
        raw_text = self._call_claude(user_message)
        parsed = self._parse_patterns(raw_text)

        self._db.client.table("loss_patterns").update({
            "total_lost_calls": len(calls),
            "patterns": parsed.get("patterns", []),
            "common_objections": parsed.get("common_objections", []),
            "weakest_phases": parsed.get("weakest_phases", []),
            "report_markdown": raw_text,
        }).eq("id", report_id).execute()

        logger.info("Loss pattern report %s updated (%d patterns)", report_id, len(parsed.get("patterns", [])))

        return {
            "report_id": report_id,
            "total_lost_calls": len(calls),
            **parsed,
        }

    def _fetch_lost_calls(self, date_from: str, date_to: str) -> list[dict[str, Any]]:
        """Fetch calls that didn't close in the date range."""
        dim_cols = ", ".join(DIMENSION_NAMES.keys())
        select_cols = (
            f"id, lead_name, call_date, score_final, classificacao, resultado, "
            f"top_erros, plano_acao, closers(name), {dim_cols}"
        )

        result = (
            self._db.client.table("call_audits")
            .select(select_cols)
            .neq("resultado", "fechamento")
            .in_("status", ["completed", "analyzed"])
            .gte("call_date", date_from)
            .lte("call_date", date_to)
            .order("call_date", desc=True)
            .execute()
        )

        return result.data or []

    def _build_prompt(self, calls: list[dict[str, Any]]) -> str:
        """Build the user message with call data for Claude."""
        lines: list[str] = [
            f"Total de calls perdidas: {len(calls)}",
            "",
            "## Dados das Calls",
            "",
        ]

        for i, call in enumerate(calls, 1):
            closer_name = "Desconhecido"
            if call.get("closers") and isinstance(call["closers"], dict):
                closer_name = call["closers"].get("name", "Desconhecido")

            lines.append(f"### Call {i}")
            lines.append(f"- **ID:** {call.get('id', 'N/A')}")
            lines.append(f"- **Closer:** {closer_name}")
            lines.append(f"- **Lead:** {call.get('lead_name', 'N/A')}")
            lines.append(f"- **Data:** {call.get('call_date', 'N/A')}")
            lines.append(f"- **Score Final:** {call.get('score_final', 'N/A')}")
            lines.append(f"- **Classificacao:** {call.get('classificacao', 'N/A')}")
            lines.append(f"- **Resultado:** {call.get('resultado', 'N/A')}")

            # Dimension scores
            dim_scores: list[str] = []
            for dim_id, dim_name in DIMENSION_NAMES.items():
                val = call.get(dim_id)
                if val is not None:
                    dim_scores.append(f"  - {dim_name}: {val}")
            if dim_scores:
                lines.append("- **Dimensoes:**")
                lines.extend(dim_scores)

            # Top errors
            top_erros = call.get("top_erros")
            if top_erros:
                if isinstance(top_erros, str):
                    lines.append(f"- **Top Erros:** {top_erros}")
                elif isinstance(top_erros, list):
                    lines.append("- **Top Erros:**")
                    for err in top_erros[:5]:
                        lines.append(f"  - {err}")

            lines.append("")

        return "\n".join(lines)

    @retry(
        stop=stop_after_attempt(2),
        wait=wait_exponential(multiplier=2, min=2, max=30),
        reraise=True,
    )
    def _call_claude(self, user_message: str) -> str:
        """Call Claude API with loss pattern prompt."""
        response = self._client.messages.create(
            model=self._model,
            max_tokens=8000,
            system=LOSS_PATTERN_PROMPT,
            messages=[{"role": "user", "content": user_message}],
            timeout=180.0,
        )
        return response.content[0].text

    def _parse_patterns(self, raw_text: str) -> dict[str, Any]:
        """Parse Claude's response into structured data.

        Extracts patterns, objections, and weakest phases from the markdown.

        Returns:
            Dict with keys: patterns, common_objections, weakest_phases.
        """
        patterns: list[dict[str, Any]] = []
        objections: list[dict[str, Any]] = []
        phases: list[dict[str, Any]] = []

        # Split into sections
        sections = re.split(r"###?\s+\d+\.\s+", raw_text)

        for section in sections:
            section_lower = section.lower()

            if "padr" in section_lower and "perda" in section_lower:
                patterns = self._parse_pattern_section(section)
            elif "obje" in section_lower and "comun" in section_lower:
                objections = self._parse_objections_section(section)
            elif "fase" in section_lower and "frac" in section_lower:
                phases = self._parse_phases_section(section)

        return {
            "patterns": patterns,
            "common_objections": objections,
            "weakest_phases": phases,
        }

    def _parse_pattern_section(self, section: str) -> list[dict[str, Any]]:
        """Parse patterns from the PADROES DE PERDA section."""
        patterns: list[dict[str, Any]] = []
        blocks = re.split(r"\n---\n|\n\*\*Padrao:\*\*", section)

        for block in blocks:
            if not block.strip():
                continue

            pattern: dict[str, Any] = {
                "pattern": "",
                "frequency": 0,
                "severity": "medium",
                "affected_closers": [],
                "example_audits": [],
                "recommendation": "",
            }

            # Extract pattern description
            pat_match = re.search(r"(?:\*\*Padrao:\*\*\s*)?(.+?)(?:\n|$)", block.strip())
            if pat_match:
                pattern["pattern"] = pat_match.group(1).strip().strip("*").strip()

            # Extract frequency
            freq_match = re.search(r"\*\*Frequencia:\*\*\s*(\d+)", block)
            if freq_match:
                pattern["frequency"] = int(freq_match.group(1))

            # Extract severity
            sev_match = re.search(r"\*\*Severidade:\*\*\s*(HIGH|MEDIUM|LOW)", block, re.IGNORECASE)
            if sev_match:
                pattern["severity"] = sev_match.group(1).lower()

            # Extract affected closers
            closers_match = re.search(r"\*\*Closers afetados:\*\*\s*(.+?)(?:\n|$)", block)
            if closers_match:
                names = closers_match.group(1).strip()
                pattern["affected_closers"] = [n.strip() for n in names.split(",") if n.strip()]

            # Extract example audit IDs
            ids_match = re.search(r"\*\*IDs de exemplo:\*\*\s*(.+?)(?:\n|$)", block)
            if ids_match:
                ids_text = ids_match.group(1).strip()
                pattern["example_audits"] = [i.strip() for i in ids_text.split(",") if i.strip()]

            # Extract recommendation
            rec_match = re.search(r"\*\*Recomendacao:\*\*\s*(.+?)(?:\n|$)", block)
            if rec_match:
                pattern["recommendation"] = rec_match.group(1).strip()

            if pattern["pattern"]:
                patterns.append(pattern)

        return patterns

    def _parse_objections_section(self, section: str) -> list[dict[str, Any]]:
        """Parse objections from the OBJECOES section."""
        objections: list[dict[str, Any]] = []
        blocks = re.split(r"\n(?=- \*\*Objecao:\*\*)", section)

        for block in blocks:
            obj: dict[str, Any] = {"objection": "", "count": 0, "best_response": ""}

            obj_match = re.search(r"\*\*Objecao:\*\*\s*(.+?)(?:\n|$)", block)
            if obj_match:
                obj["objection"] = obj_match.group(1).strip()

            count_match = re.search(r"\*\*Contagem:\*\*\s*(\d+)", block)
            if count_match:
                obj["count"] = int(count_match.group(1))

            resp_match = re.search(r"\*\*Melhor resposta sugerida:\*\*\s*(.+?)(?:\n|$)", block)
            if resp_match:
                obj["best_response"] = resp_match.group(1).strip()

            if obj["objection"]:
                objections.append(obj)

        return objections

    def _parse_phases_section(self, section: str) -> list[dict[str, Any]]:
        """Parse weakest phases from the FASES section."""
        phases: list[dict[str, Any]] = []
        matches = re.finditer(
            r"\*\*Fase:\*\*\s*(.+?)\n.*?\*\*Score medio:\*\*\s*([\d.]+)",
            section,
            re.DOTALL,
        )

        for match in matches:
            phases.append({
                "phase": match.group(1).strip(),
                "avg_score": float(match.group(2)),
            })

        return phases

    def _save_report(
        self,
        date_from: str,
        date_to: str,
        total: int,
        parsed: dict[str, Any],
        raw_text: str,
    ) -> str:
        """Save the report to loss_patterns table. Returns the report ID."""
        result = (
            self._db.client.table("loss_patterns")
            .insert({
                "period_start": date_from,
                "period_end": date_to,
                "total_lost_calls": total,
                "patterns": parsed.get("patterns", []),
                "common_objections": parsed.get("common_objections", []),
                "weakest_phases": parsed.get("weakest_phases", []),
                "report_markdown": raw_text,
            })
            .execute()
        )
        return result.data[0]["id"]
