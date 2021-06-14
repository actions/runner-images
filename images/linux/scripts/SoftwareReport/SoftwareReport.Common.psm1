function Get-BashVersion {
    $version = bash -c 'echo ${BASH_VERSION}'
    return "Bash $version"
}

function Get-CPPVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    $cppVersions = $result.Output | Where-Object { $_ -match "g\+\+-\d+"} | ForEach-Object {
        & $_.Split("/")[0] --version | Select-Object -First 1 | Take-OutputPart -Part 3
    } | Sort-Object {[Version]$_}
    return "GNU C++ " + ($cppVersions -Join ", ")
}

function Get-FortranVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    $fortranVersions = $result.Output | Where-Object { $_ -match "^gfortran-\d+"} | ForEach-Object {
        $_ -match "now (?<version>\d+\.\d+\.\d+)-" | Out-Null
        $Matches.version
    } | Sort-Object {[Version]$_}
    return "GNU Fortran " + ($fortranVersions -Join ", ")
}

function Get-ClangToolVersions {
    param (
        [Parameter(Mandatory = $true)]
        [string] $ToolName,
        [string] $VersionPattern = "\d+\.\d+\.\d+)-"
    )

    $result = Get-CommandResult "apt list --installed" -Multiline
    $toolVersions = $result.Output | Where-Object { $_ -match "^${ToolName}-\d+"} | ForEach-Object {
        $clangCommand = ($_ -Split "/")[0]
        Invoke-Expression "$clangCommand --version" | Where-Object { $_ -match "${ToolName} version" } | ForEach-Object {
            $_ -match "${ToolName} version (?<version>${VersionPattern}" | Out-Null
            $Matches.version
            }
        } | Sort-Object {[Version]$_}

    return $toolVersions -Join ", "
}

function Get-ClangVersions {
    $clangVersions = Get-ClangToolVersions -ToolName "clang"
    return "Clang " + $clangVersions
}

function Get-LLVMInfo {
    $clangVersions = Get-ClangToolVersions -ToolName "clang"
    $clangFormatVersions = Get-ClangToolVersions -ToolName "clang-format"
    $aptSourceRepo = Get-AptSourceRepository -PackageName "llvm"
    return "LLVM components: Clang $clangFormatVersions, Clang-format $clangFormatVersions (apt source: $aptSourceRepo)"
}

function Get-ClangFormatVersions {
    $clangFormatVersions = Get-ClangToolVersions -ToolName "clang-format"
    return "Clang-format " + $clangFormatVersions
}


function Get-ErlangVersion {
    $erlangVersion = (erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), ''OTP_VERSION''])), io:fwrite(Version), halt().' -noshell)
    $shellVersion = (erl -eval 'erlang:display(erlang:system_info(version)), halt().' -noshell).Trim('"')
    return "Erlang $erlangVersion (Eshell $shellVersion)"
}

function Get-ErlangRebar3Version {
    $result = Get-CommandResult "rebar3 --version"
    $result.Output -match "rebar (?<version>(\d+.){2}\d+)" | Out-Null
    $rebarVersion = $Matches.version
    return "Erlang rebar3 $rebarVersion"
}

function Get-MonoVersion {
    $monoVersion = mono --version | Out-String | Take-OutputPart -Part 4
    $aptSourceRepo = Get-AptSourceRepository -PackageName "mono"
    return "Mono $monoVersion (apt source repository: $aptSourceRepo)"
}

function Get-MsbuildVersion {
    $msbuildVersion = msbuild -version | Select-Object -Last 1
    $result = Select-String -Path (Get-Command msbuild).Source -Pattern "msbuild"
    $result -match "(?<path>\/\S*\.dll)" | Out-Null
    $msbuildPath = $Matches.path
    return "MSBuild $msbuildVersion (from $msbuildPath)"
}

function Get-NodeVersion {
    $nodeVersion = $(node --version).Substring(1)
    return "Node $nodeVersion"
}

function Get-OpensslVersion {
    return $(openssl version)
}

function Get-PerlVersion {
    $version = $(perl -e 'print substr($^V,1)')
    return "Perl $version"
}

