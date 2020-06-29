################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  Install Azure PowerShell modules
################################################################################

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

# The correct Modules need to be saved in C:\Modules
$installPSModulePath = $env:PSMODULES_ROOT_FOLDER
if (-not (Test-Path -LiteralPath $installPSModulePath))
{
    Write-Host "Creating ${installPSModulePath} folder to store PowerShell Azure modules"
    $null = New-Item -Path $installPSModulePath -ItemType Directory
}

# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules

foreach ($module in $modules)
{
    Write-Host "Installing $($module.name) to the ${installPSModulePath} path:"
    foreach ($version in $module.versions)
    {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "$($module.name)_${version}"
        Write-Host " - $version [$modulePath]"
        try
        {
            Save-Module -Path $modulePath -Name $module.name -RequiredVersion $version -Force -ErrorAction Stop
        }
        catch
        {
            Write-Host "Error: $_"
            exit 1
        }
    }
}

# Add AzureRM and Azure modules to the PSModulePath
$finalModulePath = '{0};{1};{2}' -f "${installPSModulePath}\azurerm_2.1.0", "${installPSModulePath}\azure_2.1.0", $env:PSModulePath
[Environment]::SetEnvironmentVariable("PSModulePath", $finalModulePath, "Machine")
