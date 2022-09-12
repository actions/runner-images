################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step because it requires a restart before we
##         can continue.
################################################################################

Write-Host "Install Docker CE"
$instScriptUrl = "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1"
$instScriptPath = Start-DownloadWithRetry -Url $instScriptUrl -Name "install-docker-ce.ps1"
& $instScriptPath

Write-Host "Install-Package Docker-Compose v1"
Choco-Install -PackageName docker-compose

Write-Host "Install-Package Docker-Compose v2"
$dockerComposev2Url = "https://github.com/docker/compose/releases/latest/download/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Start-DownloadWithRetry -Url $dockerComposev2Url -Name docker-compose.exe -DownloadPath $cliPluginsDir

Write-Host "Install docker-wincred"
$dockerCredLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/docker/docker-credential-helpers/releases/latest"
$dockerCredDownloadUrl = $dockerCredLatestRelease.assets.browser_download_url -match "docker-credential-wincred-.+\.zip" | Select-Object -First 1
$dockerCredArchive = Start-DownloadWithRetry -Url $dockerCredDownloadUrl
Expand-Archive -Path $dockerCredArchive -DestinationPath "C:\Windows\System32"

Write-Host "Download docker images"
$dockerImages = (Get-ToolsetContent).docker.images
foreach ($dockerImage in $dockerImages) {
    Write-Host "Pulling docker image $dockerImage ..."
    docker pull $dockerImage

    if (!$?) {
        Write-Host "Docker pull failed with a non-zero exit code"
        exit 1
    }
}

Invoke-PesterTests -TestFile "Docker"