################################################################################
##  File: Install-WindowsUpdatesAfterReboot.ps1
##  Desc: Waits for Windows Updates to finish installing after reboot
################################################################################

Invoke-SBWithRetry -RetryCount 10 -RetryIntervalSeconds 120 -Command {
    $inProgress = Get-WindowsUpdatesHistory | Where-Object Status -eq "InProgress" | Where-Object Title -notmatch "Microsoft Defender Antivirus"
    if ( $inProgress ) {
        $title = $inProgress.Title -join "`n"
        throw "InProgress: $title"
    }
}
