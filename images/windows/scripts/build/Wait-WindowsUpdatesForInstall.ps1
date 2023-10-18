################################################################################
##  File:  Wait-WindowsUpdatesForInstall.ps1
##  Desc:  Wait for installation windows updates to complete
################################################################################

Invoke-SBWithRetry -RetryCount 10 -RetryIntervalSeconds 120 -Command {
    $inProgress = Get-WindowsUpdatesHistory | Where-Object Status -eq "InProgress" | Where-Object Title -notmatch "Microsoft Defender Antivirus"
    if ( $inProgress ) {
        $title = $inProgress.Title -join "`n"
        throw "InProgress: $title"
    }
}
