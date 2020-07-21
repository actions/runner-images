################################################################################
##  File:  Install-Docker.ps1
##  Desc:  Install Docker.
##         Must be an independent step becuase it requires a restart before we
##         can continue.
################################################################################

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
Write-Host "Install-Module DockerProvider"
Install-Module DockerMsftProvider -Force

Write-Host "Install-Package Docker"
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Start-Service docker

Write-Host "Install-Package Docker-Compose"
Choco-Install -PackageName docker-compose

Write-Host "Install Helm"
Choco-Install -PackageName kubernetes-helm

Invoke-PesterTests -TestFile "Tools" -TestName "Docker"