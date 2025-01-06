param(
    [Parameter (Mandatory=$true)] [string] $TempResourceGroupName,
    [Parameter (Mandatory=$true)] [string] $SubscriptionId,
    [Parameter (Mandatory=$true)] [string] $ClientId,
    [Parameter (Mandatory=$true)] [string] $ClientSecret,
    [Parameter (Mandatory=$true)] [string] $TenantId
)

az login --service-principal --username $ClientId --password=$ClientSecret --tenant $TenantId | Out-Null
az account set --subscription $SubscriptionId | Out-Null

$groupExist = az group exists --name $TempResourceGroupName
if ($groupExist -eq "true") {
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --yes | Out-Null
    Write-Host "Temporary group was deleted successfully"
} else {
    Write-Host "No temporary groups found"
}
