################################################################################
##  File:  Install-Docker-Compose.ps1
##  Desc:  Install Docker Compose.
################################################################################
Write-Host "Install-Package Docker-Compose v2"
$toolsetVersion = (Get-ToolsetContent).docker.components.compose
$composeVersion = (Get-GithubReleasesByVersion -Repo "docker/compose" -Version "${toolsetVersion}").version
$dockerComposev2Url = "https://github.com/docker/compose/releases/download/v${composeVersion}/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Invoke-DownloadWithRetry -Url $dockerComposev2Url -Path "$cliPluginsDir\docker-compose.exe"

Invoke-PesterTests -TestFile "Docker" -TestName "DockerCompose"
