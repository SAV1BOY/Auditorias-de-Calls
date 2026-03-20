"""Claude API analysis pipeline step."""

from __future__ import annotations

import logging
import re
from datetime import datetime, timezone

import anthropic
from tenacity import retry, stop_after_attempt, wait_exponential

from src.config import Config
from src.db import DB
from src.drive.client import DriveClient
from src.pipeline.models import AnalysisResult
from src.pipeline.parser import parse_analysis
from src.pipeline.whatsapp import generate_whatsapp_summary
from src.prompts.system_prompt import SYSTEM_PROMPT

logger = logging.getLogger(__name__)

MODEL = "claude-sonnet-4-20250514"
MAX_TOKENS = 16000

# Anthropic pricing (Claude Sonnet 4): input $3/MTok, output $15/MTok
COST_INPUT_PER_MTOK = 3.0
COST_OUTPUT_PER_MTOK = 15.0


class Analyzer:
    """Handles call analysis via Anthropic Claude API."""

    def __init__(self, config: Config, db: DB, drive_client: DriveClient) -> None:
        """Initialize the analyzer.

        Args:
            config: Application configuration.
            db: Database wrapper.
            drive_client: Google Drive client for report uploads.
        """
        self._config = config
        self._db = db
        self._drive = drive_client
        self._client = anthropic.Anthropic(api_key=config.anthropic_api_key)

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=2, min=2, max=60),
        reraise=True,
    )
    def _call_claude(self, transcription: str, metadata: dict) -> anthropic.types.Message:
        """Call Claude API with system prompt and transcription.

        Args:
            transcription: Full call transcription text.
            metadata: Dict with closer_name, lead_name, call_date, duration_minutes.

        Returns:
            The API response message.
        """
        user_message = self._build_user_message(transcription, metadata)
        response = self._client.messages.create(
            model=MODEL,
            max_tokens=MAX_TOKENS,
            system=SYSTEM_PROMPT,
            messages=[{"role": "user", "content": user_message}],
        )
        return response

    def _build_user_message(self, transcription: str, metadata: dict) -> str:
        """Build the user message with metadata and transcription.

        Args:
            transcription: Full call transcription text.
            metadata: Dict with closer_name, lead_name, call_date, duration_minutes.

        Returns:
            Formatted user message string.
        """
        duration = metadata.get("duration_minutes")
        duration_str = f"{duration:.0f}" if duration else "N/A"

        return (
            f"## DADOS DA CALL\n"
            f"- **Closer:** {metadata.get('closer_name', 'Desconhecido')}\n"
            f"- **Lead:** {metadata.get('lead_name', 'Desconhecido')}\n"
            f"- **Data:** {metadata.get('call_date', 'N/A')}\n"
            f"- **Duração:** {duration_str} minutos\n\n"
            f"## TRANSCRIÇÃO COMPLETA\n\n{transcription}"
        )

    def analyze(self, audit_id: str) -> AnalysisResult:
        """Run the full analysis pipeline for an audit.

        Steps:
            1. Update status to 'analyzing'
            2. Fetch audit with transcription
            3. Build metadata from audit + closer join
            4. Call Claude API
            5. Parse response into AnalysisResult
            6. Generate WhatsApp summary
            7. Save everything to DB
            8. Save report to Drive (non-fatal)
            9. Create 'notify' job

        Args:
            audit_id: The call_audit ID to analyze.

        Returns:
            The analysis result.
        """
        logger.info("Starting analysis for audit %s", audit_id)

        # 1. Update status
        self._db.update_audit_status(audit_id, "analyzing")

        # 2. Fetch audit
        audit = self._db.get_audit(audit_id)
        if not audit:
            raise ValueError(f"Audit {audit_id} not found")

        transcription = audit.get("transcricao")
        if not transcription:
            raise ValueError(f"Audit {audit_id} has no transcription")

        # 3. Build metadata
        closer_name = "Desconhecido"
        closers_data = audit.get("closers")
        if closers_data:
            if isinstance(closers_data, dict):
                closer_name = closers_data.get("name", closer_name)
            elif isinstance(closers_data, list) and closers_data:
                closer_name = closers_data[0].get("name", closer_name)

        metadata = {
            "closer_name": closer_name,
            "lead_name": audit.get("lead_name", "Desconhecido"),
            "call_date": audit.get("call_date", "N/A"),
            "duration_minutes": audit.get("duration_minutes"),
        }

        # 4. Call Claude
        response = self._call_claude(transcription, metadata)
        raw_text = response.content[0].text
        tokens_input = response.usage.input_tokens
        tokens_output = response.usage.output_tokens

        logger.info(
            "Claude API response: %d input tokens, %d output tokens",
            tokens_input,
            tokens_output,
        )

        # 5. Parse
        result = parse_analysis(raw_text, tokens_input, tokens_output)
        logger.info(
            "Analysis complete: score=%.1f (%s), %d dimensions parsed",
            result.score_final,
            result.classificacao,
            len(result.dimensions),
        )

        # 6. WhatsApp summary
        whatsapp_summary = generate_whatsapp_summary(result, metadata)

        # 7. Save to DB
        cost = (tokens_input * COST_INPUT_PER_MTOK + tokens_output * COST_OUTPUT_PER_MTOK) / 1_000_000
        now = datetime.now(timezone.utc).isoformat()

        extra: dict = {
            "relatorio_completo": raw_text,
            "resumo_whatsapp": whatsapp_summary,
            "score_final": result.score_final,
            "classificacao": result.classificacao,
            # 13 dimension scores (spread into individual columns)
            **result.dimensions,
            # JSONB fields
            "top_erros": result.top_erros,
            "top_acertos": result.top_acertos,
            "plano_acao": result.plano_acao,
            "frases_proibidas": result.frases_proibidas,
            "reescrita_falas": result.reescrita_falas,
            "mapa_frameworks": result.mapa_frameworks,
            # Meta
            "modelo_analise": MODEL,
            "tokens_input": tokens_input,
            "tokens_output": tokens_output,
            "custo_estimado": round(cost, 4),
            "analyzed_at": now,
        }
        self._db.update_audit_status(audit_id, "analyzed", extra=extra)

        # 8. Save report to Drive (non-fatal)
        try:
            self._save_report_to_drive(audit_id, audit, closer_name, raw_text)
        except Exception as e:
            logger.warning(
                "Drive report save failed for audit %s (non-fatal): %s",
                audit_id,
                e,
            )

        # 9. Create notify job (will be processed in Sprint 6)
        self._db.create_job(audit_id, "notify")
        logger.info("Created 'notify' job for audit %s", audit_id)

        return result

    def _save_report_to_drive(
        self,
        audit_id: str,
        audit: dict,
        closer_name: str,
        report_text: str,
    ) -> None:
        """Save the markdown report to Google Drive.

        Uploads to Relatórios/{closer-name}/ folder.

        Args:
            audit_id: The audit ID.
            audit: The audit dict from DB.
            closer_name: The closer's name.
            report_text: The full markdown report.
        """
        if not self._drive.enabled or not self._config.google_drive_relatorios_folder_id:
            logger.debug("Drive not configured, skipping report save.")
            return

        # Build filename
        lead_name = audit.get("lead_name", "unknown")
        call_date = audit.get("call_date", "unknown")
        lead_slug = re.sub(r"[^a-z0-9]+", "-", lead_name.lower()).strip("-")
        filename = f"auditoria_{call_date}_{lead_slug}.md"

        # Get/create closer subfolder under Relatórios
        folder_name = closer_name.lower().replace(" ", "-")
        folder_id = self._drive.get_or_create_folder(
            self._config.google_drive_relatorios_folder_id, folder_name
        )

        # Upload report
        result = self._drive.upload_file(
            folder_id, filename, report_text.encode("utf-8"), "text/markdown"
        )
        drive_report_url = result.get("webViewLink", "")

        # Update audit with report URL
        self._db.update_audit_status(audit_id, "analyzed", extra={
            "drive_report_url": drive_report_url,
        })
        logger.info("Saved report to Drive for audit %s: %s", audit_id, drive_report_url)
