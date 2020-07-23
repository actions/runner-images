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

if (Test-IsWin16) {
  $ltsc = "ltsc2016"
  $nanoserver = "10.0.14393.953"
}
if (Test-IsWin19) {
  $ltsc = "ltsc2019"
  $nanoserver = "1809"
}

DockerPull mcr.microsoft.com/windows/servercore:${ltsc}
DockerPull mcr.microsoft.com/windows/nanoserver:${nanoserver}
DockerPull microsoft/aspnetcore-build:1.0-2.0
DockerPull mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-${ltsc}
DockerPull mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-${ltsc}
