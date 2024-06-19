################################################################################
##  File:  Install-GoogleCloudCLI.ps1
##  Desc:  Install Google Cloud CLI
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
Install-Binary `
  -Url 'https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe' `
  -InstallArgs @("/S", "/allusers", "/noreporting") `
  -ExpectedSignature '607A3EDAA64933E94422FC8F0C8038850590986C'

Invoke-PesterTests -TestFile "Tools" -TestName "GoogleCloudCLI"
