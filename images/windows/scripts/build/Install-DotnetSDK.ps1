################################################################################
##  File:  Install-DotnetSDK.ps1
##  Desc:  Install all released versions of the dotnet sdk and populate package
##         cache. Should run after VS and Node
##  Supply chain security: checksum validation
################################################################################

# Set environment variables
[Environment]::SetEnvironmentVariable("DOTNET_MULTILEVEL_LOOKUP", "0", "Machine")
[Environment]::SetEnvironmentVariable("DOTNET_NOLOGO", "1", "Machine")
[Environment]::SetEnvironmentVariable("DOTNET_SKIP_FIRST_TIME_EXPERIENCE", "1", "Machine")

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

#region "Functions"
function Get-SDKVersionsToInstall {
    param (
        [Parameter(Mandatory)]
        [string] $DotnetVersion
    )
    $releasesJsonUri = "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${DotnetVersion}/releases.json"
    $releasesData = (Invoke-DownloadWithRetry $releasesJsonUri) | Get-Item | Get-Content | ConvertFrom-Json
    # filtering out the preview/rc releases
    $releases = $releasesData.'releases' | Where-Object { !$_.'release-version'.Contains('-') }

    $sdks = @()
    foreach ($release in $releases) {
        $sdks += $release.'sdk'
        $sdks += $release.'sdks'
    }

    return $sdks.version `
    | Sort-Object { [Version] $_ } -Unique `
    | Group-Object { $_.Substring(0, $_.LastIndexOf('.') + 2) } `
    | ForEach-Object { $_.Group[-1] }
}

function Invoke-DotnetWarmup {
    param (
        [Parameter(Mandatory)]
        [string] $SDKVersion
    )
    # warm up dotnet for first time experience
    $projectTypes = @('console', 'mstest', 'web', 'mvc', 'webapi')
    foreach ($template in $projectTypes) {
        $projectPath = Join-Path -Path "C:\temp" -ChildPath $template
        New-Item -Path $projectPath -Force -ItemType Directory
        Push-Location -Path $projectPath
        & "$env:ProgramFiles\dotnet\dotnet.exe" new globaljson --sdk-version "$SDKVersion"
        if ($LastExitCode -ne 0) {
            throw "Dotnet new globaljson failed with exit code $LastExitCode"
        }
        & "$env:ProgramFiles\dotnet\dotnet.exe" new $template
        if ($LastExitCode -ne 0) {
            throw "Dotnet new $template failed with exit code $LastExitCode"
        }
        Pop-Location
        Remove-Item $projectPath -Force -Recurse
    }
}

function Install-DotnetSDK {
    param (
        [Parameter(Mandatory)]
        [string] $InstallScriptPath,
        [Parameter(Mandatory)]
        [Alias('Version')]
        [string] $SDKVersion,
        [Parameter(Mandatory)]
        [string] $DotnetVersion
    )

    if (Test-Path -Path "C:\Program Files\dotnet\sdk\$SDKVersion") {
        Write-Host "Sdk version $SDKVersion already installed"
        return
    }

    Write-Host "Installing dotnet $SDKVersion"
    $zipPath = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName())
    & $InstallScriptPath -Version $SDKVersion -InstallDir $(Join-Path -Path $env:ProgramFiles -ChildPath 'dotnet') -ZipPath $zipPath -KeepZip
    # Installer is PowerShell script that doesn't set exit code on failure
    # If installation failed, tests will fail anyway

    #region Supply chain security
    $releasesJsonUri = "https://dotnetcli.blob.core.windows.net/dotnet/release-metadata/${DotnetVersion}/releases.json"
    $releasesData = (Invoke-DownloadWithRetry $releasesJsonUri) | Get-Item | Get-Content | ConvertFrom-Json
    $distributorFileHash = $releasesData.releases.sdks.Where({ $_.version -eq $SDKVersion }).files.Where({ $_.name -eq 'dotnet-sdk-win-x64.zip' }).hash
    Test-FileChecksum $zipPath -ExpectedSHA512Sum $distributorFileHash
    #endregion
}
#endregion

$dotnetToolset = (Get-ToolsetContent).dotnet

# Download installation script.
$installScriptPath = Invoke-DownloadWithRetry -Url "https://dot.net/v1/dotnet-install.ps1"

# Install and warm up dotnet
foreach ($dotnetVersion in $dotnetToolset.versions) {
    $sdkVersionsToInstall = Get-SDKVersionsToInstall -DotnetVersion $dotnetVersion
    foreach ($sdkVersion in $sdkVersionsToInstall) {
        Install-DotnetSDK -InstallScriptPath $installScriptPath -SDKVersion $sdkVersion -DotnetVersion $dotnetVersion
        if ($dotnetToolset.warmup) {
            Invoke-DotnetWarmup -SDKVersion $sdkVersion
        }
    }
}

# Add dotnet to PATH
Add-MachinePathItem "C:\Program Files\dotnet"

# Remove NuGet Folder
$nugetPath = "$env:APPDATA\NuGet"
if (Test-Path $nugetPath) {
    Remove-Item -Path $nugetPath -Force -Recurse
}

# Generate and copy new NuGet.Config config
dotnet nuget list source | Out-Null
if ($LastExitCode -ne 0) {
    throw "Dotnet nuget list source failed with exit code $LastExitCode"
}
Copy-Item -Path $nugetPath -Destination "C:\Users\Default\AppData\Roaming" -Force -Recurse

# Install dotnet tools
Write-Host "Installing dotnet tools"
Add-DefaultPathItem "%USERPROFILE%\.dotnet\tools"
foreach ($dotnetTool in $dotnetToolset.tools) {
    dotnet tool install $($dotnetTool.name) --tool-path "C:\Users\Default\.dotnet\tools" --add-source "https://api.nuget.org/v3/index.json" | Out-Null
    if ($LastExitCode -ne 0) {
        throw "Dotnet tool install failed with exit code $LastExitCode"
    }
}

Invoke-PesterTests -TestFile "DotnetSDK"
