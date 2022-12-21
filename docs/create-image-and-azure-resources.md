# GitHub Actions Runner Images
The runner-images project uses [Packer](https://www.packer.io/) to generate disk images for the following platforms: Windows 2019/2022, Ubuntu 18.04/20.04/22.04. 
Each image is configured through a JSON template that Packer understands and which specifies where to build the image (Azure in this case), and what scripts to run to install software and prepare the disk.
The Packer process initializes a connection to Azure subscription via Azure CLI, and automatically creates the temporary Azure resources required to build the source VM(temporary resource group, network interfaces, and VM from the "clean" image specified in the template). 
If the VM deployment succeeds, the build agent connects to the VM and starts to execute installation steps from the JSON template.
If any step in the JSON template fails, image generation will be aborted and the temporary VM will be terminated. Packer will also attempt to cleanup all the temporary resources it created (unless otherwise told).
After successful image generation, a snapshot of the temporary VM will be converted to VHD image and then uploaded to the specified Azure Storage Account.

## Prerequisites and Image-generation
### Build Agent requirements
- `OS` - Windows/Linux
- `packer 1.8.2 or higher` - Can be downloaded from https://www.packer.io/downloads
- `PowerShell 5.0 or higher` or `PSCore` for linux distributes.
- `Azure CLI ` - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
- `Azure Az Powershell module` - https://docs.microsoft.com/en-us/powershell/azure/install-az-ps
- `Git for Windows` - https://gitforwindows.org/

> To connect to a temporary VM packer uses WinRM or SSH connections on public IP interfaces.
If you use a build agent located in an Azure subscription, please make sure that HTTPS/SSH ports are allowed for incoming/outgoing connections.
In case of firewall restrictions, prohibiting connections from public addresses, private virtual network resources can be deployed and passed as arguments to the packer. This approach allows virtual machines to use private connections inside VLAN.

### Service principal
Packer uses Service Principal to authorize in Azure infrastructure. To setup image-generation CI or use packer manually — SP with full read-write permissions for selected Azure subscription needed.
Detailed instruction can be found in [Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)

### Prepare environment and image deployment
#### How to prepare Windows build agent
Local machine or [Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli) can be used as a build agent.

Download & install `packer` from https://www.packer.io/downloads, or install it via [Chocolatey](https://chocolatey.org/):
```
choco install packer
```

Download & install `git` from https://github.com/git-for-windows/git/releases, or install it via [Chocolatey](https://chocolatey.org/):
```
choco install git -params '"/GitAndUnixToolsOnPath"'
```

Install the Azure Az PowerShell module - https://docs.microsoft.com/en-us/powershell/azure/install-az-ps.
```
Install-Module -Name Az -Repository PSGallery -Force
```

Install Azure CLI - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest&tabs=azure-cli.
```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

Download Runner Images repository.
```
Set-Location c:\
git clone https://github.com/actions/runner-images.git
```

Import [GenerateResourcesAndImage](../helpers/GenerateResourcesAndImage.ps1) script from `/helpers` folder, and run `GenerateResourcesAndImage` function via Powershell.

```
Set-Location C:\runner-images

Import-Module .\helpers\GenerateResourcesAndImage.ps1

GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "myTestResourceGroup" -ImageGenerationRepositoryRoot "$pwd" -ImageType Ubuntu1804 -AzureLocation "East US"
```
Where:
- `SubscriptionId` - The Azure subscription Id where resources will be created.
- `ResourceGroupName` - The Azure resource group name where the Azure resources will be created.
- `ImageGenerationRepositoryRoot` - The root path of the image generation repository source.
- `ImageType` - The type of the image being generated. Valid options are: "Windows2019", "Windows2022", "Ubuntu1804", "Ubuntu2004", "Ubuntu2204".
- `AzureLocation` - The location of the resources being created in Azure. For example "East US".

The function automatically creates all required Azure resources and kicks off packer image generation for the selected image type.

For optional authentication via service principal make sure to provide the following params — `AzureClientId`, `AzureClientSecret`, `AzureTenantId`, so the whole command will be:

```
GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "myTestResourceGroup" -ImageGenerationRepositoryRoot "$pwd" -ImageType Ubuntu1804 -AzureLocation "East US" -AzureClientId {AADApplicationID} -AzureClientSecret {AADApplicationSecret} -AzureTenantId {AADTenantID}
```

As extra options, you can add more params for permit to add Azure Tags on resources and enable https for Storage Account. It could be helpful on some tenants with hardenning policy. Params are — `EnableHttpsTrafficOnly` (Boolean) and `tags` (HashTable), so the whole command will be:

```
GenerateResourcesAndImage -SubscriptionId {YourSubscriptionId} -ResourceGroupName "myTestResourceGroup" -ImageGenerationRepositoryRoot "$pwd" -ImageType Ubuntu1804 -AzureLocation "East US" -EnableHttpsTrafficOnly $true -tags @{dept="devops";env="prod"}
```

*Please, check synopsis of `GenerateResourcesAndImage` for details about non-mandatory parameters.*

#### Generated VM Deployment
After the successful image generation, Virtual Machine can be created from the generated VHD using [CreateAzureVMFromPackerTemplate](../helpers/CreateAzureVMFromPackerTemplate.ps1) script.

```
Set-Location C:\runner-images

Import-Module .\helpers\CreateAzureVMFromPackerTemplate.ps1

CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId}  -ResourceGroupName {ResourceGroupName} -TemplateFile "C:\BuildVmImages\temporaryTemplate.json" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "eastus"
```
Where:
- `SubscriptionId` - The Azure subscription Id where resources will be created.
- `ResourceGroupName` - The Azure resource group name where the Azure virtual machine will be created.
- `TemplateFilePath` - The path to the json ARM-template generated by packer during image generation locally.* 
- `VirtualMachineName` - The name of the virtual machine to be generated.
- `AdminUserName` - The administrator username for the virtual machine to be created.
- `AdminPassword` - The administrator password for the virtual machine to be created.
- `AzureLocation` - The location where the Azure virtual machine will be provisioned. Example: "eastus"

\* *ARM-template can be obtained from the Packer output. For now, it seems like there is an [Az CLI bug](https://github.com/Azure/azure-cli/issues/5899) with specifying the template through a URI, so download the template from URI, that will be printed at the bottom of image-generation log, and use the local path of the template file.*

The function creates an Azure VM from a template and generates network resources in Azure to make the VM accessible.

## Additional
### User variables
The Packer template includes `variables` section containing user variables used in image generation. Each variable is defined as a key/value strings. User variables can be passed to packer via predefined environment variables, or as direct arguments, in case if packer started manually.

- `build_resource_group_name` - Specify an existing resource group to run the build in it. By default, a temporary resource group will be created and destroyed as part of the build. If you do not have permission to do so, use build_resource_group_name to specify an existing resource group to run the build in it.
- `client_id` - The application ID of the AAD Service Principal. Requires `client_secret`.
- `object_id` - The object ID for the AAD SP. Will be derived from the oAuth token if empty.
- `client_secret` - The password or secret for your service principal.
- `client_cert_path` - The location of a PEM file containing a certificate and private key for service principal.
- `subscription_id` - The subscription to use.
- `tenant_id` - The Active Directory tenant identifier with which your `client_id` and `subscription_id` are associated. If not specified, `tenant_id` will be looked up using `subscription_id`.
- `resource_group` - Resource group under which the final artifact will be stored.
- `storage_account` - Storage account under which the final artifact will be stored.
- `location` - Azure datacenter in which your VM will be built.
- `temp_resource_group_name` - Name assigned to the temporary resource group created during the build. If this value is not set, a random value will be assigned. This resource group is deleted at the end of the build.
- `private_virtual_network_with_public_ip` - This value allows you to set a `virtual_network_name` and obtain a public IP. If this value is not set and `virtual_network_name` is defined Packer is only allowed to be executed from a host on the same subnet / virtual network.
- `virtual_network_name` - Use a pre-existing virtual network for the VM. This option enables private communication with the VM, no public IP address is used or provisioned (unless you set `private_virtual_network_with_public_ip`).
- `virtual_network_resource_group_name` - If `virtual_network_name` is set, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the resource group containing the virtual network. If the resource group cannot be found, or it cannot be disambiguated, this value should be set.
- `virtual_network_subnet_name` - If `virtual_network_name` is set, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the subnet to use with the virtual network. If the subnet cannot be found, or it cannot be disambiguated, this value should be set.
- `capture_name_prefix` - VHD prefix. The final artifacts will be named PREFIX-osDisk.UUID and PREFIX-vmTemplate.UUID.

### Builder variables
The `builders` section contains variables for the `azure-arm` builder used in the project. Most of the builder variables are inherited from the `user variables` section, however, the variables can be overwritten to adjust image-generation performance.

- `vm_size` - Size of the VM used for building. This can be changed when you deploy a VM from your VHD.
- `image_os` - Type of OS that will be deployed as a temporary VM.
- `image_version` - Specify version of an OS to boot from.

**Detailed Azure builders documentation can be found in [packer documentation](https://www.packer.io/docs/builders/azure).**

### Toolset
Configuration for some installed software is located in `toolset.json` files. These files define the list of Ruby, Python, Go versions, the list of PowerShell modules and VS components that will be installed to image. They can be changed if these tools are not required to reduce image generation time or image size.

Generated tool versions and details can be found in related projects:
- [Python](https://github.com/actions/python-versions/)
- [Go](https://github.com/actions/go-versions)
- [Node](https://github.com/actions/node-versions)

### Post-generation scripts

> :warning: These scripts are intended to run on a VM deployed in Azure

The user, created during the image generation, does not exist in the result VHD hence some configuration files related to the user's home directory need to be changed as well as the file permissions for some directories. Scripts for that are located in the `post-generation` folder in the repository:
- Windows: https://github.com/actions/runner-images/tree/main/images/win/post-generation
- Linux: https://github.com/actions/runner-images/tree/main/images/linux/post-generation

**Note:** The default user for Linux should have `sudo privileges`.

The scripts are copied to the VHD during the image generation process to the following paths:
- Windows: `C:\post-generation`
- Linux:  `/opt/post-generation` 

#### Running scripts

##### Ubuntu

        sudo su -c "find /opt/post-generation -mindepth 1 -maxdepth 1 -type f -name '*.sh' -exec bash {} \;"

##### Windows

        Get-ChildItem C:\post-generation -Filter *.ps1 | ForEach-Object { & $_.FullName }

#### Script details

##### Ubuntu

- **cleanup-logs.sh** - removes all build process logs from the machine
- **environment-variables.sh** - replaces `$HOME` with the default user's home directory for environmental variables related to the default user home directory
- **homebrew-permissions.sh** - Resets homebrew repository directory by running `git reset --hard` to make the working tree clean after chmoding /home and changes the repository directory owner to the current user
- **rust-permissions.sh** - fixes permissions for the Rust folder. Detailed issue explanation is provided in [runner-images/issues/572](https://github.com/actions/runner-images/issues/572).

##### Windows

- **GenerateIISExpressCertificate.ps1** - generates and imports a certificate to run applications with IIS Express through HTTPS
- **InternetExplorerConfiguration** - turns off the Internet Explorer Enhanced Security feature
- **Msys2FirstLaunch.ps1** - initializes bash user profile in MSYS2
- **VSConfiguration.ps1** - performs initial Visual Studio configuration
