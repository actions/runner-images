################################################################################
##  File:  Install-PyPy.ps1
##  Team:  CI-Build
##  Desc:  Install PyPy
################################################################################
function Get-PyPyVersions
{
    $uri = "https://downloads.python.org/pypy/"
    try
    {
        $hrefs = (Invoke-WebRequest -Uri $uri).Links.href
        $hrefs | Where-Object {$_ -match '^pypy'} | Select-Object @{n = "Name"; e = {$_}}, @{n = "href"; e = {
            [string]::Join('', ($uri, $_))
        }}
    }
    catch
    {
        Write-Host "Enable to send request to the '$uri'. Error: '$_'"
        exit 1
    }
}
function Install-PyPy
{
    param(
        [String]$PackagePath,
        [String]$Architecture
    )

    # Expand archive with binaries
    $packageName = [IO.Path]::GetFileNameWithoutExtension((Split-Path -Path $packagePath -Leaf))
    $tempFolder = Join-Path -Path $env:Temp -ChildPath $packageName
    Extract-7Zip -Path $packagePath -DestinationPath $env:Temp

    # Get Python version from binaries
    $pypyApp = Get-ChildItem -Path "$tempFolder\pypy*.exe" | Where-Object Name -match "pypy(\d+)?.exe"
    $pypyName = $pypyApp.Name
    $pythonVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))"

    $pypyFullVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(*sys.pypy_version_info[0:3]))"
    Write-Host "Put '$pypyFullVersion' to PYPY_VERSION file"
    New-Item -Path "$tempFolder\PYPY_VERSION" -Value $pypyFullVersion

    if ($pythonVersion)
    {
        Write-Host "Installing PyPy $pythonVersion"
        $pypyToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "PyPy"
        $pypyVersionPath = Join-Path -Path $pypyToolcachePath -ChildPath $pythonVersion
        $pypyArchPath = Join-Path -Path $pypyVersionPath -ChildPath $architecture

        if (-not (Test-Path $pypyToolcachePath)) {
            Write-Host "Create PyPy toolcache folder"
            New-Item -ItemType Directory -Path $pypyToolcachePath | Out-Null
        }

        Write-Host "Create PyPy '${pythonVersion}' folder in '${pypyVersionPath}'"
        New-Item -ItemType Directory -Path $pypyVersionPath -Force | Out-Null

        Write-Host "Move PyPy '${pythonVersion}' files to '${pypyArchPath}'"
        Move-Item -Path $tempFolder -Destination $pypyArchPath | Out-Null

        Write-Host "Install PyPy '${pythonVersion}' in '${pypyArchPath}'"
        cmd.exe /c "cd /d $pypyArchPath && mklink python.exe $pypyName && python.exe -m ensurepip && python.exe -m pip install --upgrade pip"

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
$pypyTools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object Name -eq "PyPy"

# Get PyPy versions from the repo
$pypyVersions = Get-PyPyVersions

Write-Host "Starting installation PyPy..."
foreach($pypyTool in $pypyTools)
{
    foreach($pypyVersion in $pypyTool.versions)
    {
        # Query latest PyPy version
        # PyPy 3.6 is not updated anymore and win32 should be used
        $platform = if ($pypyVersion -like "3.6*") { "win32" } else { $pypyTool.platform }
        $filter = '{0}{1}-v\d+\.\d+\.\d+-{2}.zip' -f $pypyTool.name, $pypyVersion, $platform
        $latestMajorPyPyVersion = $pypyVersions | Where-Object {$_.name -match $filter} | Select-Object -First 1

        if ($latestMajorPyPyVersion)
        {
            $packageName = $latestMajorPyPyVersion.name

            Write-Host "Found PyPy '$packageName' package"
            $url = $latestMajorPyPyVersion.href
            $tempPyPyPackagePath = Start-DownloadWithRetry -Url $url -Name  $packageName
            Install-PyPy -PackagePath $tempPyPyPackagePath -Architecture $pypyTool.arch
        }
        else
        {
            Write-Host "Failed to query PyPy version '$pypyVersion' by '$filter' filter"
            exit 1
        }
    }
}
