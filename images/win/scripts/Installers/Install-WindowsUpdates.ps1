################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Desc:  Install Windows Updates.
##         Should be run at end, just before SoftwareReport and Finalize-VM.ps1.
################################################################################

Write-Host "Run windows updates"
# KB5003638 causes the windows server 2016 virtual machine to hang on shutdown step
if (Test-IsWin16) {
    Get-WUInstall -MicrosoftUpdate
    Write-Host "Hide update KB5003638"
    Hide-WindowsUpdate -Confirm:$false -KBArticleID "KB5003638"
}
Get-WUInstall -MicrosoftUpdate -AcceptAll -Install -IgnoreUserInput -IgnoreReboot
