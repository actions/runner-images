param (
  [String] [Parameter (Mandatory = $true)] $SubscriptionId,
  [String] [Parameter (Mandatory = $true)] $Location,
  [String] [Parameter (Mandatory = $true)] $ResourceGroupName,
  
  [String] [Parameter (Mandatory = $true)] $ManagedImageName,
  
  [String] [Parameter (Mandatory = $true)] $GalleryName,
  [String] [Parameter (Mandatory = $true)] $GalleryImageSku,
  [String] [Parameter (Mandatory = $true)] $GalleryImageVersion,
  
  [String] [Parameter (Mandatory = $true)] $StorageAccountName,
  [String] [Parameter (Mandatory = $true)] $StorageAccountContainerName,
  [String] [Parameter (Mandatory = $true)] $VhdName,

  [Switch] [Parameter (Mandatory = $false)] $RemoveManagedImage,
  
  [String] [Parameter (Mandatory = $true)] $ClientId,
  [String] [Parameter (Mandatory = $true)] $ClientSecret,
  [String] [Parameter (Mandatory = $true)] $TenantId
)

$ErrorActionPreference = "Stop"

# Login to Azure
az login --service-principal --username $ClientId --password $ClientSecret --tenant $TenantId | Out-Null
az account set --subscription $SubscriptionId | Out-Null

# Create Compute Image Gallery if it doesn't exist
Write-Host "Creating Compute Image Gallery '$GalleryName'..."
$galleryExists = az sig list --resource-group $ResourceGroupName --query "[?name=='$GalleryName']" -o tsv
if ($null -eq $galleryExists) {
  az sig create --resource-group $ResourceGroupName --gallery-name $GalleryName --location $Location
}

# Create Image Definition if it doesn't exist
Write-Host "Creating Image Definition '$ManagedImageName'..."
$imageDefinitionName = "RunnerImage-$GalleryImageSku"
if ($ManagedImageName -like "*windows*") {
  $imageOsType = "Windows"
} elseif ($ManagedImageName -like "*ubuntu*") {
  $imageOsType = "Linux"
} else {
  throw "Unknown OS type for image '$ManagedImageName'"
}

$galleryImageExists = az sig image-definition list --resource-group $ResourceGroupName --gallery-name $GalleryName --query "[?name=='$imageDefinitionName']" -o tsv
if ($null -eq $galleryImageExists) {
  az sig image-definition create `
    --resource-group $ResourceGroupName `
    --gallery-name $GalleryName `
    --gallery-image-definition $imageDefinitionName `
    --publisher "GuthubImagesGeneration" `
    --offer "RunnerImage" `
    --sku $GalleryImageSku `
    --os-type $imageOsType `
    --location $Location
}

# Create Image Version from existing Managed Image
Write-Host "Creating Image Version '$GalleryImageVersion' from Managed Image '$ManagedImageName'..."
az sig image-version create `
  --resource-group $ResourceGroupName `
  --gallery-name $GalleryName `
  --gallery-image-definition $imageDefinitionName `
  --gallery-image-version $GalleryImageVersion `
  --managed-image "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Compute/images/$ManagedImageName" `
  --target-regions $Location `
  --replica-count 1 `
  --location $Location

# Create Azure Managed Disk from Shared Image Gallery
Write-Host "Creating Azure Managed Disk '$ManagedImageName' from Shared Image Gallery..."
az disk create `
  --resource-group $ResourceGroupName `
  --name $ManagedImageName `
  --location $Location `
  --gallery-image-reference "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/Microsoft.Compute/galleries/$GalleryName/images/$imageDefinitionName/versions/$GalleryImageVersion"

# Generate SAS URL for the Managed Disk
Write-Host "Generating SAS URL for the Managed Disk '$ManagedImageName'..."
$sourceDiskUri = az disk grant-access `
  --resource-group $ResourceGroupName `
  --name $ManagedImageName `
  --duration-in-seconds 86400 `
  --access-level Read `
  --query [accessSas] -o tsv

Write-Host "Querying key for the storage account '$StorageAccountName'..."
$targetKey = az storage account keys list `
  --resource-group $ResourceGroupName `
  --account-name $StorageAccountName `
  --query "[0].value" -o tsv

Write-Host ("Copying VHD blob from '{0}' to 'https://{1}.blob.core.windows.net/{2}/{3}'..." `
    -f $sourceDiskUri.Split('?')[0], $StorageAccountName, $StorageAccountContainerName, $VhdName)

az storage blob copy start `
  --source-uri """$sourceDiskUri""" `
  --destination-blob $VhdName `
  --destination-container $StorageAccountContainerName `
  --account-name $StorageAccountName `
  --account-key $targetKey `
  --only-show-errors

Write-Host "Waiting for the copy to complete..."
while ($true) {
  $status = az storage blob show `
    --container-name $StorageAccountContainerName `
    --name $VhdName `
    --account-name $StorageAccountName `
    --account-key $targetKey `
    --query "properties.copy.status" -o tsv

  if ($status -eq "success") {
    Write-Host "Copy completed successfully."
    break
  } elseif ($status -ne "pending") {
    Write-Host "Copy failed with status '$status', see blob information below:"
    az storage blob show `
      --container-name $StorageAccountContainerName `
      --name $VhdName `
      --account-name $StorageAccountName `
      --account-key $targetKey
    throw "Copy failed with status '$status'"
  }

  $progress = az storage blob show `
    --container-name $StorageAccountContainerName `
    --name $VhdName `
    --account-name $StorageAccountName `
    --account-key $targetKey `
    --query "properties.copy.progress" -o tsv

  Write-Host "Progress: $(($progress.Split("/")[0] / $progress.Split("/")[1]).ToString("P"))"
  Start-Sleep -Seconds 15
}

Write-Host "Successfully converted '$ManagedImageName' to '$VhdName' in '$StorageAccountName' storage account."

# Remove Managed Image if requested
if ($RemoveManagedImage) {
  Write-Host "Removing Managed Image '$ManagedImageName'..."
  az image delete `
    --resource-group $ResourceGroupName `
    --name $ManagedImageName `
    --only-show-errors
  if ($LastExitCode) {
    Write-Host "Warning: Failed to delete the Managed Image '$ManagedImageName'."
  }
}

Write-Host "Cleaning up..."

# Revoke SAS URL for the Managed Disk
az disk revoke-access `
  --resource-group $ResourceGroupName `
  --name $ManagedImageName `
  --only-show-errors
if ($LastExitCode) {
  Write-Host "Warning: Failed to revoke access to the Managed Disk '$ManagedImageName'."
}

# Delete Azure Managed Disk from Shared Image Gallery
az disk delete `
  --resource-group $ResourceGroupName `
  --name $ManagedImageName `
  --only-show-errors `
  --yes
if ($LastExitCode) {
  Write-Host "Warning: Failed to delete the Managed Disk '$ManagedImageName'."
}

# Delete Image Version from Shared Image Gallery
az sig image-version delete `
  --resource-group $ResourceGroupName `
  --gallery-name $GalleryName `
  --gallery-image-definition $imageDefinitionName `
  --gallery-image-version $GalleryImageVersion `
  --only-show-errors
if ($LastExitCode) {
  Write-Host "Warning: Failed to delete the Image Version '$GalleryImageVersion'."
}

Write-Host "Done."
