param(
    [String] [Parameter (Mandatory=$true)] $Image,
    [String] [Parameter (Mandatory=$true)] $VcenterServer,
    [String] [Parameter (Mandatory=$true)] $VcenterUsername,
    [String] [Parameter (Mandatory=$true)] $VcenterPassword,
    [String] [Parameter (Mandatory=$true)] $VcenterDatacenter,
    [String] [Parameter (Mandatory=$true)] $EsxiCluster,
    [String] [Parameter (Mandatory=$true)] $TargetDatastore,
    [String] [Parameter (Mandatory=$true)] $OutputFolder,
    [String] [Parameter (Mandatory=$true)] $VmUsername,
    [String] [Parameter (Mandatory=$true)] $VmPassword,
    [String] [Parameter (Mandatory=$true)] $BuildId,
    [String] [Parameter (Mandatory=$true)] $BaseImageName,
    [String] [Parameter (Mandatory=$true)] $AzureStorageSas,
    [String] [Parameter (Mandatory=$true)] $AzureStorageAccount,
    [String] [Parameter (Mandatory=$true)] $BuildAssetsUrl,
    [String] [Parameter (Mandatory=$true)] $GithubFeedToken,
    [String] [Parameter (Mandatory=$true)] $XcodeInstallationUser,
    [String] [Parameter (Mandatory=$true)] $XcodeInstallationPassword
)

$TemplatePath = (Get-ChildItem -Path "images" -Include "$Image.json" -Recurse -Depth 2).FullName
if (-not $TemplatePath)
{
    Write-Error "'-Image' parameter is not valid. You have to specify correct image type."
    exit 1
}

$env:PACKER_LOG = 0

packer validate -syntax-only $TemplatePath

Write-Host "Show Packer Version"
packer --version

Write-Host "Build $Image VM"
packer build -on-error=abort -var="vcenter_server=$VcenterServer" `
                             -var="vcenter_username=$VcenterUsername" `
                             -var="vcenter_password=$VcenterPassword" `
                             -var="vcenter_datacenter=$VcenterDatacenter" `
                             -var="cluster_or_esxi_host=$EsxiCluster" `
                             -var="esxi_datastore=$TargetDatastore" `
                             -var="output_folder=$OutputFolder" `
                             -var="vm_username=$VmUsername" `
                             -var="vm_password=$VmPassword" `
                             -var="build_id=$BuildId" `
                             -var="baseimage_name=$BaseImageName" `
                             -var="azure_storage_sas=$AzureStorageSas" `
                             -var="azure_storage_account=$AzureStorageAccount" `
                             -var="build_assets_url=$BuildAssetsUrl" `
                             -var="github_feed_token=$GithubFeedToken" `
                             -var="xcode_install_user=$XcodeInstallationUser" `
                             -var="xcode_install_password=$XcodeInstallationPassword" `
                             -color=false `
                             $TemplatePath