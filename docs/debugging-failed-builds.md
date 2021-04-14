# Debugging Failed Packer Builds

## Step 1: Run packer build `-on-error=ask`
When you run the `packer build` command, give it the `-on-error=ask` flag.
By default, `packer build` will delete the resource group as soon as the build fails.
`-on-error=ask` will pause it and wait for your input so you have time to remote in to the VM and diagnose the failure.

When the build fails, you will see this:

![Ask on error screenshot](/docs/resources/askOnError.png "Ask on error screenshot")

## Step 2: Find the resource group name in the build log
At the beginning of the build log (written to console), find the resource group name for the VM:

![Resource group from log screenshot](/docs/resources/resourceGroupName.png "Resource group from log screenshot")

Log into the Azure Portal.  Find that resource group under `Resource groups`.  You should see the resources for the Packer build:

![Packer resource group in Azure screenshot](/docs/resources/packerResourceGroup.png "Packer resource group in Azure screenshot")

## Step 3: Connect to the VM
Select the VM in the resource group.  Click `Connect:`

This will download an RDP file.  Open that and enter the credentials found in the JSON file you pass to `packer build`:

![VM credentials screenshot](/docs/resources/vmCredentials.png "VM credentials screenshot")

