
-- ═══════════════════════════════════════════════════════════
-- OrganizaApp+ — Schema do banco de dados (Supabase / PostgreSQL)
-- Execute este SQL no Supabase Dashboard:
-- Database → SQL Editor → New query → Cole e clique em Run
-- ═══════════════════════════════════════════════════════════

-- Habilita Row Level Security em todas as tabelas
-- (cada usuário só vê e edita os próprios dados)

-- ── Tabela principal de dados financeiros ────────────────
CREATE TABLE IF NOT EXISTS oa_data (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  payload     JSONB NOT NULL DEFAULT '{}'::jsonb,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE oa_data ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Usuário lê seus próprios dados"
  ON oa_data FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Usuário insere seus próprios dados"
  ON oa_data FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuário atualiza seus próprios dados"
  ON oa_data FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Usuário deleta seus próprios dados"
  ON oa_data FOR DELETE
  USING (auth.uid() = user_id);

-- ── Tabela de conversas com o Otto ───────────────────────
CREATE TABLE IF NOT EXISTS oa_otto (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  messages    JSONB NOT NULL DEFAULT '[]'::jsonb,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE oa_otto ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Usuário lê seu histórico Otto"
  ON oa_otto FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Usuário insere seu histórico Otto"
  ON oa_otto FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuário atualiza seu histórico Otto"
  ON oa_otto FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Usuário deleta seu histórico Otto"
  ON oa_otto FOR DELETE
  USING (auth.uid() = user_id);

-- ── Índices para performance ─────────────────────────────
CREATE INDEX IF NOT EXISTS oa_data_user_idx ON oa_data(user_id);
CREATE INDEX IF NOT EXISTS oa_otto_user_idx ON oa_otto(user_id);

-- ── Função para atualizar updated_at automaticamente ─────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER oa_data_updated_at
  BEFORE UPDATE ON oa_data
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER oa_otto_updated_at
  BEFORE UPDATE ON oa_otto
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
