################################################################################
##  File:  Install-PyPy.ps1
##  Team:  CI-Build
##  Desc:  Install PyPy
################################################################################
function Install-PyPy
{
    param(
        [String]$PackagePath,
        [String]$Architecture
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
    Extract-7Zip -Path $packagePath -DestinationPath $pypyToolcachePath

    # Get Python version from binaries
    $pypyApp = Get-ChildItem -Path "$tempFolder\pypy*.exe" | Where-Object Name -match "pypy(\d+)?.exe" | Select-Object -First 1
    $pythonVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))"

    $pypyFullVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(*sys.pypy_version_info[0:3]))"
    Write-Host "Put '$pypyFullVersion' to PYPY_VERSION file"
    New-Item -Path "$tempFolder\PYPY_VERSION" -Value $pypyFullVersion | Out-Null

    if ($pythonVersion)
    {
        Write-Host "Installing PyPy $pythonVersion"
        $pypyVersionPath = Join-Path -Path $pypyToolcachePath -ChildPath $pythonVersion
        $pypyArchPath = Join-Path -Path $pypyVersionPath -ChildPath $architecture

        Write-Host "Create PyPy '${pythonVersion}' folder in '${pypyVersionPath}'"
        New-Item -ItemType Directory -Path $pypyVersionPath -Force | Out-Null

        Write-Host "Move PyPy '${pythonVersion}' files to '${pypyArchPath}'"
        Invoke-SBWithRetry -Command {
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
        if (-not (Test-Path $pipPath))
        {
            $pip3Path = Join-Path -Path $pypyArchPath -ChildPath "Scripts/pip3.exe"
            Copy-Item -Path $pip3Path -Destination $pipPath 
        }

        if ($LASTEXITCODE -ne 0)
        {
            Throw "Error happened during PyPy installation"
            exit 1
        }

        Write-Host "Create complete file"
        New-Item -ItemType File -Path $pypyVersionPath -Name "$architecture.complete" | Out-Null
    }
    else
    {
        Write-Host "PyPy application is not found. Failed to expand '$packagePath' archive"
        exit 1
    }
}

# Get PyPy content from toolset
$toolsetVersions = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object Name -eq "PyPy"

# Get PyPy releases
$pypyVersions = Invoke-RestMethod https://downloads.python.org/pypy/versions.json

Write-Host "Starting installation PyPy..."
foreach($toolsetVersion in $toolsetVersions.versions)
{
    # Query latest PyPy version
    $latestMajorPyPyVersion = $pypyVersions |
        Where-Object {$_.python_version.StartsWith("$toolsetVersion") -and $_.stable -eq $true} |
        Select-Object -ExpandProperty files -First 1 |
        Where-Object platform -like "win*"
    
    if ($latestMajorPyPyVersion)
    {
        Write-Host "Found PyPy '$($latestMajorPyPyVersion.filename)' package"
        $tempPyPyPackagePath = Start-DownloadWithRetry -Url $latestMajorPyPyVersion.download_url -Name $latestMajorPyPyVersion.filename
        Install-PyPy -PackagePath $tempPyPyPackagePath -Architecture $toolsetVersions.arch
    }
    else
    {
        Write-Host "Failed to query PyPy version '$toolsetVersion'"
        exit 1
    }
}