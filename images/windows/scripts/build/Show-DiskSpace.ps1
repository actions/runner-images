################################################################################
##  File:  Show-DiskSpace.ps1
##  Desc:  Log volume space and temporary paths during image generation
################################################################################

Write-Host "Disk space snapshot at $([DateTime]::UtcNow.ToString('o'))"
Write-Host "TEMP=$env:TEMP; TMP=$env:TMP; TEMP_DIR=$env:TEMP_DIR; ChocolateyInstall=$env:ChocolateyInstall"

try {
    Get-Volume -ErrorAction Stop |
        Where-Object { $_.DriveLetter -and $_.Size -gt 0 } |
        Sort-Object DriveLetter |
        Select-Object DriveLetter,
            @{Name = 'FreeGiB'; Expression = { [math]::Round($_.SizeRemaining / 1GB, 2) }},
            @{Name = 'TotalGiB'; Expression = { [math]::Round($_.Size / 1GB, 2) }} |
        Format-Table -AutoSize | Out-String -Width 200 | Write-Host
} catch {
    Write-Warning "Unable to report disk space: $_"
}