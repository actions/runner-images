# https://docs.microsoft.com/en-us/windows/win32/sysinfo/gdi-objects
# This value can be set to a number between 256 and 65,536

$defaultValue = 20000
Write-Host "Set the GDIProcessHandleQuota value to $defaultValue"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -Name GDIProcessHandleQuota -Value $defaultValue
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows" -Name GDIProcessHandleQuota -Value $defaultValue

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "GDIProcessHandleQuota"
