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

function Add-PackerVariableFlag {
    param(
        [String[]]$packerVariables
    )

    $result = @()

    foreach ($packerVariable in $packerVariables) {
        $result += "-var", $packerVariable
    }

    return $result
}

Write-Host "Show Packer Version"
packer --version

Write-Host "Download packer plugins"
packer plugins install github.com/hashicorp/azure $pluginVersion

Write-Host "Validate packer template"
packer validate -syntax-only -only "$buildName*" $TemplatePath

$packerVariablesList = Add-PackerVariableFlag -packerVariables @(
                    "client_id=$ClientId",
                    "client_secret=$ClientSecret",
                    "install_password=$InstallPassword",
                    "image_os=$ImageOS",
                    "managed_image_name=$ImageName",
                    "managed_image_resource_group_name=$ImageResourceGroupName",
                    "subscription_id=$SubscriptionId",
                    "tenant_id=$TenantId",
                    "virtual_network_name=$VirtualNetworkName",
                    "virtual_network_resource_group_name=$VirtualNetworkRG",
                    "virtual_network_subnet_name=$VirtualNetworkSubnet",
                    "allowed_inbound_ip_addresses=$($AllowedInboundIpAddresses)",
                    "use_azure_cli_auth=$UseAzureCliAuth",
                    "azure_tags=$azure_tags"
                )

switch ($PSCmdlet.ParameterSetName) {
    'TempResourceGroup' {
        Write-Host "Use temporary resource group $TempResourceGroupName"
        $packerVariablesList += Add-PackerVariableFlag -packerVariables @(
                            "temp_resource_group_name=$TempResourceGroupName",
                            "location=$Location"
                        )
        
        break
    }
    'ExistingResourceGroup' {
        Write-Host "Use existing resource group $ExistingResourceGroupName"
        $packerVariablesList += Add-PackerVariableFlag -packerVariables @(
                            "build_resource_group_name=$ExistingResourceGroupName"
                        )

        break
    }
}

Write-Host "Build $buildName VM"
packer build    -only "$buildName*" `
                @packerVariablesList `
                -color=false `
                $TemplatePath `
        | Where-Object {
            #Filter sensitive data from Packer logs
            $currentString = $_
            $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
            $sensitiveString -eq $null
        }
