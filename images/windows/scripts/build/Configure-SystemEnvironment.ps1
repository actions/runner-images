################################################################################
##  File:  Configure-SystemEnvironment.ps1
##  Desc:  Configures system environment variables
################################################################################

setx ImageVersion $env:IMAGE_VERSION /m
setx ImageOS $env:IMAGE_OS /m
setx AGENT_TOOLSDIRECTORY $env:AGENT_TOOLSDIRECTORY /m
setx ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE $env:ACTIONS_RUNNER_ACTION_ARCHIVE_CACHE /m
