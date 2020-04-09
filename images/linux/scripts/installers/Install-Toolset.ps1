################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Function Install-Asset {
    param(
        [Parameter(Mandatory = $true)]
        [object] $ReleaseAsset
    )

    $releaseAssetName = [System.IO.Path]::GetFileNameWithoutExtension($ReleaseAsset.filename)
    $assetFolderPath = Join-Path $env:AGENT_TEMPDIRECTORY $releaseAssetName
    $assetArchivePath = Start-DownloadWithRetry -Url $ReleaseAsset.download_url -Name $ReleaseAsset.filename -DownloadPath $env:AGENT_TEMPDIRECTORY

    Write-Host "Expand $($ReleaseAsset.filename) archive to the $assetFolderPath folder..."
    unzip $assetArchivePath -d $assetFolderPath

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression ./setup.ps1
    Pop-Location
}

Import-Module -Name ImageHelpers -Force

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
        | Where-Object { ($_.platform -eq $tool.platform) -and ($_.platform_version -eq $tool.platform_version) -and ($_.arch -eq $tool.arch) } `
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
