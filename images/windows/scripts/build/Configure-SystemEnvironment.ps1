################################################################################
##  File:  Configure-SystemEnvironment.ps1
##  Desc:  Configures system environment variables
################################################################################

$variables = @{
    "ImageVersion"                        = $env:IMAGE_VERSION
    "ImageOS"                             = $env:IMAGE_OS
    "AGENT_TOOLSDIRECTORY"                = $env:AGENT_TOOLSDIRECTORY
    "RUNNER_TOOL_CACHE"                   = $env:AGENT_TOOLSDIRECTORY
}

$variables.GetEnumerator() | ForEach-Object {
    [Environment]::SetEnvironmentVariable($_.Key, $_.Value, "Machine")
}
