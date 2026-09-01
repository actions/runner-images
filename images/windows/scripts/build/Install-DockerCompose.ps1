################################################################################
##  File:  Install-Docker-Compose.ps1
##  Desc:  Install Docker Compose.
################################################################################
Write-Host "Install-Package Docker-Compose v2"
$toolsetVersion = (Get-ToolsetContent).docker.components.compose
$composeVersion = (Get-GithubReleasesByVersion -Repo "docker/compose" -Version "${toolsetVersion}").version
$toolsetDockerVersion = (Get-ToolsetContent).docker.components.docker
$dockerComposev2Url = "https://github.com/docker/compose/releases/download/v${composeVersion}/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
# Docker Plugin path on Windows changed in Docker 29.1.5+: https://docs.docker.com/engine/release-notes/29/#deprecations-3
if ([version]$toolsetDockerVersion -gt [version]"29.1.5") {
    $cliPluginsDir = "C:\Program Files\docker\cli-plugins"
}
New-Item -Path $cliPluginsDir -ItemType Directory
Invoke-DownloadWithRetry -Url $dockerComposev2Url -Path "$cliPluginsDir\docker-compose.exe"

Invoke-PesterTests -TestFile "Docker" -TestName "DockerCompose"
