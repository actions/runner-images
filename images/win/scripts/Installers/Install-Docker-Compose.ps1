################################################################################
##  File:  Install-Docker-Compose.ps1
##  Desc:  Install Docker Compose.
##  Supply chain security: Docker Compose v1 - by package manager
################################################################################

Write-Host "Install-Package Docker-Compose v1"
$versionToInstall = Get-LatestChocoPackageVersion -TargetVersion "1.29" -PackageName "docker-compose"
Choco-Install -PackageName docker-compose -ArgumentList "--version=$versionToInstall"

Write-Host "Install-Package Docker-Compose v2"
$dockerComposev2Url = "https://github.com/docker/compose/releases/latest/download/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Start-DownloadWithRetry -Url $dockerComposev2Url -Name docker-compose.exe -DownloadPath $cliPluginsDir

Invoke-PesterTests -TestFile "Docker" -TestName "DockerCompose"
