################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step becuase it requires a restart before we
##         can continue.
################################################################################

Write-Host "Install-Package Docker"
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Start-Service docker

Write-Host "Install-Package Docker-Compose"
Choco-Install -PackageName docker-compose

$dockerImages = (Get-ToolsetContent).docker.images
foreach ($dockerImage in $dockerImages) {
    Write-Host "Pulling docker image $dockerImage ..."
    docker pull $dockerImage

    if (!$?) {
        Write-Host "Docker pull failed with a non-zero exit code"
        exit 1
    }
}

# fatal: open C:\ProgramData\docker\panic.log: Access is denied.
$panicLog = "C:\ProgramData\docker\panic.log"
if (Test-Path -Path $panicLog) {
    Set-ItemProperty -Path "C:\ProgramData\docker\panic.log" -Name IsReadOnly -Value $false
}

Invoke-PesterTests -TestFile "Docker"