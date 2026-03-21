"""Weekly Executive Report generator.

Generates a weekly summary report using Claude API every Monday,
collects stats from the database and sends via WhatsApp/Email.
"""

from __future__ import annotations

import logging
from datetime import date, datetime, timedelta, timezone
from typing import Any

import anthropic

from src.config import Config
from src.db import DB
from src.pipeline.evolution import EvolutionClient
from src.pipeline.email_sender import EmailSender

logger = logging.getLogger(__name__)

WEEKLY_REPORT_PROMPT = """Você é o analista-chefe do CallAudit. Gere um resumo executivo semanal CONCISO e ACIONÁVEL.

Dados da semana:
{stats_json}

Formato OBRIGATÓRIO (use exatamente essa estrutura):

📊 RESUMO SEMANAL — {week_start} a {week_end}

🔢 NÚMEROS DA SEMANA
- X calls auditadas (↑/↓ Y% vs semana anterior)
- Score médio: X.X (↑/↓ X.X)
- Taxa de fechamento: XX%

🏆 TOP 3 CLOSERS
1. Nome — score X.X
2. Nome — score X.X
3. Nome — score X.X

📈 DESTAQUE DE EVOLUÇÃO
Nome subiu de X.X para X.X (+XX%) — maior evolução da semana
(se não houver dados suficientes, omita esta seção)

⚠️ PRIORIDADE DE TREINAMENTO
Dimensão "nome" com média X.X — a mais baixa do time

🌟 CALL DESTAQUE: "lead" por closer — score X.X
❌ CALL ATENÇÃO: "lead" por closer — score X.X

💡 RECOMENDAÇÃO DA SEMANA
1-2 frases acionáveis baseadas nos dados.

Regras:
- Seja direto e conciso
- Use dados reais, não invente
- Se algum dado não estiver disponível, omita a seção
- Máximo 400 palavras"""


