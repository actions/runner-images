################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  Install Azure PowerShell modules
################################################################################

# The correct Modules need to be saved in C:\Modules
$installPSModulePath = "C:\\Modules"
if (-not (Test-Path -LiteralPath $installPSModulePath))
{
    Write-Host "Creating ${installPSModulePath} folder to store PowerShell Azure modules..."
    $null = New-Item -Path $installPSModulePath -ItemType Directory
}

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

    if($null -ne $module.url)
    {
        $assets = Invoke-RestMethod $module.url
    }

    foreach ($version in $module.zip_versions)
    {
        # Install modules from GH Release
        if($null -ne $assets)
        {
            $asset = $assets | Where-Object version -eq $version `
                         | Select-Object -ExpandProperty files `
                         | Select-Object -First 1

            Write-Host "Installing $($module.name) $version ..."
            if ($null -ne $asset) {
                Start-DownloadWithRetry -Url $asset.download_url -Name $asset.filename -DownloadPath $installPSModulePath
            } else {
                Write-Host "Asset was not found in versions manifest"
                exit 1
            }
        }
        # Install modules from vsts blob
        else
        {
            $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
            $filename = "${moduleName}_${version}.zip"
            $download_url = [System.String]::Concat($module.blob_url,$filename)
            Write-Host " - $version [$modulePath]"
            try
            {
                Start-DownloadWithRetry -Url $download_url -Name $filename -DownloadPath $installPSModulePath
            }
            catch
            {
                Write-Host "Error: $_"
                exit 1
            }
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

# Add modules to the PSModulePath
$psModuleMachinePath += $env:PSModulePath
[Environment]::SetEnvironmentVariable("PSModulePath", $psModuleMachinePath, "Machine")

Invoke-PesterTests -TestFile "PowerShellAzModules" -TestName "AzureModules"