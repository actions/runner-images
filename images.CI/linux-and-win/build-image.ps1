[CmdletBinding(DefaultParameterSetName = 'TempResourceGroup')]
param(
    [String] [Parameter (Mandatory=$true)] $TemplatePath,
    [String] [Parameter (Mandatory=$true)] $BuildTemplateName,
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$false)] $ClientSecret,
    [String] [Parameter (Mandatory=$true, ParameterSetName = 'TempResourceGroup')] $Location,
    [String] [Parameter (Mandatory=$true)] $ImageName,
    [String] [Parameter (Mandatory=$true)] $ImageResourceGroupName,
    [String] [Parameter (Mandatory=$true, ParameterSetName = 'TempResourceGroup')] $TempResourceGroupName,
    [String] [Parameter (Mandatory=$true, ParameterSetName = 'ExistingResourceGroup')] $ExistingResourceGroupName,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $TenantId,
    [String] [Parameter (Mandatory=$true)] $ImageOS, # e.g. "ubuntu22", "ubuntu24" or "win22", "win25"
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

$packerVariableFlag = "-var"
$packerVariables =  "$packerVariableFlag", "client_id=$ClientId", `
                    "$packerVariableFlag", "client_secret=$ClientSecret", `
                    "$packerVariableFlag", "install_password=$InstallPassword", `
                    "$packerVariableFlag", "image_os=$ImageOS", `
                    "$packerVariableFlag", "managed_image_name=$ImageName", `
                    "$packerVariableFlag", "managed_image_resource_group_name=$ImageResourceGroupName", `
                    "$packerVariableFlag", "subscription_id=$SubscriptionId", `
                    "$packerVariableFlag", "tenant_id=$TenantId", `
                    "$packerVariableFlag", "virtual_network_name=$VirtualNetworkName", `
                    "$packerVariableFlag", "virtual_network_resource_group_name=$VirtualNetworkRG", `
                    "$packerVariableFlag", "virtual_network_subnet_name=$VirtualNetworkSubnet", `
                    "$packerVariableFlag", "allowed_inbound_ip_addresses=$($AllowedInboundIpAddresses)", `
                    "$packerVariableFlag", "use_azure_cli_auth=$UseAzureCliAuth", `
                    "$packerVariableFlag", "azure_tags=$azure_tags" `

switch ($PSCmdlet.ParameterSetName) {
    'TempResourceGroup' {
        Write-Host "Use temporary resource group $TempResourceGroupName"
        $packerVariables += "$packerVariableFlag", "temp_resource_group_name=$TempResourceGroupName", `
                            "$packerVariableFlag", "location=$Location"
        
        break
    }
    'ExistingResourceGroup' {
        Write-Host "Use existing resource group $ExistingResourceGroupName"
        $packerVariables += "$packerVariableFlag", "existing_resource_group_name=$ExistingResourceGroupName"

        break
    }
}

Write-Host "Build $buildName VM"
packer build    -only "$buildName*" `
                @packerVariables `
                -color=false `
                $TemplatePath `
            | Where-Object {
                #Filter sensitive data from Packer logs
                $currentString = $_
                $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
                $sensitiveString -eq $null
            }
