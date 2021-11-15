################################################################################
##  File:  Install-WindowsUpdates.ps1
##  Desc:  Install Windows Updates.
##         Should be run at end, just before SoftwareReport and Finalize-VM.ps1.
################################################################################

function Install-WindowsUpdates {
    Write-Host "Starting wuauserv"
    Start-Service -Name wuauserv -PassThru | Out-Host

    Write-Host "Getting list of available windows updates"
    Get-WindowsUpdate -MicrosoftUpdate -OutVariable updates | Out-Host

    if ( -not $updates ) {
        Write-Host "There are no windows updates to install"
        return
    }

    Write-Host "Installing windows updates"
    Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -IgnoreUserInput -IgnoreReboot | Out-Host

    Write-Host "Validating windows updates installation and skip Microsoft Defender Antivirus"
    # Azure service can automatic updates AV engine(Microsoft.Azure.Security.AntimalwareSignature.AntimalwareConfiguration)
    # Get-WUHistory doesn't support Windows Server 2022
    $wuHistory = Get-WindowsUpdatesHistory | Where-Object { $_.Status -in ("Successful", "InProgress") }
    $wuFail = $updates[0] | Where-Object Title -notmatch "Microsoft Defender Antivirus" | Where-Object { -not ($wuHistory.Title -match $_.KB) }

    if ( $wuFail ) {
        Write-Host "Windows updates failed to install: $($wuFail.KB)"
        exit 1
    }
}

Install-WindowsUpdates

# Create complete windows update file
New-Item -Path $env:windir -Name WindowsUpdateDone.txt -ItemType File | Out-Null
