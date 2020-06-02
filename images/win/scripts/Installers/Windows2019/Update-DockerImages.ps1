################################################################################
##  File:  Update-DockerImages.ps1
##  Desc:  Pull some standard docker images.
##         Must be run after docker is installed.
################################################################################

function DockerPull {
    Param ([string]$image)

    Write-Host Installing $image ...
    docker pull $image

    if (!$?) {
      Write-Host "Docker pull failed with a non-zero exit code"
      exit 1
    }
}

DockerPull mcr.microsoft.com/windows/servercore:ltsc2019
DockerPull mcr.microsoft.com/windows/nanoserver:1809
DockerPull microsoft/aspnetcore-build:1.0-2.0
DockerPull mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
DockerPull mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019

