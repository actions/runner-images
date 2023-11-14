################################################################################
##  File:  Configure-WindowsDefender.ps1
##  Desc:  Disables Windows Defender
################################################################################

Write-Host "Disable Windows Defender..."
$avPreference = @(
    @{DisableArchiveScanning = $true}
    @{DisableAutoExclusions = $true}
    @{DisableBehaviorMonitoring = $true}
    @{DisableBlockAtFirstSeen = $true}
    @{DisableCatchupFullScan = $true}
    @{DisableCatchupQuickScan = $true}
    @{DisableIntrusionPreventionSystem = $true}
    @{DisableIOAVProtection = $true}
    @{DisablePrivacyMode = $true}
    @{DisableScanningNetworkFiles = $true}
    @{DisableScriptScanning = $true}
    @{MAPSReporting = 0}
    @{PUAProtection = 0}
    @{SignatureDisableUpdateOnStartupWithoutEngine = $true}
    @{SubmitSamplesConsent = 2}
    @{ScanAvgCPULoadFactor = 5; ExclusionPath = @("D:\", "C:\")}
    @{DisableRealtimeMonitoring = $true}
    @{ScanScheduleDay = 8}
)

$avPreference += @(
    @{EnableControlledFolderAccess = "Disable"}
    @{EnableNetworkProtection = "Disabled"}
)

$avPreference | Foreach-Object {
    $avParams = $_
    Set-MpPreference @avParams
}

# https://github.com/actions/runner-images/issues/4277
# https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-antivirus-compatibility?view=o365-worldwide
$atpRegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection'
if (Test-Path $atpRegPath) {
    Write-Host "Set Microsoft Defender Antivirus to passive mode"
    Set-ItemProperty -Path $atpRegPath -Name 'ForceDefenderPassiveMode' -Value '1' -Type 'DWORD'
}
