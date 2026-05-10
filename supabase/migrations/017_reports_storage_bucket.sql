-- Migration 017: Create reports storage bucket
-- For storing generated audit report markdown files

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'reports',
  'reports',
  false,
  10485760, -- 10 MB
  ARRAY['text/markdown', 'text/plain', 'application/pdf']
)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Service role full access reports"
  ON storage.objects FOR ALL TO service_role
  USING (bucket_id = 'reports');

CREATE POLICY "Auth users read reports"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'reports');
