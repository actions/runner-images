$latestPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
$dotnetPath = "$env:USERPROFILE\.dotnet\tools"

if (-not $latestPath.Contains($dotnetPath))
{
    $latestPath = "$dotnetPath;$latestPath"
    [System.Environment]::SetEnvironmentVariable('PATH', $latestPath, [System.EnvironmentVariableTarget]::Machine)
}

# Delete empty nuget.config file created by choco and recreate the config using the 'dotnet nuget list source command'
# before choco or powershell’s ancient embedded nuget does to prevent the issue with downloading packages from nuget.org
# https://github.com/actions/virtual-environments/issues/3038
$nugetConfigPath = "$env:APPDATA\NuGet\NuGet.Config"
if (Test-Path $nugetConfigPath) 
{
    Remove-Item $nugetConfigPath -Force
}
dotnet nuget list source
