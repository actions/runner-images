################################################################################
##  File:  Install-DebianImage.ps1
##  Desc:  Install Debian Image for WSL
################################################################################

Import-Module -Name ImageHelpers

debianTempDir = "C:\Temp\debian"

if (-not (Test-Path $debianPath)) {
    New-Item -Path debianTempDir -ItemType Directory
}

Push-Location debianTempDir

$debianZipName = "debian.zip"
Invoke-WebRequest -Uri "https://aka.ms/wsl-debian-gnulinux" -OutFile $debianZipName

$debianPath = "C:\tools\debian"
Expand-Archive -Path $debianZipName -DestinationPath $debianPath

Add-MachinePathItem $debianPath

debian install --root
debian run apt update
debian run DEBIAN_FRONTEND=noninteractive apt upgrade -y

Pop-Location
Remove-Item debianTempDir -Recurse -Force
