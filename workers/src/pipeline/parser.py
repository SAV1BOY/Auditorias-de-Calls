"""Parser for Claude analysis markdown output.

Extracts structured data (scores, errors, wins, action plan, etc.)
from the markdown report produced by the analyst system prompt.

All parse functions are fault-tolerant: they return sensible defaults
(empty lists, dicts, or zero scores) when sections are missing or malformed.
"""

from __future__ import annotations

import logging
import re
from typing import Any

from src.pipeline.models import AnalysisResult

logger = logging.getLogger(__name__)

# Dimension keys mapped to their row numbers in the scorecard table
DIMENSION_KEYS: dict[int, str] = {
    1: "d01_frame",
    2: "d02_qualificacao",
    3: "d03_diag_quantitativo",
    4: "d04_diag_qualitativo",
    5: "d05_consequencia",
    6: "d06_ensino",
    7: "d07_identidade",
    8: "d08_ancoragem",
    9: "d09_isolamento",
    10: "d10_proporcao_fala",
    11: "d11_promessas",
    12: "d12_checkpoints",
    13: "d13_fechamento",
}

DIMENSION_WEIGHTS: dict[str, float] = {
    "d01_frame": 0.08,
    "d02_qualificacao": 0.10,
    "d03_diag_quantitativo": 0.12,
    "d04_diag_qualitativo": 0.08,
    "d05_consequencia": 0.10,
    "d06_ensino": 0.05,
    "d07_identidade": 0.05,
    "d08_ancoragem": 0.10,
    "d09_isolamento": 0.10,
    "d10_proporcao_fala": 0.08,
    "d11_promessas": 0.08,
    "d12_checkpoints": 0.03,
    "d13_fechamento": 0.03,
}


def _normalize_decimal(text: str) -> float:
    """Convert a decimal string with comma or dot separator to float.

    Handles Brazilian Portuguese format (6,8) and standard format (6.8).
    """
    return float(text.strip().replace(",", "."))


def _classify(score: float) -> str:
    """Return the classification based on score thresholds."""
    if score >= 8.5:
        return "ELITE"
    elif score >= 7.0:
        return "FORTE"
    elif score >= 5.5:
        return "MEDIANA"
    else:
        return "FRACA"


def _extract_section(raw_text: str, section_num: int) -> str:
    """Extract text of a numbered section (## N. ...) up to the next section.

    Args:
        raw_text: Full markdown text.
        section_num: The section number (1-9).

    Returns:
        The section text, or empty string if not found.
    """
    # Match "## N." or "## N " at the start of a line
    pattern = rf"^##\s+{section_num}\.\s"
    match = re.search(pattern, raw_text, re.MULTILINE)
    if not match:
        return ""

    start = match.start()

    # Find next section header (## followed by digit)
    next_section = re.search(r"^##\s+\d+\.\s", raw_text[match.end():], re.MULTILINE)
    if next_section:
        end = match.end() + next_section.start()
    else:
        end = len(raw_text)

    return raw_text[start:end]


def parse_score_final(raw_text: str) -> tuple[float, str]:
    """Extract the final score and classification from the report.

    Looks for the pattern: **SCORE FINAL: X,X/10 — [CLASSIFICAÇÃO]**

    Args:
        raw_text: Full markdown report.

    Returns:
        Tuple of (score, classification). Defaults to (0.0, "FRACA").
    """
    # Primary pattern: **SCORE FINAL: 6,8/10 — CALL MEDIANA** or similar
    pattern = (
        r"SCORE\s+FINAL\s*:\s*"
        r"([\d]+[,.][\d]+)\s*/\s*10\s*"
        r"[-—]+\s*(?:CALL\s+DE\s+|CALL\s+)?"
        r"(ELITE|FORTE|MEDIANA|FRACA)"
    )
    match = re.search(pattern, raw_text, re.IGNORECASE)
    if match:
        try:
            score = _normalize_decimal(match.group(1))
            classificacao = match.group(2).upper()
            return (score, classificacao)
        except (ValueError, IndexError):
            pass

    # Fallback: look for any X,X/10 near a classification keyword
    score_pattern = r"([\d]+[,.][\d]+)\s*/\s*10"
    class_pattern = r"(?:CALL\s+DE\s+|CALL\s+)?(ELITE|FORTE|MEDIANA|FRACA)"

    score_match = re.search(score_pattern, raw_text)
    class_match = re.search(class_pattern, raw_text, re.IGNORECASE)

    score = 0.0
    classificacao = "FRACA"

    if score_match:
        try:
            score = _normalize_decimal(score_match.group(1))
        except ValueError:
            pass

    if class_match:
        classificacao = class_match.group(1).upper()

    return (score, classificacao)


