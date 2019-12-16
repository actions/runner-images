################################################################################
##  File:  Validate-AzureCli.ps1
##  Desc:  Validate Azure CLI
################################################################################

if(Get-Command -Name 'az')
{
    Write-Host "Azure Cli $(az --version) on path"
}
else
{
    Write-Error "Azure Cli not on path"
    exit 1
}

$azureCliVersion = az -v | findstr azure-cli
$azureCliVersion = $azureCliVersion.trim().Substring("azure-cli".Length).trim()

# Adding description of the software to Markdown
$SoftwareName = "Azure CLI"

$Description = @"
_Version:_ $azureCliVersion
_Environment:_
* PATH: contains location of az.cmd
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
