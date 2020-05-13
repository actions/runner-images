################################################################################
##  File:  Install-PyPy.ps1
##  Team:  CI-Build
##  Desc:  Install PyPy
################################################################################

function Get-PyPyUri
{
    param(
        [String]$PackageName
    )

    "https://bitbucket.org/pypy/pypy/downloads/{0}" -f $packageName
}

function Get-PyPyVersions
{
    $uri = "https://api.bitbucket.org/2.0/repositories/pypy/pypy/downloads?pagelen=100"
    try
    {
        (Invoke-RestMethod -Uri $uri).Values
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
    $pypyVersion = & $pypyApp -c "import sys;print('{}.{}.{}'.format(sys.version_info[0],sys.version_info[1],sys.version_info[2]))"

    if ($pypyVersion)
    {
        Write-Host "Installing PyPy $pypyVersion"
        $pypyToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "PyPy"
        $pypyVersionPath = Join-Path -Path $pypyToolcachePath -ChildPath $pypyVersion
        $pypyArchPath = Join-Path -Path $pypyVersionPath -ChildPath $architecture

        if (-not (Test-Path $pypyToolcachePath)) {
            Write-Host "Create PyPy toolcache folder"
            $null = New-Item -ItemType Directory -Path $env:AGENT_TOOLSDIRECTORY -Name "PyPy"
        }

        Write-Host "Create PyPy '${pypyVersion}' folder in '${pypyToolcachePath}'"
        $null = New-Item -ItemType Directory -Path $pypyArchPath -Force

        Write-Host "Move PyPy files to '${pypyArchPath}'"
        Move-Item -Path $tempFolder\* -Destination $pypyArchPath | Out-Null

        Write-Host "Clear temporary folder"
        Remove-Item -Path $tempFolder -Force -Recurse | Out-Null

        Write-Host "Install PyPy '${pypyVersion}' in '${pypyArchPath}'"
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

$ErrorActionPreference = "Stop"
Import-Module -Name ImageHelpers -Force -DisableNameChecking

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
        $filter = '{0}{1}-*-{2}.zip' -f $pypyTool.name, $pypyVersion, $pypyTool.platform
        $latestMajorPyPyVersion = $pypyVersions | Where-Object {
            $_.name -like $filter -and $_.name.Split('-')[1].Substring(1) -as [System.Version]
        } | Sort-Object {Get-Date $_.created_on}  | Select-Object -Last 1

        if ($latestMajorPyPyVersion)
        {
            $packageName = $latestMajorPyPyVersion.name
            $packageDate = $latestMajorPyPyVersion.created_on

            Write-Host "Found PyPy '$packageName' package created on '$packageDate'"
            $url = Get-PyPyUri -PackageName $packageName
            $arch = $pypyTool.arch
            $tempPyPyPackagePath = Start-DownloadWithRetry -Url $url -Name  $packageName
            Install-PyPy -PackagePath $tempPyPyPackagePath -Architecture $arch
        }
        else
        {
            Write-Host "Failed to query PyPy version '$pypyVersion' by '$filter' filter"
            exit 1
        }
    }
}