def parse_dimensions(raw_text: str) -> dict[str, float]:
    """Extract the 13 dimension scores from the scorecard table.

    The table has columns: # | Dimensão | Peso | Nota | Ponderada | Evidência
    We extract column index 3 (Nota) for each row numbered 1-13.

    Args:
        raw_text: Full markdown report.

    Returns:
        Dict mapping dimension keys to scores. Empty dict if parsing fails.
    """
    section = _extract_section(raw_text, 2)  # Section "2. SCORECARD"
    if not section:
        # Try the full text if section extraction fails
        section = raw_text

    dimensions: dict[str, float] = {}

    # Match table rows: | N | ... | ... | NOTA | ...
    # Row pattern: starts with | followed by a number 1-13
    row_pattern = r"\|\s*(\d{1,2})\s*\|[^|]+\|[^|]+\|\s*([\d]+[,.][\d]+)\s*\|"
    for match in re.finditer(row_pattern, section):
        try:
            row_num = int(match.group(1))
            score = _normalize_decimal(match.group(2))
            if row_num in DIMENSION_KEYS and 0 <= score <= 10:
                dimensions[DIMENSION_KEYS[row_num]] = score
        except (ValueError, KeyError):
            continue

    if len(dimensions) < 13:
        logger.warning(
            "Only parsed %d/13 dimensions from scorecard table", len(dimensions)
        )

    return dimensions


def parse_top_items(raw_text: str, section_header: str) -> list[dict[str, Any]]:
    """Parse a numbered list section (TOP 5 ACERTOS or TOP 5 ERROS).

    Args:
        raw_text: Full markdown report.
        section_header: The header to search for (e.g., "TOP 5 ACERTOS").

    Returns:
        List of dicts with 'rank', 'title', 'description', and optionally 'severity'.
    """
    # Find the section
    header_pattern = rf"##\s+\d+\.\s+{re.escape(section_header)}"
    match = re.search(header_pattern, raw_text, re.IGNORECASE)
    if not match:
        return []

    start = match.end()
    # Find next section
    next_section = re.search(r"^##\s+\d+\.\s", raw_text[start:], re.MULTILINE)
    end = start + next_section.start() if next_section else len(raw_text)
    section_text = raw_text[start:end]

    items: list[dict[str, Any]] = []

    # Match numbered items: 1. **[SEVERITY] title** — description
    # or: 1. **title** — description
    item_pattern = r"(\d+)\.\s+\*\*(?:\[([^\]]+)\]\s*)?([^*]+)\*\*\s*[-—]?\s*(.*)"
    for item_match in re.finditer(item_pattern, section_text):
        rank = int(item_match.group(1))
        severity = item_match.group(2)  # May be None
        title = item_match.group(3).strip()
        description = item_match.group(4).strip()

        item: dict[str, Any] = {
            "rank": rank,
            "title": title,
            "description": description,
        }
        if severity:
            item["severity"] = severity.strip()

        items.append(item)

    return items


def parse_plano_acao(raw_text: str) -> list[dict[str, Any]]:
    """Parse the action plan section.

    Each recommendation has: title, o_que_fazer, por_que, como_treinar, prioridade.

    Args:
        raw_text: Full markdown report.

    Returns:
        List of recommendation dicts.
    """
    section = _extract_section(raw_text, 8)  # Section "8. PLANO DE AÇÃO"
    if not section:
        return []

    items: list[dict[str, Any]] = []

    # Split by recommendation headers: ### Recomendação N: or ### N:
    rec_pattern = r"###\s+(?:Recomenda[çc][ãa]o\s+)?(\d+)\s*:\s*(.+)"
    rec_matches = list(re.finditer(rec_pattern, section, re.IGNORECASE))

    for i, rec_match in enumerate(rec_matches):
        start = rec_match.end()
        end = rec_matches[i + 1].start() if i + 1 < len(rec_matches) else len(section)
        block = section[start:end]

        title = rec_match.group(2).strip()
        item: dict[str, Any] = {"rank": int(rec_match.group(1)), "title": title}

        # Extract bullet fields
        for field_name, field_key in [
            (r"O que fazer", "o_que_fazer"),
            (r"Por qu[êe]", "por_que"),
            (r"Como treinar", "como_treinar"),
            (r"Prioridade", "prioridade"),
        ]:
            field_match = re.search(
                rf"\*\*{field_name}:\*\*\s*(.+)", block, re.IGNORECASE
            )
            if field_match:
                item[field_key] = field_match.group(1).strip()

        items.append(item)

    return items


