################################################################################
##  File:  Install-Ruby.ps1
##  Desc:  Install rubyinstaller2
################################################################################

function Get-RubyVersions
{
    param (
        [System.String] $Arch = "x64",
        [System.String] $Extension = "7z"
    )

    $uri = "https://api.github.com/repos/oneclick/rubyinstaller2/releases"
    try
    {
        $versionLists = @{}
        $assets = (Invoke-RestMethod -Uri $uri).Where{ -not $_.prerelease }.assets
        $7zArchives = $assets.Where{ $_.name.EndsWith("$Arch.$Extension") }
        $majorMinorGroups = $7zArchives | Group-Object { $_.name.Replace("rubyinstaller-", "").Substring(0, 3) }
        foreach($majorMinorGroup in $majorMinorGroups)
        {
            $group = $majorMinorGroup.Group
            $sortVersions = $group | Sort-Object {[Version]$_.name.Replace("rubyinstaller-", "").Replace("-$Arch.$Extension","").Replace("-",".")}
            $latestVersion = $sortVersions | Select-Object -Last 1
            $versionLists[$majorMinorGroup.Name] = $latestVersion.browser_download_url

        }
        return $versionLists
    }
    catch
    {
        Write-Host "Unable to send request to the '$uri'. Error: '$_'"
        exit 1
    }
}

# Most of this logic is from
# https://github.com/ruby/setup-ruby/blob/master/windows.js
function Install-Ruby
{
    param(
        [String]$PackagePath,
        [String]$Architecture = "x64"
    )

    # Expand archive with binaries
    $packageName = [IO.Path]::GetFileNameWithoutExtension((Split-Path -Path $PackagePath -Leaf))
    $tempFolder = Join-Path -Path $env:TEMP -ChildPath $packageName
    Extract-7Zip -Path $PackagePath -DestinationPath $env:TEMP

    # Get Ruby version from binaries
    $rubyVersion = & "$tempFolder\bin\ruby.exe" -e "print RUBY_VERSION"

    if ($rubyVersion)
    {
        Write-Host "Installing Ruby $rubyVersion"
        $rubyToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Ruby"
        $rubyVersionPath = Join-Path -Path $rubyToolcachePath -ChildPath $rubyVersion
        $rubyArchPath = Join-Path -Path $rubyVersionPath -ChildPath $Architecture

        if (-not (Test-Path $rubyToolcachePath))
        {
            Write-Host "Creating Ruby toolcache folder"
            New-Item -ItemType Directory -Path $rubyToolcachePath | Out-Null
        }

        Write-Host "Creating Ruby '${rubyVersion}' folder in '${rubyVersionPath}'"
        New-Item -ItemType Directory -Path $rubyVersionPath -Force | Out-Null

        Write-Host "Moving Ruby '${rubyVersion}' files to '${rubyArchPath}'"
        Move-Item -Path $tempFolder -Destination $rubyArchPath | Out-Null

        Write-Host "Removing Ruby '${rubyVersion}' documentation '${rubyArchPath}\share\doc' folder"
        Remove-Item -Path "${rubyArchPath}\share\doc" -Force -Recurse -ErrorAction Ignore

        Write-Host "Creating complete file"
        New-Item -ItemType File -Path $rubyVersionPath -Name "$Architecture.complete" | Out-Null
    }
    else
    {
        Write-Host "Ruby application is not found. Failed to expand '$PackagePath' archive"
        exit 1
    }
}

function Set-DefaultRubyVersion
{
    param(
        [Parameter(Mandatory=$true)]
        [System.Version] $Version,
        [System.String] $Arch = "x64"
    )

    $rubyPath = Join-Path $env:AGENT_TOOLSDIRECTORY "/Ruby/${Version}*/${Arch}/bin"
    $rubyDir = (Get-Item -Path $rubyPath).FullName

    Write-Host "Use Ruby ${Version} as a system Ruby"
    Add-MachinePathItem -PathItem $rubyDir | Out-Null
}

# Install Ruby
$rubyTools = (Get-ToolsetContent).toolcache | Where-Object { $_.name -eq "Ruby" }
$rubyToolVersions = $rubyTools.versions

# Get Ruby versions from the repo
$rubyLatestMajorVersions = Get-RubyVersions

Write-Host "Starting installation Ruby..."
foreach($rubyVersion in $rubyToolVersions)
{
    Write-Host "Starting Ruby $rubyVersion installation"
    # Get url for the latest major Ruby version
    $url = $rubyLatestMajorVersions[$rubyVersion]
    if ($url)
    {
        $tempRubyPackagePath = Start-DownloadWithRetry -Url $url
        Install-Ruby -PackagePath $tempRubyPackagePath
    }
    else
    {
        Write-Host "Url not found for the '$rubyVersion' version"
        exit 1
    }
}

Set-DefaultRubyVersion -Version $rubyTools.default -Arch $rubyTools.arch