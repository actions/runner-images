Function CreateAzureVMFromPackerTemplate {
    <#
        .SYNOPSIS
            A helper function to deploy a VM from generated image.

        .DESCRIPTION
             Creates an Azure VM from a template. Also generates network resources in Azure to make the VM accessible.

        .PARAMETER SubscriptionId
            The Azure subscription Id where resources will be created.

        .PARAMETER ResourceGroupName
            The Azure resource group name where the Azure virtual machine will be created.

        .PARAMETER TemplatFilePath
            The path for the json template generated by packer during image generation locally.

        .PARAMETER VirtualMachineName
            The name of the virtual machine to be generated.

        .PARAMETER AdminUserName
            The administrator username for the virtual machine to be created.

        .PARAMETER AdminPassword
            The administrator password for the virtual machine to be created.

        .PARAMETER AzureLocation
            The location where the Azure virtual machine will be provisioned. Example: "eastus"

        .EXAMPLE
            CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId}  -ResourceGroupName {ResourceGroupName} -TemplateFile "C:\BuildVmImages\temporaryTemplate.json" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "eastus"
    #>
    param (
        [Parameter(Mandatory = $True)]
        [string] $SubscriptionId,
        [Parameter(Mandatory = $True)]
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $True)]
        [string] $TemplateFilePath,
        [Parameter(Mandatory = $True)]
        [string] $VirtualMachineName,
        [Parameter(Mandatory = $True)]
        [string] $AdminUsername,
        [Parameter(Mandatory = $True)]
        [string] $AdminPassword,
        [Parameter(Mandatory = $True)]
        [string] $AzureLocation
    )

    $vmSize = "Standard_DS2_v2"
    $vnetName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $subnetName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $nicName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()
    $publicIpName = $env:UserName + [System.GUID]::NewGuid().ToString().ToUpper()

    Write-Host "Creating a Vnet and a Subnet"
    az network vnet create -g $ResourceGroupName -l $AzureLocation --name $vnetName --address-prefix 10.0.0.0/16 --subscription $subscriptionId
    az network vnet subnet create -g $ResourceGroupName --vnet-name $vnetName -n $subnetName --address-prefix 10.0.1.0/24  --subscription $subscriptionId

    Write-Host "Creating a network interface card (NIC)."
    $nic = az network nic create -g $ResourceGroupName --vnet-name $vnetName --subnet $subnetName -n $nicName  --subscription $subscriptionId
    $networkId = ($nic | ConvertFrom-Json).NewNIC.id

    Write-Host "create public IP."
    az network public-ip create -g $ResourceGroupName -n $publicIpName --subscription $subscriptionId --allocation-method Static --location $AzureLocation --sku Standard --version IPv4

    Write-Host "Adding the public IP to the NIC."
    az network nic ip-config update --name ipconfig1 --nic-name $nicName --resource-group $ResourceGroupName --subscription $subscriptionId --public-ip-address $publicIpName

    Write-Host "Creating the VM"
    az group deployment create --resource-group $ResourceGroupName --subscription $subscriptionId --name $VirtualMachineName --template-file $templateFilePath --parameters vmSize=$vmSize vmName=$VirtualMachineName adminUserName=$AdminUsername adminPassword=$AdminPassword networkInterfaceId=$networkId
}
