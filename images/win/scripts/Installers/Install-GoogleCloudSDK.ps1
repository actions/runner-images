################################################################################
##  File:  Install-GoogleCloudSDK.ps1
##  Desc:  Install Google Cloud SDK
################################################################################

# https://cloud.google.com/sdk/docs/downloads-interactive
$googleCloudSDKInstaller = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
$argumentList = @("/S", "/allusers", "/noreporting")
Install-Binary -Url $googleCloudSDKInstaller -Name "GoogleCloudSDKInstaller.exe" -ArgumentList $argumentList

# Simple validation gcloud, gsutil, and bq command line tools
$env:Path += ";${env:ProgramFiles(x86)}\Google\Cloud SDK\google-cloud-sdk\bin"
$validateTools = @("bq", "gcloud", "gsutil")
foreach($tool in $validateTools)
{
    if (Get-Command -Name $tool)
    {
        Write-Host "$tool on path"
    }
    else
    {
        Write-Host "$tool is not on path"
        exit 1
    }
}
