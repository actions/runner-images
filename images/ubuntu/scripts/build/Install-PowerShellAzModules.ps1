################################################################################
##  File:  Install-PowerShellAzModules.ps1
##  Desc:  Install Az modules for PowerShell
################################################################################

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Import-Module "$env:HELPER_SCRIPTS/../tests/Helpers.psm1"

# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules
$installPSModulePath = "/usr/share"

foreach ($module in $modules) {
    $moduleName = $module.name

    Write-Host "Installing ${moduleName} to the ${installPSModulePath} path..."
    foreach ($version in $module.versions) {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
        Write-Host " - $version [$modulePath]"
        Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force
    }

}

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "AzureModules"
