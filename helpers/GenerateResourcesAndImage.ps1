$ErrorActionPreference = 'Stop'

enum ImageType {
    Windows2019   = 1
    Windows2022   = 2
    Ubuntu2004    = 3
    Ubuntu2204    = 4
    Ubuntu2404    = 5
    UbuntuMinimal = 6
}

Function Get-PackerTemplatePath {
    param (
        [Parameter(Mandatory = $True)]
        [string] $RepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType
    )

    switch ($ImageType) {
        # Note: Double Join-Path is required to support PowerShell 5.1
        ([ImageType]::Windows2019) {
            $relativeTemplatePath = Join-Path (Join-Path "windows" "templates") "windows-2019.pkr.hcl"
        }
        ([ImageType]::Windows2022) {
            $relativeTemplatePath = Join-Path (Join-Path "windows" "templates") "windows-2022.pkr.hcl"
        }
        ([ImageType]::Ubuntu2004) {
            $relativeTemplatePath = Join-Path (Join-Path "ubuntu" "templates") "ubuntu-20.04.pkr.hcl"
        }
        ([ImageType]::Ubuntu2204) {
            $relativeTemplatePath = Join-Path (Join-Path "ubuntu" "templates") "ubuntu-22.04.pkr.hcl"
        }
        ([ImageType]::Ubuntu2404) {
            $relativeTemplatePath = Join-Path (Join-Path "ubuntu" "templates") "ubuntu-24.04.pkr.hcl"
        }
        ([ImageType]::UbuntuMinimal) {
            $relativeTemplatePath = Join-Path (Join-Path "ubuntu" "templates") "ubuntu-minimal.pkr.hcl"
        }
        default { throw "Unknown type of image" }
    }

    $imageTemplatePath = [IO.Path]::Combine($RepositoryRoot, "images", $relativeTemplatePath)

    if (-not (Test-Path $imageTemplatePath)) {
        throw "Template for image '$ImageType' doesn't exist on path '$imageTemplatePath'."
    }

    return $imageTemplatePath;
}

Function Show-LatestCommit {
    [CmdletBinding()]
    param()

    process {
        $latestCommit = (git --no-pager log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1)
        Write-Host "Latest commit: $latestCommit."
    }
}

function Start-Sleep($seconds) {
    $doneDT = (Get-Date).AddSeconds($seconds)
    while ($doneDT -gt (Get-Date)) {
        $secondsLeft = $doneDT.Subtract((Get-Date)).TotalSeconds
        $percent = ($seconds - $secondsLeft) / $seconds * 100
        Write-Progress -Activity "Sleeping" -Status "Sleeping..." -SecondsRemaining $secondsLeft -PercentComplete $percent
        [System.Threading.Thread]::Sleep(500)
    }
    Write-Progress -Activity "Sleeping" -Status "Sleeping..." -SecondsRemaining 0 -Completed
}

