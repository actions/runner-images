################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

$ErrorActionPreference = "Stop"
Function Install-Asset {
    param(
        [Parameter(Mandatory = $true)]
        [object] $ReleaseAsset
    )

    $releaseAssetName = [System.IO.Path]::GetFileNameWithoutExtension($ReleaseAsset.filename)
    $assetFolderPath = Join-Path $env:INSTALLER_SCRIPT_FOLDER $releaseAssetName
    wget $ReleaseAsset.download_url -nv --retry-connrefused --tries=10

    Write-Host "Expand $($ReleaseAsset.filename) archive to the $assetFolderPath folder..."
    unzip $ReleaseAsset.filename -d $assetFolderPath

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression ./setup.sh
    Pop-Location
}

# Get toolset content
$toolsetJson = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$tools = ConvertFrom-Json -InputObject $toolsetJson | Select-Object -ExpandProperty toolcache

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
        if ($asset -ne $null) {
            Install-Asset -ReleaseAsset $asset
        }
        else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}
