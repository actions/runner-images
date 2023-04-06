function Get-BashVersion {
    $version = bash -c 'echo ${BASH_VERSION}'
    return $version
}

function Get-DashVersion {
    $version = dpkg-query -W -f '${Version}' dash
    return $version
}

function Get-CPPVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    $cppVersions = $result.Output | Where-Object { $_ -match "g\+\+-\d+"} | ForEach-Object {
        & $_.Split("/")[0] --version | Select-Object -First 1 | Take-OutputPart -Part 3
    } | Sort-Object {[Version]$_}
    return $cppVersions
}

function Get-FortranVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    $fortranVersions = $result.Output | Where-Object { $_ -match "^gfortran-\d+"} | ForEach-Object {
        $_ -match "now (?<version>\d+\.\d+\.\d+)-" | Out-Null
        $Matches.version
    } | Sort-Object {[Version]$_}
    return $fortranVersions
}

function Get-ClangToolVersions {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ToolName,
        [string] $VersionLineMatcher = "${ToolName} version",
        [string] $VersionPattern = "\d+\.\d+\.\d+)-"
    )

    $result = Get-CommandResult "apt list --installed" -Multiline
    $toolVersions = $result.Output | Where-Object { $_ -match "^${ToolName}-\d+"} | ForEach-Object {
        $clangCommand = ($_ -Split "/")[0]
        Invoke-Expression "$clangCommand --version" | Where-Object { $_ -match "${VersionLineMatcher}" } | ForEach-Object {
            $_ -match "${VersionLineMatcher} (?<version>${VersionPattern}" | Out-Null
            $Matches.version
            }
        } | Sort-Object {[Version]$_}

    return $toolVersions
}


function Get-ClangTidyVersions {
    return Get-ClangToolVersions -ToolName "clang-tidy" -VersionLineMatcher "LLVM version" -VersionPattern "\d+\.\d+\.\d+)"
}


function Get-ErlangVersion {
    $erlangVersion = (erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), ''OTP_VERSION''])), io:fwrite(Version), halt().' -noshell)
    $shellVersion = (erl -eval 'erlang:display(erlang:system_info(version)), halt().' -noshell).Trim('"')
    return "$erlangVersion (Eshell $shellVersion)"
}

function Get-ErlangRebar3Version {
    $result = Get-CommandResult "rebar3 --version"
    $result.Output -match "rebar (?<version>(\d+.){2}\d+)" | Out-Null
    return $Matches.version
}

function Get-MonoVersion {
    $monoVersion = mono --version | Out-String | Take-OutputPart -Part 4
    return $monoVersion
}

function Get-MsbuildVersion {
    $msbuildVersion = msbuild -version | Select-Object -Last 1
    $monoVersion = Get-MonoVersion
    return "$msbuildVersion (Mono $monoVersion)"
}

function Get-NuGetVersion {
    $nugetVersion = nuget help | Select-Object -First 1 | Take-OutputPart -Part 2
    return $nugetVersion
}

function Get-NodeVersion {
    $nodeVersion = $(node --version).Substring(1)
    return $nodeVersion
}

function Get-OpensslVersion {
    return $(dpkg-query -W -f '${Version}' openssl)
}

function Get-PerlVersion {
    $version = $(perl -e 'print substr($^V,1)')
    return $version
}

function Get-PythonVersion {
    $result = Get-CommandResult "python --version"
    $version = $result.Output | Take-OutputPart -Part 1
    return $version
}

function Get-Python3Version {
    $result = Get-CommandResult "python3 --version"
    $version = $result.Output | Take-OutputPart -Part 1
    return $version
}

function Get-PowershellVersion {
    return $(pwsh --version) | Take-OutputPart -Part 1
}

function Get-RubyVersion {
    $rubyVersion = ruby --version | Out-String | Take-OutputPart -Part 1
    return $rubyVersion
}

function Get-SwiftVersion {
    $swiftVersion = swift --version | Out-String | Take-OutputPart -Part 2
    return $swiftVersion
}

function Get-KotlinVersion {
    $kotlinVersion = kotlin -version | Out-String | Take-OutputPart -Part 2
    return $kotlinVersion
}

function Get-JuliaVersion {
    $juliaVersion = julia --version | Take-OutputPart -Part 2
    return $juliaVersion
}

function Get-LernaVersion {
    $version = lerna -v
    return $version
}

function Get-HomebrewVersion {
    $result = Get-CommandResult "/home/linuxbrew/.linuxbrew/bin/brew -v"
    $result.Output -match "Homebrew (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-CpanVersion {
    $result = Get-CommandResult "cpan --version" -ExpectExitCode @(25, 255)
    $result.Output -match "version (?<version>\d+\.\d+) " | Out-Null
    return $Matches.version
}

