# ═══════════════════════════════════════════════════════════════
# vercel-migrate-env.ps1 — Atualiza env vars Supabase na Vercel
# Usa a API REST diretamente — não precisa de Vercel CLI nem repo clonado.
#
# USO (PowerShell no Windows):
#   $token = 'vcp_xxxxxxxxxxxx'
#   irm "https://raw.githubusercontent.com/SAV1BOY/Auditorias-de-Calls/claude/fix-audit-closer-data-iltr7/scripts/vercel-migrate-env.ps1" -OutFile vmig.ps1
#   ./vmig.ps1 -Token $token
# ═══════════════════════════════════════════════════════════════

param(
  [Parameter(Mandatory=$true)][string]$Token,
  [string]$ProjectName = ''
)

$ErrorActionPreference = 'Stop'
$headers = @{Authorization = "Bearer $Token"}

# Novos valores do projeto Supabase destino (CALL AUDIT)
$newValues = [ordered]@{
  'NEXT_PUBLIC_SUPABASE_URL'      = 'https://putdygyeerldrsyjhvzm.supabase.co'
  'NEXT_PUBLIC_SUPABASE_ANON_KEY' = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE'
  'SUPABASE_SERVICE_ROLE_KEY'     = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3ODQzOTUwOSwiZXhwIjoyMDk0MDE1NTA5fQ.jJXI9rUmc5UDFGd34OrEHs9aigijLhTpFZHq1-i5YTM'
}

function Step($m) { Write-Host "`n▶ $m" -ForegroundColor Cyan }
function Ok($m)   { Write-Host "  ✓ $m" -ForegroundColor Green }
function Warn($m) { Write-Host "  ⚠ $m" -ForegroundColor Yellow }
function Fail($m) { Write-Host "  ✗ $m" -ForegroundColor Red; exit 1 }

# ─── 1. Validar token ───
Step '1/5 — Validando token Vercel'
try {
  $user = Invoke-RestMethod -Uri 'https://api.vercel.com/v2/user' -Headers $headers
  Ok "Logado como: $($user.user.username) ($($user.user.email))"
} catch {
  Fail "Token inválido ou expirado. Erro: $($_.Exception.Message)"
}

# ─── 2. Listar projetos e localizar CallAudit ───
Step '2/5 — Localizando projeto na Vercel'
$allProjects = @()
$next = $null
do {
  $url = if ($next) { "https://api.vercel.com/v9/projects?limit=100&until=$next" } else { 'https://api.vercel.com/v9/projects?limit=100' }
  $page = Invoke-RestMethod -Uri $url -Headers $headers
  $allProjects += $page.projects
  $next = $page.pagination.next
} while ($next)

Ok "Total de projetos encontrados: $($allProjects.Count)"

if ($ProjectName) {
  $project = $allProjects | Where-Object { $_.name -eq $ProjectName } | Select-Object -First 1
} else {
  # Tenta auto-detectar
  $project = $allProjects | Where-Object {
    $_.name -match 'auditoria|callaudit|call-audit|call_audit'
  } | Select-Object -First 1
}

if (-not $project) {
  Warn "Não consegui identificar o projeto automaticamente."
  Write-Host ""
  Write-Host "Projetos disponíveis:" -ForegroundColor Yellow
  for ($i = 0; $i -lt $allProjects.Count; $i++) {
    Write-Host ("  [{0}] {1}" -f $i, $allProjects[$i].name)
  }
  Write-Host ""
  $choice = Read-Host "Digite o número do projeto CallAudit"
  $project = $allProjects[[int]$choice]
}

Ok "Projeto: $($project.name) (id: $($project.id))"

# ─── 3. Listar env vars existentes ───
Step '3/5 — Listando variáveis existentes'
$envResp = Invoke-RestMethod -Uri "https://api.vercel.com/v9/projects/$($project.id)/env?decrypt=false" -Headers $headers
$existingEnvs = $envResp.envs
Ok "$($existingEnvs.Count) variáveis no projeto"

# ─── 4. Para cada chave: deletar todas as versões antigas, criar nova ───
Step '4/5 — Atualizando as 3 variáveis Supabase'

foreach ($key in $newValues.Keys) {
  $val = $newValues[$key]
  Write-Host "`n  → $key" -ForegroundColor White

  # Deletar todas as versões existentes
  $toDelete = $existingEnvs | Where-Object { $_.key -eq $key }
  foreach ($e in $toDelete) {
    $targets = ($e.target -join ',')
    try {
      Invoke-RestMethod -Method DELETE `
        -Uri "https://api.vercel.com/v9/projects/$($project.id)/env/$($e.id)" `
        -Headers $headers | Out-Null
      Write-Host "      - removido (targets: $targets)" -ForegroundColor DarkGray
    } catch {
      Warn "    Falha ao remover (id $($e.id)): $($_.Exception.Message)"
    }
  }

  # Adicionar nova versão para os 3 ambientes
  $body = @{
    key    = $key
    value  = $val
    type   = if ($key.StartsWith('NEXT_PUBLIC_')) { 'plain' } else { 'encrypted' }
    target = @('production', 'preview', 'development')
  } | ConvertTo-Json -Depth 5

  try {
    Invoke-RestMethod -Method POST `
      -Uri "https://api.vercel.com/v10/projects/$($project.id)/env?upsert=true" `
      -Headers $headers `
      -ContentType 'application/json' `
      -Body $body | Out-Null
    Write-Host "      + criada para production / preview / development" -ForegroundColor Green
  } catch {
    Fail "Falha ao criar $key. Erro: $($_.Exception.Message)"
  }
}

Ok 'Todas as 3 variáveis foram atualizadas nos 3 ambientes'

# ─── 5. Trigger redeploy ───
Step '5/5 — Disparando redeploy em produção'

# Buscar o último deployment de produção para obter o gitSource
$lastDeployResp = Invoke-RestMethod -Uri "https://api.vercel.com/v6/deployments?projectId=$($project.id)&target=production&limit=1&state=READY" -Headers $headers
if (-not $lastDeployResp.deployments -or $lastDeployResp.deployments.Count -eq 0) {
  Warn 'Nenhum deploy de produção anterior encontrado. Faça push no GitHub para triggar o primeiro deploy.'
  exit 0
}

$lastDeploy = $lastDeployResp.deployments[0]

# Criar novo deployment baseado no último
$deployBody = @{
  name      = $project.name
  target    = 'production'
  gitSource = $lastDeploy.gitSource
  project   = $project.id
} | ConvertTo-Json -Depth 10

try {
  $newDeploy = Invoke-RestMethod -Method POST `
    -Uri 'https://api.vercel.com/v13/deployments?forceNew=1' `
    -Headers $headers `
    -ContentType 'application/json' `
    -Body $deployBody
  Ok "Deploy disparado! URL: https://$($newDeploy.url)"
  Write-Host ""
  Write-Host "Acompanhe o build em: https://vercel.com/$($user.user.username)/$($project.name)/deployments" -ForegroundColor Cyan
} catch {
  Warn "Falha ao disparar deploy via API. Faça redeploy manual no dashboard."
  Write-Host "  Dashboard: https://vercel.com/$($user.user.username)/$($project.name)/deployments"
}

Write-Host ""
Write-Host "═══ Migração de env vars concluída! ═══" -ForegroundColor Green
Write-Host "Próximo passo: aguarde o deploy (~3 min) e teste login em:" -ForegroundColor White
Write-Host "  https://$($project.name).vercel.app/login" -ForegroundColor Yellow
Write-Host "  Email: miguelgsaviotti29@gmail.com (senha antiga preservada)" -ForegroundColor Yellow
