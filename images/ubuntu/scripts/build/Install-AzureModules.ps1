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
        Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force
    }

    $assets = Invoke-RestMethod $module.url

    # Get github release asset for each version
    foreach ($toolVersion in $module.zip_versions) {
        $asset = $assets | Where-Object version -eq $toolVersion `
        | Select-Object -ExpandProperty files `
        | Select-Object -First 1

        Write-Host "Installing $($module.name) $toolVersion ..."
        if ($null -ne $asset) {
            Write-Host "Download $($asset.filename)"
            wget $asset.download_url -nv --retry-connrefused --tries=10 -P $installPSModulePath
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "AzureModules"
