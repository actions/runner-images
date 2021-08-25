################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Desc:  Install Windows Updates.
##         Should be run at end, just before SoftwareReport and Finalize-VM.ps1.
################################################################################

Write-Host "Run windows updates"
# KB5005030 causes Windows Server 2019 virtual machine issues with running tests
if (Test-IsWin19) {
    Get-WUInstall -MicrosoftUpdate
    Write-Host "Hide update KB5005030"
    Hide-WindowsUpdate -Confirm:$false -KBArticleID "KB5005030"
}
Get-WUInstall -MicrosoftUpdate -AcceptAll -Install -IgnoreUserInput -IgnoreReboot
