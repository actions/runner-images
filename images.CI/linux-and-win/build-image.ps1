param(
    [String] [Parameter (Mandatory=$true)] $TemplatePath,
    [String] [Parameter (Mandatory=$true)] $BuildTemplateName,
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$false)] $ClientSecret,
    [String] [Parameter (Mandatory=$true)] $Location,
    [String] [Parameter (Mandatory=$true)] $ImageName,
    [String] [Parameter (Mandatory=$true)] $ImageResourceGroupName,
    [String] [Parameter (Mandatory=$true)] $TempResourceGroupName,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $TenantId,
    [String] [Parameter (Mandatory=$false)] $UseAzureCliAuth = "false",
    [String] [Parameter (Mandatory=$false)] $PluginVersion = "2.3.3",
    [String] [Parameter (Mandatory=$false)] $VirtualNetworkName,
    [String] [Parameter (Mandatory=$false)] $VirtualNetworkRG,
    [String] [Parameter (Mandatory=$false)] $VirtualNetworkSubnet,
    [String] [Parameter (Mandatory=$false)] $AllowedInboundIpAddresses = "[]",
    [hashtable] [Parameter (Mandatory=$false)] $Tags = @{}
)

if (-not (Test-Path $TemplatePath))
{
    Write-Error "'-TemplatePath' parameter is not valid. You have to specify correct Template Path"
    exit 1
}

$buildName = $($BuildTemplateName).Split(".")[1]
$InstallPassword = [System.GUID]::NewGuid().ToString().ToUpper()

switch ($BuildTemplateName) {
    "build.windows-2019.pkr.hcl" { $imageURN = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter" }
    "build.windows-2022.pkr.hcl" { $imageURN = "MicrosoftWindowsServer:WindowsServer:2022-Datacenter" }
    "build.windows-2025.pkr.hcl" { $imageURN = "MicrosoftWindowsServer:WindowsServer:2025-Datacenter" }
    "build.ubuntu-22_04.pkr.hcl"  { $imageURN = "canonical:0001-com-ubuntu-server-jammy:22_04-lts" }
    "build.ubuntu-24_04.pkr.hcl"  { $imageURN = "canonical:ubuntu-24_04-lts:server-gen1" }
}

$SensitiveData = @(
    'OSType',
    'StorageAccountLocation',
    'OSDiskUri',
    'OSDiskUriReadOnlySas',
    'TemplateUri',
    'TemplateUriReadOnlySas',
    ':  ->'
)

$azure_tags = $Tags | ConvertTo-Json -Compress

Write-Host "Show Packer Version"
packer --version

Write-Host "Download packer plugins"
packer plugins install github.com/hashicorp/azure $pluginVersion

Write-Host "Validate packer template"
packer validate -syntax-only -only "$buildName*" $TemplatePath

Write-Host "Build $buildName VM"
packer build    -only "$buildName*" `
                -var "client_id=$ClientId" `
                -var "client_secret=$ClientSecret" `
                -var "install_password=$InstallPassword" `
                -var "location=$Location" `
                -var "image_publisher=$($imageURN.Split(":")[0])" `
                -var "image_offer=$($imageURN.Split(":")[1])" `
                -var "image_sku=$($imageURN.Split(":")[2])" `
                -var "managed_image_name=$ImageName" `
                -var "managed_image_resource_group_name=$ImageResourceGroupName" `
                -var "subscription_id=$SubscriptionId" `
                -var "temp_resource_group_name=$TempResourceGroupName" `
                -var "tenant_id=$TenantId" `
                -var "virtual_network_name=$VirtualNetworkName" `
                -var "virtual_network_resource_group_name=$VirtualNetworkRG" `
                -var "virtual_network_subnet_name=$VirtualNetworkSubnet" `
                -var "allowed_inbound_ip_addresses=$($AllowedInboundIpAddresses)" `
                -var "use_azure_cli_auth=$UseAzureCliAuth" `
                -var "azure_tags=$azure_tags" `
                -color=false `
                $TemplatePath `
        | Where-Object {
            #Filter sensitive data from Packer logs
            $currentString = $_
            $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
            $sensitiveString -eq $null
        }
