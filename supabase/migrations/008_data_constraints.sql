-- ═══════════════════════════════════════════════════════════════
-- Migration 008: Data Integrity Constraints
-- Score ranges, job dedup, status transitions, prompt versioning
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. Score range CHECK constraints (0-10) ───

ALTER TABLE call_audits
  ADD CONSTRAINT chk_score_final CHECK (score_final IS NULL OR (score_final >= 0 AND score_final <= 10)),
  ADD CONSTRAINT chk_d01_frame CHECK (d01_frame IS NULL OR (d01_frame >= 0 AND d01_frame <= 10)),
  ADD CONSTRAINT chk_d02_qualificacao CHECK (d02_qualificacao IS NULL OR (d02_qualificacao >= 0 AND d02_qualificacao <= 10)),
  ADD CONSTRAINT chk_d03_diag_quantitativo CHECK (d03_diag_quantitativo IS NULL OR (d03_diag_quantitativo >= 0 AND d03_diag_quantitativo <= 10)),
  ADD CONSTRAINT chk_d04_diag_qualitativo CHECK (d04_diag_qualitativo IS NULL OR (d04_diag_qualitativo >= 0 AND d04_diag_qualitativo <= 10)),
  ADD CONSTRAINT chk_d05_consequencia CHECK (d05_consequencia IS NULL OR (d05_consequencia >= 0 AND d05_consequencia <= 10)),
  ADD CONSTRAINT chk_d06_ensino CHECK (d06_ensino IS NULL OR (d06_ensino >= 0 AND d06_ensino <= 10)),
  ADD CONSTRAINT chk_d07_identidade CHECK (d07_identidade IS NULL OR (d07_identidade >= 0 AND d07_identidade <= 10)),
  ADD CONSTRAINT chk_d08_ancoragem CHECK (d08_ancoragem IS NULL OR (d08_ancoragem >= 0 AND d08_ancoragem <= 10)),
  ADD CONSTRAINT chk_d09_isolamento CHECK (d09_isolamento IS NULL OR (d09_isolamento >= 0 AND d09_isolamento <= 10)),
  ADD CONSTRAINT chk_d10_proporcao_fala CHECK (d10_proporcao_fala IS NULL OR (d10_proporcao_fala >= 0 AND d10_proporcao_fala <= 10)),
  ADD CONSTRAINT chk_d11_promessas CHECK (d11_promessas IS NULL OR (d11_promessas >= 0 AND d11_promessas <= 10)),
  ADD CONSTRAINT chk_d12_checkpoints CHECK (d12_checkpoints IS NULL OR (d12_checkpoints >= 0 AND d12_checkpoints <= 10)),
  ADD CONSTRAINT chk_d13_fechamento CHECK (d13_fechamento IS NULL OR (d13_fechamento >= 0 AND d13_fechamento <= 10));

-- Sentiment score: -1 to 1
ALTER TABLE call_audits
  ADD CONSTRAINT chk_sentiment_score CHECK (sentiment_score IS NULL OR (sentiment_score >= -1 AND sentiment_score <= 1));

-- ─── 2. Job idempotency: prevent duplicate active jobs ───

-- Partial unique index: only one pending/processing job per (audit_id, job_type)
CREATE UNIQUE INDEX idx_job_queue_dedup
  ON job_queue (audit_id, job_type)
  WHERE status IN ('pending', 'processing');

-- ─── 3. Status transition validation via trigger ───

-- Add 'dead_letter' as valid job status
ALTER TABLE job_queue DROP CONSTRAINT IF EXISTS job_queue_status_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_status_check
  CHECK (status IN ('pending', 'processing', 'completed', 'failed', 'dead_letter'));

-- Valid audit status transitions
CREATE OR REPLACE FUNCTION validate_audit_status_transition()
RETURNS TRIGGER AS $$
DECLARE
  valid_transitions JSONB := '{
    "uploaded": ["transcribing", "error"],
    "transcribing": ["transcribed", "error"],
    "transcribed": ["analyzing", "error"],
    "analyzing": ["analyzed", "error"],
    "analyzed": ["notifying", "error"],
    "notifying": ["completed", "error"],
    "completed": ["notifying"],
    "error": ["uploaded", "transcribing", "analyzing", "notifying"]
  }'::JSONB;
  allowed JSONB;
BEGIN
  -- Allow if status hasn't changed
  IF OLD.status = NEW.status THEN
    RETURN NEW;
  END IF;

  allowed := valid_transitions -> OLD.status;

  IF allowed IS NULL OR NOT (allowed ? NEW.status) THEN
    RAISE EXCEPTION 'Invalid status transition: % -> %', OLD.status, NEW.status;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_audit_status_transition
  BEFORE UPDATE OF status ON call_audits
  FOR EACH ROW EXECUTE FUNCTION validate_audit_status_transition();

-- ─── 4. Prompt versioning + report hash columns ───

ALTER TABLE call_audits
  ADD COLUMN IF NOT EXISTS prompt_version TEXT,
  ADD COLUMN IF NOT EXISTS report_hash TEXT;

-- Index for prompt version analysis
CREATE INDEX IF NOT EXISTS idx_call_audits_prompt_version ON call_audits(prompt_version)
  WHERE prompt_version IS NOT NULL;
