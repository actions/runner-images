# GitHub Actions Runner Images

The runner-images project uses [Packer](https://www.packer.io/) to generate disk images for Windows 2019/2022 and Ubuntu 20.04/22.04.

Each image is configured by a HCL2 Packer template that specifies where to build the image (Azure, in this case),
and what steps to run to install software and prepare the disk.

The Packer process initializes a connection to the Azure subscription using Azure CLI and creates temporary resources
required for the build process: a resource group, network interfaces and a virtual machine from the "clean" image specified in the template.

If the VM deployment succeeds, Packer connects to it using SSH or WinRM and begins executing installation steps from the template one-by-one.
If any step fails, image generation is aborted, and the temporary VM is terminated.
Packer also attempts to clean up all the temporary resources it created (unless otherwise configured).

After successful completion of all installation steps, Packer creates a managed image from the temporary VM's disk and deletes the VM.

- [Build Agent Preparation](#build-agent-preparation)
- [Manual image generation](#manual-image-generation)
- [Manual Image Generation Customization](#manual-image-generation-customization)
  - [Network Security](#network-security)
  - [Azure Subscription Authentication](#azure-subscription-authentication)
- [Generated Machine Deployment](#generated-machine-deployment)
- [Automated image generation](#automated-image-generation)
  - [Required variables](#required-variables)
  - [Optional variables](#optional-variables)
- [Builder variables](#builder-variables)
- [Toolset](#toolset)
- [Post-generation scripts](#post-generation-scripts)
  - [Running scripts](#running-scripts)
  - [Script Details: Ubuntu](#script-details-ubuntu)
  - [Script Details: Windows](#script-details-windows)

## Build Agent Preparation

The build agent is a machine where the Packer process will be started.
You can use any physical or virtual machine running Windows or Linux OS.
Of course, you may also use an [Azure VM](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli).
In any case, you will need these software installed:

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
  to add Microsoft's Linux Software Repository and then install the `powershell` package.

- Azure CLI.

  Follow the instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
  Or if you use Windows, you may run this command in Powershell instead:

  ```powershell
  Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
  Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
  ```

## Manual image generation

This repository includes a script that assists in generating images in Azure.
All you need is an Azure subscription and a build agent configured as described above.
We suggest starting with building the UbuntuMinimal image because it includes only basic software and builds in less than 30 minutes.

All the commands below should be executed in PowerShell.

First, clone the runner-images repository and set the current directory to it:

```powershell
git clone https://github.com/actions/runner-images.git
Set-Location runner-images
```

Then, import the [GenerateResourcesAndImage](../helpers/GenerateResourcesAndImage.ps1) script from the `helpers` subdirectory:

```powershell
Import-Module .\helpers\GenerateResourcesAndImage.ps1
```

Finally, run the `GenerateResourcesAndImage` function, setting the mandatory arguments: image type and where to build and store the resulting managed image:

- `SubscriptionId` - your Azure Subscription ID;
- `ResourceGroupName` - the name of the resource group that will be created within your subscription (e.g., "imagegen-test");
- `AzureLocation` - the location where resources will be created (e.g., "East US");
- `ImageType` - the type of image to build (we suggest choosing "UbuntuMinimal" here; other valid options are "Windows2019", "Windows2022", "Ubuntu2004", "Ubuntu2204").

This function automatically creates all required Azure resources and initiates the Packer image generation for the selected image type.

When the image is ready, you may proceed to [deployment](#generated-machine-deployment).

## Manual Image Generation Customization

The `GenerateResourcesAndImage` function accepts a number of arguments that may assist you in generating an image in your specific environment.

For example, you may want all the resources involved in the image generation process to be tagged.
In this case, pass a HashTable of tags as a value for the `Tags` parameter.

If you don't want the function to authenticate interactively, you should create a Service Principal and invoke the function with the parameters `AzureClientId`, `AzureClientSecret` and `AzureTenantId`.
You can find more details in the [corresponding section below](#azure-subscription-authentication).

Use `get-help GenerateResourcesAndImage -Detailed` for the complete list of available parameters.

### Network Security

To connect to a temporary virtual machine, Packer uses WinRM or SSH.

If your build agent is located outside of the Azure subscription where the temporary VM is created, a public network interface and public IP address are used.
Make sure that firewalls are configured properly and that WinRM (TCP port 5986) and SSH (TCP port 22) connections are allowed both outgoing for the build agent and incoming for the temporary VM.
Also, if you don't want the temporary VM to be accessible from everywhere, set the `RestrictToAgentIpAddress` parameter value to `$true`
to set up firewall rules allowing access only from your build agent's public IP address.

If your build agent and temporary VM are in the same subscription, you can configure Packer to connect using a private virtual network.
To achieve this, set proper values for the environment variables `VNET_RESOURCE_GROUP`, `VNET_NAME` and `VNET_SUBNET`.

### Azure Subscription Authentication

Packer uses a Service Principal to authenticate in Azure infrastructure.
For more information about Service Principals, refer to the
[Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).

The `GenerateResourcesAndImage` function is able to create a Service Principal to be used by Packer.
It uses the Connect-AzAccount cmdlet that invokes an interactive authentication process by default.
If you don't want to use interactive authentication, you should create a Service Principal with full read-write permissions for the selected Azure subscription on your own
and provide proper values for the parameters `AzureClientId`, `AzureClientSecret` and `AzureTenantId`.

Here is an example of how to create a Service Principal using the Az PowerShell module:

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

## Generated Machine Deployment

After successful image generation, a Virtual Machine can be created from the generated image using the [CreateAzureVMFromPackerTemplate](../helpers/CreateAzureVMFromPackerTemplate.ps1) script.

```powershell
Import-Module .\helpers\CreateAzureVMFromPackerTemplate.ps1

CreateAzureVMFromPackerTemplate -SubscriptionId {YourSubscriptionId} -ResourceGroupName {ResourceGroupName} -ManagedImageName "Runner-Image-Ubuntu2204" -VirtualMachineName "testvm1" -AdminUsername "shady1" -AdminPassword "SomeSecurePassword1" -AzureLocation "eastus"
```

Where:

- `SubscriptionId` - the Azure subscription ID where resources will be created;
- `ResourceGroupName` - the Azure resource group name where the Azure virtual machine will be created;
- `ManagedImageName` - the name of the managed image to be used for the virtual machine creation;
- `VirtualMachineName` - the name of the virtual machine to be generated;
- `AdminUserName` - the administrator username for the virtual machine to be created;
- `AdminPassword` - the administrator password for the virtual machine to be created;
- `AzureLocation` - the location where the Azure virtual machine will be provisioned (e.g., "eastus").

This function creates an Azure VM and generates network resources in Azure to make the VM accessible.

## Automated image generation

If you want to generate images automatically (e.g., as a part of a CI/CD pipeline),
you can use Packer directly. To do this, you will need:

- a build agent configured as described in the
  [Build agent preparation](#build-agent-preparation) section;
- an Azure subscription and Service Principal configured as described in the
  [Azure subscription authentication](#azure-subscription-authentication) section;
- a resource group created in your Azure subscription where the managed image will be stored;
- a string to be used as a password for the user used to install software (Windows only).

Then, you can invoke Packer in your CI/CD pipeline using the following command:

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

- `SubscriptionId` - your Azure Subscription ID;
- `ClientId` and `ClientSecret` - Service Principal credentials;
- `TenantId` - Azure Tenant ID;
- `InstallPassword` - password for the user used to install software (Windows only);
- `Location` - location where resources will be created (e.g., "East US");
- `ImageName` and `ImageResourceGroupName` - name of the resource group where the managed image will be stored;
- `TemplatePath` - path to the Packer template file (e.g., "images/windows/templates/windows-2022.pkr.hcl").

### Required variables

The following variables are required to be passed to the Packer process:

| Template var | Env var | Description
| ------------ | ------- | -----------
| `subscription_id` | `ARM_SUBSCRIPTION_ID` | The subscription under which the build will be performed.
| `client_id` | `ARM_CLIENT_ID` | The Active Directory service principal associated with your builder.
| `client_secret` | `ARM_CLIENT_SECRET` | The password or secret for your service principal; may be omitted if `client_cert_path` is set.
| `client_cert_path` | `ARM_CLIENT_CERT_PATH` | The location of a PEM file containing a certificate and private key for the service principal; may be omitted if `client_secret` is set.
| `location` | `ARM_RESOURCE_LOCATION` | The Azure datacenter in which your VM will be built.
| `managed_image_resource_group_name` | `ARM_RESOURCE_GROUP` | The resource group under which the final artifact will be stored.

### Optional variables

The following variables are optional:

- `managed_image_name` - the name of the managed image to create. If not specified, "Runner-Image-{{ImageType}}" will be used;
- `build_resource_group_name` - specify an existing resource group to run the build in; by default, a temporary resource group will be created and destroyed as part of the build; if you do not have permission to do so, use `build_resource_group_name` to specify an existing resource group to run the build in;
- `object_id` - the object ID for the AAD SP; will be derived from the oAuth token if empty;
- `tenant_id` - the Active Directory tenant identifier with which your `client_id` and `subscription_id` are associated; if not specified, `tenant_id` will be looked up using `subscription_id`;
- `temp_resource_group_name` - the name assigned to the temporary resource group created during the build; if this value is not set, a random value will be assigned; this resource group is deleted at the end of the build;
- `private_virtual_network_with_public_ip` - this value allows you to set a `virtual_network_name` and obtain a public IP; if this value is not set and `virtual_network_name` is defined, Packer is only allowed to be executed from a host on the same subnet / virtual network;
- `virtual_network_name` - use a pre-existing virtual network for the VM; this option enables private communication with the VM, no public IP address is used or provisioned (unless you set `private_virtual_network_with_public_ip`);
- `virtual_network_resource_group_name` - if `virtual_network_name` is set, this value may also be set; if `virtual_network_name` is set, and this value is not set, the builder attempts to determine the resource group containing the virtual network; if the resource group cannot be found, or it cannot be disambiguated, this value should be set;
- `virtual_network_subnet_name` - if `virtual_network_name` is set, this value may also be set; if `virtual_network_name` is set, and this value is not set, the builder attempts to determine the subnet to use with the virtual network; if the subnet cannot be found, or it cannot be disambiguated, this value should be set.

## Builder variables

The `builders` section contains variables for the `azure-arm` builder used in the project. Most of the builder variables are inherited from the `user variables` section, however, the variables can be overwritten to adjust image-generation performance.

- `vm_size` - the size of the VM used for building; this can be changed when you deploy a VM from your image;
- `image_os` - the type of OS that will be deployed as a temporary VM;
- `image_version` - specify the version of an OS to boot from.

**Detailed Azure builders documentation can be found in the [packer documentation](https://www.packer.io/docs/builders/azure).**

## Toolset

The configuration for some installed software is located in `toolset.json` files. These files define the list of Ruby, Python, Go versions, the list of PowerShell modules and VS components that will be installed on the image. They can be changed if these tools are not required, to reduce image generation time or image size.

Generated tool versions and details can be found in related projects:

- [Python](https://github.com/actions/python-versions/)
- [Go](https://github.com/actions/go-versions)
- [Node](https://github.com/actions/node-versions)

## Post-generation scripts

> :warning: These scripts are intended to be run on a VM deployed in Azure

The user, created during the image generation, does not exist in the resulting image. Hence, some configuration files related to the user's home directory need to be changed, as well as the file permissions for some directories. Scripts for that are located in the `post-gen` folder in the repository:

- Windows: <https://github.com/actions/runner-images/tree/main/images/windows/assets/post-gen>
- Linux: <https://github.com/actions/runner-images/tree/main/images/ubuntu/assets/post-gen>

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

### Script Details: Ubuntu

- **cleanup-logs.sh** - removes all build process logs from the machine;
- **environment-variables.sh** - replaces `$HOME` with the default user's home directory for environment variables related to the default user home directory;
- **homebrew-permissions.sh** - resets the Homebrew repository directory by running `git reset --hard` to make the working tree clean after changing permissions in /home and changes the repository directory owner to the current user;
- **rust-permissions.sh** - fixes permissions for the Rust folder; a detailed issue explanation is provided in [runner-images/issues/572](https://github.com/actions/runner-images/issues/572).

### Script Details: Windows

- **GenerateIISExpressCertificate.ps1** - generates and imports a certificate to run applications with IIS Express through HTTPS;
- **InternetExplorerConfiguration.ps1** - turns off the Internet Explorer Enhanced Security feature;
- **Msys2FirstLaunch.ps1** - initializes the bash user profile in MSYS2;
- **VSConfiguration.ps1** - performs initial Visual Studio configuration.
