################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Desc:  Install Windows Updates.
##         Should be run at end, just before SoftwareReport and Finalize-VM.ps1.
################################################################################

Write-Host "Run windows updates"
Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Get-WUInstall -MicrosoftUpdate -AcceptAll -Install -IgnoreUserInput -IgnoreReboot
