#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# vercel-migrate-env.sh — Atualiza env vars Supabase na Vercel
#
# USO (no seu PC local, dentro da pasta Auditorias-de-Calls):
#   chmod +x scripts/vercel-migrate-env.sh
#   ./scripts/vercel-migrate-env.sh
#
# REQUISITOS:
#   - Node.js instalado
#   - Pasta atual = raiz do projeto Auditorias-de-Calls
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

# ═══ Valores do NOVO projeto Supabase (CALL AUDIT) ═══
NEW_URL="https://putdygyeerldrsyjhvzm.supabase.co"
NEW_ANON="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE"
NEW_SERVICE="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3ODQzOTUwOSwiZXhwIjoyMDk0MDE1NTA5fQ.jJXI9rUmc5UDFGd34OrEHs9aigijLhTpFZHq1-i5YTM"

# Cores
G='\033[0;32m'; Y='\033[0;33m'; R='\033[0;31m'; B='\033[0;34m'; N='\033[0m'

step() { echo -e "\n${B}▶ $1${N}"; }
ok()   { echo -e "${G}✓ $1${N}"; }
warn() { echo -e "${Y}⚠ $1${N}"; }
err()  { echo -e "${R}✗ $1${N}"; exit 1; }

# ─── 1. Verificar Vercel CLI ───
step "1/5 — Verificando Vercel CLI"
if ! command -v vercel >/dev/null 2>&1; then
  warn "Vercel CLI não encontrado. Instalando..."
  npm install -g vercel || err "Falha ao instalar Vercel CLI"
fi
ok "Vercel CLI: $(vercel --version)"

# ─── 2. Autenticar ───
step "2/5 — Verificando autenticação"
if ! vercel whoami >/dev/null 2>&1; then
  warn "Você não está logado. Abrindo navegador para login..."
  vercel login || err "Falha no login"
fi
ok "Logado como: $(vercel whoami)"

# ─── 3. Link projeto (se necessário) ───
step "3/5 — Vinculando ao projeto Vercel"
if [ ! -f ".vercel/project.json" ]; then
  warn "Projeto não está linkado. Vincule manualmente:"
  vercel link || err "Falha ao linkar"
fi
PROJECT_NAME=$(node -e "console.log(JSON.parse(require('fs').readFileSync('.vercel/project.json')).projectName || 'unknown')" 2>/dev/null || echo "unknown")
ok "Projeto: $PROJECT_NAME"

# ─── 4. Atualizar 3 env vars × 3 ambientes (9 ops) ───
step "4/5 — Atualizando variáveis (3 vars × 3 ambientes = 9 operações)"

update_env() {
  local NAME="$1" VALUE="$2" ENV="$3"
  echo -n "  $NAME [$ENV]: "
  # Remove se existir (silencia erro se não existir)
  vercel env rm "$NAME" "$ENV" --yes >/dev/null 2>&1 || true
  # Adiciona o novo valor
  if printf '%s' "$VALUE" | vercel env add "$NAME" "$ENV" >/dev/null 2>&1; then
    echo -e "${G}OK${N}"
  else
    echo -e "${R}FALHOU${N}"
    return 1
  fi
}

for ENV in production preview development; do
  update_env NEXT_PUBLIC_SUPABASE_URL      "$NEW_URL"     "$ENV"
  update_env NEXT_PUBLIC_SUPABASE_ANON_KEY "$NEW_ANON"    "$ENV"
  update_env SUPABASE_SERVICE_ROLE_KEY     "$NEW_SERVICE" "$ENV"
done

ok "Todas as 9 variáveis atualizadas"

# ─── 5. Trigger Redeploy ───
step "5/5 — Disparando redeploy em produção"
warn "Aguarde, o build pode levar 2-4 minutos..."
vercel --prod --yes 2>&1 | tail -20

echo ""
ok "Migração de env vars concluída!"
echo -e "${B}Próximos passos:${N}"
echo "  1. Acesse a URL de produção mostrada acima"
echo "  2. Tente login com: miguelgsaviotti29@gmail.com (senha antiga preservada)"
echo "  3. Verifique se o dashboard carrega os 10 audits"
