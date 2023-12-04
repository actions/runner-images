################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Import-Module "~/image-generation/tests/Helpers.psm1"
Import-Module "~/image-generation/helpers/Common.Helpers.psm1"

Function Install-Asset {
    param(
        [Parameter(Mandatory=$true)]
        [object] $ReleaseAsset
    )

    Write-Host "Download $($ReleaseAsset.filename) archive..."
    $assetArchivePath = Invoke-DownloadWithRetry $ReleaseAsset.download_url

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    $assetFolderPath = Join-Path "/tmp" "$($ReleaseAsset.filename)-temp-dir"
    New-Item -ItemType Directory -Path $assetFolderPath | Out-Null
    tar -xzf $assetArchivePath -C $assetFolderPath

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression "bash ./setup.sh"
    Pop-Location
}

$arch = Get-Architecture

# Get toolcache content from toolset
$toolsToInstall = @("Python", "Node", "Go")
$tools = (Get-ToolsetContent).toolcache | Where-Object {$toolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url -MaximumRetryCount 10 -RetryIntervalSec 30

    # Get github release asset for each version
    foreach ($version in $tool.arch.$arch.versions) {
        $asset = $assets | Where-Object version -like $version `
                         | Select-Object -ExpandProperty files `
                         | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $arch)} `
                         | Select-Object -First 1

        Write-Host "Installing $($tool.name) $version..."
        if ($null -ne $asset) {
            Install-Asset -ReleaseAsset $asset
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}

Invoke-PesterTests "Toolcache"
