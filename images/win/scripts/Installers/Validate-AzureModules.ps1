################################################################################
##  File:  Validate-AzureModules.ps1
##  Desc:  Validate Azure PowerShell modules
################################################################################

Import-Module -Name ImageHelpers -Force

# Adding description of the software to Markdown
function Add-ModuleDescription
{
    param($DefaultModule, [String]$ModuleName)

    # Adding description of the software to Markdown
    $softwareName = "$moduleName PowerShell module"

    if ($defaultModule)
    {
        $description = "#### $($defaultModule.Version)`n`nThis version is installed and is available via ``Get-Module -ListAvailable``"
    }
    else
    {
        $Description = ""
    }

    Add-SoftwareDetailsToMarkdown -SoftwareName $softwareName -DescriptionMarkdown $description
    if($moduleName -eq 'Az')
    {
        $prop = @{n="Version";e={[Version]$_.Directory.Name}},@{n="Path";e={$_.FullName}}
        $azureModules = Get-ChildItem C:\Modules\az_*\Az\*\Az.psd1 | Select-Object $prop
    }
    else
    {
        $azureModules = Get-Module -Name $moduleName -ListAvailable | Sort-Object Version -Unique
    }

    foreach($module in $azureModules)
    {
        if($module.Version -ne $defaultModule.Version)
        {

            $currentModule = "#### $($module.Version)`n`nThis version is saved but not installed`n_Location:_ $($module.Path)"
            Add-ContentToMarkdown -Content $currentModule
        }
    }
}

function Validate-AzureModule
{
    param([String]$ModuleName, [String[]]$ModuleVersions)

    foreach($moduleVersion in $moduleVersions)
    {
        $modulePath = "${installPSModulePath}\${moduleName}_${moduleVersion}"
        # Import each module in PowerShell session
        $job = Start-Job -ScriptBlock {
            param($modulePath, $moduleName)

            $env:PsModulePath = "$modulePath;$env:PsModulePath"
            Import-Module -Name $moduleName
            Get-Module -Name $moduleName
        } -ArgumentList $modulePath, $moduleName
        $isError = $job | Wait-Job | Foreach-Object ChildJobs | Where-Object {$_.Error}
        if($isError)
        {
            Write-Host "Required '$moduleName' module '$moduleVersion' version is not present"
            exit 1
        }
        $job | Receive-Job | Select-Object Name,Version,Path
        Remove-Job $job
    }
}

# Modules path
$installPSModulePath = 'C:\Modules'

# Validate Azure modules and versions
$azurermVersions = "2.1.0", "3.8.0", "4.2.1", "5.1.1", "6.7.0", "6.13.1"
Validate-AzureModule -ModuleName AzureRM -ModuleVersions $azurermVersions

$azureVersions = "2.1.0", "3.8.0", "4.2.1", "5.1.1", "5.3.0"
Validate-AzureModule -ModuleName Azure -ModuleVersions $azureVersions

$azVersions = "1.0.0", "1.6.0", "2.3.2", "2.6.0", "3.1.0", "3.5.0"
Validate-AzureModule -ModuleName Az -ModuleVersions $azVersions

# Get default modules version
$defaultAzureRMModule = Get-Module -Name AzureRM -ListAvailable
$defaultAzureModule = Get-Module -Name Azure -ListAvailable

# Add modules to the PSModulePath
$env:PSModulePath = $env:PSModulePath + ";C:\Modules"

# Adding description of the software to Markdown
Add-ModuleDescription -DefaultModule $defaultAzureRMModule -ModuleName AzureRM
Add-ModuleDescription -DefaultModule $defaultAzureModule -ModuleName Azure
Add-ModuleDescription -ModuleName Az