def parse_frases_proibidas(raw_text: str) -> list[dict[str, Any]]:
    """Parse the promise alerts section.

    Args:
        raw_text: Full markdown report.

    Returns:
        List of dicts with 'frase', 'risco', 'versao_segura'.
    """
    section = _extract_section(raw_text, 9)  # Section "9. ALERTAS DE PROMESSA"
    if not section:
        return []

    items: list[dict[str, Any]] = []

    # Look for patterns like:
    # - **"frase"** → Risco: ... | Versão segura: ...
    # or numbered/bulleted items with quotes
    phrase_pattern = r'[*-]\s*\*?\*?"([^"]+)"\*?\*?\s*[-—→]+\s*(.*?)(?=\n[*-]|\n##|\n\n|\Z)'
    for match in re.finditer(phrase_pattern, section, re.DOTALL):
        frase = match.group(1).strip()
        rest = match.group(2).strip()

        item: dict[str, Any] = {"frase": frase}

        # Try to extract risk and safe version
        risco_match = re.search(r"[Rr]isco\s*:\s*(.+?)(?:\||$)", rest)
        safe_match = re.search(r"[Vv]ers[ãa]o\s+segura\s*:\s*(.+?)(?:\||$)", rest)

        if risco_match:
            item["risco"] = risco_match.group(1).strip()
        if safe_match:
            item["versao_segura"] = safe_match.group(1).strip()

        if not risco_match and not safe_match:
            item["descricao"] = rest

        items.append(item)

    return items


def parse_reescrita_falas(raw_text: str) -> list[dict[str, Any]]:
    """Parse the critical moments rewrite section.

    Args:
        raw_text: Full markdown report.

    Returns:
        List of dicts with 'timestamp', 'description', 'original', 'rewritten',
        'reason', 'impact'.
    """
    section = _extract_section(raw_text, 7)  # Section "7. REESCRITA DE MOMENTOS CRÍTICOS"
    if not section:
        return []

    items: list[dict[str, Any]] = []

    # Split by moment headers: ### Momento N:
    moment_pattern = r"###\s+Momento\s+(\d+)\s*:\s*(.+)"
    moment_matches = list(re.finditer(moment_pattern, section, re.IGNORECASE))

    for i, m_match in enumerate(moment_matches):
        start = m_match.end()
        end = moment_matches[i + 1].start() if i + 1 < len(moment_matches) else len(section)
        block = section[start:end]

        item: dict[str, Any] = {"description": m_match.group(2).strip()}

        # Extract fields
        for field_name, field_key in [
            (r"O QUE FOI DITO", "original"),
            (r"O QUE DEVERIA TER SIDO DITO", "rewritten"),
            (r"POR QU[ÊE]", "reason"),
            (r"IMPACTO ESTIMADO", "impact"),
        ]:
            field_match = re.search(
                rf"\*\*{field_name}:\*\*\s*(.+)", block, re.IGNORECASE
            )
            if field_match:
                value = field_match.group(1).strip().strip('"')
                item[field_key] = value

        items.append(item)

    return items