function Get-PythonVersion {
    $result = Get-CommandResult "python --version"
    $version = $result.Output | Take-OutputPart -Part 1
    return "Python $version"
}

function Get-Python3Version {
    $result = Get-CommandResult "python3 --version"
    $version = $result.Output | Take-OutputPart -Part 1
    return "Python3 $version"
}

function Get-PowershellVersion {
    return $(pwsh --version)
}

function Get-RubyVersion {
    $rubyVersion = ruby --version | Out-String | Take-OutputPart -Part 1
    return "Ruby $rubyVersion"
}

function Get-SwiftVersion {
    $swiftVersion = swift --version | Out-String | Take-OutputPart -Part 2
    return "Swift $swiftVersion"
}

function Get-JuliaVersion {
    $juliaVersion = julia --version | Take-OutputPart -Part 2
    return "Julia $juliaVersion"
}

function Get-LernaVersion {
    $version = lerna -v
    return "Lerna $version"
}

function Get-HomebrewVersion {
    $result = Get-CommandResult "brew -v"
    $result.Output -match "Homebrew (?<version>\d+\.\d+\.\d+)" | Out-Null
    $version = $Matches.version
    return "Homebrew $version"
}

function Get-CpanVersion {
    $result = Get-CommandResult "cpan --version"
    $result.Output -match "version (?<version>\d+\.\d+) " | Out-Null
    $cpanVersion = $Matches.version
    return "cpan $cpanVersion"
}

function Get-GemVersion {
    $result = Get-CommandResult "gem --version"
    $result.Output -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $gemVersion = $Matches.version
    return "RubyGems $gemVersion"
}

function Get-MinicondaVersion {
    $condaVersion = conda --version
    return "Mini$condaVersion"
}

function Get-HelmVersion {
    $(helm version) -match 'Version:"v(?<version>\d+\.\d+\.\d+)"' | Out-Null
    $helmVersion = $Matches.version
    return "Helm $helmVersion"
}

function Get-NpmVersion {
    $npmVersion = npm --version
    return "Npm $npmVersion"
}

function Get-YarnVersion {
    $yarnVersion = yarn --version
    return "Yarn $yarnVersion"
}

function Get-PipVersion {
    $result = Get-CommandResult "pip --version"
    $result.Output -match "pip (?<version>\d+\.\d+\.\d+)" | Out-Null
    $pipVersion = $Matches.version
    return "Pip $pipVersion"
}

function Get-Pip3Version {
    $result = Get-CommandResult "pip3 --version"
    $result.Output -match "pip (?<version>\d+\.\d+\.\d+)" | Out-Null
    $pipVersion = $Matches.version
    return "Pip3 $pipVersion"
}

function Get-VcpkgVersion {
    $result = Get-CommandResult "vcpkg version"
    $result.Output -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $vcpkgVersion = $Matches.version
    $commitId = git -C "/usr/local/share/vcpkg" rev-parse --short HEAD
    return "Vcpkg $vcpkgVersion (build from master \<$commitId>)"
}

function Get-AntVersion {
    $result = ant -version | Out-String
    $result -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $antVersion = $Matches.version
    return "Ant $antVersion"
}

function Get-GradleVersion {
    $gradleVersion = (gradle -v) -match "^Gradle \d" | Take-OutputPart -Part 1
    return "Gradle $gradleVersion"
}

function Get-MavenVersion {
    $result = mvn -version | Out-String
    $result -match "Apache Maven (?<version>\d+\.\d+\.\d+)" | Out-Null
    $mavenVersion = $Matches.version
    return "Maven $mavenVersion"
}

function Get-SbtVersion {
    $result = Get-CommandResult "sbt -version"
    $result.Output -match "sbt script version: (?<version>\d+\.\d+\.\d+)" | Out-Null
    $sbtVersion = $Matches.version
    return "Sbt $sbtVersion"
}

function Get-PHPVersions {
    $result = Get-CommandResult "apt list --installed" -Multiline
    return $result.Output | Where-Object { $_ -match "^php\d+\.\d+/"} | ForEach-Object {
        $_ -match "now (?<version>\d+\.\d+\.\d+)-" | Out-Null
        $Matches.version
    }
}

