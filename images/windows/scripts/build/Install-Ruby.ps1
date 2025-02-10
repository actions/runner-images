################################################################################
##  File:  Install-Ruby.ps1
##  Desc:  Install Ruby using the RubyInstaller2 package and set the default Ruby version
################################################################################

# Most of this logic is from
# https://github.com/ruby/setup-ruby/blob/master/windows.js
function Install-Ruby {
    param(
        [String] $PackagePath,
        [String] $Architecture = "x64"
    )

    # Create Ruby toolcache folder
    $rubyToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Ruby"
    if (-not (Test-Path $rubyToolcachePath)) {
        Write-Host "Creating Ruby toolcache folder"
        New-Item -ItemType Directory -Path $rubyToolcachePath | Out-Null
    }
    
    $packageName = [IO.Path]::GetFileNameWithoutExtension((Split-Path -Path $PackagePath -Leaf))
    Write-Host "Expanding Ruby archive $packageName"
    $tempFolder = Join-Path -Path $rubyToolcachePath -ChildPath $packageName
    Expand-7ZipArchive -Path $PackagePath -DestinationPath $rubyToolcachePath

    # Get Ruby version from binaries
    $rubyVersion = & "$tempFolder\bin\ruby.exe" -e "print RUBY_VERSION"
    if (($LASTEXITCODE -ne 0) -or (-not $rubyVersion)) {
        throw "Unable to determine Ruby version. Exit code: $LASTEXITCODE, output: '$rubyVersion'"
    }
    Write-Host "Ruby version is $rubyVersion"

    $rubyVersionPath = Join-Path -Path $rubyToolcachePath -ChildPath $rubyVersion
    $rubyArchPath = Join-Path -Path $rubyVersionPath -ChildPath $Architecture

    Write-Host "Creating Ruby '${rubyVersion}' folder in '${rubyVersionPath}'"
    New-Item -ItemType Directory -Path $rubyVersionPath -Force | Out-Null

    Write-Host "Moving Ruby '${rubyVersion}' files to '${rubyArchPath}'"
    Invoke-ScriptBlockWithRetry -Command {
        Move-Item -Path $tempFolder -Destination $rubyArchPath -ErrorAction Stop | Out-Null
    }

    Write-Host "Removing Ruby '${rubyVersion}' documentation '${rubyArchPath}\share\doc' folder"
    Remove-Item -Path "${rubyArchPath}\share\doc" -Force -Recurse -ErrorAction Ignore

    Write-Host "Creating complete file for Ruby $rubyVersion $Architecture"
    New-Item -ItemType File -Path $rubyVersionPath -Name "$Architecture.complete" | Out-Null
}

function Set-DefaultRubyVersion {
    param(
        [Parameter(Mandatory = $true)]
        [version] $Version,
        [Alias("Arch")]
        [string] $Architecture = "x64"
    )

    $rubyPath = Join-Path $env:AGENT_TOOLSDIRECTORY "/Ruby/${Version}*/${Architecture}/bin"
    $rubyDir = (Get-Item -Path $rubyPath).FullName

    Write-Host "Use Ruby ${Version} as a system Ruby"
    Add-MachinePathItem -PathItem $rubyDir | Out-Null
}

# Install Ruby
$rubyTools = (Get-ToolsetContent).toolcache | Where-Object { $_.name -eq "Ruby" }
$rubyToolVersions = $rubyTools.versions

Write-Host "Starting installation Ruby..."
foreach ($rubyVersion in $rubyToolVersions) {
    Write-Host "Starting Ruby $rubyVersion installation"
    $downloadUrl = Resolve-GithubReleaseAssetUrl `
        -Repo "oneclick/rubyinstaller2" `
        -Version "$rubyVersion*" `
        -UrlMatchPattern "*-x64.7z"
    $packagePath = Invoke-DownloadWithRetry $downloadUrl
    Install-Ruby -PackagePath $packagePath
}

Set-DefaultRubyVersion -Version $rubyTools.default -Arch $rubyTools.arch
