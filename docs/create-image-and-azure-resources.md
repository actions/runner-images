# GitHub Actions Runner Images

The runner-images project uses [Packer](https://www.packer.io/) to generate disk images for  Windows 2019/2022 and Ubuntu 20.04/22.04. 

Each image is configured through a JSON or HCL2 Packer template and specifies where to build the image (Azure in this case) and what steps to run to install software and prepare the disk.

The Packer process initializes a connection to Azure subscription via Azure CLI, and automatically creates all the temporary Azure resources required to build the source VM (resource group, network interfaces and VM from the "clean" image specified in the template).

If the VM deployment succeeds, the build agent connects to the VM and starts executing installation steps from the template. If any step fails, image generation is aborted and the temporary VM is terminated. Packer also attempts to cleanup all the temporary resources it created (unless otherwise configured).

After successful image generation, a snapshot of the temporary VM is converted to VHD image which is uploaded to the specified Azure Storage Account.

## Prerequisites
### Build agent

You can use local or virtual machine running OS Windows or Linux as a build agent.
You may use [Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli) as well.
In any case you will need these software:

- Packer 1.8.2 or higher.

  Download and install it manually from [here](https://www.packer.io/downloads) or use [Chocolatey](https://chocolatey.org/):
  ```
  choco install packer
  ```
- Git.

  For Linux - install the latest version from your distro's package repo.

  For Windows - download and install it from [here](https://github.com/git-for-windows/git/releases) of use [Chocolatey](https://chocolatey.org/):
  ```
  choco install git -params '"/GitAndUnixToolsOnPath"'
  ```
- Powershell 5.0 or higher.

  In Windows you already has it.

  For Linux follow instructions [here](https://learn.microsoft.com/en-us/windows-server/administration/linux-package-repository-for-microsoft-software) to add Microsoft's Linux Software Repository and then install package `powershell`.
- Azure CLI.

  Follow instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) or run this command in Powershell:
  ```
  Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
  ```
- [Az Powershell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps).
  
  Run this command in Powershell:
  ```
  Install-Module -Name Az -Repository PSGallery -Force
  ```

### Network security considerations

To connect to a temporary VM packer uses WinRM or SSH connection on public IP interface.

If you use a build agent located in an Azure subscription, please make sure that HTTPS/SSH ports are allowed for incoming/outgoing connections.

In case of firewall restrictions, prohibiting connections from public addresses, private virtual network resources can be deployed and passed as arguments to the packer (use environment variables `VNET_NAME`, `VNET_RESOURCE_GROUP` and `VNET_SUBNET`). This approach allows virtual machines to use private connections inside the VLAN.

### Azure subscription authentication
Packer uses Service Principal to authenticate in Azure infrastructure. For more information about Service Principals refer to [Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)

This repository contains script that automates creation of resources for Packer in Azure subscription including SP. You may rely on it (it'll open web browser to perform authentication) or create SP manually using Az PS module:

```powershell
$credentials = [Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphPasswordCredential]@{
  StartDateTime = Get-Date
  EndDateTime = (Get-Date).AddDays(7)
}

$sp = New-AzADServicePrincipal -DisplayName "imagegen-app"
$appCred = New-AzADAppCredential -ApplicationId $sp.AppId -PasswordCredentials $credentials

Start-Sleep -Seconds 30
New-AzRoleAssignment -RoleDefinitionName "Contributor" -PrincipalId $sp.Id
Start-Sleep -Seconds 30

@{
  clientId = $sp.AppId
  clientSecret = $appCred.SecretText
  tenantId = (Get-AzSubscription -SubscriptionId $SubscriptionId).TenantId
}
```

Note that to setup image generation CI or use packer manually you need proper SP with full read-write permissions for selected Azure subscription.

### Run image generation

All further steps are supposed to run in Powershell.

Clone runner-images repository and change directory:
```
git clone https://github.com/actions/runner-images.git
Set-Location runner-images
```

Import [GenerateResourcesAndImage](../helpers/GenerateResourcesAndImage.ps1) script from `/helpers` folder:

```powershell
Import-Module .\helpers\GenerateResourcesAndImage.ps1
```

Run `GenerateResourcesAndImage` function with appropriate arguments. Only four of them are mandatory:

- `SubscriptionId` - Azure Subscription Id where resources will be created
- `ResourceGroupName` - resource group name where resources will be created (e.g. "imagegen-test")
- `AzureLocation` - location where resources will be created (e.g. "East US")
- `ImageType` - what image to build (e.g. "UbuntuMinimal", other valid options are "Windows2019", "Windows2022", "Ubuntu2004", "Ubuntu2204")

This function automatically creates all required Azure resources and kicks off packer image generation for the selected image type.

To authenticate with existing service principal make sure to provide optional parameters `AzureClientId`, `AzureClientSecret` and `AzureTenantId`.

If you want specific tags to be set on all resources involved in image generation process then pass a HashTable of tags as a value for `Tags` parameter.

Other useful parameters may be `EnableHttpsTrafficOnly` (Boolean, to enable https for Storage Account) and `RestrictToAgentIpAddress` (Boolean, to limit access to temporary VM to your IP address only)

Use `get-help GenerateResourcesAndImage -Detailed` for the complete list of parameters available.

### Generated VM Deployment

After the successful image generation, Virtual Machine can be created from the generated VHD using [CreateAzureVMFromPackerTemplate](../helpers/CreateAzureVMFromPackerTemplate.ps1) script.

```
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
