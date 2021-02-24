Write-Host "Set antivirus parameters"
$processes = @('choco.exe', 'candle.exe', 'heat.exe','light.exe','meteor.bat','mongod.exe','node.exe','python.exe','git.exe')
Set-MpPreference -ScanAvgCPULoadFactor 5 -ExclusionPath "D:\", "C:\" -ExclusionProcess $processes
