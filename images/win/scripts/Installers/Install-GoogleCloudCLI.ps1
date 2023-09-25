################################################################################
##  File:  Install-GoogleCloudCLI.ps1
##  Desc:  Install Google Cloud CLI
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
$googleCloudCLIInstaller = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
$argumentList = @("/S", "/allusers", "/noreporting")
$googleCloudCLISignatureThumbprint = "2673EA6CC23BEFFDA49AC715B121544098A1284C"

Install-Binary -Url $googleCloudCLIInstaller -Name "GoogleCloudSDKInstaller.exe" -ArgumentList $argumentList -ExpectedSignature $googleCloudCLISignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "GoogleCloudCLI"
