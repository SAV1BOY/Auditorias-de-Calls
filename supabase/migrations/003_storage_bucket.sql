-- Migration 003: Create Storage bucket for audio files
-- Execute via Supabase Dashboard (SQL Editor) or CLI

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'audios',
  'audios',
  false,
  524288000, -- 500 MB
  ARRAY['audio/ogg', 'audio/mpeg', 'audio/mp4', 'audio/webm', 'audio/wav', 'audio/x-m4a']
);

-- Authenticated users can upload and read audios
CREATE POLICY "Auth users upload audios"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'audios');

CREATE POLICY "Auth users read audios"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'audios');

-- Service role (worker) has full access
CREATE POLICY "Service role full access audios"
  ON storage.objects FOR ALL TO service_role
  USING (bucket_id = 'audios');
