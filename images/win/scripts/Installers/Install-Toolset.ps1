################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

Function Install-Asset {
    param(
        [Parameter(Mandatory=$true)]
        [object] $ReleaseAsset
    )

    $releaseAssetName = [System.IO.Path]::GetFileNameWithoutExtension($ReleaseAsset.filename)
    $assetFolderPath = Join-Path $env:TEMP $releaseAssetName
    $assetArchivePath = Start-DownloadWithRetry -Url $ReleaseAsset.download_url -Name $ReleaseAsset.filename

    Write-Host "Extract $($ReleaseAsset.filename) content..."
    7z.exe x $assetArchivePath -o"$assetFolderPath" -y | Out-Null

    Write-Host "Invoke installation script..."
    Push-Location -Path $assetFolderPath
    Invoke-Expression .\setup.ps1
    Pop-Location
}

Function Set-DefaultPythonVersion {
    param(
        [Parameter(Mandatory=$true)]
        [object[]] $Toolset
    )

    $python = $Toolset  | Where-Object { ($_.name -eq "Python") -and ($_.default -ne "") } `
                        | Select-Object default, arch -First 1

    if ($python.default -ne $null) {
        $pythonPath = Join-Path $Env:AGENT_TOOLSDIRECTORY "/Python/$($python.default)/$($python.arch)" -Resolve

        Write-Host "Use Python $($python.default) as a system Python"
        Add-MachinePathItem -PathItem $pythonPath
        Add-MachinePathItem -PathItem "$pythonPath\Scripts"
    } else {
        Write-Host "Default Python version not found in toolset file!"
    }
}

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

# Get toolcache content from toolset
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
                         | Sort-Object -Property {[version]$_.version} -Descending `
                         | Select-Object -ExpandProperty files `
                         | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) } `
                         | Select-Object -First 1

        Write-Host "Installing $($tool.name) $toolVersion $($tool.arch)..."
        if ($asset -ne $null) {
            Install-Asset -ReleaseAsset $asset
        } else {
            Write-Host "Asset was not found in versions manifest"
            exit 1
        }
    }
}

# Install default python version
Set-DefaultPythonVersion -Toolset $tools