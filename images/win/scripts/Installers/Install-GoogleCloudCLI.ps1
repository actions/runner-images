################################################################################
##  File:  Install-GoogleCloudCLI.ps1
##  Desc:  Install Google Cloud CLI
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
$googleCloudCLIInstaller = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
$argumentList = @("/S", "/allusers", "/noreporting")
Install-Binary -Url $googleCloudCLIInstaller -Name "GoogleCloudSDKInstaller.exe" -ArgumentList $argumentList

Invoke-PesterTests -TestFile "Tools" -TestName "GoogleCloudCLI"
