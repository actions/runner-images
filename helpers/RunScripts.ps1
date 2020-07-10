#----
# Include the Set Environment Variables script and call the function
#----
. './SetEnvironmentVariables.ps1'
SetEnvironmentVariables

#----
# Include the Generate Resources and Image script
#----
. './GenerateResourcesAndImage.ps1'

#----
# Enable the AzureRm prefix aliases for Az modules
#----
Enable-AzureRmAlias

#----
# Login to Azure
#----
Write-Host "Logging in..."
Login-AzureRmAccount

Write-Host "-- Selecting subscription '$env:SubscriptionId'"
Set-AzureRmContext -SubscriptionId $env:SubscriptionId
Write-Host ""

#----
# Call the GenerateResourcesAndImage function
#----
$params = @{
    'SubscriptionId' = $env:SubscriptionId;
    'ResourceGroupName' = $env:ResourceGroupName;
    'ImageGenerationRepositoryRoot' = $env:ImageGenerationRepositoryRoot;
    'ImageType' = $env:ImageType;
    'AzureLocation' = $env:AzureLocation;
    'GithubFeedToken' = $env:GithubFeedToken;
    'ServicePrincipalDisplayName' = $env:ServicePrincipalDisplayName;
    'ServicePrincipalClientSecret' = $env:ServicePrincipalClientSecret;
}

GenerateResourcesAndImage @params -Verbose
