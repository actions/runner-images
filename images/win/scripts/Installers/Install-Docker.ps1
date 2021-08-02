################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step becuase it requires a restart before we
##         can continue.
################################################################################

# TO-DO: Will be fixed with https://github.com/actions/virtual-environments-internal/issues/2512
# Write-Host "Install-Package Docker"
# Install-Package -Name docker -ProviderName DockerMsftProvider -Force
# Start-Service docker

# Write-Host "Install-Package Docker-Compose"
# Choco-Install -PackageName docker-compose

$dockerImages = (Get-ToolsetContent).docker.images
foreach ($dockerImage in $dockerImages) {
    Write-Host "Pulling docker image $dockerImage ..."
    docker pull $dockerImage

    if (!$?) {
        Write-Host "Docker pull failed with a non-zero exit code"
        exit 1
    }
}

# Invoke-PesterTests -TestFile "Docker"