################################################################################
##  File:  Finalize-VM.ps1
##  Desc:  Clean up temp folders after installs to save space
################################################################################

Write-Host "Cleanup WinSxS"
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

# Sets the default install version to v1 for new distributions
# https://github.com/actions/runner-images/issues/5760
if (Test-IsWin22) {
    Write-Host "Sets the default install version to v1 for new distributions"
    Add-DefaultItem -DefaultVariable "DefaultVersion" -Value 1 -Name "DEFAULT\Software\Microsoft\Windows\CurrentVersion\Lxss" -Kind "DWord"
}

Write-Host "Clean up various directories"
@(
    "$env:SystemDrive\Recovery",
    "$env:SystemRoot\logs",
    "$env:SystemRoot\winsxs\manifestcache",
    "$env:SystemRoot\Temp",
    "$env:SystemDrive\Users\$env:INSTALL_USER\AppData\Local\Temp",
    "$env:TEMP"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        cmd /c "takeown /d Y /R /f $_ 2>&1" | Out-Null
        cmd /c "icacls $_ /grant:r administrators:f /t /c /q 2>&1" | Out-Null
        Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

$winInstallDir = "$env:SystemRoot\Installer"
New-Item -Path $winInstallDir -ItemType Directory -Force | Out-Null

# Remove AllUsersAllHosts profile
Remove-Item $profile.AllUsersAllHosts -Force -ErrorAction SilentlyContinue | Out-Null

# Clean yarn and npm cache
cmd /c "yarn cache clean 2>&1" | Out-Null
cmd /c "npm cache clean --force 2>&1" | Out-Null

# allow msi to write to temp folder
# see https://github.com/actions/runner-images/issues/1704
cmd /c "icacls $env:SystemRoot\Temp /grant Users:f /t /c /q 2>&1" | Out-Null

# Registry settings
$registrySettings = @(
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"; Name = "AUOptions"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"; Name = "NoAutoUpdate"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"; Name = "DoNotConnectToWindowsUpdateInternetLocations"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"; Name = "DisableWindowsUpdateAccess"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"; Name = "PreventDeviceMetadataFromNetwork"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"; Name = "AllowTelemetry"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows"; Name = "CEIPEnable"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"; Name = "AITEnable"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"; Name = "DisableUAR"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"; Name = "AllowTelemetry"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection"; Name = "AllowTelemetry"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance"; Name = "MaintenanceDisabled"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\MRT"; Name = "DontOfferThroughWUAU"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\MRT"; Name = "DontReportInfectionInformation"; Value = 1; PropertyType = "DWORD"}
    @{Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"; Name = "AllowCortana"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SYSTEM\CurrentControlSet\Control"; Name = "ServicesPipeTimeout"; Value = 120000; PropertyType = "DWORD"}
    @{Path = "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener"; Name = "Start"; Value = 0; PropertyType = "DWORD"}
    @{Path = "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger"; Name = "Start"; Value = 0; PropertyType = "DWORD"}
)

$registrySettings | ForEach-Object {
    $regPath = $PSItem.Path
    New-ItemPath -Path $regPath
    New-ItemProperty @PSItem -Force -ErrorAction Ignore
} | Out-Null

# Disable Template Services / User Services added by Desktop Experience
$regUserServicesToDisables = @(
    "HKLM:\SYSTEM\CurrentControlSet\Services\CDPUserSvc"
    "HKLM:\SYSTEM\CurrentControlSet\Services\OneSyncSvc"
    "HKLM:\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc"
    "HKLM:\SYSTEM\CurrentControlSet\Services\UnistoreSvc"
    "HKLM:\SYSTEM\CurrentControlSet\Services\UserDataSvc"
)

$regUserServicesToDisables | ForEach-Object {
    $regPath = $_
    New-ItemPath -Path $regPath
    New-ItemProperty -Path $regPath -Name "Start" -Value 4 -PropertyType DWORD -Force -ErrorAction Ignore
    New-ItemProperty -Path $regPath -Name "UserServiceFlags" -Value 0 -PropertyType DWORD -Force -ErrorAction Ignore
} | Out-Null


# Disabled services
$servicesToDisable = @(
    "wuauserv"
    "DiagTrack"
    "dmwappushservice"
    "PcaSvc"
    "SysMain"
    "gupdate"
    "gupdatem"
)

$servicesToDisable | ForEach-Object {
    Set-Service -Name $_ -StartupType Disabled -ErrorAction Ignore
} | Out-Null

# Disable scheduled tasks
$allTasksInTaskPath = @(
    "\"
    "\Microsoft\Azure\Security\"
    "\Microsoft\VisualStudio\"
    "\Microsoft\VisualStudio\Updates\"
    "\Microsoft\Windows\Application Experience\"
    "\Microsoft\Windows\ApplicationData\"
    "\Microsoft\Windows\Autochk\"
    "\Microsoft\Windows\Chkdsk\"
    "\Microsoft\Windows\Customer Experience Improvement Program\"
    "\Microsoft\Windows\Data Integrity Scan\"
    "\Microsoft\Windows\Defrag\"
    "\Microsoft\Windows\Diagnosis\"
    "\Microsoft\Windows\DiskCleanup\"
    "\Microsoft\Windows\DiskDiagnostic\"
    "\Microsoft\Windows\Maintenance\"
    "\Microsoft\Windows\PI\"
    "\Microsoft\Windows\Power Efficiency Diagnostics\"
    "\Microsoft\Windows\Server Manager\"
    "\Microsoft\Windows\Speech\"
    "\Microsoft\Windows\UpdateOrchestrator\"
    "\Microsoft\Windows\Windows Error Reporting\"
    "\Microsoft\Windows\WindowsUpdate\"
    "\Microsoft\XblGameSave\"
)

$allTasksInTaskPath | ForEach-Object {
    Get-ScheduledTask -TaskPath $_ -ErrorAction Ignore | Disable-ScheduledTask -ErrorAction Ignore
} | Out-Null

$disableTaskNames = @(
    @{TaskPath = "\Microsoft\Windows\.NET Framework\"; TaskName = ".NET Framework NGEN v4.0.30319"}
    @{TaskPath = "\Microsoft\Windows\.NET Framework\"; TaskName = ".NET Framework NGEN v4.0.30319 64"}
    @{TaskPath = "\Microsoft\Windows\AppID\"; TaskName = "SmartScreenSpecific"}
)

$disableTaskNames | ForEach-Object {
    Disable-ScheduledTask @PSItem -ErrorAction Ignore
} | Out-Null

Write-Host "Finalize-VM.ps1 - completed"
