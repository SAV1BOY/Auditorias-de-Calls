# setup-all-clis.ps1 - One-shot setup of Vercel, Supabase, GitHub CLIs on Windows
# Run as Administrator for cleanest install.
#
# What it does:
#   1. Verifies/installs Node.js (via winget) - needed for Vercel CLI
#   2. Installs Vercel CLI (via npm)
#   3. Installs Supabase CLI (via scoop)
#   4. Installs GitHub CLI (via winget)
#   5. Persists tokens (Vercel + optional Supabase/GitHub) in your PowerShell profile
#   6. Auto-logs you into each CLI
#
# USAGE:
#   irm "https://raw.githubusercontent.com/SAV1BOY/Auditorias-de-Calls/claude/fix-audit-closer-data-iltr7/scripts/setup-all-clis.ps1" -OutFile setup.ps1
#   ./setup.ps1 -VercelToken 'vcp_your_token'
#
# After running, ALL future PowerShell sessions will have:
#   vercel, supabase, gh commands available
#   $env:VERCEL_TOKEN, $env:SUPABASE_ACCESS_TOKEN, $env:GH_TOKEN automatically set

param(
  [Parameter(Mandatory=$true)][string]$VercelToken,
  [string]$SupabaseToken = '',
  [string]$GitHubToken = ''
)

$ErrorActionPreference = 'Continue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

function H($m) { Write-Host ""; Write-Host ("="*60) -ForegroundColor Cyan; Write-Host $m -ForegroundColor Cyan; Write-Host ("="*60) -ForegroundColor Cyan }
function OK($m) { Write-Host "  [OK]   $m" -ForegroundColor Green }
function W($m)  { Write-Host "  [WARN] $m" -ForegroundColor Yellow }
function I($m)  { Write-Host "  [INFO] $m" -ForegroundColor Gray }
function X($m)  { Write-Host "  [FAIL] $m" -ForegroundColor Red }

# Check if running as admin (winget needs it sometimes)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
  W "Not running as Administrator. Some installs may need elevation."
}

# =====================================================
# 1. Node.js (needed for Vercel CLI)
# =====================================================
H "1/5  Verifying Node.js"
if (Get-Command node -ErrorAction SilentlyContinue) {
  $nodeVer = & node --version
  OK "Node.js already installed: $nodeVer"
} else {
  W "Node.js not found. Installing via winget..."
  winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  if (Get-Command node -ErrorAction SilentlyContinue) {
    OK "Node.js installed: $(node --version)"
  } else {
    X "Node.js install failed. Restart PowerShell and run this script again."
    exit 1
  }
}

# =====================================================
# 2. Vercel CLI (via npm)
# =====================================================
H "2/5  Installing Vercel CLI"
if (Get-Command vercel -ErrorAction SilentlyContinue) {
  OK "Vercel CLI already installed: $(vercel --version)"
} else {
  npm install -g vercel 2>&1 | Out-Null
  if (Get-Command vercel -ErrorAction SilentlyContinue) {
    OK "Vercel CLI installed: $(vercel --version)"
  } else {
    X "Vercel install failed. Run manually: npm install -g vercel"
  }
}

# =====================================================
# 3. Supabase CLI (via scoop)
# =====================================================
H "3/5  Installing Supabase CLI"
if (Get-Command supabase -ErrorAction SilentlyContinue) {
  OK "Supabase CLI already installed: $(supabase --version)"
} else {
  # Ensure scoop is installed first
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    W "Scoop not found. Installing scoop (package manager)..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    iwr -useb get.scoop.sh | iex
  }
  if (Get-Command scoop -ErrorAction SilentlyContinue) {
    scoop bucket add supabase https://github.com/supabase/scoop-bucket.git 2>&1 | Out-Null
    scoop install supabase 2>&1 | Out-Null
    if (Get-Command supabase -ErrorAction SilentlyContinue) {
      OK "Supabase CLI installed: $(supabase --version)"
    } else {
      X "Supabase CLI install failed via scoop. Try manually: scoop install supabase"
    }
  } else {
    X "Scoop install failed. Install supabase CLI manually from: https://github.com/supabase/cli/releases"
  }
}

# =====================================================
# 4. GitHub CLI (via winget)
# =====================================================
H "4/5  Installing GitHub CLI"
if (Get-Command gh -ErrorAction SilentlyContinue) {
  OK "GitHub CLI already installed: $((gh --version | Select-Object -First 1))"
} else {
  winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements 2>&1 | Out-Null
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  if (Get-Command gh -ErrorAction SilentlyContinue) {
    OK "GitHub CLI installed: $((gh --version | Select-Object -First 1))"
  } else {
    W "GitHub CLI install may require restart. Re-run after restarting PowerShell."
  }
}

