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
    if ($assetArchivePath.EndsWith(".tar.gz")) {
        $assetTarPath = $assetArchivePath.TrimEnd(".tar.gz")
        Extract-7Zip -Path $assetArchivePath -DestinationPath $assetTarPath
        Extract-7Zip -Path $assetTarPath -DestinationPath $assetFolderPath
    } else {
        Extract-7Zip -Path $assetArchivePath -DestinationPath $assetFolderPath
    }

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

Function Set-DefaultGoVersion {
    param(
        [Parameter(Mandatory=$true)]
        [object[]] $Toolset
    )

    $goToolset = $Toolset  | Where-Object { ($_.name -eq "go") -and ($_.default -ne "") } `
                           | Select-Object default, arch -First 1

    if ($goToolset.default -ne $null) {
        $goPath = Join-Path $Env:AGENT_TOOLSDIRECTORY "/go/$($goToolset.default)/$($goToolset.arch)" -Resolve

        Write-Host "Use Go $($goToolset.default) as a system Go"
        Add-MachinePathItem -PathItem "$goPath\bin" | Out-Null
        # Set the GOROOT environment variable.
        setx GOROOT "$goPath" /M | Out-Null
    } else {
        Write-Host "Default Go version not found in toolset file!"
    }
}

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

# Get toolcache content from toolset
$ToolsToInstall = @("Python", "Node", "Boost", "Go")

$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where {$ToolsToInstall -contains $_.Name}

foreach ($tool in $tools) {
    # Get versions manifest for current tool
    $assets = Invoke-RestMethod $tool.url

    # Get github release asset for each version
    foreach ($toolVersion in $tool.versions) {
        $asset = $assets | Where-Object version -like $toolVersion `
                         | Sort-Object -Property {[version]$_.version} -Descending `
                         | Select-Object -ExpandProperty files `
                         | Where-Object { ($_.platform -eq $tool.platform) -and ($_.arch -eq $tool.arch) -and ($_.toolset -eq $tool.toolset) } `
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
Set-DefaultGoVersion -Toolset $tools