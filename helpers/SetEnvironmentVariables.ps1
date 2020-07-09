Function SetEnvironmentVariables {
    $env:SubscriptionId = "11111111-1111-1111-1111-111111111111"
    $env:ResourceGroupName = "rg-name"
    $env:ImageGenerationRepositoryRoot = "/tmp/virtual-environments"
    $env:ImageType = "Windows2019" ## Windows2016 | Windows2019 | Ubuntu1604 | Ubuntu1804
    $env:AzureLocation = "Central US" ## The Azure Location: Central US, East US 2, etc.
    $env:GithubFeedToken = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    $env:ServicePrincipalDisplayName = "SPN-Display-Name"
    $env:ServicePrincipalClientSecret = "22222222-2222-2222-2222-22222222222"
}