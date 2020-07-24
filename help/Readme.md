### General
Virtual-environment project uses packer tool and contains a number of templates for several OS types: Windows 2016/2019, Ubuntu 16.04/18.04/20.04.
Each image template contains set of scripts that will be executed on virtual machine.
Packer process will initialize connection to Azure subscription via Azure CLI, and deploy required resources, such as temporary resource group, network interfaces and VM from the "clean" image that specified in template.
If deployment succeeded, build agent will connect to the deployed VM and begin to execute installation steps from selected the template.
Connection can be established via SSH or WinRM, depending on image type, so the ports between build agent and temporary VM have to be opened for connection.
If any template step fails, image generation will be aborted and temporary VM will be terminated.
If all steps are succeeded, a temporary VM snapshot will be converted to VHD and then uploaded to the specified Azure Storage Account. After that image can be deployed further from this account.

### Build Agent requirements
- `OS` - Windows/Linux
- `packer` - Can be downloaded from https://www.packer.io/downloads
- `PowerShell 5.0 or higher` or `PSCore` for linux distributes.
- `Azure CLI ` - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

#### Azure DevOps self-hosted pool requirements
To connect to temporary VM packer will use WinRM, or SSH connections on public IP interfaces.
If you use build agent located in some Azure subscription, please make sure that HTTPS/SSH ports are allowed for incoming/outgoing connections.
In case if firewall restrictions forbid connections from public addresses, you may deploy private virtual network resources, and pass them as arguments to packer, so temporary virtual machines can use private connections inside Vlan. 

#### Service principal
Packer will authorize in Azure infrastructure via Service Principal. If you want to prepare image-generation CI, or use packer manually, you need to create your SP with full read-write permissions for selected Azure subscription.
Detailed instruction can be found [here](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)

### Prepare environment and image deployment
#### How to prepare Windows build agent
You can use local machine as build agent, or deploy virtual machine in [Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli).

Download `packer` from https://www.packer.io/downloads, or install it via Chocolately.
```
Choco-Install -PackageName packer
```

Install Azure CLI - https://docs.microsoft.com/ru-ru/cli/azure/install-azure-cli-windows?view=azure-cli-latest&tabs=azure-cli.
```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

Download Virtual-Envionments repository.
```
git clone https://github.com/actions/virtual-environments.git
```

Import [GenerateResourcesAndImage](https://github.com/actions/virtual-environments/blob/main/helpers/GenerateResourcesAndImage.ps1) script from `/helpers` folder, and run `GenerateResourcesAndImage` function in Powershell.

```
Import-Module C:\virtual-environments\helpers\GenerateResourcesAndImage.ps1

GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "shsamytest1" -ImageGenerationRepositoryRoot "C:\virtual-environments" -ImageType Ubuntu1604 -AzureLocation "East US"
```
Where:
- `SubscriptionId` - The Azure subscription Id where resources will be created.
- `ResourceGroupName` - The Azure resource group name where the Azure resources will be created.
- `ImageGenerationRepositoryRoot` - The root path of the image generation repository source.
- `ImageType` - The type of the image being generated. Valid options are: {"Windows2016", "Windows2019", "Ubuntu1604", "Ubuntu1804"}.
- `AzureLocation` - The location of the resources being created in Azure. For example "East US".

Function will automatically create all required Azure resources and kick off a packer image generation for the selected image type.

*Please, check synopsis of `GenerateResourcesAndImage` for details about non mandatory parameters.*

#### Generated VM Deployment
After successful image generation, you can deploy Virtual Machine based on generated VHD using [CreateAzureVMFromPackerTemplate](https://github.com/actions/virtual-environments/blob/main/helpers/CreateAzureVMFromPackerTemplate.ps1) script.
```
Import-Module C:\virtual-environments\helpers\CreateAzureVMFromPackerTemplate.ps1

CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId}  -ResourceGroupName {ResourceGroupName} -TemplateFile "C:\BuildVmImages\temporaryTemplate.json" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "eastus"
```
Where:
- `SubscriptionId` - The Azure subscription Id where resources will be created.
- `ResourceGroupName` - The Azure resource group name where the Azure virtual machine will be created.
- `TemplatFilePath` - The path for the json template generated by packer during image generation locally.
- `VirtualMachineName` - The name of the virtual machine to be generated.
- `AdminUserName` - The administrator username for the virtual machine to be created.
- `AdminPassword` - The administrator password for the virtual machine to be created.
- `AzureLocation` - The location where the Azure virtual machine will be provisioned. Example: "eastus"

Fuction will create an Azure VM from a template and generate network resources in Azure to make the VM accessible.

### Additional
### Variables
Each packer template includes `variables` group that contains builder variables that are used in image generation.
Builder variables can be passed to packer via predefined environment variables, or as direct arguments, in case if packer started manually.

#### Builder variables
- `client_id` - The application ID of the AAD Service Principal. Requires `client_secret`.
- `object_id` - The object ID for the AAD SP. Will be derived from the oAuth token if empty.
- `client_secret` - A password/secret registered for the AAD SP.
- `subscription_id` - The subscription to use.
- `tenant_id` - The Active Directory tenant identifier with which your `client_id` and `subscription_id` are associated. If not specified, `tenant_id` will be looked up using `subscription_id`.
- `resource_group` - Resource group under which the final artifact will be stored.
- `storage_account` - Storage account under which the final artifact will be stored.
- `location` - Azure datacenter in which your VM will be built.
- `temp_resource_group_name` - Name assigned to the temporary resource group created during the build. If this value is not set, a random value will be assigned. This resource group is deleted at the end of the build.
- `private_virtual_network_with_public_ip` - This value allows you to set a `virtual_network_name` and obtain a public IP. If this value is not set and `virtual_network_name` is defined Packer is only allowed to be executed from a host on the same subnet / virtual network.
- `virtual_network_name` - Use a pre-existing virtual network for the VM. This option enables private communication with the VM, no public IP address is used or provisioned (unless you set `private_virtual_network_with_public_ip`).
- `virtual_network_resource_group_name` - If `virtual_network_name` is set, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the resource group containing the virtual network. If the resource group cannot be found, or it cannot be disambiguated, this value should be set.
- `virtual_network_subnet_name` - If `virtual_network_name is set`, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the subnet to use with the virtual network. If the subnet cannot be found, or it cannot be disambiguated, this value should be set.
- `capture_name_prefix` - VHD prefix. The final artifacts will be named PREFIX-osDisk.UUID and PREFIX-vmTemplate.UUID.
- `github_feed_token` - Github PAT. Required for NPM toolcache installation. Will be depricated soon.

#### Additional vairables
- `vm_size` - Size of the VM used for building. This can be changed when you deploy a VM from your VHD. See pricing information. https://docs.microsoft.com/en-us/azure/search/search-sku-tier.
- `image_os` - Type of OS that will be deployed as a temporary VM.
- `image_version` -  Specify a specific version of an OS to boot from.

**Detailed Azure builders documentation can be found [here](https://www.packer.io/docs/builders/azure).**

### Toolset
Configuration for some installed software is located in `toolset.json` files. These files define the list of Ruby, Python, Go versions, the list of PowerShell modules and VS components that will be installed to image. They can be changed if these tools are not required to reduce image generation time or image size.

Generated tool versions and details can be found in related projects:
- [Python](https://github.com/actions/python-versions/)
- [Go](https://github.com/actions/go-versions)
- [Node](https://github.com/actions/node-versions)
- [Boost](https://github.com/actions/boost-versions)