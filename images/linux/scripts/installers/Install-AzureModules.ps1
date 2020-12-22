$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Import-Module "$env:HELPER_SCRIPTS/Tests.Helpers.psm1" -DisableNameChecking

# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules
$installPSModulePath = "/usr/share"

foreach ($module in $modules)
{
    $moduleName = $module.name
    Write-Host "Installing ${moduleName} to the ${installPSModulePath} path..."
    foreach ($version in $module.versions)
    {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
        Write-Host " - $version [$modulePath]"
        Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force -Verbose
    }
}

# If Az.Accounts > 1.0.0 unable to load module with error: Assembly with same name is already loaded
# Force install Az.Accounts 1.0.0
$azAccountsPath = "/usr/share/az_1.0.0/Az.Accounts"
if (Test-Path $azAccountsPath)
{
    Remove-Item -Path $azAccountsPath -Force -Recurse
    Save-Module -Name Az.Accounts -Path "/usr/share/az_1.0.0" -RequiredVersion 1.0.0 -Force
}

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "AzureModules"
