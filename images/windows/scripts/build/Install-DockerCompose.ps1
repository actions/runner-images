################################################################################
##  File:  Install-Docker-Compose.ps1
##  Desc:  Install Docker Compose.
################################################################################

Write-Host "Install-Package Docker-Compose v1"
$dockerComposev1Url = "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Windows-x86_64.exe"
$checksumsUrl = "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Windows-x86_64.exe.sha256"
$dockerComposev1Dir = "C:\ProgramData\docker-compose"
New-Item -Path $dockerComposev1Dir -ItemType Directory
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url $checksumsUrl `
    -FileName (Split-Path $dockerComposev1Url -Leaf)
$dockerComposev1Path = Invoke-DownloadWithRetry -Url $dockerComposev1Url -Path "$dockerComposev1Dir\docker-compose.exe"
Test-FileChecksum $dockerComposev1Path -ExpectedSHA256Sum $externalHash
Add-MachinePathItem $dockerComposev1Dir
Update-Environment

Write-Host "Install-Package Docker-Compose v2"
$toolsetVersion = (Get-ToolsetContent).docker.components.compose
$composeVersion = (Get-GithubReleasesByVersion -Repo "docker/compose" -Version "${toolsetVersion}").version
$dockerComposev2Url = "https://github.com/docker/compose/releases/download/v${composeVersion}/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Invoke-DownloadWithRetry -Url $dockerComposev2Url -Path "$cliPluginsDir\docker-compose.exe"

Invoke-PesterTests -TestFile "Docker" -TestName "DockerCompose"
