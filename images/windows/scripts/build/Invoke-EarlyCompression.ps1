################################################################################
##  File:  Invoke-EarlyCompression.ps1
##  Desc:  Compress large directories right after they are populated to keep
##         enough free disk space until the end of the build. The same directories
##         are compressed again in Invoke-Cleanup.ps1, which skips compressed files.
################################################################################

if (-not (Test-IsWin25-X64)) {
    Write-Host "Early compression is only used on Windows Server 2025 x64, skipping"
    return
}

$directoriesToCompact = @(
    "C:\Program Files (x86)\Android",
    "C:\Program Files\dotnet"
)

$freeBefore = (Get-PSDrive -Name C).Free
$start = Get-Date
$ErrorActionPreferenceValue = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
# compact.exe compresses one file at a time, so compress the directories in parallel
$compactJobs = foreach ($directory in $directoriesToCompact) {
    if (Test-Path $directory) {
        Write-Host "Compressing '$directory' directory"
        $logFile = Join-Path $env:TEMP_DIR "early-compact-$(Split-Path $directory -Leaf).log"
        $process = Start-Process -FilePath "compact.exe" -ArgumentList "/s:`"$directory`"", "/c", "/a", "/i", "/EXE:LZX", "*" `
            -NoNewWindow -PassThru -RedirectStandardOutput $logFile
        @{ Directory = $directory; Process = $process; LogFile = $logFile }
    }
}
foreach ($job in $compactJobs) {
    $job.Process | Wait-Process
    Write-Host "Compressed '$($job.Directory)' directory"
    Get-Content -Path $job.LogFile -Tail 3
}
$ErrorActionPreference = $ErrorActionPreferenceValue

$freed = [math]::Round(((Get-PSDrive -Name C).Free - $freeBefore) / 1GB, 2)
Write-Host "Early compression took $([math]::Round(((Get-Date) - $start).TotalMinutes, 1)) minutes and freed $freed GB"
