$ErrorActionPreference = 'Stop'

enum ImageType {
    Windows2016 = 0
    Windows2019 = 1
    Ubuntu1604 = 2
    Ubuntu1804 = 3
    Ubuntu2004 = 4
}

Function Get-PackerTemplatePath {
    param (
        [Parameter(Mandatory = $True)]
        [string] $RepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType
    )

    switch ($ImageType) {
        ([ImageType]::Windows2016) {
            $relativeTemplatePath = Join-Path "win" "windows2016.json"
        }
        ([ImageType]::Windows2019) {
            $relativeTemplatePath = Join-Path "win" "windows2019.json"
        }
        ([ImageType]::Ubuntu1604) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu1604.json"
        }
        ([ImageType]::Ubuntu1804) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu1804.json"
        }
        ([ImageType]::Ubuntu2004) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu2004.json"
        }
        default { throw "Unknown type of image" }
    }

    $imageTemplatePath = [IO.Path]::Combine($RepositoryRoot, "images", $relativeTemplatePath)

    if (-not (Test-Path $imageTemplatePath)) {
        throw "Template for image '$ImageType' doesn't exist on path '$imageTemplatePath'"
    }

    return $imageTemplatePath;
}

Function Get-LatestCommit {
    [CmdletBinding()]
    param()

    process {
        Write-Host "Latest commit:"
        git --no-pager log --pretty=format:"Date: %cd; Commit: %H - %s; Author: %an <%ae>" -1
    }
}

