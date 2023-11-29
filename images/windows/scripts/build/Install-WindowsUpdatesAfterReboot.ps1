################################################################################
##  File: Install-WindowsUpdatesAfterReboot.ps1
##  Desc: Waits for Windows Updates to finish installing after reboot
################################################################################

Invoke-ScriptBlockWithRetry -RetryCount 10 -RetryIntervalSeconds 120 -Command {
    $inProgress = Get-WindowsUpdateStates | Where-Object State -eq "Running" | Where-Object Title -notmatch "Microsoft Defender Antivirus"
    if ( $inProgress ) {
        $title = $inProgress.Title -join "`n"
        throw "Windows updates are still installing: $title"
    }
}
