$isPathUpdated = $false
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

$dotnetPath = "$env:USERPROFILE\.dotnet\tools"
if ($latestPath.Contains("C:\Users\VssAdministrator\.dotnet\tools"))
{
    $latestPath = $latestPath.Replace("C:\Users\VssAdministrator\.dotnet\tools", "$dotnetPath")
    $isPathUpdated = $true
}

if (-not $latestPath.Contains($dotnetPath))
{
    $latestPath = "$dotnetPath;$latestPath"
    Write-Host "Added .dotnet\tools $dotnetPath to PATH"
    $isPathUpdated = $true
}
else
{
    Write-Host "$dotnetPath already in PATH"
}

if ($isPathUpdated)
{
    [System.Environment]::SetEnvironmentVariable('PATH', $latestPath, [System.EnvironmentVariableTarget]::Machine)
}
$updatedPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
Write-Host "Windows PATH: $updatedPath"