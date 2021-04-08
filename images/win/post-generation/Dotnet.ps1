$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
$dotnetPath = "$env:USERPROFILE\.dotnet\tools"

if (-not $latestPath.Contains($dotnetPath))
{
    $latestPath = "$dotnetPath;$latestPath"
    [System.Environment]::SetEnvironmentVariable('PATH', $latestPath, [System.EnvironmentVariableTarget]::Machine)
}

# Add nuget.org package source to the default nuget.config file https://github.com/actions/virtual-environments/issues/3038
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org --configfile $env:APPDATA\NuGet\NuGet.Config
