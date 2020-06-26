################################################################################
##  File:  Validate-GoogleCloudSDK.ps1
##  Desc:  Validate Install Google Cloud SDK for Windows
################################################################################

# Simple validation gcloud, gsutil, and bq command line tools
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
