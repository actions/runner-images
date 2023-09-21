################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  PowerShell modules used by AzureFileCopy@4, AzureFileCopy@5, AzurePowerShell@4, AzurePowerShell@5 tasks
##  Supply chain security: package manager
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
        Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force -ErrorAction Stop
    }

    foreach ($version in $module.zip_versions)
    {
        $modulePath = Join-Path -Path $installPSModulePath -ChildPath "${moduleName}_${version}"
        Save-Module -Path $modulePath -Name $moduleName -RequiredVersion $version -Force -ErrorAction Stop
        Compress-Archive -Path $modulePath -DestinationPath "${modulePath}.zip"
        Remove-Item $modulePath -Recurse -Force
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