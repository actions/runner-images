################################################################################
##  File:  Validate-Chrome.ps1
##  Desc:  Validate Google Chrome installation.
################################################################################

if (Test-Path 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe')
{
    (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
}
else
{
    Write-Host 'Google Chrome is not installed.'
    exit 1
}
