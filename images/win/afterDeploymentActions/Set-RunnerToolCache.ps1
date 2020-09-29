if ([string]::IsNullOrEmpty($env:RUNNER_TOOL_CACHE)) 
{
    $env:RUNNER_TOOL_CACHE=$env:AGENT_TOOLSDIRECTORY
    [System.Environment]::SetEnvironmentVariable('RUNNER_TOOL_CACHE', $env:AGENT_TOOLSDIRECTORY, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "RUNNER_TOOL_CACHE set to match AGENT_TOOLSDIRECTORY: $env:RUNNER_TOOL_CACHE"

    [System.Environment]::SetEnvironmentVariable('AGENT_TOOLSDIRECTORY', $null, [System.EnvironmentVariableTarget]::Machine)
    $isAgentToolsDirectoryNotThere = [string]::IsNullOrEmpty($env:RUNNER_TOOL_CACHE)
    Write-Host "AGENT_TOOLSDIRECTORY deleted: $isAgentToolsDirectoryNotThere" 
} 
else 
{
    Write-Host "RUNNER_TOOL_CACHE non-empty: $env:RUNNER_TOOL_CACHE"
}
