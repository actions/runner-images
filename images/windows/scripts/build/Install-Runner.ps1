################################################################################
##  File:  Install-Runner.ps1
##  Desc:  Install Runner for GitHub Actions
##  Supply chain security: none
################################################################################

Write-Host "Download latest Runner for GitHub Actions"
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/actions/runner/releases/latest"
$version = $release.tag_name.Trim("v")
$downloadUrl = ($release.assets.browser_download_url -ilike "*actions-runner-win-x64-${version}.zip*") | Select-Object -First 1
$fileName = [System.IO.Path]::GetFileName($downloadUrl)
New-Item -Path "C:\ProgramData\runner" -ItemType Directory
Invoke-DownloadWithRetry -Url $downloadUrl -Path "C:\ProgramData\runner\$fileName"

Invoke-PesterTests -TestFile "RunnerCache"