function Get-GemVersion {
    $result = Get-CommandResult "gem --version"
    $result.Output -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-MinicondaVersion {
    $condaVersion = conda --version | Take-OutputPart -Part 1
    return $condaVersion
}

function Get-HelmVersion {
    $(helm version) -match 'Version:"v(?<version>\d+\.\d+\.\d+)"' | Out-Null
    return $Matches.version
}

function Get-NpmVersion {
    $npmVersion = npm --version
    return $npmVersion
}

function Get-YarnVersion {
    $yarnVersion = yarn --version
    return $yarnVersion
}

function Get-ParcelVersion {
    $parcelVersion = parcel --version
    return $parcelVersion
}

function Get-PipVersion {
    $result = Get-CommandResult "pip --version"
    $result.Output -match "pip (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-Pip3Version {
    $result = Get-CommandResult "pip3 --version"
    $result.Output -match "pip (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-VcpkgVersion {
    $commitId = git -C "/usr/local/share/vcpkg" rev-parse --short HEAD
    return "(build from commit $commitId)"
}

function Get-AntVersion {
    $result = ant -version | Out-String
    $result -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-GradleVersion {
    $gradleVersion = (gradle -v) -match "^Gradle \d" | Take-OutputPart -Part 1
    return $gradleVersion
}

function Get-MavenVersion {
    $result = mvn -version | Out-String
    $result -match "Apache Maven (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-SbtVersion {
    $result = Get-CommandResult "sbt -version"
    $result.Output -match "sbt script version: (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-PHPVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    return $result.Output | Where-Object { $_ -match "^php\d+\.\d+/"} | ForEach-Object {
        $_ -match "now (\d+:)?(?<version>\d+\.\d+\.\d+)" | Out-Null
        $Matches.version
    }
}

function Get-ComposerVersion {
    $composerVersion = (composer --version) -replace " version" | Take-OutputPart -Part 1
    return $composerVersion
}

function Get-PHPUnitVersion {
    $(phpunit --version | Out-String) -match "PHPUnit (?<version>\d+\.\d+\.\d+)\s" | Out-Null
    return $Matches.version
}

function Get-GHCVersion {
    $(ghc --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-GHCupVersion {
    $(ghcup --version) -match "version (?<version>\d+(\.\d+){2,})" | Out-Null
    return $Matches.version
}

function Get-CabalVersion {
    $(cabal --version | Out-String) -match "cabal-install version (?<version>\d+\.\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-StackVersion {
    $(stack --version | Out-String) -match "Version (?<version>\d+\.\d+\.\d+)" | Out-Null
    return $Matches.version
}

function Get-AzModuleVersions {
    $azModuleVersions = Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
        $_.Name.Split("_")[1]
    }

    $azModuleVersions = $azModuleVersions -join " "
    return $azModuleVersions
}

function Get-PowerShellModules {
    [Array] $result = @()

    [Array] $azureInstalledModules = Get-ChildItem -Path "/usr/share/az_*" -Directory | ForEach-Object { $_.Name.Split("_")[1] }
    if ($azureInstalledModules.Count -gt 0) {
        $result += [ToolVersionsListNode]::new("Az", $azureInstalledModules, "^\d+\.\d+", "Inline")
    }

    [Array] $azureCachedModules = Get-ChildItem /usr/share/az_*.zip -File | ForEach-Object { $_.Name.Split("_")[1] }
    if ($azureCachedModules.Count -gt 0) {
        $result += [ToolVersionsListNode]::new("Az (Cached)", $azureCachedModules, "^\d+\.\d+", "Inline")
    }

    (Get-ToolsetContent).powershellModules.name | ForEach-Object {
        $moduleName = $_
        $moduleVersions = Get-Module -Name $moduleName -ListAvailable | Select-Object -ExpandProperty Version | Sort-Object -Unique
        $result += [ToolVersionsListNode]::new($moduleName, $moduleVersions, "^\d+", "Inline")
    }

    return $result
}

function Get-DotNetCoreSdkVersions {
    $dotNetCoreSdkVersion = dotnet --list-sdks list | ForEach-Object { $_ | Take-OutputPart -Part 0 }
    return $dotNetCoreSdkVersion
}

function Get-DotnetTools {
    $env:PATH = "/etc/skel/.dotnet/tools:$($env:PATH)"
    $dotnetTools = (Get-ToolsetContent).dotnet.tools

    return $dotnetTools | ForEach-Object {
        $version = Invoke-Expression $_.getversion
        return [ToolVersionNode]::new($_.name, $version)
    }
}

function Get-CachedDockerImages {
    $toolsetJson = Get-ToolsetContent
    $images = $toolsetJson.docker.images
    return $images
}

function Get-CachedDockerImagesTableData {
    $allImages = sudo docker images --digests --format "*{{.Repository}}:{{.Tag}}|{{.Digest}} |{{.CreatedAt}}"
    $allImages.Split("*") | Where-Object { $_ } | ForEach-Object {
        $parts = $_.Split("|")
        [PSCustomObject] @{
            "Repository:Tag" = $parts[0]
            "Digest" = $parts[1]
            "Created" = $parts[2].split(' ')[0]
        }
    } | Sort-Object -Property "Repository:Tag"
}

function Get-AptPackages {
    $apt = (Get-ToolsetContent).Apt
    $output = @()
    ForEach ($pkg in ($apt.common_packages + $apt.cmd_packages)) {
        $version = $(dpkg-query -W -f '${Version}' $pkg)
        if ($Null -eq $version) {
            $version = $(dpkg-query -W -f '${Version}' "$pkg*")
        }
        
        $version = $version -replace '~','\~'

        $output += [PSCustomObject] @{
            Name    = $pkg
            Version = $version
        }
    }
    return ($output | Sort-Object Name)
}

function Get-PipxVersion {
    $result = (Get-CommandResult "pipx --version").Output
    $result -match "(?<version>\d+\.\d+\.\d+\.?\d*)" | Out-Null
    return $Matches.Version
}

function Build-PackageManagementEnvironmentTable {
    return @(
        [PSCustomObject] @{
            "Name" = "CONDA"
            "Value" = $env:CONDA
        },
        [PSCustomObject] @{
            "Name" = "VCPKG_INSTALLATION_ROOT"
            "Value" = $env:VCPKG_INSTALLATION_ROOT
        }
    )
}

function Get-SystemdVersion {
    $matches = [regex]::Matches((systemctl --version | head -n 1), "\((.*?)\)")
    $result = foreach ($match in $matches) {$match.Groups[1].Value}
    return $result
}