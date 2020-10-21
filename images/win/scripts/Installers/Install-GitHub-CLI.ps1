################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
################################################################################

Write-Host "Get the latest gh version..."

$Name = "gh_windows_amd64.msi"
$Assets = (Invoke-RestMethod -Uri "https://api.github.com/repos/cli/cli/releases/latest").assets
$DownloadUrl = ($Assets.browser_download_url -match "windows_amd64.msi") | Select-Object -First 1

Install-Binary -Url $DownloadUrl -Name $Name

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"