function Get-ComposerVersion {
    $(composer --version) -match "Composer version (?<version>\d+\.\d+\.\d+)\s" | Out-Null
    return $Matches.version
}

function Get-PHPUnitVersion {
    $(phpunit --version | Out-String) -match "PHPUnit (?<version>\d+\.\d+\.\d+)\s" | Out-Null
    return $Matches.version
}

function Build-PHPTable {
    $php = @{
        "Tool" = "PHP"
        "Version" = "$(Get-PHPVersions -Join '<br>')"
    }
    $composer = @{
        "Tool" = "Composer"
        "Version" = Get-ComposerVersion
    }
    $phpunit = @{
        "Tool" = "PHPUnit"
        "Version" = Get-PHPUnitVersion
    }
    return @($php, $composer, $phpunit) | ForEach-Object {
        [PSCustomObject] @{
            "Tool" = $_.Tool
            "Version" = $_.Version
        }
    }
}

function Build-PHPSection {
    $output = ""
    $output += New-MDHeader "PHP" -Level 3
    $output += Build-PHPTable | New-MDTable
    $output += New-MDCode -Lines @(
        "Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled."
    )

    return $output
}

function Get-GHCVersion {
    $(ghc --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghcVersion = $Matches.version
    $aptSourceRepo = Get-AptSourceRepository -PackageName "ghc"
    return "GHC $ghcVersion (apt source repository: $aptSourceRepo)"
}

function Get-GHCupVersion {
    $(ghcup --version) -match "version v(?<version>\d+(\.\d+){2,})" | Out-Null
    $ghcVersion = $Matches.version
    return "GHCup $ghcVersion"
}

function Get-CabalVersion {
    $(cabal --version | Out-String) -match "cabal-install version (?<version>\d+\.\d+\.\d+\.\d+)" | Out-Null
    $cabalVersion = $Matches.version
    return "Cabal $cabalVersion"
}

function Get-StackVersion {
    $(stack --version | Out-String) -match "Version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $stackVersion = $Matches.version
    return "Stack $stackVersion"
}

function Get-AzModuleVersions {
    $azModuleVersions = Get-ChildItem /usr/share | Where-Object { $_ -match "az_\d+" } | Foreach-Object {
        $_.Name.Split("_")[1]
    }

    $azModuleVersions = $azModuleVersions -join " "
    return $azModuleVersions
}

function Get-PowerShellModules {
    $modules = (Get-ToolsetContent).powershellModules.name

    $psModules = Get-Module -Name $modules -ListAvailable | Sort-Object Name | Group-Object Name
    $psModules | ForEach-Object {
        $moduleName = $_.Name
        $moduleVersions = ($_.group.Version | Sort-Object -Unique) -join '<br>'

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
        }
    }
}

function Get-DotNetCoreSdkVersions {
    $unsortedDotNetCoreSdkVersion = dotnet --list-sdks list | ForEach-Object { $_ | Take-OutputPart -Part 0 }
    $dotNetCoreSdkVersion = $unsortedDotNetCoreSdkVersion -join " "
    return $dotNetCoreSdkVersion
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
    $pipxVersion = $Matches.Version
    return "Pipx $pipxVersion"
}

function Get-GraalVMVersion {
    $version = & "$env:GRAALVM_11_ROOT\bin\java" --version | Select-String -Pattern "GraalVM" | Take-OutputPart -Part 5,6
    return $version
}

function Build-GraalVMTable {
    $version = Get-GraalVMVersion
    $envVariables = "GRAALVM_11_ROOT"

    return [PSCustomObject] @{
        "Version" = $version
        "Environment variables" = $envVariables
    }
}

function Build-PackageManagementEnvironmentTable {
    return @(
        @{
            "Name" = "CONDA"
            "Value" = $env:CONDA
        },
        @{
            "Name" = "VCPKG_INSTALLATION_ROOT"
            "Value" = $env:VCPKG_INSTALLATION_ROOT
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
