################################################################################
##  File:  Install-GoogleCloudCLI.ps1
##  Desc:  Install Google Cloud CLI
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
Install-Binary `
  -Url 'https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe' `
  -InstallArgs @("/S", "/allusers", "/noreporting") `
  -ExpectedSignature '2673EA6CC23BEFFDA49AC715B121544098A1284C'

Invoke-PesterTests -TestFile "Tools" -TestName "GoogleCloudCLI"
