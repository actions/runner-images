################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  Install Azure PowerShell modules
################################################################################

# The correct Modules need to be saved in C:\Modules
$installPSModulePath = $env:PSMODULES_ROOT_FOLDER
if (-not (Test-Path -LiteralPath $installPSModulePath))
{
    Write-Host "Creating ${installPSModulePath} folder to store PowerShell Azure modules..."
    $null = New-Item -Path $installPSModulePath -ItemType Directory
}
# Install modules from powershell gallery
# Get modules content from toolset
$modules = (Get-ToolsetContent).azureModules

$psModuleMachinePath = ""

foreach ($module in $modules)
{
    $moduleName = $module.name

    Write-Host "Installing ${moduleName} to the ${installPSModulePath} path..."
    foreach ($version in $module.versions)
    {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
        Write-Host " - $version [$modulePath]"
        try
        {
            Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force -ErrorAction Stop
        }
        catch
        {
            Write-Host "Error: $_"
            exit 1
        }
    }
    foreach ($version in $module.zipversions)
    {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
        Write-Host " - $version [$modulePath]"
        try
        {
            Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force -ErrorAction Stop
            Compress-Archive -Path $modulePath -DestinationPath "${modulePath}.zip"
            Remove-Item $modulePath -Recurse -Force
        }
        catch
        {
            Write-Host "Error: $_"
            exit 1
        }   
    }    
    # Append default tool version to machine path
    if ($null -ne $module.default)
    {
        $defaultVersion = $module.default

        Write-Host "Use ${moduleName} ${defaultVersion} as default version..."
        $psModuleMachinePath += "${installPSModulePath}\${moduleName}_${defaultVersion};"
    }
}
# Install modules from GH Release
# Get toolcache content from toolset
$ToolsToInstall = @("Az")
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
                         | Select-Object -ExpandProperty files `
                         | Select-Object -First 1

        Write-Host "Installing $($tool.name) $toolVersion ..."
        if ($null -ne $asset) {
            Start-DownloadWithRetry -Url $asset.download_url -Name $asset.filename -DownloadPath $installPSModulePath
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}

# Add modules to the PSModulePath
$psModuleMachinePath += $env:PSModulePath
[Environment]::SetEnvironmentVariable("PSModulePath", $psModuleMachinePath, "Machine")

Invoke-PesterTests -TestFile "PowerShellModules" -TestName "AzureModules"