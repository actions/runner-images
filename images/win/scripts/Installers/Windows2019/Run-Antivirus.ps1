################################################################################
##  File:  Run-Antivirus.ps1
##  Desc:  Run a full antivirus scan.
##         Run right after cleanup before we sysprep
################################################################################

Write-Host "Make sure windefend is going to start"
Start-Service windefend -ErrorAction Continue

Write-Host "Waiting for windefend to report as running"
$service = Get-Service "Windefend"
$service.WaitForStatus("Running","00:10:00")

Write-Host "Run antivirus"
Push-Location "C:\Program Files\Windows Defender"

# Tell Defender to use 100% of the CPU during the scan
Set-MpPreference -ScanAvgCPULoadFactor 100

# Full Scan
.\MpCmdRun.exe -Scan -ScanType 2
Pop-Location

Update-MpSignature
Write-Host "Set antivirus parmeters"
Set-MpPreference -ScanAvgCPULoadFactor 5 `
                 -ExclusionPath "D:\", "C:\"
