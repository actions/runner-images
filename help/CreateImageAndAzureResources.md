# Build an image.

## Create required Azure resources and generate an image

1. Generating required Azure resources and running a packer build for a targeted image is automated [here](../helpers/GenerateResourcesAndImage.ps1).

## Create a VM based on the template created by Packer

1. At the end of the output from running Packer above is a URL to the VM resource template with a read access token. It ends with `.json` plus a query string. Note this URL. For now, it seems like there is an [Az CLI bug](https://github.com/Azure/azure-cli/issues/5899) with specifying the template through a URI. So download the template locally and note the path of the template file.
1. Generating the required Azure resources and creating the VM is automated [here](../helpers/CreateAzureVMFromPackerTemplate.ps1).
1. After the VM is created, remote into it using its public IP address. You can test the installed tools or install the Azure Pipelines agent and connect it to your Azure DevOps organization.