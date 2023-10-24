################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step because it requires a restart before we
##         can continue.
##  Supply chain security: (docker-wincred) checksum validation
################################################################################

#region functions
Function Get-DockerWincredHash
{
 Param (
    [Parameter(Mandatory = $True)]
    [string] $Release
)

 $hashURL = "https://github.com/docker/docker-credential-helpers/releases/download/${Release}/checksums.txt "
 (Invoke-RestMethod -Uri $hashURL).ToString().Split("`n").Where({ $_ -ilike "*docker-credential-wincred-${Release}.windows-amd64.exe*" }).Split(' ')[0]

}
#endregion

Write-Host "Get latest Moby release"
$mobyLatestReleaseVersion = (Invoke-RestMethod -Uri "https://api.github.com/repos/moby/moby/releases/latest").tag_name.Trim("v")
$dockerceUrl = "https://download.docker.com/win/static/stable/x86_64/"
$dockerceBinaries = Invoke-WebRequest -Uri $dockerceUrl -UseBasicParsing

Write-Host "Check Moby version $mobyLatestReleaseVersion"
$mobyRelease = $dockerceBinaries.Links.href -match "${mobyLatestReleaseVersion}\.zip" | Select-Object -Last 1
if (-not $mobyRelease) {
    Write-Host "Release not found for $mobyLatestRelease version"
    $versions = [regex]::Matches($dockerceBinaries.Links.href, "docker-(\d+\.\d+\.\d+)\.zip") | Sort-Object { [version]$_.Groups[1].Value }
    $mobyRelease = $versions | Select-Object -ExpandProperty Value -Last 1
    Write-Host "Found $mobyRelease"
}
$mobyReleaseUrl = $dockerceUrl + $mobyRelease

Write-Host "Install Moby $mobyRelease..."
$mobyArchivePath = Start-DownloadWithRetry -Url $mobyReleaseUrl -Name $mobyRelease
Expand-Archive -Path $mobyArchivePath -DestinationPath $env:TEMP
$dockerPath = "$env:TEMP\docker\docker.exe"
$dockerdPath = "$env:TEMP\docker\dockerd.exe"

Write-Host "Install Docker CE"
$instScriptUrl = "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1"
$instScriptPath = Start-DownloadWithRetry -Url $instScriptUrl -Name "install-docker-ce.ps1"
& $instScriptPath -DockerPath $dockerPath -DockerDPath $dockerdPath
if ($LastExitCode -ne 0) {
    Write-Host "Docker installation failed with exit code $LastExitCode"
    exit $exitCode
}

# Fix AZ CLI DOCKER_COMMAND_ERROR
# cli.azure.cli.command_modules.acr.custom: Could not run 'docker.exe' command.
# https://github.com/Azure/azure-cli/issues/18766
New-Item -ItemType SymbolicLink -Path "C:\Windows\SysWOW64\docker.exe" -Target "C:\Windows\System32\docker.exe"

Write-Host "Install-Package Docker-Compose v1"
$versionToInstall = Get-LatestChocoPackageVersion -TargetVersion "1.29" -PackageName "docker-compose"
Choco-Install -PackageName docker-compose -ArgumentList "--version=$versionToInstall"

Write-Host "Install-Package Docker-Compose v2"
$dockerComposev2Url = "https://github.com/docker/compose/releases/latest/download/docker-compose-windows-x86_64.exe"
$cliPluginsDir = "C:\ProgramData\docker\cli-plugins"
New-Item -Path $cliPluginsDir -ItemType Directory
Start-DownloadWithRetry -Url $dockerComposev2Url -Name docker-compose.exe -DownloadPath $cliPluginsDir

Write-Host "Install docker-wincred"
$dockerCredLatestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/docker/docker-credential-helpers/releases/latest"
$dockerCredDownloadUrl = $dockerCredLatestRelease.assets.browser_download_url -match "docker-credential-wincred-.+\.exe" | Select-Object -First 1
Start-DownloadWithRetry -Url $dockerCredDownloadUrl -DownloadPath "C:\Windows\System32" -Name "docker-credential-wincred.exe"

#region Supply chain security
$distributor_file_hash = Get-DockerWincredHash -Release $dockerCredLatestRelease.name
$local_file_hash = (Get-FileHash -Path 'C:\Windows\System32\docker-credential-wincred.exe' -Algorithm SHA256).Hash

if ($local_file_hash -ne $distributor_file_hash) {
    Write-Host "hash must be equal to: ${distributor_file_hash}"
    Write-Host "actual hash is: ${local_file_hash}"
    throw 'Checksum verification failed, please rerun install'
}
#endregion

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
