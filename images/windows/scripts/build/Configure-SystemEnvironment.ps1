################################################################################
##  File:  Configure-SystemEnvironment.ps1
##  Desc:  Configures system environment variables
################################################################################

$variables = @{
  "ImageVersion"                        = $env:IMAGE_VERSION
  "ImageOS"                             = $env:IMAGE_OS
  "AGENT_TOOLSDIRECTORY"                = $env:AGENT_TOOLSDIRECTORY
  "ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE" = $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE
}

$variables.GetEnumerator() | ForEach-Object {
  [Environment]::SetEnvironmentVariable($_.Key, $_.Value, "Machine")
}