Function GenerateResourcesAndImage {
    <#
        .SYNOPSIS
            A helper function to help generate an image.
        .DESCRIPTION
            This function will generate the Azure resources and image for the specified image type.
        .PARAMETER SubscriptionId
            The Azure subscription id where the Azure resources will be created.
        .PARAMETER ResourceGroupName
            The name of the resource group to create the Azure resources in.
        .PARAMETER ImageType
            The type of image to generate. Valid values are: Windows2019, Windows2022, Ubuntu2004, Ubuntu2204, UbuntuMinimal.
        .PARAMETER ManagedImageName
            The name of the managed image to create. The default is "Runner-Image-{{ImageType}}".
        .PARAMETER AzureLocation
            The Azure location where the Azure resources will be created. For example: "East US"
        .PARAMETER ImageGenerationRepositoryRoot
            The root directory of the image generation repository. This is used to locate the packer template.
        .PARAMETER SecondsToWaitForServicePrincipalSetup
            The number of seconds to wait for the service principal to be setup. The default is 120 seconds.
        .PARAMETER AzureClientId
            The Azure client id to use to authenticate with Azure. If not specified, the current user's credentials will be used.
        .PARAMETER AzureClientSecret
            The Azure client secret to use to authenticate with Azure. If not specified, the current user's credentials will be used.
        .PARAMETER AzureTenantId
            The Azure tenant id to use to authenticate with Azure. If not specified, the current user's credentials will be used.
        .PARAMETER RestrictToAgentIpAddress
            If set, access to the VM used by packer to generate the image is restricted to the public IP address this script is run from. 
            This parameter cannot be used in combination with the virtual_network_name packer parameter.
        .PARAMETER Force
            Delete the resource group if it exists without user confirmation.
            This parameter is deprecated and will be removed in a future release.
        .PARAMETER ReuseResourceGroup
            Reuse the resource group if it exists without user confirmation.
            This parameter is deprecated and will be removed in a future release.
        .PARAMETER OnError
            Specify how packer handles an error during image creation.
            Options:
                abort - abort immediately
                ask - ask user for input
                cleanup - attempt to cleanup and then abort
                run-cleanup-provisioner - run the cleanup provisioner and then abort
            The default is 'ask'.
        .PARAMETER Tags
            Tags to be applied to the Azure resources created.
        .EXAMPLE
            GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "shsamytest1" -ImageGenerationRepositoryRoot "C:\runner-images" -ImageType Ubuntu2004 -AzureLocation "East US"
    #>
    param (
        [Parameter(Mandatory = $True)]
        [string] $SubscriptionId,
        [Parameter(Mandatory = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType,
        [Parameter(Mandatory = $False)]
        [string] $ManagedImageName = "Runner-Image-$($ImageType)",
        [Parameter(Mandatory = $True)]
        [string] $AzureLocation,
        [Parameter(Mandatory = $False)]
        [string] $ImageGenerationRepositoryRoot = $pwd,
        [Parameter(Mandatory = $False)]
        [int] $SecondsToWaitForServicePrincipalSetup = 120,
        [Parameter(Mandatory = $False)]
        [string] $AzureClientId,
        [Parameter(Mandatory = $False)]
        [string] $AzureClientSecret,
        [Parameter(Mandatory = $False)]
        [string] $AzureTenantId,
        [Parameter(Mandatory = $False)]
        [switch] $RestrictToAgentIpAddress,
        [Parameter(Mandatory = $False)]
        [switch] $Force,
        [Parameter(Mandatory = $False)]
        [switch] $ReuseResourceGroup,
        [Parameter(Mandatory = $False)]
        [ValidateSet("abort", "ask", "cleanup", "run-cleanup-provisioner")]
        [string] $OnError = "ask",
        [Parameter(Mandatory = $False)]
        [hashtable] $Tags = @{}
    )

    if ($Force -or $ReuseResourceGroup) {
        Write-Warning "The `ReuseResourceGroup` and `Force` parameters are deprecated and will be removed in a future release. The resource group will be reused when it already exists and an error will be thrown when it doesn't. If you want to delete the resource group, please delete it manually."
    }

    if ($Force -and $ReuseResourceGroup) {
        throw "Force and ReuseResourceGroup cannot be used together."
    }

    Show-LatestCommit -ErrorAction SilentlyContinue

    # Validate packer is installed
    $PackerBinary = Get-Command "packer"
    if (-not ($PackerBinary)) {
        throw "'packer' binary is not found on PATH."
    }

    # Get template path
    $TemplatePath = Get-PackerTemplatePath -RepositoryRoot $ImageGenerationRepositoryRoot -ImageType $ImageType
    Write-Debug "Template path: $TemplatePath."

    # Prepare list of allowed inbound IP addresses
    if ($RestrictToAgentIpAddress) {
        $AgentIp = (Invoke-RestMethod http://ipinfo.io/json).ip
        if (-not $AgentIp) {
            throw "Unable to determine agent IP address."
        }

        Write-Host "Access to packer generated VM will be restricted to agent IP Address: $AgentIp."
        if ($PSVersionTable.PSVersion.Major -eq 5) {
            Write-Verbose "PowerShell 5 detected. Replacing double quotes with escaped double quotes in allowed inbound IP addresses."
            $AllowedInboundIpAddresses = '[\"{0}\"]' -f $AgentIp
        }
        elseif ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -le 2) {
            Write-Verbose "PowerShell 7.0-7.2 detected. Replacing double quotes with escaped double quotes in allowed inbound IP addresses."
            $AllowedInboundIpAddresses = '[\"{0}\"]' -f $AgentIp
        }
        else {
            $AllowedInboundIpAddresses = '["{0}"]' -f $AgentIp
        }
    }
    else {
        $AllowedInboundIpAddresses = "[]"
    }
    Write-Debug "Allowed inbound IP addresses: $AllowedInboundIpAddresses."

    # Prepare tags
    $TagsList = $Tags.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }
    Write-Debug "Tags list: $TagsList."
    $TagsJson = $Tags | ConvertTo-Json -Compress
    if ($PSVersionTable.PSVersion.Major -eq 5) {
        Write-Verbose "PowerShell 5 detected. Replacing double quotes with escaped double quotes in tags JSON."
        $TagsJson = $TagsJson -replace '"', '\"'
    }
    elseif ($PSVersionTable.PSVersion.Major -eq 7 -and $PSVersionTable.PSVersion.Minor -le 2) {
        Write-Verbose "PowerShell 7.0-7.2 detected. Replacing double quotes with escaped double quotes in tags JSON."
        $TagsJson = $TagsJson -replace '"', '\"'
    }
    Write-Debug "Tags JSON: $TagsJson."

    $InstallPassword = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()

    Write-Host "Downloading packer plugins..."
    & $PackerBinary init $TemplatePath

    if ($LastExitCode -ne 0) {
        throw "Packer plugins download failed."
    }

    Write-Host "Validating packer template..."
    & $PackerBinary validate `
        "-var=client_id=fake" `
        "-var=client_secret=fake" `
        "-var=subscription_id=$($SubscriptionId)" `
        "-var=tenant_id=fake" `
        "-var=location=$($AzureLocation)" `
        "-var=managed_image_name=$($ManagedImageName)" `
        "-var=managed_image_resource_group_name=$($ResourceGroupName)" `
        "-var=install_password=$($InstallPassword)" `
        "-var=allowed_inbound_ip_addresses=$($AllowedInboundIpAddresses)" `
        "-var=azure_tags=$($TagsJson)" `
        $TemplatePath

    if ($LastExitCode -ne 0) {
        throw "Packer template validation failed."
    }

    try {
        # Login to Azure subscription
        if ([string]::IsNullOrEmpty($AzureClientId)) {
            Write-Verbose "No AzureClientId was provided, will use interactive login."
            az login --output none
        }
        else {
            Write-Verbose "AzureClientId was provided, will use service principal login."
            az login --service-principal --username $AzureClientId --password=$AzureClientSecret --tenant $AzureTenantId --output none
        }
        az account set --subscription $SubscriptionId
        if ($LastExitCode -ne 0) {
            throw "Failed to login to Azure subscription '$SubscriptionId'."
        }

        # Check resource group
        $ResourceGroupExists = [System.Convert]::ToBoolean((az group exists --name $ResourceGroupName));
        if ($ResourceGroupExists) {
            Write-Verbose "Resource group '$ResourceGroupName' already exists."
        }

        # Remove resource group if it exists and we are not reusing it
        if ($ResourceGroupExists -and -not $ReuseResourceGroup) {
            if ($Force) {
                # Delete and recreate the resource group
                Write-Host "Deleting resource group '$ResourceGroupName'..."
                az group delete --name $ResourceGroupName --yes --output none
                if ($LastExitCode -ne 0) {
                    throw "Failed to delete resource group '$ResourceGroupName'."
                }
                Write-Host "Resource group '$ResourceGroupName' was deleted."
                $ResourceGroupExists = $false
            }
            else {
                # are we running in a non-interactive session?
                # https://stackoverflow.com/questions/9738535/powershell-test-for-noninteractive-mode
                if ([System.Console]::IsOutputRedirected -or ![Environment]::UserInteractive -or !!([Environment]::GetCommandLineArgs() | Where-Object { $_ -ilike '-noni*' })) {
                    throw "Non-interactive mode, resource group '$ResourceGroupName' already exists, either specify -Force to delete it, or -ReuseResourceGroup to reuse."
                }
                else {
                    # Resource group already exists, ask the user what to do
                    $title = "Resource group '$ResourceGroupName' already exists"
                    $message = "Do you want to delete the resource group and all resources in it?"

                    $options = @(
                        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Delete the resource group and all resources in it."),
                        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Keep the resource group and continue."),
                        [System.Management.Automation.Host.ChoiceDescription]::new("&Abort", "Abort execution.")
                    )
                    $result = $Host.UI.PromptForChoice($title, $message, $options, 0)
                }

                switch ($result) {
                    0 {
                        # Delete and recreate the resource group
                        Write-Host "Deleting resource group '$ResourceGroupName'..."
                        az group delete --name $ResourceGroupName --yes
                        if ($LastExitCode -ne 0) {
                            throw "Failed to delete resource group '$ResourceGroupName'."
                        }
                        Write-Host "Resource group '$ResourceGroupName' was deleted."
                        $ResourceGroupExists = $false
                    }
                    1 {
                        # Keep the resource group and continue
                    }
                    2 {
                        # Stop the current action
                        Write-Error "User stopped the action."
                        exit 1
                    }
                }
            }
        }

        # Create resource group
        if (-not $ResourceGroupExists) {
            Write-Host "Creating resource group '$ResourceGroupName' in location '$AzureLocation'..."
            if ($TagsList) {
                az group create --name $ResourceGroupName --location $AzureLocation --tags $TagsList --query id
            }
            else {
                az group create --name $ResourceGroupName --location $AzureLocation --query id
            }
            if ($LastExitCode -ne 0) {
                throw "Failed to create resource group '$ResourceGroupName'."
            }
        }

        # Create service principal
        if ([string]::IsNullOrEmpty($AzureClientId)) {
            Write-Host "Creating service principal for packer..."
            $ADCleanupRequired = $true

            $ServicePrincipalName = "packer-" + [System.GUID]::NewGuid().ToString().ToUpper()
            $ServicePrincipal = az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes /subscriptions/$SubscriptionId --only-show-errors | ConvertFrom-Json
            if ($LastExitCode -ne 0) {
                throw "Failed to create service principal '$ServicePrincipalName'."
            }

            $ServicePrincipalAppId = $ServicePrincipal.appId
            $ServicePrincipalPassword = $ServicePrincipal.password
            $TenantId = $ServicePrincipal.tenant

            Write-Verbose "Waiting for service principal to propagate..."
            Start-Sleep $SecondsToWaitForServicePrincipalSetup
            Write-Host "Service principal created with id '$ServicePrincipalAppId'. It will be deleted after the build."
        }
        else {
            $ServicePrincipalAppId = $AzureClientId
            $ServicePrincipalPassword = $AzureClientSecret
            $TenantId = $AzureTenantId
        }
        Write-Debug "Service principal app id: $ServicePrincipalAppId."
        Write-Debug "Tenant id: $TenantId."

        & $PackerBinary build -on-error="$($OnError)" `
            -var "client_id=$($ServicePrincipalAppId)" `
            -var "client_secret=$($ServicePrincipalPassword)" `
            -var "subscription_id=$($SubscriptionId)" `
            -var "tenant_id=$($TenantId)" `
            -var "location=$($AzureLocation)" `
            -var "managed_image_name=$($ManagedImageName)" `
            -var "managed_image_resource_group_name=$($ResourceGroupName)" `
            -var "install_password=$($InstallPassword)" `
            -var "allowed_inbound_ip_addresses=$($AllowedInboundIpAddresses)" `
            -var "azure_tags=$($TagsJson)" `
            $TemplatePath

        if ($LastExitCode -ne 0) {
            throw "Failed to build image."
        }
    } catch {
        Write-Error $_
    } finally {
        Write-Verbose "`nCleaning up..."

        # Remove ADServicePrincipal and ADApplication
        if ($ADCleanupRequired) {
            Write-Host "Removing ADServicePrincipal..."
            if (az ad sp show --id $ServicePrincipalAppId --query id) {
                az ad sp delete --id $ServicePrincipalAppId
            }

            Write-Host "Removing ADApplication..."
            if (az ad app show --id $ServicePrincipalAppId --query id) {
                az ad app delete --id $ServicePrincipalAppId
            }
        }
        Write-Verbose "Cleanup completed."
    }
}
