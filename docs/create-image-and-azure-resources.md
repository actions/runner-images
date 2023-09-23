# GitHub Actions Runner Images

The runner-images project uses [Packer](https://www.packer.io/) to generate disk images for Windows 2019/2022 and Ubuntu 20.04/22.04.

Each image is configured by a JSON or HCL2 Packer template that specifies where to build the image (Azure in this case)
and what steps to run to install software and prepare the disk.

The Packer process initializes a connection to Azure subscription using Azure CLI and creates temporary resources
required for the build process: resource group, network interfaces and virtual machine from the "clean" image specified in the template.

If the VM deployment succeeds, Packer connects it using ssh or WinRM and begins executing installation steps from the template one-by-one.
If any step fails, image generation is aborted and the temporary VM is terminated.
Packer also attempts to cleanup all the temporary resources it created (unless otherwise configured).

After successful completion of all installation steps Packer creates managed image from the temporary VM's disk and deletes the VM.

- [Build agent preparation](#build-agent-preparation)
- [Manual image generation](#manual-image-generation)
- [Manual image generation customization](#manual-image-generation-customization)
  - [Network security](#network-security)
  - [Azure subscription authentication](#azure-subscription-authentication)
- [Generated machine deployment](#generated-machine-deployment)
- [Automated image generation](#automated-image-generation)
  - [Required variables](#required-variables)
  - [Optional variables](#optional-variables)
- [Builder variables](#builder-variables)
- [Toolset](#toolset)
- [Post-generation scripts](#post-generation-scripts)
  - [Running scripts](#running-scripts)
  - [Script details: Ubuntu](#script-details-ubuntu)
  - [Script details: Windows](#script-details-windows)

## Build agent preparation

Build agent is a machine where Packer process will be started.
You can use any physical or virtual machine running OS Windows or Linux.
Of course you may also use [Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli).
In any case you will need these software installed:

- Packer 1.8.2 or higher.

  Download and install it manually from [here](https://www.packer.io/downloads) or use [Chocolatey](https://chocolatey.org/):

  ```powershell
  choco install packer
  ```

- Git.

  For Linux - install the latest version from your distro's package repo.

  For Windows - download and install it from [here](https://gitforwindows.org/) of use [Chocolatey](https://chocolatey.org/):

  ```powershell
  choco install git -params '"/GitAndUnixToolsOnPath"'
  ```

- Powershell 5.0 or higher.

  In Windows you already have it.

  For Linux follow instructions [here](https://learn.microsoft.com/en-us/windows-server/administration/linux-package-repository-for-microsoft-software)
  to add Microsoft's Linux Software Repository and then install package `powershell`.
- Azure CLI.

  Follow instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
  Or if you use Windows you may run this command in Powershell instead:

  ```powershell
  Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
  Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
  ```

## Manual image generation

This repo bundles script that helps generating images in Azure.
All you need are Azure subscription and build agent configured as described above.
We suggest starting with building UbuntuMinimal image because it includes only basic software and build in less than 30 minutes.

All the commands below should be executed in Powershell.

First clone runner-images repository and set current directory to it:

```powershell
git clone https://github.com/actions/runner-images.git
Set-Location runner-images
```

Then import [GenerateResourcesAndImage](../helpers/GenerateResourcesAndImage.ps1) script from `helpers` subdirectory:

```powershell
Import-Module .\helpers\GenerateResourcesAndImage.ps1
```

Finally, run `GenerateResourcesAndImage` function setting mandatory arguments: image type and where to create resources:

- `SubscriptionId` - your Azure Subscription ID
- `ResourceGroupName` - name of the resource group that will be created within your subscription (e.g. "imagegen-test")
- `AzureLocation` - location where resources will be created (e.g. "East US")
- `ImageType` - what image to build (we suggest choosing "UbuntuMinimal" here, other valid options are "Windows2019", "Windows2022", "Ubuntu2004", "Ubuntu2204")

This function automatically creates all required Azure resources and kicks off packer image generation for the selected image type.

When image is ready you may proceed to [deployment](#generated-machine-deployment)

## Manual image generation customization

Function `GenerateResourcesAndImage` accepts a bunch of arguments that may help you generating image in your specific environment.

For example, you may want that all the resources involved in image generation process are tagged.
In this case pass a HashTable of tags as a value for `Tags` parameter.

If you don't want function to authenticate interactively, you should create Service Principal and invoke the function with parameters `AzureClientId`, `AzureClientSecret` and `AzureTenantId`.
You can find more details [in corresponding section below](#azure-subscription-authentication).

Use `get-help GenerateResourcesAndImage -Detailed` for the complete list of parameters available.

### Network security

To connect to a temporary virtual machine Packer uses WinRM or SSH.

If your build agent is located outside of the Azure subscription where temporary VM is created, the public network interface and public IP address is used.
Make sure that firewalls are configured properly and WinRM (tcp port 5986) and ssh (tcp port 22) connections are allowed both outgoing for build agent and incoming for temporary VM.
Also if you don't want temporary VM to be accessible from everywhere, set `RestrictToAgentIpAddress` parameter value to `$true`
to setup firewall rules allowing access only from your build agent public IP address.

If your build agent and temporary VM are in the same subscription you can configure Packer to connect using private virtual network.
To achieve that set proper values for environment variables `VNET_RESOURCE_GROUP`, `VNET_NAME` and `VNET_SUBNET`.

### Azure subscription authentication

Packer uses Service Principal to authenticate in Azure infrastructure.
For more information about Service Principals refer to
[Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).

Function `GenerateResourcesAndImage` is able to create Service Principle to be used by Packer.
It uses Connect-AzAccount cmdlet that invokes interactive authentication process by default.
If you don't want to use interactive authentication you should create Service Principal with full read-write permissions for selected Azure subscription on your own
and provide proper values for parameters `AzureClientId`, `AzureClientSecret` and `AzureTenantId`.

Here is an example of how to create Service Principle using Az Powershell module:

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
  ClientId = $sp.AppId
  ClientSecret = $appCred.SecretText
  TenantId = (Get-AzSubscription -SubscriptionId $SubscriptionId).TenantId
}
```

## Generated machine deployment

After the successful image generation, Virtual Machine can be created from the generated image using [CreateAzureVMFromPackerTemplate](../helpers/CreateAzureVMFromPackerTemplate.ps1) script.

```powershell
Import-Module .\helpers\CreateAzureVMFromPackerTemplate.ps1

CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId} -ResourceGroupName {ResourceGroupName} -ManagedImageName "Runner-Image-Ubuntu2204" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "eastus"
```

Where:

- `SubscriptionId` - The Azure subscription Id where resources will be created.
- `ResourceGroupName` - The Azure resource group name where the Azure virtual machine will be created.
- `ManagedImageName` - The name of the managed image to be used for the virtual machine creation.
- `VirtualMachineName` - The name of the virtual machine to be generated.
- `AdminUserName` - The administrator username for the virtual machine to be created.
- `AdminPassword` - The administrator password for the virtual machine to be created.
- `AzureLocation` - The location where the Azure virtual machine will be provisioned. Example: "eastus"

The function creates an Azure VM and generates network resources in Azure to make the VM accessible.

## Automated image generation

If you want to generate images automatically (e.g. as a part of CI/CD pipeline)
you can use Packer directly. To do that you will need:

- A build agent configured as described in
  [Build agent preparation](#build-agent-preparation) section.
- Azure subscription and Service Principal configured as described in
  [Azure subscription authentication](#azure-subscription-authentication) section.
- Resource group created in your Azure subscription where managed image will be stored.
- String to be used as password for the user used to install software (Windows only).

Then you can invoke Packer in you CI/CD pipeline using the following command:

```powershell
packer build -var "subscription_id=$SubscriptionId" `
             -var "client_id=$ClientId" `
             -var "client_secret=$ClientSecret" `
             -var "install_password=$InstallPassword" `
             -var "location=$Location" `
             -var "managed_image_name=$ImageName" `
             -var "managed_image_resource_group_name=$ImageResourceGroupName" `
             -var "tenant_id=$TenantId" `
             $TemplatePath
```

Where:

- `SubscriptionId` - your Azure Subscription ID
- `ClientId` and `ClientSecret` - Service Principal credentials
- `TenantId` - Azure Tenant ID
- `InstallPassword` - password for the user used to install software (Windows only)
- `Location` - location where resources will be created (e.g. "East US")
- `ImageName` and `ImageResourceGroupName` - name of the resource group where managed image will be stored
- `TemplatePath` - path to the Packer template file (e.g. "images/win/windows2022.json")

### Required variables

The following variables are required to be passed to Packer process:

| Template var | Env var | Description
| ------------ | ------- | -----------
| `subscription_id` | `ARM_SUBSCRIPTION_ID` | Subscription under which the build will be performed.
| `client_id` | `ARM_CLIENT_ID` | The Active Directory service principal associated with your builder.
| `client_secret` | `ARM_CLIENT_SECRET` | The password or secret for your service principal; may be omitted if `client_cert_path` is set.
| `client_cert_path` | `ARM_CLIENT_CERT_PATH` | The location of a PEM file containing a certificate and private key for service principal; may be omitted if `client_secret` is set.
| `location` | `ARM_RESOURCE_LOCATION` | Azure datacenter in which your VM will build.
| `managed_image_resource_group_name` | `ARM_RESOURCE_GROUP` | Resource group under which the final artifact will be stored.

### Optional variables

The following variables are optional:

- `managed_image_name` - Name of the managed image to create. If not specified, "Runner-Image-{{ImageType}}" will be used.
- `build_resource_group_name` - Specify an existing resource group to run the build in it. By default, a temporary resource group will be created and destroyed as part of the build. If you do not have permission to do so, use build_resource_group_name to specify an existing resource group to run the build in it.
- `object_id` - The object ID for the AAD SP. Will be derived from the oAuth token if empty.
- `tenant_id` - The Active Directory tenant identifier with which your `client_id` and `subscription_id` are associated. If not specified, `tenant_id` will be looked up using `subscription_id`.
- `temp_resource_group_name` - Name assigned to the temporary resource group created during the build. If this value is not set, a random value will be assigned. This resource group is deleted at the end of the build.
- `private_virtual_network_with_public_ip` - This value allows you to set a `virtual_network_name` and obtain a public IP. If this value is not set and `virtual_network_name` is defined Packer is only allowed to be executed from a host on the same subnet / virtual network.
- `virtual_network_name` - Use a pre-existing virtual network for the VM. This option enables private communication with the VM, no public IP address is used or provisioned (unless you set `private_virtual_network_with_public_ip`).
- `virtual_network_resource_group_name` - If `virtual_network_name` is set, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the resource group containing the virtual network. If the resource group cannot be found, or it cannot be disambiguated, this value should be set.
- `virtual_network_subnet_name` - If `virtual_network_name` is set, this value may also be set. If `virtual_network_name` is set, and this value is not set the builder attempts to determine the subnet to use with the virtual network. If the subnet cannot be found, or it cannot be disambiguated, this value should be set.

## Builder variables

The `builders` section contains variables for the `azure-arm` builder used in the project. Most of the builder variables are inherited from the `user variables` section, however, the variables can be overwritten to adjust image-generation performance.

- `vm_size` - Size of the VM used for building. This can be changed when you deploy a VM from your image.
- `image_os` - Type of OS that will be deployed as a temporary VM.
- `image_version` - Specify version of an OS to boot from.

**Detailed Azure builders documentation can be found in [packer documentation](https://www.packer.io/docs/builders/azure).**

## Toolset

Configuration for some installed software is located in `toolset.json` files. These files define the list of Ruby, Python, Go versions, the list of PowerShell modules and VS components that will be installed to image. They can be changed if these tools are not required to reduce image generation time or image size.

Generated tool versions and details can be found in related projects:

- [Python](https://github.com/actions/python-versions/)
- [Go](https://github.com/actions/go-versions)
- [Node](https://github.com/actions/node-versions)

## Post-generation scripts

> :warning: These scripts are intended to run on a VM deployed in Azure

The user, created during the image generation, does not exist in the result image hence some configuration files related to the user's home directory need to be changed as well as the file permissions for some directories. Scripts for that are located in the `post-generation` folder in the repository:

- Windows: <https://github.com/actions/runner-images/tree/main/images/win/post-generation>
- Linux: <https://github.com/actions/runner-images/tree/main/images/linux/post-generation>

**Note:** The default user for Linux should have `sudo privileges`.

The scripts are copied to the image during the generation process to the following paths:

- Windows: `C:\post-generation`
- Linux:  `/opt/post-generation`

### Running scripts

- Ubuntu

  ```bash
  sudo su -c "find /opt/post-generation -mindepth 1 -maxdepth 1 -type f -name '*.sh' -exec bash {} \;"
  ```

- Windows

  ```powershell
  Get-ChildItem C:\post-generation -Filter *.ps1 | ForEach-Object { & $_.FullName }
  ```

### Script details: Ubuntu

- **cleanup-logs.sh** - removes all build process logs from the machine
- **environment-variables.sh** - replaces `$HOME` with the default user's home directory for environmental variables related to the default user home directory
- **homebrew-permissions.sh** - Resets homebrew repository directory by running `git reset --hard` to make the working tree clean after chmoding /home and changes the repository directory owner to the current user
- **rust-permissions.sh** - fixes permissions for the Rust folder. Detailed issue explanation is provided in [runner-images/issues/572](https://github.com/actions/runner-images/issues/572).

### Script details: Windows

- **GenerateIISExpressCertificate.ps1** - generates and imports a certificate to run applications with IIS Express through HTTPS
- **InternetExplorerConfiguration** - turns off the Internet Explorer Enhanced Security feature
- **Msys2FirstLaunch.ps1** - initializes bash user profile in MSYS2
- **VSConfiguration.ps1** - performs initial Visual Studio configuration
