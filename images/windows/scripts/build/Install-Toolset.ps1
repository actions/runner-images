################################################################################
##  File:  Install-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Install toolset
################################################################################

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

function Install-Asset {
    param(
        [Parameter(Mandatory = $true)]
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

    # Correct verbose logging in Python v12
    if ($releaseAssetName -like "*python-3.12.10-win32-x64*") {
        $scriptPath = "setup.ps1"
        $lines = Get-Content $scriptPath
        $block = @(
            '# print out all files in $PythonArchPath',
            'Write-Host "Files in $PythonArchPath"',
            '$files = Get-ChildItem -Path $PythonArchPath -File -Recurse',
            'Write-Output $files'
        )

        # Determine line ending style of $scriptPath
        $lineEnding = "`n"    # Unix style
        $rawContent = Get-Content $scriptPath -Raw
        if ($rawContent -match "`r`n") {
            $lineEnding = "`r`n"  # Windows style
        }

        $i = 0
        $output = @()
        while ($i -lt $lines.Count) {
            if (
                $i + 3 -lt $lines.Count -and
                $lines[$i] -eq $block[0] -and
                $lines[$i + 1] -eq $block[1] -and
                $lines[$i + 2] -eq $block[2] -and
                $lines[$i + 3] -eq $block[3]
            ) {
                $i += 4
                continue
            }
            $output += $lines[$i]
            $i++
        }
        Set-Content -Path $scriptPath -Value ($output -join $lineEnding)
    }
    # End correction

    Invoke-Expression .\setup.ps1
    Pop-Location
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
        $asset = $assets `
        | Where-Object version -Like $toolVersion `
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
