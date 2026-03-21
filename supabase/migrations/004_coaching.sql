-- Sprint 9: Coaching e Treinamento
-- Tabelas: call_bookmarks, call_comments, weekly_reports
-- Atualização: job_type na job_queue

-- ============================================================
-- 1. call_bookmarks (Biblioteca de Calls Modelo)
-- ============================================================
CREATE TABLE call_bookmarks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  organization_id UUID REFERENCES organizations(id),
  bookmarked_by UUID REFERENCES profiles(id),
  tags TEXT[] DEFAULT '{}',
  highlight_timestamps JSONB DEFAULT '[]',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_call_bookmarks_audit ON call_bookmarks(audit_id);
CREATE INDEX idx_call_bookmarks_org ON call_bookmarks(organization_id);
CREATE INDEX idx_call_bookmarks_tags ON call_bookmarks USING GIN(tags);

ALTER TABLE call_bookmarks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON call_bookmarks
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- 2. call_comments (Coaching Assíncrono)
-- ============================================================
CREATE TABLE call_comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  audit_id UUID NOT NULL REFERENCES call_audits(id) ON DELETE CASCADE,
  author_id UUID NOT NULL REFERENCES profiles(id),
  parent_id UUID REFERENCES call_comments(id) ON DELETE CASCADE,
  timestamp_sec NUMERIC(8,1),
  content TEXT NOT NULL,
  resolved BOOLEAN DEFAULT FALSE,
  resolved_by UUID REFERENCES profiles(id),
  resolved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_call_comments_audit ON call_comments(audit_id);
CREATE INDEX idx_call_comments_parent ON call_comments(parent_id);
CREATE INDEX idx_call_comments_author ON call_comments(author_id);

ALTER TABLE call_comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON call_comments
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE TRIGGER trigger_call_comments_updated
  BEFORE UPDATE ON call_comments FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 3. weekly_reports (Resumo Executivo Semanal)
-- ============================================================
CREATE TABLE weekly_reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  organization_id UUID REFERENCES organizations(id),
  week_start DATE NOT NULL,
  week_end DATE NOT NULL,
  report_markdown TEXT NOT NULL,
  stats JSONB NOT NULL DEFAULT '{}',
  sent_whatsapp BOOLEAN DEFAULT FALSE,
  sent_email BOOLEAN DEFAULT FALSE,
  sent_at TIMESTAMPTZ,
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_weekly_reports_week ON weekly_reports(organization_id, week_start);

ALTER TABLE weekly_reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated_all" ON weekly_reports
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- 4. Atualizar job_type na job_queue
-- ============================================================
ALTER TABLE job_queue DROP CONSTRAINT job_queue_job_type_check;
ALTER TABLE job_queue ADD CONSTRAINT job_queue_job_type_check
  CHECK (job_type IN ('transcribe', 'analyze', 'notify', 'weekly_report'));
