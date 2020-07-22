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
You can use local machine as build agent, or deploy virtual machine in [Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-cli) 

Download `packer` from https://www.packer.io/downloads
```
$packerFolder = "C:\packer"
Invoke-WebRequest -Uri https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_windows_amd64.zip -OutFile "$packerFolder/packer.zip" && Expand-Archive $packerFolder/packer.zip .
```
Or install it via Chocolately
```
Choco-Install -PackageName packer
```

Install Azure CLI - https://docs.microsoft.com/ru-ru/cli/azure/install-azure-cli-windows?view=azure-cli-latest&tabs=azure-cli
```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

Download Virtual-Envionments repository
```
git clone https://github.com/actions/virtual-environments.git
```

Run `packer` with specified arguments
```
packer build    -var "capture_name_prefix=$ResourcesNamePrefix" `
                -var "client_id=$ClientId" `
                -var "client_secret=$ClientSecret" `
                -var "install_password=$InstallPassword" `
                -var "github_feed_token=$GitHubFeedToken" `
                -var "location=$Location" `
                -var "resource_group=$ResourceGroup" `
                -var "storage_account=$StorageAccount" `
                -var "subscription_id=$SubscriptionId" `
                -var "temp_resource_group_name=$TempResourceGroupName" `
                -var "tenant_id=$TenantId" `
                -var "virtual_network_name=$VirtualNetworkName" `
                -var "virtual_network_resource_group_name=$VirtualNetworkRG" `
                -var "virtual_network_subnet_name=$VirtualNetworkSubnet" `
                $TemplatePath `
```
Where $TemplatePath is path to required image json template.

#### Generated VM Deployment
After successful image generation, you can deploy Virtual Machine based on generated VHD using following script - https://github.com/actions/virtual-environments/blob/main/helpers/CreateAzureVMFromPackerTemplate.ps1.
It will deploy private VNet and Subnet resoruces in selected subscription, create and attend network interfaces and deploy VM in selected resource group. 

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

#### Common vairables
- `vm_size` - Size of the VM used for building. This can be changed when you deploy a VM from your VHD. See pricing information. https://docs.microsoft.com/en-us/azure/search/search-sku-tier
- `image_os` - Type of OS that will be deployed as a temporary VM.
- `image_version` -  Specify a specific version of an OS to boot from.
- `imagedata_file` - Path to json file that will contain image-version and readme path
- `helper_script_folder` - Path, where helper modules will be deployed.
- `image_folder` - Root path of current image scripts location.

#### Linux only
- `metadata_file` - Path to metadata file that required for documentation creation.
- `installer_script_folder` - Root path of installation scripts.
- `run_validation_diskspace` - Boolean flag. Enable or disable available disk space scan.

#### Windows only
- `run_scan_antivirus` - Boolean flag. Enable or disable antivirus scan during image generation.
- `root_folder` - Path to installation root folder.
- `toolset_json_path` - Path to toolset config.
- `psmodules_root_folder` - Path to AZ modules.
- `install_user` - User under which all installations will be performed.
- `install_password` - Installation user password.

**Detailed Azure builders documentation can be found [here](https://www.packer.io/docs/builders/azure).**

### Toolset
To reduce image generation time, we store prebuilted versions of Python, Boost, Node and ruby in external sources, from which toolset-provision scripts download them during the build. If needed, unused versions or tools from toolset can be safely disabled, via removing from specified `toolset.json` config.

Example of toolset configuration:
```
"name": "Python",
"url" : "https://raw.githubusercontent.com/actions/python-versions/master/versions-manifest.json",
"platform" : "linux",
"platform_version": "20.04",
"arch": "x64",
"versions": [
    "2.7.*",
    "3.5.*",
    "3.6.*",
    "3.7.*",
    "3.8.*"
]
```
Generated tool versions and details can be found in related projects:
- [Python](https://github.com/actions/python-versions/)
- [Go](https://github.com/actions/go-versions)
- [Node](https://github.com/actions/node-versions)
- [Boost](https://github.com/actions/boost-versions)