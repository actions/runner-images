################################################################################
##  File:  Validate-AzureModules.ps1
##  Desc:  Validate Azure PowerShell modules
################################################################################

Import-Module -Name ImageHelpers -Force

$DefaultModule = Get-Module -Name AzureRM -ListAvailable | Select-Object -First 1

$env:PSModulePath = $env:PSModulePath + ";C:\Modules"

$azureModules = Get-Module -Name Azure -ListAvailable | Select-Object Name,Version,Path | Format-Table | Out-String

Write-Host "The Azure Modules finally present are:"
$azureModules

if( ($azureModules -match "2.1.0") -and ($azureModules -match "3.8.0") -and ($azureModules -match "4.2.1") -and ($azureModules -match "5.1.1"))
{
    Write-Host "Required Azure modules are present"
}
else {
    Write-Host "One or more required Azure modules are not present"
    throw "One or more required Azure modules are not present."
}


$azureRMModules = Get-Module -Name AzureRM -ListAvailable | Select-Object Name,Version,Path | Format-Table | Out-String

Write-Host "The AzureRM Modules finally present are:"
$azureRMModules

if( ($azureRMModules -match "2.1.0") -and ($azureRMModules -match "3.8.0") -and ($azureRMModules -match "4.2.1") -and ($azureRMModules -match "5.1.1"))
{
    Write-Host "Required AzureRM modules are present"

}
else {
    Write-Host "One or more required AzureRM modules are not present"
    throw "One or more required AzureRM modules are not present."
}


$azureModules = Get-Module -Name AzureRM -ListAvailable


# Adding description of the software to Markdown
$SoftwareName = "Azure/AzureRM Powershell modules"

$Description = @"
#### $($DefaultModule.Version)

This version is installed and is available via ``Get-Module -ListAvailable``
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

foreach( $module in $azureModules)
{
    if($module.Version -ne $DefaultModule.Version)
    {

        $CurrentModule = @"
#### $($module.Version)

This version is saved but not installed
_Location:_ $($module.Path)

"@
        Add-ContentToMarkdown -Content $CurrentModule
    }
}
