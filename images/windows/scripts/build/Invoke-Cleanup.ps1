################################################################################
##  File:  Invoke-Cleanup.ps1
##  Desc:  Cleanup WinSxS, temp, cache and compress some directories
################################################################################

Write-Host "Cleanup WinSxS"
dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
if ($LASTEXITCODE -ne 0) {
    throw "Failed to cleanup WinSxS"
}

Write-Host "Clean up various directories"
@(
    "$env:SystemDrive\Recovery",
    "$env:SystemRoot\logs",
    "$env:SystemRoot\winsxs\manifestcache",
    "$env:SystemRoot\Temp",
    "$env:SystemDrive\Users\$env:INSTALL_USER\AppData\Local\Temp",
    "$env:TEMP",
    "$env:AZURE_CONFIG_DIR\logs",
    "$env:AZURE_CONFIG_DIR\commands",
    "$env:AZURE_CONFIG_DIR\telemetry"
) | ForEach-Object {
    if (Test-Path $_) {
        Write-Host "Removing $_"
        cmd /c "takeown /d Y /R /f $_ 2>&1" | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to take ownership of $_"
        }
        cmd /c "icacls $_ /grant:r administrators:f /t /c /q 2>&1" | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to grant administrators full control of $_"
        }
        Remove-Item $_ -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
}

# Remove AllUsersAllHosts profile
Remove-Item $profile.AllUsersAllHosts -Force -ErrorAction SilentlyContinue | Out-Null

# Clean yarn and npm cache
cmd /c "yarn cache clean 2>&1" | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Failed to clean yarn cache"
}

cmd /c "npm cache clean --force 2>&1" | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Failed to clean npm cache"
}

if (Test-IsWin25) {
    $directoriesToCompact = @(
        "C:\Program Files (x86)\Android",
        "C:\Program Files\dotnet",
        "$env:SystemRoot\assembly",
        "$env:SystemRoot\WinSxS"
    )
    Write-Host "Starting Image slimming process"
    $start = get-date
    $ErrorActionPreviousValue = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    foreach ($directory in $directoriesToCompact) {
        Write-Host "Compressing '$directory' directory"
        $compressionResult =  & compact /s:"$directory" /c /a /i /EXE:LZX *
        $compressionResult | Select-Object -Last 3
    }
    $ErrorActionPreference = $ErrorActionPreviousValue
    $finish = get-date
    $time = "$(($finish - $start).Minutes):$(($finish - $start).Seconds)"
    Write-Host "The process took a total of $time (in minutes:seconds)"
}
