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

    $assets = Invoke-RestMethod $module.url

    # Get github release asset for each version
    foreach ($toolVersion in $module.zip_versions) {
        $asset = $assets | Where-Object version -eq $toolVersion `
            | Select-Object -ExpandProperty files `
            | Select-Object -First 1

        if (-not $asset) {
            Write-Host "Asset for ${moduleName} ${toolVersion} was not found in versions manifest"
            exit 1
        }

        Write-Host "Downloading asset for ${moduleName} ${toolVersion}: $($asset.filename)"
        Invoke-DownloadWithRetry $asset.download_url -Destination "$installPSModulePath/$($asset.filename)"
    }
}

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "AzureModules"
