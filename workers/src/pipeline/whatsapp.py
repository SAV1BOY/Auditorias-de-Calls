"""WhatsApp summary generator for call audits."""

from __future__ import annotations

from src.pipeline.models import AnalysisResult

SCORE_EMOJIS: dict[str, str] = {
    "ELITE": "\U0001f3c6",   # 🏆
    "FORTE": "\U0001f4aa",   # 💪
    "MEDIANA": "\u26a0\ufe0f",  # ⚠️
    "FRACA": "\U0001f534",   # 🔴
}

MAX_LENGTH = 1000


def generate_whatsapp_summary(parsed: AnalysisResult, metadata: dict) -> str:
    """Generate a WhatsApp-friendly summary of the analysis.

    The summary is designed to be read on mobile in ~10 seconds.
    It includes the score, classification, top 3 wins, and top 3 errors.

    Args:
        parsed: The parsed analysis result.
        metadata: Dict with closer_name, lead_name, call_date, duration_minutes.

    Returns:
        Summary string, guaranteed ≤1000 characters.
    """
    emoji = SCORE_EMOJIS.get(parsed.classificacao, "\U0001f4ca")  # 📊 fallback
    closer = metadata.get("closer_name", "Desconhecido")
    lead = metadata.get("lead_name", "Desconhecido")
    call_date = metadata.get("call_date", "N/A")
    duration = metadata.get("duration_minutes", "N/A")

    # Header
    lines: list[str] = [
        f"{emoji} AUDITORIA: {closer} x {lead}",
        f"\U0001f4c5 {call_date} | \u23f1 {duration}min",
        f"\U0001f4ca Score: {parsed.score_final}/10 \u2014 {parsed.classificacao}",
        "",
    ]

    # Top acertos (max 3)
    acertos = parsed.top_acertos[:3]
    if acertos:
        lines.append("\u2705 Top Acertos:")
        for item in acertos:
            title = item.get("title", "")
            if len(title) > 60:
                title = title[:57] + "..."
            lines.append(f"{item.get('rank', '-')}. {title}")
        lines.append("")

    # Top erros (max 3)
    erros = parsed.top_erros[:3]
    if erros:
        lines.append("\u274c Top Erros:")
        for item in erros:
            title = item.get("title", "")
            if len(title) > 60:
                title = title[:57] + "..."
            lines.append(f"{item.get('rank', '-')}. {title}")

    summary = "\n".join(lines)

    # Enforce max length
    if len(summary) > MAX_LENGTH:
        summary = summary[:MAX_LENGTH - 3] + "..."

    return summary
