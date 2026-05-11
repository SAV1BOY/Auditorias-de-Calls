# setup-all-clis.ps1 - One-shot setup of Vercel, Supabase, GitHub CLIs on Windows
# v2 - Fixed shadowing of built-in aliases (H/W) and scoop+admin conflict.
#
# USAGE:
#   irm "https://raw.githubusercontent.com/SAV1BOY/Auditorias-de-Calls/claude/fix-audit-closer-data-iltr7/scripts/setup-all-clis.ps1" -OutFile setup.ps1
#   ./setup.ps1 -VercelToken 'vcp_your_token'
#
# After running, ALL future PowerShell sessions will have:
#   vercel, supabase, gh commands available
#   $env:VERCEL_TOKEN automatically set

param(
  [Parameter(Mandatory=$true)][string]$VercelToken,
  [string]$SupabaseToken = '',
  [string]$GitHubToken = ''
)

$ErrorActionPreference = 'Continue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Use unique function names to avoid PowerShell built-in alias shadowing
function Section($m) { Write-Host ""; Write-Host ("="*60) -ForegroundColor Cyan; Write-Host $m -ForegroundColor Cyan; Write-Host ("="*60) -ForegroundColor Cyan }
function LogOk($m)   { Write-Host "  [OK]   $m" -ForegroundColor Green }
function LogWarn($m) { Write-Host "  [WARN] $m" -ForegroundColor Yellow }
function LogInfo($m) { Write-Host "  [INFO] $m" -ForegroundColor Gray }
function LogFail($m) { Write-Host "  [FAIL] $m" -ForegroundColor Red }

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
  LogWarn "Running as Administrator. Scoop installs per-user, so will use direct .exe download for Supabase."
}

# =====================================================
# 1. Node.js
# =====================================================
Section "1/5  Verifying Node.js"
if (Get-Command node -ErrorAction SilentlyContinue) {
  LogOk "Node.js already installed: $(node --version)"
} else {
  LogWarn "Node.js not found. Installing via winget..."
  winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements 2>&1 | Out-Null
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  if (Get-Command node -ErrorAction SilentlyContinue) {
    LogOk "Node.js installed: $(node --version)"
  } else {
    LogFail "Node.js install failed. Install manually from nodejs.org then restart PowerShell."
    exit 1
  }
}

# =====================================================
# 2. Vercel CLI (via npm)
# =====================================================
Section "2/5  Installing Vercel CLI"
if (Get-Command vercel -ErrorAction SilentlyContinue) {
  LogOk "Vercel CLI already installed: $(vercel --version)"
} else {
  npm install -g vercel 2>&1 | Out-Null
  if (Get-Command vercel -ErrorAction SilentlyContinue) {
    LogOk "Vercel CLI installed: $(vercel --version)"
  } else {
    LogFail "Vercel install failed. Run manually: npm install -g vercel"
  }
}

# =====================================================
# 3. Supabase CLI (direct .exe download, works as admin)
# =====================================================
Section "3/5  Installing Supabase CLI"
if (Get-Command supabase -ErrorAction SilentlyContinue) {
  LogOk "Supabase CLI already installed: $(supabase --version)"
} else {
  $supabaseDir = "$env:LOCALAPPDATA\supabase"
  $supabaseExe = "$supabaseDir\supabase.exe"
  New-Item -ItemType Directory -Path $supabaseDir -Force | Out-Null

  try {
    LogInfo "Fetching latest release info from GitHub..."
    $rel = Invoke-RestMethod -Uri "https://api.github.com/repos/supabase/cli/releases/latest"
    $asset = $rel.assets | Where-Object { $_.name -like "*windows_amd64.tar.gz" } | Select-Object -First 1
    if (-not $asset) { throw "Could not find Windows amd64 release asset" }

    $tarPath = "$env:TEMP\supabase.tar.gz"
    LogInfo "Downloading $($asset.name) ($([math]::Round($asset.size/1MB,1)) MB)..."
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $tarPath -UseBasicParsing

    LogInfo "Extracting to $supabaseDir..."
    tar -xzf $tarPath -C $supabaseDir
    Remove-Item $tarPath -Force -ErrorAction SilentlyContinue

    if (Test-Path $supabaseExe) {
      # Add to user PATH (persisted)
      $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
      if ($userPath -notlike "*$supabaseDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$userPath;$supabaseDir", "User")
      }
      # Also for current session
      $env:Path += ";$supabaseDir"
      LogOk "Supabase CLI installed: $(& $supabaseExe --version)"
    } else {
      LogFail "supabase.exe not found after extraction in $supabaseDir"
    }
  } catch {
    LogFail "Supabase install failed: $($_.Exception.Message)"
    LogInfo "Manual install: https://github.com/supabase/cli/releases (download supabase_windows_amd64.tar.gz, extract supabase.exe to anywhere in PATH)"
  }
}

