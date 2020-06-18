################################################################################
##  File:  Validate-Edge.ps1
##  Desc:  Validate Microsoft Edge installation.
################################################################################

$RegistryKey = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
if (Test-Path $RegistryKey)
{
    (Get-Item (Get-ItemProperty $RegistryKey).'(Default)').VersionInfo
}
else
{
    Write-Host "Microsoft Edge is not installed."
    exit 1
}
