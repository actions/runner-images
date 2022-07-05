param(
    [String] [Parameter (Mandatory=$true)] $Image,
    [String] [Parameter (Mandatory=$true)] $ResourcesNamePrefix,
    [String] [Parameter (Mandatory=$true)] $StorageAccount,
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$true)] $ClientSecret,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $TenantId
)

az login --service-principal --username $ClientId --password $ClientSecret --tenant $TenantId | Out-Null

$TempResourceGroupName = "${ResourcesNamePrefix}_${Image}"

$groupExist = az group exists --name $TempResourceGroupName --subscription $SubscriptionId
if ($groupExist -eq "true") {
    $osDiskName = az deployment group list --resource-group $TempResourceGroupName --query "[].properties.parameters.osDiskName.value" -o tsv
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --subscription $SubscriptionId --yes | Out-Null
    Write-Host "Temporary group was deleted successfully"
    Write-Host "Deleting OS disk"
    az storage remove --account-name $StorageAccount -c "images" -n "$osDiskName.vhd" --only-show-errors | Out-Null
    Write-Host "OS disk deleted"
} else {
    Write-Host "No temporary groups found"
}