class WeeklyReporter:
    """Generates and sends weekly executive reports."""

    def __init__(self, config: Config, db: DB) -> None:
        self._config = config
        self._db = db
        self._claude = anthropic.Anthropic(api_key=config.anthropic_api_key)
        self._evolution = EvolutionClient(
            config.evolution_api_url,
            config.evolution_api_token,
            config.evolution_instance_id,
        )
        self._email = EmailSender(
            config.resend_api_key,
            config.resend_from_email,
        )

    def _get_week_bounds(self) -> tuple[date, date]:
        """Get Monday-Sunday of the previous week."""
        today = date.today()
        # Last Monday
        last_monday = today - timedelta(days=today.weekday() + 7)
        last_sunday = last_monday + timedelta(days=6)
        return last_monday, last_sunday

    def should_generate(self) -> bool:
        """Check if it's Monday and report hasn't been generated yet."""
        today = date.today()
        if today.weekday() != 0:  # 0 = Monday
            return False

        week_start, _ = self._get_week_bounds()
        # Check if report already exists
        result = (
            self._db.client.table("weekly_reports")
            .select("id")
            .eq("week_start", week_start.isoformat())
            .limit(1)
            .execute()
        )
        return len(result.data) == 0

    def collect_stats(self, week_start: date, week_end: date) -> dict[str, Any]:
        """Collect statistics for the given week from the database."""
        client = self._db.client

        start_str = week_start.isoformat()
        end_str = week_end.isoformat()

        # Calls this week
        result = (
            client.table("call_audits")
            .select("id, score_final, classificacao, resultado, closer_id, lead_name, closers(name)")
            .gte("call_date", start_str)
            .lte("call_date", end_str)
            .in_("status", ["completed", "analyzed"])
            .execute()
        )
        calls = result.data or []
        total_calls = len(calls)

        if total_calls == 0:
            return {"total_calls": 0, "insufficient_data": True}

        # Score avg
        scores = [c["score_final"] for c in calls if c["score_final"] is not None]
        score_avg = round(sum(scores) / len(scores), 1) if scores else 0

        # Previous week for comparison
        prev_start = week_start - timedelta(days=7)
        prev_end = week_end - timedelta(days=7)
        prev_result = (
            client.table("call_audits")
            .select("score_final")
            .gte("call_date", prev_start.isoformat())
            .lte("call_date", prev_end.isoformat())
            .in_("status", ["completed", "analyzed"])
            .not_("score_final", "is", "null")
            .execute()
        )
        prev_scores = [r["score_final"] for r in (prev_result.data or [])]
        score_avg_prev = round(sum(prev_scores) / len(prev_scores), 1) if prev_scores else None

        # Top closers by avg score
        closer_scores: dict[str, list[float]] = {}
        closer_names: dict[str, str] = {}
        for c in calls:
            cid = c.get("closer_id")
            s = c.get("score_final")
            if cid and s is not None:
                closer_scores.setdefault(cid, []).append(s)
                closers_data = c.get("closers")
                if closers_data:
                    name = closers_data.get("name", "Desconhecido") if isinstance(closers_data, dict) else "Desconhecido"
                    closer_names[cid] = name

        top_closers = sorted(
            [
                {"id": cid, "name": closer_names.get(cid, "Desconhecido"), "score": round(sum(ss) / len(ss), 1)}
                for cid, ss in closer_scores.items()
            ],
            key=lambda x: x["score"],
            reverse=True,
        )[:3]

        # Taxa de fechamento
        fechamentos = sum(1 for c in calls if c.get("resultado") == "fechamento")
        taxa_fechamento = round(fechamentos / total_calls * 100, 1) if total_calls > 0 else 0

        # Best and worst call
        best_call = max(calls, key=lambda c: c.get("score_final") or 0) if scores else None
        worst_call = min(calls, key=lambda c: c.get("score_final") or 999) if scores else None

        # Weakest dimension
        dim_cols = [f"d{str(i).zfill(2)}" for i in range(1, 14)]
        dim_names = {
            "d01": "Frame e Liderança", "d02": "Qualificação Preliminar",
            "d03": "Diagnóstico Quantitativo", "d04": "Diagnóstico Qualitativo",
            "d05": "Perguntas de Consequência", "d06": "Ensino Comercial",
            "d07": "Reframe de Identidade", "d08": "Ancoragem de Valor",
            "d09": "Isolamento de Objeção", "d10": "Proporção de Fala",
            "d11": "Segurança de Promessas", "d12": "Checkpoints",
            "d13": "Controle e Fechamento",
        }

        # Fetch dimension scores
        dim_result = (
            client.table("call_audits")
            .select(
                "d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, "
                "d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, "
                "d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento"
            )
            .gte("call_date", start_str)
            .lte("call_date", end_str)
            .in_("status", ["completed", "analyzed"])
            .execute()
        )
        dim_data = dim_result.data or []
        dim_field_map = {
            "d01": "d01_frame", "d02": "d02_qualificacao", "d03": "d03_diag_quantitativo",
            "d04": "d04_diag_qualitativo", "d05": "d05_consequencia", "d06": "d06_ensino",
            "d07": "d07_identidade", "d08": "d08_ancoragem", "d09": "d09_isolamento",
            "d10": "d10_proporcao_fala", "d11": "d11_promessas", "d12": "d12_checkpoints",
            "d13": "d13_fechamento",
        }

        weakest_dimension = None
        min_avg = 999.0
        for dim_key, field_name in dim_field_map.items():
            vals = [r[field_name] for r in dim_data if r.get(field_name) is not None]
            if vals:
                avg = round(sum(vals) / len(vals), 1)
                if avg < min_avg:
                    min_avg = avg
                    weakest_dimension = {"id": dim_key, "name": dim_names[dim_key], "avg": avg}

        def _call_summary(call: dict) -> dict | None:
            if not call:
                return None
            closers_data = call.get("closers")
            closer_name = "Desconhecido"
            if isinstance(closers_data, dict):
                closer_name = closers_data.get("name", closer_name)
            return {
                "id": call["id"],
                "lead_name": call.get("lead_name", "—"),
                "closer_name": closer_name,
                "score": call.get("score_final"),
            }

        return {
            "total_calls": total_calls,
            "score_avg": score_avg,
            "score_avg_prev": score_avg_prev,
            "top_closers": top_closers,
            "weakest_dimension": weakest_dimension,
            "best_call": _call_summary(best_call) if best_call else None,
            "worst_call": _call_summary(worst_call) if worst_call else None,
            "taxa_fechamento": taxa_fechamento,
            "total_prev_calls": len(prev_scores),
        }

    def generate_report(self, stats: dict[str, Any], week_start: date, week_end: date) -> str:
        """Send stats to Claude API and get formatted markdown report."""
        import json

        if stats.get("insufficient_data"):
            return (
                f"📊 RESUMO SEMANAL — {week_start.strftime('%d/%m')} a {week_end.strftime('%d/%m')}\n\n"
                "Dados insuficientes para gerar relatório completo. "
                f"Apenas {stats.get('total_calls', 0)} calls auditadas nesta semana.\n\n"
                "💡 Aumente o volume de auditorias para obter insights mais ricos."
            )

        prompt = WEEKLY_REPORT_PROMPT.format(
            stats_json=json.dumps(stats, ensure_ascii=False, indent=2),
            week_start=week_start.strftime("%d/%m/%Y"),
            week_end=week_end.strftime("%d/%m/%Y"),
        )

        response = self._claude.messages.create(
            model="claude-sonnet-4-20250514",
            max_tokens=2000,
            messages=[{"role": "user", "content": prompt}],
        )

        return response.content[0].text

    def send_report(self, report: str) -> None:
        """Send report via WhatsApp and/or email based on config."""
        recipients = self._db.get_notification_recipients()
        whatsapp_numbers = recipients.get("whatsapp_numbers", [])
        email_addresses = recipients.get("email_addresses", [])

        sent = 0

        if self._evolution.enabled and whatsapp_numbers:
            for number in whatsapp_numbers:
                try:
                    self._evolution.send_text(number, report)
                    sent += 1
                except Exception as e:
                    logger.error("Failed to send weekly WhatsApp to %s: %s", number, e)

        if self._email.enabled and email_addresses:
            week_start, week_end = self._get_week_bounds()
            subject = f"Resumo Semanal CallAudit — {week_start.strftime('%d/%m')} a {week_end.strftime('%d/%m')}"
            for email in email_addresses:
                try:
                    self._email.send_report(email, subject, report)
                    sent += 1
                except Exception as e:
                    logger.error("Failed to send weekly email to %s: %s", email, e)

        logger.info("Weekly report sent to %d recipients", sent)

    def run(self) -> None:
        """Entry point: check → collect → generate → save → send."""
        if not self.should_generate():
            return

        week_start, week_end = self._get_week_bounds()
        logger.info("Generating weekly report for %s to %s", week_start, week_end)

        # Collect
        stats = self.collect_stats(week_start, week_end)

        # Generate
        report = self.generate_report(stats, week_start, week_end)

        # Save
        now = datetime.now(timezone.utc).isoformat()
        self._db.client.table("weekly_reports").insert({
            "week_start": week_start.isoformat(),
            "week_end": week_end.isoformat(),
            "report_markdown": report,
            "stats": stats,
            "generated_at": now,
        }).execute()

        # Send
        self.send_report(report)

        logger.info("Weekly report generated and sent successfully")
