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
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url ($downloadUrl -replace $installerName, "checksums.txt") `
    -FileName $installerName
Install-Binary `
  -Url $downloadUrl `
  -ExpectedSHA256Sum $externalHash

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "GitHub CLI"
