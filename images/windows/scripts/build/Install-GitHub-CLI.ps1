################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
##  Supply chain security: GitHub CLI - checksum validation
################################################################################

Write-Host "Get the latest gh version..."

$repoUrl = "https://api.github.com/repos/cli/cli/releases/latest"
$assets = (Invoke-RestMethod -Uri $repoUrl).assets
$downloadUrl = ($assets.browser_download_url -match "windows_amd64.msi") | Select-Object -First 1

$hashUrl = ($assets.browser_download_url -match "checksums.txt") | Select-Object -First 1
$externalHash = (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*windows_amd64.msi*" }).Split(' ')[0]

Install-Binary `
  -Url $downloadUrl `
  -ExpectedSHA256Sum $externalHash

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"