def parse_fases_analise(raw_text: str) -> list[dict[str, Any]]:
    """Parse the phase-by-phase analysis section.

    Extracts each sales phase with its rating and observations.

    Args:
        raw_text: Full markdown report.

    Returns:
        List of dicts with 'phase', 'rating', 'observations'.
    """
    section = _extract_section(raw_text, 3)  # Section "3. ANÁLISE FASE A FASE"
    if not section:
        return []

    items: list[dict[str, Any]] = []

    # Match phase headers: ### Fase N: Name or ### N. Name
    phase_pattern = r"###\s+(?:Fase\s+)?(\d+)\s*[:.]\s*(.+)"
    phase_matches = list(re.finditer(phase_pattern, section, re.IGNORECASE))

    for i, p_match in enumerate(phase_matches):
        start = p_match.end()
        end = phase_matches[i + 1].start() if i + 1 < len(phase_matches) else len(section)
        block = section[start:end]

        item: dict[str, Any] = {
            "phase": int(p_match.group(1)),
            "name": p_match.group(2).strip(),
        }

        # Try to extract rating (e.g., **Nota:** 7.5 or similar)
        rating_match = re.search(
            r"(?:nota|rating|avalia[çc][ãa]o)\s*:\s*([\d]+[,.][\d]+)",
            block,
            re.IGNORECASE,
        )
        if rating_match:
            try:
                item["rating"] = _normalize_decimal(rating_match.group(1))
            except ValueError:
                pass

        # Collect the block text as observations (trimmed)
        obs = block.strip()
        if obs:
            item["observations"] = obs

        items.append(item)

    return items


def parse_mapa_frameworks(raw_text: str) -> dict[str, Any]:
    """Parse the frameworks map table.

    The table has columns: Framework | Presença (0-10) | Onde aplicou | Onde faltou | Impacto

    Args:
        raw_text: Full markdown report.

    Returns:
        Dict mapping framework names to their analysis data.
    """
    section = _extract_section(raw_text, 4)  # Section "4. MAPA DE FRAMEWORKS"
    if not section:
        return {}

    frameworks: dict[str, Any] = {}

    # Match table rows: | Framework Name | X/10 | ... | ... | ... |
    row_pattern = r"\|\s*([^|]+?)\s*\|\s*([\d]+[,.]?[\d]*)\s*/\s*10\s*\|\s*([^|]*)\|\s*([^|]*)\|\s*([^|]*)\|"
    for match in re.finditer(row_pattern, section):
        name = match.group(1).strip()
        # Skip header rows
        if name.lower() in ("framework", "---", ""):
            continue

        try:
            score = _normalize_decimal(match.group(2))
        except ValueError:
            score = 0.0

        frameworks[name] = {
            "score": score,
            "where_applied": match.group(3).strip(),
            "where_missing": match.group(4).strip(),
            "impact": match.group(5).strip(),
        }

    return frameworks


def calculate_weighted_score(dimensions: dict[str, float]) -> float:
    """Calculate the weighted average score from dimension scores.

    Args:
        dimensions: Dict mapping dimension keys to scores.

    Returns:
        Weighted average score (0-10).
    """
    if not dimensions:
        return 0.0

    total = sum(
        dimensions.get(key, 0.0) * weight
        for key, weight in DIMENSION_WEIGHTS.items()
    )
    return round(total, 1)


def parse_analysis(
    raw_text: str,
    tokens_input: int = 0,
    tokens_output: int = 0,
) -> AnalysisResult:
    """Parse Claude's markdown analysis into a structured AnalysisResult.

    This is the main orchestrator function. It calls all individual parsers
    and performs a cross-check between the parsed score and the calculated
    weighted average.

    Args:
        raw_text: Full markdown report from Claude.
        tokens_input: Number of input tokens used.
        tokens_output: Number of output tokens used.

    Returns:
        Fully populated AnalysisResult.
    """
    score_final, classificacao = parse_score_final(raw_text)
    dimensions = parse_dimensions(raw_text)

    # Cross-check: if parsed score diverges from calculated weighted average
    if dimensions:
        calculated = calculate_weighted_score(dimensions)
        if calculated > 0 and abs(calculated - score_final) > 0.5:
            logger.warning(
                "Score mismatch: parsed %.1f vs calculated %.1f (using calculated)",
                score_final,
                calculated,
            )
            score_final = calculated
            classificacao = _classify(score_final)

    return AnalysisResult(
        raw_text=raw_text,
        score_final=score_final,
        classificacao=classificacao,
        dimensions=dimensions,
        top_erros=parse_top_items(raw_text, "TOP 5 ERROS"),
        top_acertos=parse_top_items(raw_text, "TOP 5 ACERTOS"),
        plano_acao=parse_plano_acao(raw_text),
        frases_proibidas=parse_frases_proibidas(raw_text),
        reescrita_falas=parse_reescrita_falas(raw_text),
        mapa_frameworks=parse_mapa_frameworks(raw_text),
        fases_analise=parse_fases_analise(raw_text),
        tokens_input=tokens_input,
        tokens_output=tokens_output,
    )
