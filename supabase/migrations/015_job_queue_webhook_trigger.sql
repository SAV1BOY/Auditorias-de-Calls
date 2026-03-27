-- Migration 015: Auto-trigger Edge Function on job_queue INSERT
-- Uses pg_net extension to call the process-job Edge Function
-- When a new job is inserted with status='pending', the trigger
-- automatically POSTs to the Edge Function for processing.

-- Enable pg_net for HTTP calls from triggers
CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

-- Trigger function: calls Edge Function via HTTP POST
CREATE OR REPLACE FUNCTION public.trigger_process_job()
RETURNS trigger AS $$
DECLARE
  edge_function_url TEXT;
BEGIN
  edge_function_url := 'https://mfqpjwxszbjzcmdfqcqw.supabase.co/functions/v1/process-job';

  PERFORM extensions.http_post(
    url := edge_function_url,
    body := jsonb_build_object(
      'job_id', NEW.id,
      'audit_id', NEW.audit_id,
      'job_type', NEW.job_type
    )::text,
    headers := jsonb_build_object(
      'Content-Type', 'application/json'
    )
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger: fires on INSERT when status is 'pending'
DROP TRIGGER IF EXISTS on_job_inserted ON job_queue;
CREATE TRIGGER on_job_inserted
  AFTER INSERT ON job_queue
  FOR EACH ROW
  WHEN (NEW.status = 'pending')
  EXECUTE FUNCTION public.trigger_process_job();
