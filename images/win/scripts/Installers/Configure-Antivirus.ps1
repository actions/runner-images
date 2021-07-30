Write-Host "Set antivirus parameters"
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "D:\", "C:\"

Write-Host "Disable Antivirus"
Set-MpPreference -DisableRealtimeMonitoring $true