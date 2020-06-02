################################################################################
##  File:  Validate-WinAppDriver.ps1
##  Desc:  Validate WinAppDriver installation 
################################################################################

$wad = "Windows Application Driver" 
if (${env:ProgramFiles(x86)})
{
    $wadPath = "${env:ProgramFiles(x86)}\$wad"
}
else
{
    $wadPath = "${env:ProgramFiles}\$wad"
}

if (Test-Path $wadPath -PathType Any)
{
    Write-Host "WinAppDriver directory found."
}
else
{
    Write-Host "Failed to locate WinAppDriver directory. Exiting."
    exit 1
}

#Validate if Developer Mode is enabled
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock";
if ((Get-ItemProperty -Path $path | Select-Object -ExpandProperty "AllowDevelopmentWithoutDevLicense") -eq 1)
{
    Write-Host "Developer Mode is successfully provisioned."
}
else
{
    Write-Host "Developer Mode was not successfully provisioned."
    exit 1
}

