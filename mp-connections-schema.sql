-- Tabla para almacenar las conexiones OAuth de clientes con Mercado Pago
-- Proyecto: Pluxow
-- Supabase project: schema pluxow (mismo patrón que kinesicpro)

CREATE SCHEMA IF NOT EXISTS pluxow;

CREATE TABLE IF NOT EXISTS pluxow.mp_connections (
  id                UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  client_identifier TEXT        NOT NULL,           -- email o slug del cliente (viene del state param del OAuth)
  mp_user_id        TEXT,                           -- user_id de la cuenta MP del cliente
  access_token      TEXT        NOT NULL,           -- token activo para llamar la API de MP
  refresh_token     TEXT,                           -- para renovar el access_token cuando vence
  token_type        TEXT        DEFAULT 'Bearer',
  scope             TEXT,                           -- permisos otorgados
  expires_at        TIMESTAMPTZ,                    -- cuándo vence el access_token
  is_active         BOOLEAN     DEFAULT TRUE,       -- false si el cliente revocó el acceso
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  updated_at        TIMESTAMPTZ DEFAULT NOW()
);

-- Índices
CREATE INDEX IF NOT EXISTS mp_connections_client_idx ON pluxow.mp_connections (client_identifier);
CREATE INDEX IF NOT EXISTS mp_connections_active_idx ON pluxow.mp_connections (is_active) WHERE is_active = TRUE;

-- Trigger para updated_at automático
CREATE OR REPLACE FUNCTION pluxow.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER mp_connections_updated_at
  BEFORE UPDATE ON pluxow.mp_connections
  FOR EACH ROW EXECUTE FUNCTION pluxow.update_updated_at();

-- RLS: solo service_role (los tokens son sensibles, nunca exponer al frontend)
ALTER TABLE pluxow.mp_connections ENABLE ROW LEVEL SECURITY;

-- Exponer el schema en PostgREST:
-- Settings > API > Extra Search Path → agregar "pluxow"
-- GRANT USAGE ON SCHEMA pluxow TO service_role;
-- GRANT ALL ON ALL TABLES IN SCHEMA pluxow TO service_role;
