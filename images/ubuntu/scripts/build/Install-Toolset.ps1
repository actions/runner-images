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

    $toolsetPath = Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    $toolsetDirectory = Split-Path -Parent $toolsetPath
    $scriptFileName = Split-Path -Leaf $RelativePath

    $candidatePaths = @(
        [System.IO.Path]::GetFullPath((Join-Path $toolsetDirectory $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path $env:INSTALLER_SCRIPT_FOLDER $RelativePath)),
        [System.IO.Path]::GetFullPath((Join-Path $env:INSTALLER_SCRIPT_FOLDER $scriptFileName))
    )

    foreach ($candidate in $candidatePaths) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    return $candidatePaths[0]
}

# Run any tool-specific install scripts declared in the toolset JSON.
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
    & bash $installScript.ScriptPath
}

# Get toolcache content from toolset
$tools = $toolsetContent.toolcache | Where-Object { $_.url -ne $null }

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