# =====================================================
# 4. GitHub CLI (via winget)
# =====================================================
Section "4/5  Installing GitHub CLI"
if (Get-Command gh -ErrorAction SilentlyContinue) {
  LogOk "GitHub CLI already installed: $((gh --version | Select-Object -First 1))"
} else {
  winget install --id GitHub.cli --accept-source-agreements --accept-package-agreements 2>&1 | Out-Null
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  if (Get-Command gh -ErrorAction SilentlyContinue) {
    LogOk "GitHub CLI installed: $((gh --version | Select-Object -First 1))"
  } else {
    LogWarn "GitHub CLI install may need PowerShell restart to detect."
  }
}

# =====================================================
# 5. Persist tokens + login
# =====================================================
Section "5/5  Persisting tokens and configuring CLIs"

$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path $profilePath
if (-not (Test-Path $profileDir)) { New-Item -ItemType Directory -Path $profileDir -Force | Out-Null }
if (-not (Test-Path $profilePath)) { New-Item -ItemType File -Path $profilePath -Force | Out-Null }
LogInfo "Profile: $profilePath"

$lines = @("", "# === CallAudit CLI tokens (managed by setup-all-clis.ps1) ===")
$lines += "`$env:VERCEL_TOKEN = '$VercelToken'"
if ($SupabaseToken) { $lines += "`$env:SUPABASE_ACCESS_TOKEN = '$SupabaseToken'" }
if ($GitHubToken)   { $lines += "`$env:GH_TOKEN = '$GitHubToken'" }
$lines += "# === end CallAudit block ==="
$lines += ""
$newBlock = $lines -join "`r`n"

$existing = ""
if (Test-Path $profilePath) { $existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue }
if (-not $existing) { $existing = "" }
$cleaned = $existing -replace '(?s)\r?\n?# === CallAudit CLI tokens.*?# === end CallAudit block ===\r?\n?', ''
Set-Content -Path $profilePath -Value ($cleaned.TrimEnd() + "`r`n" + $newBlock) -NoNewline -Encoding UTF8
LogOk "Tokens persisted in profile (active on next session)"

# Apply to current session immediately
$env:VERCEL_TOKEN = $VercelToken
if ($SupabaseToken) { $env:SUPABASE_ACCESS_TOKEN = $SupabaseToken }
if ($GitHubToken)   { $env:GH_TOKEN = $GitHubToken }

# Test Vercel login
if (Get-Command vercel -ErrorAction SilentlyContinue) {
  $vUser = & vercel whoami --token=$VercelToken 2>&1
  if ($LASTEXITCODE -eq 0) {
    LogOk "Vercel logged in as: $vUser"
  } else {
    LogWarn "Vercel token may be invalid. Generate new at https://vercel.com/account/tokens"
  }
}

if ($SupabaseToken -and (Get-Command supabase -ErrorAction SilentlyContinue)) {
  & supabase login --token $SupabaseToken 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) { LogOk "Supabase CLI logged in" }
}

if ($GitHubToken -and (Get-Command gh -ErrorAction SilentlyContinue)) {
  $GitHubToken | & gh auth login --with-token 2>&1 | Out-Null
  if ($LASTEXITCODE -eq 0) { LogOk "GitHub CLI logged in" }
}

# =====================================================
Section "Setup complete!"
Write-Host ""
Write-Host "Available CLIs (in this session and all future sessions):" -ForegroundColor White
Write-Host "  vercel    - Deploy/manage Vercel projects" -ForegroundColor White
Write-Host "  supabase  - Manage Supabase projects/migrations" -ForegroundColor White
Write-Host "  gh        - GitHub operations (issues, PRs, etc.)" -ForegroundColor White
Write-Host ""
Write-Host "Try now:" -ForegroundColor Yellow
Write-Host "  vercel logs --since 10m" -ForegroundColor Yellow
Write-Host "  vercel ls" -ForegroundColor Yellow
Write-Host "  supabase --help" -ForegroundColor Yellow
Write-Host ""
Write-Host "To get Supabase / GitHub tokens (optional):" -ForegroundColor Gray
Write-Host "  Supabase: https://supabase.com/dashboard/account/tokens" -ForegroundColor Gray
Write-Host "  GitHub:   https://github.com/settings/tokens (classic, scope: repo)" -ForegroundColor Gray
Write-Host "  Then re-run: ./setup.ps1 -VercelToken 'vcp_...' -SupabaseToken 'sbp_...' -GitHubToken 'ghp_...'" -ForegroundColor Gray