# =====================================================
# 5. Persist tokens in PowerShell profile + login
# =====================================================
H "5/5  Persisting tokens and configuring CLIs"

# Determine profile path
$profilePath = $PROFILE.CurrentUserAllHosts
if (-not (Test-Path (Split-Path $profilePath))) {
  New-Item -ItemType Directory -Path (Split-Path $profilePath) -Force | Out-Null
}
if (-not (Test-Path $profilePath)) {
  New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

I "Profile: $profilePath"

# Block of env exports (idempotent — replaces previous block)
$profileBlock = @"

# === CallAudit CLI tokens (managed by setup-all-clis.ps1) ===
`$env:VERCEL_TOKEN = '$VercelToken'
"@

if ($SupabaseToken) {
  $profileBlock += "`n`$env:SUPABASE_ACCESS_TOKEN = '$SupabaseToken'"
}
if ($GitHubToken) {
  $profileBlock += "`n`$env:GH_TOKEN = '$GitHubToken'"
}
$profileBlock += "`n# === end CallAudit block ===`n"

# Remove old block if exists, then append new
$existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
if ($existing) {
  $cleaned = $existing -replace '(?s)\r?\n?# === CallAudit CLI tokens.*?# === end CallAudit block ===\r?\n?', ''
  Set-Content -Path $profilePath -Value $cleaned -NoNewline
}
Add-Content -Path $profilePath -Value $profileBlock
OK "Tokens persisted in profile (active on next session)"

# Also set in CURRENT session
$env:VERCEL_TOKEN = $VercelToken
if ($SupabaseToken) { $env:SUPABASE_ACCESS_TOKEN = $SupabaseToken }
if ($GitHubToken) { $env:GH_TOKEN = $GitHubToken }

# Login CLIs
if (Get-Command vercel -ErrorAction SilentlyContinue) {
  $vUser = vercel whoami --token=$VercelToken 2>&1
  if ($LASTEXITCODE -eq 0) {
    OK "Vercel logged in as: $vUser"
  } else {
    W "Vercel token may be invalid. Generate new at https://vercel.com/account/tokens"
  }
}

if ($SupabaseToken -and (Get-Command supabase -ErrorAction SilentlyContinue)) {
  supabase login --token $SupabaseToken 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) {
    OK "Supabase CLI logged in"
  }
}

if ($GitHubToken -and (Get-Command gh -ErrorAction SilentlyContinue)) {
  $GitHubToken | gh auth login --with-token 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) {
    OK "GitHub CLI logged in"
  }
}

# =====================================================
# DONE
# =====================================================
H "Setup complete!"
Write-Host ""
Write-Host "Available CLIs (now and in all future PowerShell sessions):" -ForegroundColor White
Write-Host "  vercel    - Deploy/manage Vercel projects" -ForegroundColor White
Write-Host "  supabase  - Manage Supabase projects/migrations" -ForegroundColor White
Write-Host "  gh        - GitHub operations (issues, PRs, etc.)" -ForegroundColor White
Write-Host ""
Write-Host "Environment variables persisted (next session onwards):" -ForegroundColor White
Write-Host "  `$env:VERCEL_TOKEN" -ForegroundColor White
if ($SupabaseToken) { Write-Host "  `$env:SUPABASE_ACCESS_TOKEN" -ForegroundColor White }
if ($GitHubToken)   { Write-Host "  `$env:GH_TOKEN" -ForegroundColor White }
Write-Host ""
Write-Host "Try now:" -ForegroundColor Yellow
Write-Host "  vercel logs --since 10m" -ForegroundColor Yellow
Write-Host "  vercel env ls" -ForegroundColor Yellow
Write-Host ""
Write-Host "To get tokens for Supabase / GitHub if you want them:" -ForegroundColor Gray
Write-Host "  Supabase: https://supabase.com/dashboard/account/tokens" -ForegroundColor Gray
Write-Host "  GitHub:   https://github.com/settings/tokens (Generate new -> classic, scope: repo)" -ForegroundColor Gray
Write-Host "  Then rerun: ./setup.ps1 -SupabaseToken 'sbp_...' -GitHubToken 'ghp_...'" -ForegroundColor Gray
