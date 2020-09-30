$hgPath = "$Env:ProgramFiles\Mercurial\"
$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)

if (Test-Path -Path $hgPath)
{
    $latestPath = "$hgPath;$latestPath"
    Write-Host "Added Mercurial to PATH"
    $isPathUpdated = $true
}
else
{
    Write-Host "Didn't find Mercurial at $hgPath. Skipping adding PATH to it."
}

$updatedPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
Write-Host "Windows PATH: $updatedPath"