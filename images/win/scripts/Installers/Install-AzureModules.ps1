################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  Install Azure PowerShell modules
################################################################################

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

#### NOW The correct Modules need to be saved in C:\Modules
$installPSModulePath = 'C:\Modules'
if(-not (Test-Path -LiteralPath $installPSModulePath))
{
    Write-Host "Creating '$installPSModulePath' folder to store PowerShell Azure modules"
    $null = New-Item -Path $installPSModulePath -ItemType Directory
}

# Powershell Azure modules to install
$psAzureModulesToInstall = @{
    "azurerm" = @(
        "2.1.0"
        "3.8.0"
        "4.2.1"
        "5.1.1"
        "6.7.0"
        "6.13.1"
    )

    "azure" = @(
        "2.1.0"
        "3.8.0"
        "4.2.1"
        "5.1.1"
        "5.3.0"
    )

    "az" = @(
        "1.0.0"
        "1.6.0"
        "2.3.2"
        "2.6.0"
        "3.1.0"
        "3.5.0"
    )
}

# Download Azure PowerShell modules
foreach($psmoduleName in $psAzureModulesToInstall.Keys)
{
    Write-Host "Installing '$psmoduleName' to the '$installPSModulePath' path:"
    $psmoduleVersions = $psAzureModulesToInstall[$psmoduleName]
    foreach($psmoduleVersion in $psmoduleVersions)
    {
        $psmodulePath = Join-Path $installPSModulePath "${psmoduleName}_${psmoduleVersion}"
        Write-Host " - $psmoduleVersion [$psmodulePath]"
        try
        {
            Save-Module -Path $psmodulePath -Name $psmoduleName -RequiredVersion $psmoduleVersion -Force -ErrorAction Stop
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