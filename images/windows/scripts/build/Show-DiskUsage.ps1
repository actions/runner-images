################################################################################
##  File:  Show-DiskUsage.ps1
##  Desc:  Print free disk space and the size of the largest directories on the
##         system drive to troubleshoot "not enough space" build failures.
################################################################################

Get-PSDrive -PSProvider FileSystem | Where-Object { $null -ne $_.Free } | ForEach-Object {
    Write-Host ("Disk usage: {0}:\ free {1} GB, used {2} GB" -f $_.Name, [math]::Round($_.Free / 1GB, 2), [math]::Round($_.Used / 1GB, 2))
}

function Get-DirectorySize {
    param ([string] $Path)
    # robocopy in list-only mode sizes a directory much faster than Get-ChildItem
    $summary = robocopy $Path "$env:SystemRoot\Temp\disk-usage-target" /L /E /BYTES /NFL /NDL /NJH /NP /R:0 /W:0 /XJ |
        Select-String -Pattern "^\s*Bytes\s*:\s*(\d+)"
    if ($summary) { return [double]$summary.Matches[0].Groups[1].Value }
    return 0
}

$directories = "C:\", "C:\Program Files", "C:\ProgramData", "C:\Users", "C:\Windows" | ForEach-Object {
    Get-ChildItem $_ -Force -Directory -ErrorAction SilentlyContinue | ForEach-Object FullName
}
$sizes = foreach ($directory in $directories) {
    [pscustomobject]@{ Path = $directory; SizeGB = [math]::Round((Get-DirectorySize $directory) / 1GB, 2) }
}
$sizes | Sort-Object SizeGB -Descending | Select-Object -First 25 | ForEach-Object {
    Write-Host ("Disk usage: {0,8} GB  {1}" -f $_.SizeGB, $_.Path)
}

# robocopy returns non-zero codes on success, do not fail the provisioner
$global:LASTEXITCODE = 0
