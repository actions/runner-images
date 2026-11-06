################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Import-Module "$env:HELPER_SCRIPTS/../tests/Helpers.psm1"

function Install-Asset {
    param(
        [Parameter(Mandatory = $true)]
        [object] $ReleaseAsset
    )

    Write-Host "Download $($ReleaseAsset.filename)"
    $assetArchivePath = Invoke-DownloadWithRetry $ReleaseAsset.download_url

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    $assetFolderPath = Join-Path "/tmp" "$($ReleaseAsset.filename)-temp-dir"
    New-Item -ItemType Directory -Path $assetFolderPath | Out-Null
    tar -xzf $assetArchivePath -C $assetFolderPath

    Write-Host "Invoke installation script..."
    try {
        Push-Location -Path $assetFolderPath
        try {
            Invoke-Expression "bash ./setup.sh"
        } finally {
            Pop-Location
        }
    } finally {
        Remove-Item -Path $assetArchivePath -Force
        Remove-Item -Path $assetFolderPath -Recurse -Force
    }
}

$ErrorActionPreference = "Stop"

# Get toolcache content from toolset
$tools = (Get-ToolsetContent).toolcache | Where-Object { $_.url -ne $null }

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object { ($_.version -like $toolVersion) -and ($_.version -as [version] -ne $null) } `
            | Select-Object -ExpandProperty files `
            | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) -and ($_.platform_version -eq $tool.platform_version) } `
            | Select-Object -First 1

        if (-not $asset) {
            Write-Host "Asset for $($tool.name) $toolVersion $($tool.arch) not found in versions manifest"
            exit 1
        }

        Write-Host "Installing $($tool.name) $toolVersion $($tool.arch)..."
        Install-Asset -ReleaseAsset $asset
    }

    chown -R "$($env:SUDO_USER):$($env:SUDO_USER)" "/opt/hostedtoolcache/$($tool.name)"
}
