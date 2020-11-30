Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking

function Get-OSName {
    lsb_release -ds
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

function Get-ClangVersions {
    $clangVersions = @()
    $result = Get-CommandResult "apt list --installed" -Multiline
    $clangVersions = $result.Output | Where-Object { $_ -match "^clang-\d+"} | ForEach-Object {
        $clangCommand = ($_ -Split "/")[0]
        Invoke-Expression "$clangCommand --version" | Where-Object { $_ -match "clang version" } | ForEach-Object {
            $_ -match "clang version (?<version>\d+\.\d+\.\d+)-" | Out-Null
            $Matches.version
        }
    } | Sort-Object {[Version]$_}
    return "Clang " + ($clangVersions -Join ", ")
}

function Get-ErlangVersion {
    $version = (erl -eval 'erlang:display(erlang:system_info(version)), halt().' -noshell).Trim('"')
    return "Erlang $version"
}

function Get-MonoVersion {
    $monoVersion = mono --version | Out-String | Take-OutputPart -Part 4
    return "Mono $monoVersion"
}

function Get-NodeVersion {
    $nodeVersion = $(node --version).Substring(1)
    return "Node $nodeVersion"
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

function Get-HomebrewVersion {
    $result = Get-CommandResult "brew -v"
    $result.Output -match "Homebrew (?<version>\d+\.\d+\.\d+)" | Out-Null
    $version = $Matches.version
    return "Homebrew $version"
}

function Get-GemVersion {
    $result = Get-CommandResult "gem --version"
    $result.Output -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $gemVersion = $Matches.version
    return "Gem $gemVersion"
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
    return "Vcpkg $vcpkgVersion"
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

function Get-GHCVersion {
    $(ghc --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghcVersion = $Matches.version
    return "GHC $ghcVersion"
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
    return (sudo docker images --digests --format "*{{.Repository}}:{{.Tag}}|{{.Digest}} |{{.CreatedAt}}").Split("*")     | Where-Object { $_ } |  ForEach-Object {
      $parts=$_.Split("|")
      [PSCustomObject] @{
             "Repository:Tag" = $parts[0]
              "Digest" = $parts[1]
              "Created" = $parts[2].split(' ')[0]
         }
    }
}

function Get-AptPackages {
    $toolsetJson = Get-ToolsetContent
    $apt = $toolsetJson.apt
    $pkgs = ($apt.common_packages + $apt.cmd_packages | Sort-Object) -join ", "
    return $pkgs
}

function Get-PipxVersion {
    $result = (Get-CommandResult "pipx --version").Output
    $result -match "(?<version>\d+\.\d+\.\d+\.?\d*)" | Out-Null
    $pipxVersion = $Matches.Version
    return "Pipx $pipxVersion"
}
