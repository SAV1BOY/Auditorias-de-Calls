-- ═══════════════════════════════════════════════════════════════
-- Migration 010: Safe async refresh for materialized views
-- Replaces synchronous REFRESH in trigger with pg_notify
-- Worker or pg_cron handles actual refresh asynchronously
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. Drop the blocking trigger ───
DROP TRIGGER IF EXISTS trigger_audit_refresh_views ON call_audits;
DROP FUNCTION IF EXISTS trigger_refresh_on_audit_complete();

-- ─── 2. Debounced refresh function ───
-- Only refreshes if last refresh was more than 30 seconds ago
-- Prevents cascading refreshes when multiple audits complete simultaneously

CREATE OR REPLACE FUNCTION refresh_dashboard_views_debounced()
RETURNS void AS $$
DECLARE
  last_refresh timestamptz;
BEGIN
  -- Use advisory lock to prevent concurrent refreshes
  IF NOT pg_try_advisory_lock(hashtext('refresh_dashboard_views')) THEN
    RETURN;  -- Another refresh is in progress, skip
  END IF;

  BEGIN
    -- Check last refresh time from a control record
    SELECT value->>'last_refresh'
    INTO last_refresh
    FROM app_config
    WHERE key = 'mv_refresh_control'
    LIMIT 1;

    -- Only refresh if more than 30s since last refresh (or first time)
    IF last_refresh IS NULL OR last_refresh < NOW() - INTERVAL '30 seconds' THEN
      REFRESH MATERIALIZED VIEW CONCURRENTLY mv_dashboard_stats;
      REFRESH MATERIALIZED VIEW CONCURRENTLY mv_closer_performance;

      -- Update last refresh timestamp
      INSERT INTO app_config (key, value, organization_id)
      VALUES ('mv_refresh_control', jsonb_build_object('last_refresh', NOW()::text), NULL)
      ON CONFLICT (organization_id, key)
      DO UPDATE SET value = jsonb_build_object('last_refresh', NOW()::text);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    -- Release lock even on error
    PERFORM pg_advisory_unlock(hashtext('refresh_dashboard_views'));
    RAISE;
  END;

  PERFORM pg_advisory_unlock(hashtext('refresh_dashboard_views'));
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─── 3. Lightweight trigger: notify instead of refresh ───
-- Sends a NOTIFY so the worker can refresh asynchronously

CREATE OR REPLACE FUNCTION trigger_notify_audit_complete()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status IN ('completed', 'analyzed') AND (OLD.status IS DISTINCT FROM NEW.status) THEN
    PERFORM pg_notify('audit_completed', json_build_object(
      'audit_id', NEW.id,
      'status', NEW.status,
      'organization_id', NEW.organization_id
    )::text);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trigger_audit_notify_complete
  AFTER UPDATE OF status ON call_audits
  FOR EACH ROW EXECUTE FUNCTION trigger_notify_audit_complete();

-- ─── 4. Keep refresh_dashboard_views() for manual/scheduled use ───
-- The original function is kept unchanged for:
--   * Manual refresh: SELECT refresh_dashboard_views();
--   * pg_cron scheduled refresh (recommended for production)
--   * Worker-driven refresh via refresh_dashboard_views_debounced()

-- Example pg_cron setup (run in Supabase SQL Editor, not in migration):
-- SELECT cron.schedule('refresh-mv', '*/5 * * * *', 'SELECT refresh_dashboard_views_debounced()');
