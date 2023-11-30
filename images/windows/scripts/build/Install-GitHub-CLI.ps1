################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
##  Supply chain security: GitHub CLI - checksum validation
################################################################################

Write-Host "Get the latest gh version..."

$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "cli/cli" `
    -Version "latest" `
    -UrlMatchPattern "gh_*_windows_amd64.msi"

$installerName = Split-Path $downloadUrl -Leaf
$checksums = Invoke-DownloadWithRetry ($downloadUrl -replace $installerName, "checksums.txt") | Get-Item | Get-Content
$externalHash = $checksums.Where({ $_ -ilike "*${installerName}*" }) | Select-String -Pattern "[A-Fa-f0-9]{64}" | ForEach-Object { $_.Matches.Value }

Install-Binary `
  -Url $downloadUrl `
  -ExpectedSHA256Sum $externalHash

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"
