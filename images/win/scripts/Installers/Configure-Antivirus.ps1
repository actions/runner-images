Write-Host "Set antivirus parameters"
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "D:\", "C:\"
$processes = @('choco.exe', 'candle.exe', 'heat.exe','light.exe','meteor.bat','mongod.exe','node.exe','python.exe','git.exe')
Add-MpPreference -ExclusionProcess $processes
