# test-supabase-auth.ps1 - Verifica diretamente se as credenciais funcionam
# no Supabase, isolando o teste da camada Vercel/SSR.
#
# USAGE:
#   ./test-supabase-auth.ps1 -Email 'miguelgsaviotti29@gmail.com' -Password 'sua_senha'

param(
  [Parameter(Mandatory=$true)][string]$Email,
  [Parameter(Mandatory=$true)][string]$Password
)

$ErrorActionPreference = 'Continue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$supabaseUrl = 'https://putdygyeerldrsyjhvzm.supabase.co'
$anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1dGR5Z3llZXJsZHJzeWpodnptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0Mzk1MDksImV4cCI6MjA5NDAxNTUwOX0.-BL__9l5wrRUepWVXSQ3QLn6tOeRCFQE9m5E0hVaRbE'

Write-Host ""
Write-Host "=== Testing Supabase Auth directly ===" -ForegroundColor Cyan
Write-Host "URL: $supabaseUrl"
Write-Host "Email: $Email"
Write-Host ""

$body = @{
  email    = $Email
  password = $Password
} | ConvertTo-Json

$headers = @{
  'apikey'       = $anonKey
  'Authorization' = "Bearer $anonKey"
  'Content-Type' = 'application/json'
}

try {
  $response = Invoke-RestMethod -Method POST `
    -Uri "$supabaseUrl/auth/v1/token?grant_type=password" `
    -Headers $headers `
    -Body $body

  Write-Host "[OK] Authentication succeeded!" -ForegroundColor Green
  Write-Host ""
  Write-Host "User info:"
  Write-Host "  ID:    $($response.user.id)"
  Write-Host "  Email: $($response.user.email)"
  Write-Host "  Confirmed: $($response.user.email_confirmed_at)"
  Write-Host ""
  Write-Host "Tokens:"
  Write-Host "  Access:  $($response.access_token.Substring(0, 40))..."
  Write-Host "  Refresh: $($response.refresh_token.Substring(0, 40))..."
  Write-Host "  Expires in: $($response.expires_in)s"
  Write-Host ""
  Write-Host "Conclusion: Supabase auth is working correctly." -ForegroundColor Green
  Write-Host "If login is failing in the browser, the issue is in the Vercel/SSR layer." -ForegroundColor Yellow
} catch {
  Write-Host "[FAIL] Authentication failed!" -ForegroundColor Red
  Write-Host ""
  Write-Host "Error:" -ForegroundColor Red
  try {
    $errResp = $_.Exception.Response.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($errResp)
    $errBody = $reader.ReadToEnd()
    Write-Host $errBody -ForegroundColor Red
  } catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
  }
  Write-Host ""
  Write-Host "Common causes:"
  Write-Host "  - Password is incorrect"
  Write-Host "  - Email provider not enabled in Supabase Auth settings"
  Write-Host "  - encrypted_password hash incompatible (rare)"
  Write-Host "  - Rate limit hit (5+ failed attempts in last hour)"
}
