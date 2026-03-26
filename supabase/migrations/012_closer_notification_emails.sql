-- Sprint 11: Email Routing por Closer
-- Adiciona campo notification_emails na tabela closers
-- Permite configurar quais supervisores recebem auditorias de cada closer

ALTER TABLE closers ADD COLUMN IF NOT EXISTS notification_emails TEXT[] DEFAULT '{}';

-- Indice para queries de notificacao
CREATE INDEX IF NOT EXISTS idx_closers_notification_emails ON closers USING GIN(notification_emails);

COMMENT ON COLUMN closers.notification_emails IS
  'Lista de emails de supervisores que recebem auditorias deste closer. Se vazio, usa config global.';
