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

$toolset = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$toolsToInstall = @("Az")

$tools = ConvertFrom-Json -InputObject $toolset | Select-Object -ExpandProperty toolcache | Where-Object {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
        | Select-Object -ExpandProperty files `
        | Where-Object { ($_.platform -eq $tool.platform) -and ($_.platform_version -eq $tool.platform_version)} `
        | Select-Object -First 1

        Write-Host "Installing $($tool.name) $toolVersion $($tool.arch)..."
        if ($null -ne $asset) {
            Write-Host "Download $($asset.filename)"
            wget $asset.download_url -nv --retry-connrefused --tries=10 -P $installPSModulePath
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
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
