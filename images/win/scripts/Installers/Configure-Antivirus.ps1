Write-Host "Set antivirus parameters"
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "C:\", "D:\", "E:\"
$processes = @('choco.exe', 'candle.exe', 'heat.exe','light.exe','meteor.bat','mongod.exe','node.exe','python.exe','git.exe')
Add-MpPreference -ExclusionProcess $processes