Function GenerateResourcesAndImage {
    <#
        .SYNOPSIS
            A helper function to help generate an image.

        .DESCRIPTION
            Creates Azure resources and kicks off a packer image generation for the selected image type.

        .PARAMETER SubscriptionId
            The Azure subscription Id where resources will be created.

        .PARAMETER ResourceGroupName
            The Azure resource group name where the Azure resources will be created.

        .PARAMETER ImageGenerationRepositoryRoot
            The root path of the image generation repository source.

        .PARAMETER ImageType
            The type of the image being generated. Valid options are: {"Windows2016", "Windows2019", "Ubuntu1604", "Ubuntu1804"}.

        .PARAMETER AzureLocation
            The location of the resources being created in Azure. For example "East US".

        .PARAMETER Force
            Delete the resource group if it exists without user confirmation.

        .PARAMETER AzureClientId
            Client id needs to be provided for optional authentication via service principal. Example: "11111111-1111-1111-1111-111111111111"

        .PARAMETER AzureClientSecret
            Client secret needs to be provided for optional authentication via service principal. Example: "11111111-1111-1111-1111-111111111111"

        .PARAMETER AzureTenantId
            Tenant needs to be provided for optional authentication via service principal. Example: "11111111-1111-1111-1111-111111111111"

        .PARAMETER RestrictToAgentIpAddress
            If set, access to the VM used by packer to generate the image is restricted to the public IP address this script is run from. 
            This parameter cannot be used in combination with the virtual_network_name packer parameter.

        .EXAMPLE
            GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "shsamytest1" -ImageGenerationRepositoryRoot "C:\virtual-environments" -ImageType Ubuntu1604 -AzureLocation "East US"
    #>
    param (
        [Parameter(Mandatory = $True)]
        [string] $SubscriptionId,
        [Parameter(Mandatory = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType,
        [Parameter(Mandatory = $True)]
        [string] $AzureLocation,
        [Parameter(Mandatory = $False)]
        [string] $ImageGenerationRepositoryRoot = $pwd,
        [Parameter(Mandatory = $False)]
        [int] $SecondsToWaitForServicePrincipalSetup = 30,
        [Parameter(Mandatory = $False)]
        [string] $AzureClientId,
        [Parameter(Mandatory = $False)]
        [string] $AzureClientSecret,
        [Parameter(Mandatory = $False)]
        [string] $AzureTenantId,
        [Parameter(Mandatory = $False)]
        [Switch] $RestrictToAgentIpAddress,
        [Parameter(Mandatory = $False)]
        [Switch] $Force
    )

    $builderScriptPath = Get-PackerTemplatePath -RepositoryRoot $ImageGenerationRepositoryRoot -ImageType $ImageType
    $ServicePrincipalClientSecret = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper();
    $InstallPassword = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper();

    if ([string]::IsNullOrEmpty($AzureClientId))
    {
        Connect-AzAccount
    } else {
        $AzSecureSecret = ConvertTo-SecureString $AzureClientSecret -AsPlainText -Force
        $AzureAppCred = New-Object System.Management.Automation.PSCredential($AzureClientId, $AzSecureSecret)
        Connect-AzAccount -ServicePrincipal -Credential $AzureAppCred -Tenant $AzureTenantId
    }
    Set-AzContext -SubscriptionId $SubscriptionId

    $alreadyExists = $true;
    try {
        Get-AzResourceGroup -Name $ResourceGroupName
        Write-Verbose "Resource group was found, will delete and recreate it."
    }
    catch {
        Write-Verbose "Resource group was not found, will create it."
        $alreadyExists = $false;
    }

    if ($alreadyExists) {
        if($Force -eq $true) {
            # Cleanup the resource group if it already exitsted before
            Remove-AzResourceGroup -Name $ResourceGroupName -Force
            New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation
        } else {
            $title = "Delete Resource Group"
            $message = "The resource group you specified already exists. Do you want to clean it up?"

            $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
                "Delete the resource group including all resources."

            $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
                "Keep the resource group and continue."

            $stop = New-Object System.Management.Automation.Host.ChoiceDescription "&Stop", `
                "Stop the current action."

            $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $stop)
            $result = $host.ui.PromptForChoice($title, $message, $options, 0)

            switch ($result)
            {
                0 { Remove-AzResourceGroup -Name $ResourceGroupName -Force; New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation }
                1 { <# Do nothing #> }
                2 { exit }
            }
        }
    } else {
        New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation
    }

    # This script should follow the recommended naming conventions for azure resources
    $storageAccountName = if($ResourceGroupName.EndsWith("-rg")) {
        $ResourceGroupName.Substring(0, $ResourceGroupName.Length -3)
    } else { $ResourceGroupName }

    # Resource group names may contain special characters, that are not allowed in the storage account name
    $storageAccountName = $storageAccountName.Replace("-", "").Replace("_", "").Replace("(", "").Replace(")", "").ToLower()
    $storageAccountName += "001"

    New-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName -Location $AzureLocation -SkuName "Standard_LRS"

    if ([string]::IsNullOrEmpty($AzureClientId)) {
        # Interactive authentication: A service principal is created during runtime.
        $spDisplayName = [System.GUID]::NewGuid().ToString().ToUpper()
        $credentialProperties = @{ StartDate=Get-Date; EndDate=Get-Date -Year 2024; Password=$ServicePrincipalClientSecret }
        $credentials = New-Object -TypeName Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential -Property $credentialProperties
        $sp = New-AzADServicePrincipal -DisplayName $spDisplayName -PasswordCredential $credentials

        $spAppId = $sp.ApplicationId
        $spClientId = $sp.ApplicationId
        Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup

        New-AzRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $spAppId
        Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup
        $sub = Get-AzSubscription -SubscriptionId $SubscriptionId
        $tenantId = $sub.TenantId
        # "", "Note this variable-setting script for running Packer with these Azure resources in the future:", "==============================================================================================", "`$spClientId = `"$spClientId`"", "`$ServicePrincipalClientSecret = `"$ServicePrincipalClientSecret`"", "`$SubscriptionId = `"$SubscriptionId`"", "`$tenantId = `"$tenantId`"", "`$spObjectId = `"$spObjectId`"", "`$AzureLocation = `"$AzureLocation`"", "`$ResourceGroupName = `"$ResourceGroupName`"", "`$storageAccountName = `"$storageAccountName`"", "`$install_password = `"$install_password`"", ""
    } else {
        # Parametrized Authentication via given service principal: The service principal with the data provided via the command line
        # is used for all authentication purposes.
        $spAppId = $AzureClientId
        $spClientId = $AzureClientId
        $credentials = $AzureAppCred
        $ServicePrincipalClientSecret = $AzureClientSecret
        $tenantId = $AzureTenantId
    }

    Get-LatestCommit -ErrorAction SilentlyContinue

    $packerBinary = Get-Command "packer"
    if (-not ($packerBinary)) {
        throw "'packer' binary is not found on PATH"
    }

    if($RestrictToAgentIpAddress -eq $true) {
        $AgentIp = (Invoke-RestMethod http://ipinfo.io/json).ip
        echo "Restricting access to packer generated VM to agent IP Address: $AgentIp"
    }

    & $packerBinary build -on-error=ask `
        -var "client_id=$($spClientId)" `
        -var "client_secret=$($ServicePrincipalClientSecret)" `
        -var "subscription_id=$($SubscriptionId)" `
        -var "tenant_id=$($tenantId)" `
        -var "location=$($AzureLocation)" `
        -var "resource_group=$($ResourceGroupName)" `
        -var "storage_account=$($storageAccountName)" `
        -var "install_password=$($InstallPassword)" `
        -var "allowed_inbound_ip_addresses=$($AgentIp)" `
        $builderScriptPath
}
