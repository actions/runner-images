param(
    [ValidateSet('Windows2019-Azure','Windows2016-Azure','ubuntu1604','ubuntu1804')]
    [String] [Parameter (Mandatory=$true)] $Image,
    [String] [Parameter (Mandatory=$true)] $ResourcesNamePrefix,
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$true)] $ClientSecret,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $TenantId
)

az login --service-principal --username $ClientId --password $ClientSecret --tenant $TenantId

$TempResourceGroupName = "${ResourcesNamePrefix}_${Image}"

Write-Host "ResourcesNamePrefix = $ResourcesNamePrefix"
Write-Host "TempResourceGroupName = $TempResourceGroupName"

$groupExist = az group exists --name $TempResourceGroupName --subscription $SubscriptionId
if ($groupExist -eq "true") {
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --subscription $SubscriptionId --yes
    Write-Host "Temporary group was deleted succesfully" -ForegroundColor Green
} else {
    Write-Host "No temporary groups found"
}
