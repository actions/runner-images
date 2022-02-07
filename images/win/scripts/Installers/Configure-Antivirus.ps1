Write-Host "Disable Windows Defender..."
Set-MpPreference -DisableArchiveScanning $true
Set-MpPreference -DisableAutoExclusions  $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true
Set-MpPreference -DisableCatchupFullScan $true
Set-MpPreference -DisableCatchupQuickScan $true
Set-MpPreference -DisableIntrusionPreventionSystem $true
Set-MpPreference -DisableIOAVProtection $true
Set-MpPreference -DisablePrivacyMode $true
Set-MpPreference -DisableScanningNetworkFiles $true
Set-MpPreference -DisableScriptScanning $true
Set-MpPreference -MAPSReporting 0
Set-MpPreference -PUAProtection 0
Set-MpPreference -SignatureDisableUpdateOnStartupWithoutEngine $true
Set-MpPreference -SubmitSamplesConsent 2
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "D:\", "C:\"
Set-MpPreference -DisableRealtimeMonitoring $true

if (-not (Test-IsWin16)) {
    Set-MpPreference -EnableControlledFolderAccess Disable
    Set-MpPreference -EnableNetworkProtection Disabled
}

Write-Host "Disable Windows Defender scheduled tasks"
Get-ScheduledTask -TaskPath '\Microsoft\Windows\Windows Defender\' | Disable-ScheduledTask | Out-Null

# https://github.com/actions/virtual-environments/issues/4277
# https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-antivirus-compatibility?view=o365-worldwide
$atpRegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection'
if (Test-Path $atpRegPath) {
    Write-Host "Set Microsoft Defender Antivirus to passive mode"
    Set-ItemProperty -Path $atpRegPath -Name 'ForceDefenderPassiveMode' -Value '1' -Type 'DWORD'
}
