################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Desc:  Install Windows Updates.
##         Should be run at end, just before SoftwareReport and Finalize-VM.ps1.
################################################################################

function Install-WindowsUpdates {
    Write-Host "Starting wuauserv"
    Start-Service -Name wuauserv -PassThru | Out-Host

    # Temporarily exclude Windows update KB5034439 since it throws an error.
    # The known issue (https://support.microsoft.com/en-au/topic/kb5034439-windows-recovery-environment-update-for-azure-stack-hci-version-22h2-and-windows-server-2022-january-9-2024-6f9d26e6-784c-4503-a3c6-0beedda443ca)
    Write-Host "Getting list of available windows updates"
    Get-WindowsUpdate -MicrosoftUpdate -NotKBArticleID "KB5034439" -OutVariable updates | Out-Host

    if ( -not $updates ) {
        Write-Host "There are no windows updates to install"
        return
    }

    Write-Host "Installing windows updates"
    Get-WindowsUpdate -MicrosoftUpdate -NotKBArticleID "KB5034439" -AcceptAll -Install -IgnoreUserInput -IgnoreReboot | Out-Host

    Write-Host "Validating windows updates installation"
    # Get-WUHistory doesn't support Windows Server 2022
    $notFailedUpdateNames = Get-WindowsUpdateStates | Where-Object { $_.State -in ("Installed", "Running") } | Select-Object -ExpandProperty Title
    # We ignore Microsoft Defender Antivirus updates; Azure service updates AV automatically
    $failedUpdates = $updates[0] | Where-Object Title -notmatch "Microsoft Defender Antivirus" | Where-Object { -not ($notFailedUpdateNames -match $_.KB) }

    if ( $failedUpdates ) {
        throw "Windows updates failed to install: $($failedUpdates.KB)"
    }
}

Install-WindowsUpdates

# Create complete windows update file
New-Item -Path $env:windir -Name WindowsUpdateDone.txt -ItemType File | Out-Null
