################################################################################
##  File:  Run-Antivirus.ps1
##  Desc:  Run a full antivirus scan.
##         Run right after cleanup before we sysprep
################################################################################

try{
    Update-MpSignature
}
catch {
    Write-Host "Some error was found"
}

$run_scan_antivirus = $env:run_scan_antivitrus
if($run_scan_antivitrus -eq $true) {
    Write-Host "Make sure windefend is going to start"
    Start-Service windefend -ErrorAction Continue
    Write-Host "Waiting for windefend to report as running"
    $service = Get-Service "Windefend"
    $service.WaitForStatus("Running","00:10:00")

    Write-Host "Run antivirus"
    # Tell Defender to use 100% of the CPU during the scan
    Set-MpPreference -ScanAvgCPULoadFactor 100
    # Full Scan
    start-procces -FilePath "C:\Program Files\Windows Defender\MpCmdRun.exe" -ArgumentList -Scan -ScanType 2 -Wait
    Write-Host "Set antivirus parmeters"

}
else{
    Write-Host "Scanning procces has not been started"
    Set-MpPreference -ScanAvgCPULoadFactor 5 `
             -ExclusionPath "D:\", "C:\"
}





