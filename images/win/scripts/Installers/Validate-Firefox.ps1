################################################################################
##  File:  Validate-Firefox.ps1
##  Desc:  Validate Mozilla Firefox installation.
################################################################################

if (Test-Path 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe')
{
    (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo
}
else
{
    Write-Host 'Mozilla Firefox is not installed.'
    exit 1
}
