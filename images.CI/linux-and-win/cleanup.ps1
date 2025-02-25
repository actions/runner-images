param(
    [Parameter (Mandatory=$true)] [string] $TempResourceGroupName
)

$groupExist = az group exists --name $TempResourceGroupName
if ($groupExist -eq "true") {
    Write-Host "Found a match, deleting temporary files"
    az group delete --name $TempResourceGroupName --yes | Out-Null
    Write-Host "Temporary group was deleted successfully"
} else {
    Write-Host "No temporary groups found"
}
