$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)

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

$updatedPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
Write-Host "Windows PATH: $updatedPath"