################################################################################
##  File:  Install-Docker-Buildx.ps1
##  Desc:  Install Docker Buildx.
################################################################################

Write-Host "Install-Package Docker Buildx"
$assets = (Invoke-RestMethod -Uri "https://api.github.com/repos/docker/buildx/releases/latest").assets
$dockerBuildxUrl = ($assets | Where-Object { $_.name.EndsWith(".windows-amd64.exe") }).browser_download_url
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Invoke-DownloadWithRetry -Url $dockerBuildxUrl -Path "$cliPluginsDir\docker-buildx.exe"

Invoke-PesterTests -TestFile "Docker" -TestName "DockerBuildx"
