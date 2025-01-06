################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step because it requires a restart before we
##         can continue.
################################################################################

Write-Host "Get latest Moby release"
$toolsetVersion = (Get-ToolsetContent).docker.components.docker
$mobyVersion = (Get-GithubReleasesByVersion -Repo "moby/moby" -Version "${toolsetVersion}").version
$dockerceUrl = "https://download.docker.com/win/static/stable/x86_64/"
$dockerceBinaries = Invoke-WebRequest -Uri $dockerceUrl -UseBasicParsing

Write-Host "Check Moby version $mobyVersion"
$mobyRelease = $dockerceBinaries.Links.href -match "${mobyVersion}\.zip" | Select-Object -Last 1
if (-not $mobyRelease) {
    Write-Host "Release not found for $mobyLatestRelease version"
    $versions = [regex]::Matches($dockerceBinaries.Links.href, "docker-(\d+\.\d+\.\d+)\.zip") | Sort-Object { [version] $_.Groups[1].Value }
    $mobyRelease = $versions | Select-Object -ExpandProperty Value -Last 1
    Write-Host "Found $mobyRelease"
}
$mobyReleaseUrl = $dockerceUrl + $mobyRelease

Write-Host "Install Moby $mobyRelease..."
$mobyArchivePath = Invoke-DownloadWithRetry $mobyReleaseUrl
Expand-Archive -Path $mobyArchivePath -DestinationPath $env:TEMP_DIR
$dockerPath = "$env:TEMP_DIR\docker\docker.exe"
$dockerdPath = "$env:TEMP_DIR\docker\dockerd.exe"

Write-Host "Install Docker CE"
$instScriptUrl = "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1"
$instScriptPath = Invoke-DownloadWithRetry $instScriptUrl
& $instScriptPath -DockerPath $dockerPath -DockerDPath $dockerdPath
if ($LastExitCode -ne 0) {
    Write-Host "Docker installation failed with exit code $LastExitCode"
    exit $exitCode
}

# Fix AZ CLI DOCKER_COMMAND_ERROR
# cli.azure.cli.command_modules.acr.custom: Could not run 'docker.exe' command.
# https://github.com/Azure/azure-cli/issues/18766
New-Item -ItemType SymbolicLink -Path "C:\Windows\SysWOW64\docker.exe" -Target "C:\Windows\System32\docker.exe"

if (-not (Test-IsWin25)) {
    Write-Host "Download docker images"
    $dockerImages = (Get-ToolsetContent).docker.images
    foreach ($dockerImage in $dockerImages) {
        Write-Host "Pulling docker image $dockerImage ..."
        docker pull $dockerImage

        if (!$?) {
            throw "Docker pull failed with a non-zero exit code ($LastExitCode)"
        }
    }
    Invoke-PesterTests -TestFile "Docker" -TestName "DockerImages"
}

Invoke-PesterTests -TestFile "Docker" -TestName "Docker"
