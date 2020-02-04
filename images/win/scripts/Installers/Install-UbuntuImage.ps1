################################################################################
##  File:  Install-UbuntuImage.ps1
##  Desc:  Install Ubuntu 18.04 Image for WSL
################################################################################

Import-Module -Name ImageHelpers

$ubuntuTempDir = "$env:AGENT_TEMPDIRECTORY\ubuntu"

if (-not (Test-Path $ubuntuTempDir)) {
    New-Item -Path $ubuntuTempDir -ItemType Directory
}

Push-Location $ubuntuTempDir

$ubuntuZipName = "ubuntu.zip"
Invoke-WebRequest -Uri "https://aka.ms/wsl-ubuntu-1804" -OutFile $ubuntuZipName

$ubuntuPath = "C:\tools\ubuntu"
if (-not (Test-Path $ubuntuPath)) {
    New-Item -Path $ubuntuPath -ItemType Directory
}

Expand-Archive -Path $ubuntuZipName -DestinationPath $ubuntuPath

Add-MachinePathItem $ubuntuPath

ubuntu1804 install --root
ubuntu1804 run apt update
ubuntu1804 run DEBIAN_FRONTEND=noninteractive apt upgrade -y

Pop-Location
Remove-Item $ubuntuTempDir -Recurse -Force
