################################################################################
##  File:  Install-PyPy.ps1
##  Desc:  Install PyPy
##  Supply chain security: checksum validation
################################################################################

function Install-PyPy {
    param(
        [String] $PackagePath,
        [String] $Architecture
    )

    # Create PyPy toolcache folder
    $pypyToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "PyPy"
    if (-not (Test-Path $pypyToolcachePath)) {
        Write-Host "Create PyPy toolcache folder"
        New-Item -ItemType Directory -Path $pypyToolcachePath | Out-Null
    }

    # Expand archive with binaries
    $packageName = [IO.Path]::GetFileNameWithoutExtension((Split-Path -Path $packagePath -Leaf))
    $tempFolder = Join-Path -Path $pypyToolcachePath -ChildPath $packageName
    Expand-7ZipArchive -Path $packagePath -DestinationPath $pypyToolcachePath

    # Get Python version from binaries
    $pypyApp = Get-ChildItem -Path "$tempFolder\pypy*.exe" | Where-Object Name -match "pypy(\d+)?.exe" | Select-Object -First 1
    $pythonVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))"

    $pypyFullVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(*sys.pypy_version_info[0:3]))"
    Write-Host "Put '$pypyFullVersion' to PYPY_VERSION file"
    New-Item -Path "$tempFolder\PYPY_VERSION" -Value $pypyFullVersion | Out-Null

    if ($pythonVersion) {
        Write-Host "Installing PyPy $pythonVersion"
        $pypyVersionPath = Join-Path -Path $pypyToolcachePath -ChildPath $pythonVersion
        $pypyArchPath = Join-Path -Path $pypyVersionPath -ChildPath $architecture

        Write-Host "Create PyPy '${pythonVersion}' folder in '${pypyVersionPath}'"
        New-Item -ItemType Directory -Path $pypyVersionPath -Force | Out-Null

        Write-Host "Move PyPy '${pythonVersion}' files to '${pypyArchPath}'"
        Invoke-ScriptBlockWithRetry -Command {
            Move-Item -Path $tempFolder -Destination $pypyArchPath -ErrorAction Stop | Out-Null
        }

        Write-Host "Install PyPy '${pythonVersion}' in '${pypyArchPath}'"
        if (Test-Path "$pypyArchPath\python.exe") {
            cmd.exe /c "cd /d $pypyArchPath && python.exe -m ensurepip && python.exe -m pip install --upgrade pip"
        } else {
            $pypyName = $pypyApp.Name
            cmd.exe /c "cd /d $pypyArchPath && mklink python.exe $pypyName && python.exe -m ensurepip && python.exe -m pip install --upgrade pip"
        }

        # Create pip.exe if missing
        $pipPath = Join-Path -Path $pypyArchPath -ChildPath "Scripts/pip.exe"
        if (-not (Test-Path $pipPath)) {
            $pip3Path = Join-Path -Path $pypyArchPath -ChildPath "Scripts/pip3.exe"
            Copy-Item -Path $pip3Path -Destination $pipPath 
        }

        if ($LASTEXITCODE -ne 0) {
            throw "PyPy installation failed with exit code $LASTEXITCODE"
        }

        Write-Host "Create complete file"
        New-Item -ItemType File -Path $pypyVersionPath -Name "$architecture.complete" | Out-Null
    } else {
        throw "PyPy application is not found. Failed to expand '$packagePath' archive"
    }
}

# Get PyPy content from toolset
$toolsetVersions = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object Name -eq "PyPy"

# Get PyPy releases
$pypyVersions = Invoke-RestMethod https://downloads.python.org/pypy/versions.json

# required for html parsing
$checksums = (Invoke-RestMethod -Uri 'https://www.pypy.org/checksums.html' | ConvertFrom-HTML).SelectNodes('//*[@id="content"]/article/div/pre')

Write-Host "Start PyPy installation"
foreach ($toolsetVersion in $toolsetVersions.versions) {
    # Query latest PyPy version
    $latestMajorPyPyVersion = $pypyVersions |
        Where-Object { $_.python_version.StartsWith("$toolsetVersion") -and $_.stable -eq $true } |
        Select-Object -ExpandProperty files -First 1 |
        Where-Object platform -like "win*"
    
    if (-not $latestMajorPyPyVersion) {
        throw "Failed to query PyPy version '$toolsetVersion'"
    }

    $filename = $latestMajorPyPyVersion.filename
    Write-Host "Found PyPy '$filename' package"
    $tempPyPyPackagePath = Invoke-DownloadWithRetry $latestMajorPyPyVersion.download_url

    #region Supply chain security
    $distributorFileHash = $null
    foreach ($node in $checksums) {
        if ($node.InnerText -ilike "*${filename}*") {
            $distributorFileHash = $node.InnerText.ToString().Split("`n").Where({ $_ -ilike "*${filename}*" }).Split(' ')[0]
        }
    }
    Test-FileChecksum $tempPyPyPackagePath -ExpectedSHA256Sum $distributorFileHash
    #endregion

    Install-PyPy -PackagePath $tempPyPyPackagePath -Architecture $toolsetVersions.arch
}
