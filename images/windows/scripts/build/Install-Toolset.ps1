################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

Function Install-Asset {
    param(
        [Parameter(Mandatory=$true)]
        [object] $ReleaseAsset
    )

    $releaseAssetName = [System.IO.Path]::GetFileNameWithoutExtension($ReleaseAsset.filename)
    $assetFolderPath = Join-Path $env:TEMP_DIR $releaseAssetName
    $assetArchivePath = Invoke-DownloadWithRetry $ReleaseAsset.download_url

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    if ($assetArchivePath.EndsWith(".tar.gz")) {
        $assetTarPath = $assetArchivePath.TrimEnd(".tar.gz")
        Expand-7ZipArchive -Path $assetArchivePath -DestinationPath $assetTarPath
        Expand-7ZipArchive -Path $assetTarPath -DestinationPath $assetFolderPath
    } else {
        Expand-7ZipArchive -Path $assetArchivePath -DestinationPath $assetFolderPath
    }

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression .\setup.ps1
    Pop-Location
}

function Resolve-ToolsetInstallScriptPath {
    param(
        [Parameter(Mandatory = $true)]
        [string] $RelativePath
    )

    if ([string]::IsNullOrWhiteSpace($RelativePath)) {
        return $null
    }

    if ([System.IO.Path]::IsPathRooted($RelativePath)) {
        return $RelativePath
    }

    $toolsetPath = Join-Path $env:IMAGE_FOLDER "toolset.json"
    $toolsetDirectory = Split-Path -Parent $toolsetPath
    $scriptFileName = Split-Path -Leaf $RelativePath

    $candidatePaths = @(
        [System.IO.Path]::GetFullPath((Join-Path $toolsetDirectory $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $PSScriptRoot) $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path $env:IMAGE_FOLDER $scriptFileName)),
        [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $scriptFileName))
    )

    foreach ($candidate in $candidatePaths | Select-Object -Unique) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    return $candidatePaths[0]
}

$toolsetContent = Get-ToolsetContent
$installScripts = @(
    foreach ($property in $toolsetContent.PSObject.Properties) {
        if ($property.Value -is [pscustomobject] -and ($property.Value.PSObject.Properties.Name -contains "install_script")) {
            $scriptPath = Resolve-ToolsetInstallScriptPath -RelativePath $property.Value.install_script
            if ($scriptPath) {
                [pscustomobject]@{
                    Tool = $property.Name
                    ScriptPath = $scriptPath
                }
            }
        }
    }
)

foreach ($installScript in $installScripts) {
    Write-Host "Running install script for tool '$($installScript.Tool)' from $($installScript.ScriptPath)"
    & $installScript.ScriptPath
}

# Get toolcache content from toolset
$toolsToInstall = @("Python", "Node", "Go")
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object { $toolsToInstall -contains $_.Name }

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    # Invoke-RestMethod doesn't support retry in PowerShell 5.1
    $assets = Invoke-ScriptBlockWithRetry -Command {
        Invoke-RestMethod $tool.url
    }

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object { ($_.version -like $toolVersion) -and ($_.version -as [version] -ne $null) } `
            | Select-Object -ExpandProperty files `
            | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) -and ($_.toolset -eq $tool.toolset) } `
            | Select-Object -First 1

        if (-not $asset) {
            throw "Asset for $($tool.name) $toolVersion $($tool.arch) not found in versions manifest"
        }

        Write-Host "Installing $($tool.name) $toolVersion $($tool.arch)..."
        Install-Asset -ReleaseAsset $asset
    }
}
