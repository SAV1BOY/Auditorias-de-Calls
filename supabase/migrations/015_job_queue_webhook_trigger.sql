-- Migration 015: Job queue webhook trigger via pg_net
-- Calls Edge Function when a new job is inserted

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

CREATE OR REPLACE FUNCTION public.trigger_process_job()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $function$
DECLARE
  edge_function_url TEXT;
BEGIN
  -- IMPORTANT: Update this URL when migrating to a new Supabase project
  edge_function_url := 'https://putdygyeerldrsyjhvzm.supabase.co/functions/v1/process-job';

  PERFORM net.http_post(
    url := edge_function_url,
    body := jsonb_build_object(
      'job_id', NEW.id,
      'audit_id', NEW.audit_id,
      'job_type', NEW.job_type
    ),
    headers := jsonb_build_object(
      'Content-Type', 'application/json'
    )::jsonb
  );

  RETURN NEW;
END;
$function$;

CREATE TRIGGER on_job_inserted
  AFTER INSERT ON public.job_queue
  FOR EACH ROW
  WHEN (NEW.status = 'pending')
  EXECUTE FUNCTION trigger_process_job();
