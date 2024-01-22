################################################################################
##  File:  Install-Docker-Compose.ps1
##  Desc:  Install Docker Compose.
##  Supply chain security: Docker Compose v1 - by package manager
################################################################################

Write-Host "Install-Package Docker-Compose v1"
$versionToInstall = Resolve-ChocoPackageVersion -PackageName "docker-compose" -TargetVersion "1.29"
Install-ChocoPackage docker-compose -ArgumentList "--version=$versionToInstall"

Write-Host "Install-Package Docker-Compose v2"
# Temporaty pinned to v2.23.3 due https://github.com/actions/runner-images/issues/9172
$toolsetVersion = (Get-ToolsetContent).docker.components.compose
$composeVersion = (Get-GithubReleasesByVersion -Repo "docker/compose" -Version "${toolsetVersion}").version
$dockerComposev2Url = "https://github.com/docker/compose/releases/download/v${composeVersion}/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Invoke-DownloadWithRetry -Url $dockerComposev2Url -Path "$cliPluginsDir\docker-compose.exe"

Invoke-PesterTests -TestFile "Docker" -TestName "DockerCompose"
