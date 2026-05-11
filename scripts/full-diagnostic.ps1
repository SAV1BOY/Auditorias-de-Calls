# full-diagnostic.ps1 - Diagnostico end-to-end do fluxo de login
# Testa em sequencia:
#   1. Auth API direta do Supabase (com a senha real)
#   2. Pagina /login do Vercel (responde 200?)
#   3. Simulacao de POST para Server Action (Next.js Action endpoint)
#
# USAGE:
#   ./full-diagnostic.ps1 -Email 'miguelgsaviotti29@gmail.com' -Password 'CallAudit2026!'

param(
  [Parameter(Mandatory=$true)][string]$Email,
  [Parameter(Mandatory=$true)][string]$Password
)

$ErrorActionPreference = 'Continue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$supabaseUrl = 'https://putdygyeerldrsyjhvzm.supabase.co'
$anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE'
$vercelUrl = 'https://auditorias-de-calls.vercel.app'

function Header($t) {
  Write-Host ""
  Write-Host ("=" * 60) -ForegroundColor Cyan
  Write-Host $t -ForegroundColor Cyan
  Write-Host ("=" * 60) -ForegroundColor Cyan
}

function Ok($m)   { Write-Host "  [OK]   $m" -ForegroundColor Green }
function Fail($m) { Write-Host "  [FAIL] $m" -ForegroundColor Red }
function Info($m) { Write-Host "  [INFO] $m" -ForegroundColor Yellow }

# =====================================================
# Test 1: Supabase Auth API direta
# =====================================================
Header "TEST 1: Supabase Auth API (signInWithPassword)"

$authBody = @{
  email    = $Email
  password = $Password
} | ConvertTo-Json

$authHeaders = @{
  'apikey'        = $anonKey
  'Authorization' = "Bearer $anonKey"
  'Content-Type'  = 'application/json'
}

$test1Pass = $false
try {
  $authResp = Invoke-RestMethod -Method POST `
    -Uri "$supabaseUrl/auth/v1/token?grant_type=password" `
    -Headers $authHeaders `
    -Body $authBody

  Ok "Authentication succeeded"
  Info "User ID: $($authResp.user.id)"
  Info "Email: $($authResp.user.email)"
  Info "Email confirmed: $($authResp.user.email_confirmed_at)"
  Info "Access token issued (expires in $($authResp.expires_in)s)"
  $test1Pass = $true
  $accessToken = $authResp.access_token
} catch {
  Fail "Supabase auth API rejected the credentials"
  try {
    $errStream = $_.Exception.Response.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($errStream)
    $errBody = $reader.ReadToEnd()
    Info "Response body: $errBody"
  } catch {
    Info "Error: $($_.Exception.Message)"
  }
}

# =====================================================
# Test 2: Vercel /login page acessivel
# =====================================================
Header "TEST 2: Vercel /login page reachable"

$test2Pass = $false
try {
  $loginResp = Invoke-WebRequest -Uri "$vercelUrl/login" -UseBasicParsing -MaximumRedirection 0 -ErrorAction Stop
  Ok "Status: $($loginResp.StatusCode)"
  Info "Server: $($loginResp.Headers.'Server' -join ', ')"
  Info "Content-Type: $($loginResp.Headers.'Content-Type' -join ', ')"

  # Check for important headers
  if ($loginResp.Headers.'Content-Security-Policy') {
    Ok "CSP header present (length: $($loginResp.Headers.'Content-Security-Policy'.Length))"
  }
  if ($loginResp.Headers.'x-nonce') {
    Ok "x-nonce header present"
  }

  $test2Pass = $true
} catch {
  Fail "Failed to fetch /login: $($_.Exception.Message)"
}

# =====================================================
# Test 3: Vercel / redireciona pra /login (no auth)
# =====================================================
Header "TEST 3: Vercel / redirects unauthenticated to /login"

try {
  $rootResp = Invoke-WebRequest -Uri "$vercelUrl/" -UseBasicParsing -MaximumRedirection 0 -ErrorAction Stop
  Info "Status: $($rootResp.StatusCode)"
  if ($rootResp.StatusCode -eq 200) {
    Info "Got 200 (no redirect) - middleware may not be running?"
  }
} catch {
  if ($_.Exception.Response.StatusCode.value__ -eq 307 -or $_.Exception.Response.StatusCode.value__ -eq 302 -or $_.Exception.Response.StatusCode.value__ -eq 303) {
    $location = $_.Exception.Response.Headers.Location
    Ok "Middleware redirected: $($_.Exception.Response.StatusCode) -> $location"
  } else {
    Fail "Unexpected response: $($_.Exception.Message)"
  }
}

# =====================================================
# Test 4: Cookies do Supabase persistem em browser real?
#         (Simulacao com session)
# =====================================================
Header "TEST 4: Simulating browser session (no Server Action call)"

Info "Para simular a Server Action do Next.js completa, usar o browser."
Info "Aqui apenas verifico se o endpoint do Vercel responde corretamente."

try {
  $session = [Microsoft.PowerShell.Commands.WebRequestSession]::new()
  $resp = Invoke-WebRequest -Uri "$vercelUrl/login" -UseBasicParsing -WebSession $session
  Info "Cookies received from /login: $($session.Cookies.Count)"
  $session.Cookies.GetCookies($vercelUrl) | ForEach-Object {
    Info "  - $($_.Name) (HttpOnly: $($_.HttpOnly), Secure: $($_.Secure), Path: $($_.Path))"
  }
} catch {
  Fail "Session test failed: $($_.Exception.Message)"
}

# =====================================================
# RESUMO
# =====================================================
Header "RESUMO"
if ($test1Pass) {
  Ok "Supabase Auth API: FUNCIONANDO"
  Info "  -> credenciais (usuario + senha) estao corretas no DB"
  Info "  -> hash bcrypt foi copiado certinho na migracao"
} else {
  Fail "Supabase Auth API: FALHOU"
  Info "  -> problema esta no banco/credenciais, nao no SSR"
}

if ($test2Pass) {
  Ok "Vercel /login page: ACESSIVEL"
  Info "  -> deploy ta no ar, middleware respondendo"
}

Write-Host ""
if ($test1Pass -and $test2Pass) {
  Write-Host "==> Se ambos passaram mas login nao funciona no browser:" -ForegroundColor Yellow
  Write-Host "    O problema esta especificamente no fluxo SSR (Server Action -> Middleware)" -ForegroundColor Yellow
  Write-Host "    Abre o app em uma aba anonima e captura DevTools (Console + Network)" -ForegroundColor Yellow
}
