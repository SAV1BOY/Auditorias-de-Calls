# vercel-migrate-env.ps1 - Update Supabase env vars on Vercel
# ASCII-only, works on PowerShell 5.1+ and 7+
# Uses Vercel REST API directly - no CLI install, no repo clone needed.
#
# USAGE:
#   irm "https://raw.githubusercontent.com/SAV1BOY/Auditorias-de-Calls/claude/fix-audit-closer-data-iltr7/scripts/vercel-migrate-env.ps1" -OutFile vmig.ps1
#   ./vmig.ps1 -Token 'vcp_xxx'

param(
  [Parameter(Mandatory=$true)][string]$Token,
  [string]$ProjectName = ''
)

$ErrorActionPreference = 'Stop'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$headers = @{Authorization = "Bearer $Token"}

# New Supabase values
$newValues = [ordered]@{
  'NEXT_PUBLIC_SUPABASE_URL'      = 'https://putdygyeerldrsyjhvzm.supabase.co'
  'NEXT_PUBLIC_SUPABASE_ANON_KEY' = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE'
  'SUPABASE_SERVICE_ROLE_KEY'     = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3ODQzOTUwOSwiZXhwIjoyMDk0MDE1NTA5fQ.jJXI9rUmc5UDFGd34OrEHs9aigijLhTpFZHq1-i5YTM'
}

function Step($m) { Write-Host "`n>> $m" -ForegroundColor Cyan }
function Ok($m)   { Write-Host "  [OK] $m" -ForegroundColor Green }
function Warn($m) { Write-Host "  [!]  $m" -ForegroundColor Yellow }
function Fail($m) { Write-Host "  [X]  $m" -ForegroundColor Red; exit 1 }

# 1. Validate token
Step '1/5 - Validating Vercel token'
try {
  $user = Invoke-RestMethod -Uri 'https://api.vercel.com/v2/user' -Headers $headers
  Ok ("Logged in as: " + $user.user.username + " (" + $user.user.email + ")")
} catch {
  Fail ("Invalid token. Error: " + $_.Exception.Message)
}

# 2. List projects
Step '2/5 - Locating project on Vercel'
$allProjects = @()
$next = $null
do {
  if ($next) {
    $url = 'https://api.vercel.com/v9/projects?limit=100&until=' + $next
  } else {
    $url = 'https://api.vercel.com/v9/projects?limit=100'
  }
  $page = Invoke-RestMethod -Uri $url -Headers $headers
  $allProjects += $page.projects
  $next = $null
  if ($page.pagination -and $page.pagination.next) { $next = $page.pagination.next }
} while ($next)

Ok ("Total projects found: " + $allProjects.Count)

if ($ProjectName) {
  $project = $allProjects | Where-Object { $_.name -eq $ProjectName } | Select-Object -First 1
} else {
  $project = $allProjects | Where-Object {
    $_.name -match 'auditoria|callaudit|call-audit|call_audit'
  } | Select-Object -First 1
}

if (-not $project) {
  Warn 'Could not auto-detect the project.'
  Write-Host ''
  Write-Host 'Available projects:' -ForegroundColor Yellow
  for ($i = 0; $i -lt $allProjects.Count; $i++) {
    Write-Host ("  [{0}] {1}" -f $i, $allProjects[$i].name)
  }
  Write-Host ''
  $choice = Read-Host 'Type the project number'
  $project = $allProjects[[int]$choice]
}

Ok ("Project: " + $project.name + " (id: " + $project.id + ")")

# 3. List existing env vars
Step '3/5 - Listing existing env vars'
$envResp = Invoke-RestMethod -Uri ('https://api.vercel.com/v9/projects/' + $project.id + '/env?decrypt=false') -Headers $headers
$existingEnvs = $envResp.envs
Ok ([string]$existingEnvs.Count + ' env vars currently set')

# 4. For each key: delete all old versions, create new
Step '4/5 - Updating the 3 Supabase variables'

foreach ($key in $newValues.Keys) {
  $val = $newValues[$key]
  Write-Host ''
  Write-Host ('  -> ' + $key) -ForegroundColor White

  $toDelete = $existingEnvs | Where-Object { $_.key -eq $key }
  foreach ($e in $toDelete) {
    $targets = ($e.target -join ',')
    try {
      Invoke-RestMethod -Method DELETE `
        -Uri ('https://api.vercel.com/v9/projects/' + $project.id + '/env/' + $e.id) `
        -Headers $headers | Out-Null
      Write-Host ('      - removed (targets: ' + $targets + ')') -ForegroundColor DarkGray
    } catch {
      Warn ('Failed to remove env id ' + $e.id + ': ' + $_.Exception.Message)
    }
  }

  $type = 'encrypted'
  if ($key.StartsWith('NEXT_PUBLIC_')) { $type = 'plain' }

  $body = @{
    key    = $key
    value  = $val
    type   = $type
    target = @('production', 'preview', 'development')
  } | ConvertTo-Json -Depth 5

  try {
    Invoke-RestMethod -Method POST `
      -Uri ('https://api.vercel.com/v10/projects/' + $project.id + '/env?upsert=true') `
      -Headers $headers `
      -ContentType 'application/json' `
      -Body $body | Out-Null
    Write-Host '      + added (production / preview / development)' -ForegroundColor Green
  } catch {
    Fail ('Failed to create ' + $key + ': ' + $_.Exception.Message)
  }
}

Ok 'All 3 variables updated across 3 environments'

# 5. Trigger redeploy
Step '5/5 - Triggering production redeploy'

$deployListUrl = 'https://api.vercel.com/v6/deployments?projectId=' + $project.id + '&target=production&limit=1&state=READY'
$lastDeployResp = Invoke-RestMethod -Uri $deployListUrl -Headers $headers
if (-not $lastDeployResp.deployments -or $lastDeployResp.deployments.Count -eq 0) {
  Warn 'No prior production deploy found. Push to GitHub to trigger the first deploy.'
  exit 0
}

$lastDeploy = $lastDeployResp.deployments[0]

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
  Ok ('Deploy triggered! URL: https://' + $newDeploy.url)
  Write-Host ''
  Write-Host ('Track build at: https://vercel.com/' + $user.user.username + '/' + $project.name + '/deployments') -ForegroundColor Cyan
} catch {
  Warn 'Failed to trigger deploy via API. Use the dashboard to redeploy manually.'
  Write-Host ('  Dashboard: https://vercel.com/' + $user.user.username + '/' + $project.name + '/deployments')
}

Write-Host ''
Write-Host '=== Migration of env vars complete! ===' -ForegroundColor Green
Write-Host 'Next: wait ~3 min for deploy, then test login at:' -ForegroundColor White
Write-Host ('  https://' + $project.name + '.vercel.app/login') -ForegroundColor Yellow
Write-Host '  Email: miguelgsaviotti29@gmail.com (old password preserved)' -ForegroundColor Yellow
