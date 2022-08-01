$ErrorActionPreference = 'Stop'

enum ImageType {
    Windows2019 = 1
    Windows2022 = 2
    Ubuntu1804 = 3
    Ubuntu2004 = 4
    Ubuntu2204 = 5
}

Function Get-PackerTemplatePath {
    param (
        [Parameter(Mandatory = $True)]
        [string] $RepositoryRoot,
        [Parameter(Mandatory = $True)]
        [ImageType] $ImageType
    )

    switch ($ImageType) {
        ([ImageType]::Windows2019) {
            $relativeTemplatePath = Join-Path "win" "windows2019.json"
        }
        ([ImageType]::Windows2022) {
            $relativeTemplatePath = Join-Path "win" "windows2022.json"
        }
        ([ImageType]::Ubuntu1804) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu1804.json"
        }
        ([ImageType]::Ubuntu2004) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu2004.json"
        }
        ([ImageType]::Ubuntu2204) {
            $relativeTemplatePath = Join-Path "linux" "ubuntu2204.pkr.hcl"
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
            The type of the image being generated. Valid options are: {"Windows2019", "Windows2022", "Ubuntu1804", "Ubuntu2004", "Ubuntu2204"}.
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
        
        .PARAMETER AllowBlobPublicAccess
            The Azure storage account will be created with this option.
        .PARAMETER OnError
            Specify how packer handles an error during image creation.
        .EXAMPLE
            GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "shsamytest1" -ImageGenerationRepositoryRoot "C:\virtual-environments" -ImageType Ubuntu1804 -AzureLocation "East US"
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
        [Switch] $Force,
        [Parameter(Mandatory = $False)]
        [bool] $AllowBlobPublicAccess = $False,
        [Parameter(Mandatory = $False)]
        [bool] $EnableHttpsTrafficOnly = $False,
        [Parameter(Mandatory = $False)]
        [ValidateSet("abort","ask","cleanup","run-cleanup-provisioner")]
        [string] $OnError = "ask",
        [Parameter(Mandatory = $False)]
        [hashtable] $Tags
    )

    try {
        $builderScriptPath = Get-PackerTemplatePath -RepositoryRoot $ImageGenerationRepositoryRoot -ImageType $ImageType
        $ServicePrincipalClientSecret = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
        $InstallPassword = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()

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
                New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation -Tag $tags

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
                    0 { Remove-AzResourceGroup -Name $ResourceGroupName -Force; New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation  -Tag $tags }
                    1 { <# Do nothing #> }
                    2 { exit }
                }
            }
        } else {
            New-AzResourceGroup -Name $ResourceGroupName -Location $AzureLocation -Tag $tags
        }

        # This script should follow the recommended naming conventions for azure resources
        $storageAccountName = if($ResourceGroupName.EndsWith("-rg")) {
            $ResourceGroupName.Substring(0, $ResourceGroupName.Length -3)
        } else { $ResourceGroupName }

        # Resource group names may contain special characters, that are not allowed in the storage account name
        $storageAccountName = $storageAccountName.Replace("-", "").Replace("_", "").Replace("(", "").Replace(")", "").ToLower()
        $storageAccountName += "001"
        
        
        # Storage Account Name can only be 24 characters long
        if ($storageAccountName.Length -gt 24){
            $storageAccountName = $storageAccountName.Substring(0, 24)
        }

        if ($tags) {
            New-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName -Location $AzureLocation -SkuName "Standard_LRS" -AllowBlobPublicAccess $AllowBlobPublicAccess -EnableHttpsTrafficOnly $EnableHttpsTrafficOnly -Tag $tags
        } else {
            New-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName -Location $AzureLocation -SkuName "Standard_LRS" -AllowBlobPublicAccess $AllowBlobPublicAccess -EnableHttpsTrafficOnly $EnableHttpsTrafficOnly
        }

        if ([string]::IsNullOrEmpty($AzureClientId)) {
            # Interactive authentication: A service principal is created during runtime.
            $spDisplayName = [System.GUID]::NewGuid().ToString().ToUpper()
            $startDate = Get-Date
            $endDate = $startDate.AddYears(1)

            if ('Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential' -as [type]) {
                $credentials = [Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential]@{
                    StartDate = $startDate
                    EndDate = $endDate
                    Password = $ServicePrincipalClientSecret
                }
                $sp = New-AzADServicePrincipal -DisplayName $spDisplayName -PasswordCredential $credentials
                $spClientId = $sp.ApplicationId
                $azRoleParam = @{
                    RoleDefinitionName = "Contributor"
                    ServicePrincipalName = $spClientId
                }
            }

            if ('Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordCredential' -as [type]) {
                $credentials = [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordCredential]@{
                    StartDateTime = $startDate
                    EndDateTime = $endDate
                }
                $sp = New-AzADServicePrincipal -DisplayName $spDisplayName
                $appCred = New-AzADAppCredential -ApplicationId $sp.AppId -PasswordCredentials $credentials
                $spClientId = $sp.AppId
                $azRoleParam = @{
                    RoleDefinitionName = "Contributor"
                    PrincipalId = $sp.Id
                }
                $ServicePrincipalClientSecret = $appCred.SecretText
            }

            Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup
            New-AzRoleAssignment @azRoleParam
            Start-Sleep -Seconds $SecondsToWaitForServicePrincipalSetup
            $sub = Get-AzSubscription -SubscriptionId $SubscriptionId
            $tenantId = $sub.TenantId

            # Remove ADPrincipal after the script completed
            $isCleanupADPrincipal = $true
        } else {
            # Parametrized Authentication via given service principal: The service principal with the data provided via the command line
            # is used for all authentication purposes.
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

        if ($RestrictToAgentIpAddress) {
            $AgentIp = (Invoke-RestMethod http://ipinfo.io/json).ip
            Write-Host "Restricting access to packer generated VM to agent IP Address: $AgentIp"
        }
        
        if ($builderScriptPath.Contains("pkr.hcl")) {
            if ($AgentIp) {
                $AgentIp = '[ \"{0}\" ]' -f $AgentIp
            } else {
                $AgentIp = "[]"
            }
        }

        if ($Tags) {
            $builderScriptPath_temp = $builderScriptPath.Replace(".json", "-temp.json")
            $packer_script = Get-Content -Path $builderScriptPath | ConvertFrom-Json
            $packer_script.builders | Add-Member -Name "azure_tags" -Value $Tags -MemberType NoteProperty
            $packer_script | ConvertTo-Json -Depth 3 | Out-File $builderScriptPath_temp
            $builderScriptPath = $builderScriptPath_temp
        }

        & $packerBinary build -on-error="$($OnError)" `
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
    catch {
        Write-Error $_
    }
    finally {
        # Remove ADServicePrincipal and ADApplication
        if ($isCleanupADPrincipal) {
            Write-Host "`nRemoving ${spDisplayName}/${spClientId}:"
            if (Get-AzADServicePrincipal -DisplayName $spDisplayName) {
                Write-Host "  [+] ADServicePrincipal"
                Remove-AzADServicePrincipal -DisplayName $spDisplayName -Confirm:$false
            }

            if (Get-AzADApplication -DisplayName $spDisplayName) {
                Write-Host "  [+] ADApplication"
                Remove-AzADApplication -DisplayName $spDisplayName -Confirm:$false
            }
        }
    }
}
