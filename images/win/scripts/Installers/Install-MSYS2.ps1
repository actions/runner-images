################################################################################
##  File:  Install-MSYS2.ps1
##  Desc:  Install MSYS2 via chocolaty
################################################################################

Import-Module -Name ImageHelpers

$msys2Path = "C:\tools\msys64"
choco install msys2 -y --params "/InstallDir:$msys2Path"

Add-MachinePathItem $msys2Path
