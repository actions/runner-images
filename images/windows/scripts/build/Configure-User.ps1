################################################################################
##  File:  Configure-User.ps1
##  Desc:  Performs user part of warm up and moves data to C:\Users\Default
################################################################################

#
# more: https://github.com/actions/runner-images-internal/issues/5320
#       https://github.com/actions/runner-images/issues/5301#issuecomment-1648292990
#

Write-Host "Warmup 'devenv.exe /updateconfiguration'"
$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
cmd.exe /c "`"$vsInstallRoot\Common7\IDE\devenv.exe`" /updateconfiguration"
if ($LASTEXITCODE -ne 0) {
    throw "Failed to warmup 'devenv.exe /updateconfiguration'"
}

# we are fine if some file is locked and cannot be copied
Copy-Item ${env:USERPROFILE}\AppData\Local\Microsoft\VisualStudio -Destination c:\users\default\AppData\Local\Microsoft\VisualStudio -Recurse -ErrorAction SilentlyContinue

Mount-RegistryHive `
    -FileName "C:\Users\Default\NTUSER.DAT" `
    -SubKey "HKLM\DEFAULT"

reg.exe copy HKCU\Software\Microsoft\VisualStudio HKLM\DEFAULT\Software\Microsoft\VisualStudio /s
if ($LASTEXITCODE -ne 0) {
    throw "Failed to copy HKCU\Software\Microsoft\VisualStudio to HKLM\DEFAULT\Software\Microsoft\VisualStudio"
}

# TortoiseSVN not installed on Windows 2025 image due to Sysprep issues
if (-not (Test-IsWin25)) {
    # disable TSVNCache.exe
    $registryKeyPath = 'HKCU:\Software\TortoiseSVN'
    if (-not(Test-Path -Path $registryKeyPath)) {
        New-Item -Path $registryKeyPath -ItemType Directory -Force
    }

    New-ItemProperty -Path $registryKeyPath -Name CacheType -PropertyType DWORD -Value 0
    reg.exe copy HKCU\Software\TortoiseSVN HKLM\DEFAULT\Software\TortoiseSVN /s
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to copy HKCU\Software\TortoiseSVN to HKLM\DEFAULT\Software\TortoiseSVN"
    }
}
# Accept by default "Send Diagnostic data to Microsoft" consent.
if (Test-IsWin25) {
    $registryKeyPath = 'HKLM:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy'
    New-ItemProperty -Path $registryKeyPath -Name PrivacyConsentPresentationVersion -PropertyType DWORD -Value 3 | Out-Null
    New-ItemProperty -Path $registryKeyPath -Name PrivacyConsentSettingsValidMask -PropertyType DWORD -Value 4 | Out-Null
    New-ItemProperty -Path $registryKeyPath -Name PrivacyConsentSettingsVersion -PropertyType DWORD -Value 5 | Out-Null
}

Dismount-RegistryHive "HKLM\DEFAULT"

# Remove the "installer" (var.install_user) user profile for Windows 2025 image
if (Test-IsWin25) {
    Get-CimInstance -ClassName Win32_UserProfile | where-object {$_.LocalPath -match $env:INSTALL_USER} | Remove-CimInstance -Confirm:$false
    & net user $env:INSTALL_USER /DELETE
}

Write-Host "Configure-User.ps1 - completed"
