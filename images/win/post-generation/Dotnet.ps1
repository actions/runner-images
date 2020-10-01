$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)

$dotnetPath = "$env:USERPROFILE\.dotnet\tools"
if ($latestPath.Contains("C:\Users\VssAdministrator\.dotnet\tools"))
{
    $latestPath = $latestPath.Replace("C:\Users\VssAdministrator\.dotnet\tools", "$dotnetPath")
}

if (-not $latestPath.Contains($dotnetPath))
{
    $latestPath = "$dotnetPath;$latestPath"
}