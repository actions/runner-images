################################################################################
##  File:  Install-Runner.ps1
##  Desc:  Install Runner for GitHub Actions
##  Supply chain security: none
################################################################################

Write-Host "Download latest Runner for GitHub Actions"
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "actions/runner" `
    -Version "latest" `
    -UrlMatchPattern "actions-runner-win-x64-*[0-9.].zip"
$fileName = Split-Path $downloadUrl -Leaf
New-Item -Path "C:\ProgramData\runner" -ItemType Directory
Invoke-DownloadWithRetry -Url $downloadUrl -Path "C:\ProgramData\runner\$fileName"

Invoke-PesterTests -TestFile "RunnerCache"
