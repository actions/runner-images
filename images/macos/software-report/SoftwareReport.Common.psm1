Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

function Get-BashVersion {
    $version = bash -c 'echo ${BASH_VERSION}'
    return $version
}

function Get-DotnetVersionList {
    $sdkRawList = Run-Command "dotnet --list-sdks"
    return $sdkRawList | ForEach-Object { Take-Part $_ -Part 0 }
}

function Get-GoVersion {
    $goOutput = Run-Command "go version" | Take-Part -Part 2
    if ($goOutput.StartsWith("go")) {
        $goOutput = $goOutput.Substring(2)
    }

    return $goOutput
}

function Get-RVersion {
    $rVersion = Run-Command "R --version | grep 'R version'" | Take-Part -Part 2
    return $rVersion
}

function Get-RustVersion {
    $rustVersion = Run-Command "rustc --version" | Take-Part -Part 1
    return $rustVersion
}

function Get-RustfmtVersion {
    $version = Run-Command "rustfmt --version" | Take-Part -Part 1
    return $version
}

function Get-RustdocVersion {
    $version = Run-Command "rustdoc --version" | Take-Part -Part 1
    return $version
}

function Get-RustCargoVersion {
    $version = Run-Command "cargo --version" | Take-Part -Part 1
    return $version
}

function Get-RustClippyVersion {
    $version = Run-Command "cargo clippy --version" | Take-Part -Part 1
    return $version
}

function Get-Bindgen {
    $bindgenVersion = Run-Command "bindgen --version" | Take-Part -Part 1
    return $bindgenVersion
}

function Get-Cbindgen {
    $cbindgenVersion = Run-Command "cbindgen --version" | Take-Part -Part 1
    return $cbindgenVersion
}

function Get-Cargooutdated {
    $cargoOutdatedVersion = Run-Command "cargo outdated --version" | Take-Part -Part 1
    return $cargoOutdatedVersion
}

function Get-Cargoaudit {
    $cargoAuditVersion = Run-Command "cargo-audit --version" | Take-Part -Part 1
    return $cargoAuditVersion
}

function Get-RustupVersion {
    $rustupVersion = Run-Command "rustup --version" | Select-Object -First 1 | Take-Part -Part 1
    return $rustupVersion
}

function Get-VcpkgVersion {
    $vcpkgVersion = Run-Command "vcpkg version" | Select-Object -First 1 | Take-Part -Part 5 | Take-Part -Part 0 -Delimiter "-"
    $commitId = git -C "/usr/local/share/vcpkg" rev-parse --short HEAD
    return "$vcpkgVersion (build from commit $commitId)"
}

function Get-GccVersions {
    $versionList = Get-ToolsetValue -KeyPath gcc.versions
    $versionList | Foreach-Object {
        $nameVersion = Run-Command "gcc-${_} --version" | Select-Object -First 1
        $version = ($nameVersion -replace "^gcc-${_}").Trim() -replace '\).*$', ')'
        return [ToolVersionNode]::new("GCC ${_}", "$version - available by ``gcc-${_}`` alias")
    }
}

function Get-FortranVersions {
    $versionList = Get-ToolsetValue -KeyPath gcc.versions
    $versionList | Foreach-Object {
        $nameVersion = Run-Command "gfortran-${_} --version" | Select-Object -First 1
        $version = ($nameVersion -replace "^GNU Fortran").Trim() -replace '\).*$', ')'
        return [ToolVersionNode]::new("GNU Fortran ${_}", "$version - available by ``gfortran-${_}`` alias")
    }
}

function Get-ClangLLVMVersions {
    $clangVersionRegex = [Regex]::new("(?<version>\d+\.\d+\.\d+)")

    $defaultClangOutput = Run-Command "clang --version" | Out-String
    $defaultClangVersion = $clangVersionRegex.Match($defaultClangOutput).Groups['version'].Value

    $homebrewClangPath = '$(brew --prefix llvm@{0})/bin/clang' -f (Get-ToolsetValue 'llvm.version')
    $homebrewClangOutput = Run-Command "$homebrewClangPath --version" | Out-String
    $homebrewClangVersion = $clangVersionRegex.Match($homebrewClangOutput).Groups['version'].Value

    return @(
        [ToolVersionNode]::new("Clang/LLVM", $defaultClangVersion)
        [ToolVersionNode]::new("Clang/LLVM (Homebrew)", "$homebrewClangVersion - available on ``$homebrewClangPath``")
    )
}

function Get-NVMVersion {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersion = Run-Command "${nvmInitCommand} && nvm --version"
    return $nodejsVersion
}

function Get-PipVersion {
    param (
        [Parameter(Mandatory)][ValidateRange(2, 3)]
        [int] $Version
    )

    $command = If ($Version -eq 2) { "pip --version" } Else { "pip3 --version" }
    $commandOutput = Run-Command $command
    $versionPart1 = $commandOutput | Take-Part -Part 1
    $versionPart2 = $commandOutput | Take-Part -Part 4
    $versionPart3 = $commandOutput | Take-Part -Part 5
    return "${versionPart1} ${versionPart2} ${versionPart3}"
}

function Get-PipxVersion {
    $pipxVersion = Run-Command "pipx --version" -SuppressStderr
    return $pipxVersion
}

function Get-NVMNodeVersionList {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersionsRaw = Run-Command "${nvmInitCommand} && nvm ls"
    $nodeVersions = $nodejsVersionsRaw | ForEach-Object { $_.TrimStart(" ").TrimEnd(" *") } | Where-Object { $_.StartsWith("v") }
    return $nodeVersions | ForEach-Object { $_.TrimStart("v") }
}

function Build-OSInfoSection {
    param (
        [string] $ImageName
    )

    $fieldsToInclude = @("System Version:", "Kernel Version:")
    $rawSystemInfo = Invoke-Expression "system_profiler SPSoftwareDataType"
    $parsedSystemInfo = $rawSystemInfo | Where-Object { -not ($_ | Select-String -NotMatch $fieldsToInclude) } | ForEach-Object { $_.Trim() }
    $parsedSystemInfo[0] -match "System Version: macOS (?<version>\d+)" | Out-Null
    $version = $Matches.Version
    $systemVersion = $parsedSystemInfo[0].Replace($fieldsToInclude[0],"").Trim()
    $kernelVersion = $parsedSystemInfo[1].Replace($fieldsToInclude[1],"").Trim()

    $osInfoNode = [HeaderNode]::new("macOS $version")
    $osInfoNode.AddToolVersion("OS Version:", $systemVersion)
    $osInfoNode.AddToolVersion("Kernel Version:", $kernelVersion)
    $osInfoNode.AddToolVersion("Image Version:", $ImageName.Split('_')[1])
    return $osInfoNode
}

function Get-MonoVersion {
    $monoVersion = mono --version | Out-String | Take-Part -Part 4
    return $monoVersion
}

function Get-MSBuildVersion {
    $msbuildVersion = msbuild -version | Select-Object -Last 1
    $monoVersion = Get-MonoVersion
    return "$msbuildVersion (Mono $monoVersion)"
}

function Get-NodeVersion {
    $nodeVersion = Run-Command "node --version"
    return $nodeVersion.TrimStart("v")
}

function Get-PerlVersion {
    $version = Run-Command "perl -e 'print substr(`$^V,1)'"
    return $version
}

function Get-PythonVersion {
    $pythonVersion = Run-Command "python --version"
    return ($pythonVersion -replace "^Python").Trim()
}

function Get-Python3Version {
    $python3Version = Run-Command "python3 --version"
    return ($python3Version -replace "^Python").Trim()
}

function Get-RubyVersion {
    $rubyVersion = Run-Command "ruby --version" | Take-Part -Part 1
    return $rubyVersion
}

function Get-PHPVersion {
    $PHPVersion = Run-Command "php --version" | Select-Object -First 1 | Take-Part -Part 0,1
    return ($PHPVersion -replace "^PHP").Trim()
}

function Get-JuliaVersion {
    $juliaVersion = Run-Command "julia --version" | Take-Part -Part 0,2
    return ($juliaVersion -replace "^Julia").Trim()
}

function Get-BundlerVersion {
    $bundlerVersion = Run-Command "bundle --version"
    return ($bundlerVersion -replace "^Bundler version").Trim()
}

function Get-CarthageVersion {
    $carthageVersion = Run-Command "carthage version" -SuppressStderr
    return $carthageVersion
}

function Get-CocoaPodsVersion {
    $cocoaPodsVersion = Run-Command "pod --version"
    return $cocoaPodsVersion
}

function Get-HomebrewVersion {
    $homebrewVersion = Run-Command "brew --version" | Select-Object -First 1
    return ($homebrewVersion -replace "^Homebrew").Trim()
}

function Get-NPMVersion {
    $NPMVersion = Run-Command "npm --version"
    return $NPMVersion
}

function Get-YarnVersion {
    $yarmVersion = Run-Command "yarn --version"
    return $yarmVersion
}

function Get-NuGetVersion {
    $nugetVersion = Run-Command "nuget help" | Select-Object -First 1 | Take-Part -Part 2
    return $nugetVersion
}

function Get-CondaVersion {
    $condaVersion = Invoke-Expression "conda --version"
    return ($condaVersion -replace "^conda").Trim()
}

function Get-RubyGemsVersion {
    $rubyGemsVersion = Run-Command "gem --version"
    return $rubyGemsVersion
}

function Get-ComposerVersion {
    $composerVersion = Run-Command "composer --version" | Take-Part -Part 2
    return $composerVersion
}

function Get-MavenVersion {
    $mavenVersion = Run-Command "mvn -version" | Select-Object -First 1 | Take-Part -Part 2
    return $mavenVersion
}

#gradle output differs on the first launch – a welcome message, that we don't need is rendered. The solution is to take the last "Gradle" occurrence from the output
function Get-GradleVersion {
    $gradleVersion = (Run-Command "gradle --version" | Select-String "Gradle")[-1]
    return ($gradleVersion.Line -replace "^Gradle").Trim()
}

function Get-ApacheAntVersion {
    $apacheAntVersion = Run-Command "ant -version"  | Take-Part -Part 0,1,3
    return ($apacheAntVersion -replace "^Apache Ant\(TM\)").Trim()
}

function Get-CurlVersion {
    $curlVersion = Run-Command "curl --version" | Select-Object -First 1 | Take-Part -Part 1
    return $curlVersion
}

function Get-GitVersion {
    $gitVersion = Run-Command "git --version" | Take-Part -Part -1
    return $gitVersion
}

function Get-GitLFSVersion {
    $gitLFSVersion = Run-Command "git-lfs version" | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return $gitLFSVersion
}

function Get-GitHubCLIVersion {
    $ghVersion = Run-Command "gh --version" | Select-String "gh version" | Select-Object -First 1 | Take-Part -Part 2
    return $ghVersion
}

function Get-HubVersion {
    $hubVersion = Run-Command "brew list --versions hub" | Take-Part -Part 1
    return $hubVersion
}

function Get-WgetVersion {
    $wgetVersion = Run-Command "wget --version" | Select-String "GNU Wget" | Take-Part -Part 2
    return $wgetVersion
}

function Get-SVNVersion {
    $svnVersion = Run-Command "svn --version --quiet"
    return $svnVersion
}

function Get-PackerVersion {
    # Packer 1.7.1 has a bug and outputs version to stderr instead of stdout https://github.com/hashicorp/packer/issues/10855
    $result = Run-Command -Command "packer --version"
    $packerVersion = [regex]::matches($result, "(\d+.){2}\d+").Value
    return $packerVersion
}

function Get-OpenSSLVersion {
    $opensslVersion = Run-Command "openssl version"
    return ($opensslVersion -replace "^OpenSSL").Trim()
}

function Get-JqVersion {
    $jqVersion = Run-Command "jq --version" | Take-Part -Part 1 -Delimiter "-"
    return $jqVersion
}

function Get-GPGVersion {
    $gpgVersion = Run-Command "gpg --version" | Select-String 'gpg (GnuPG)' -SimpleMatch
    return ($gpgVersion.Line -replace "^gpg \(GnuPG\)").Trim()
}

function Get-PostgresClientVersion {
    $postgresClientVersion = Run-Command "psql --version"
    return ($postgresClientVersion -replace "^psql \(PostgreSQL\)").Trim()
}

function Get-PostgresServerVersion {
    $postgresServerVersion = Run-Command "pg_config --version"
    return ($postgresServerVersion -replace "^PostgreSQL").Trim()
}

function Get-Aria2Version {
    $aria2Version = Run-Command "aria2c --version" | Select-Object -First 1 | Take-Part -Part 2
    return $aria2Version
}

function Get-AzcopyVersion {
    $azcopyVersion = Run-Command "azcopy --version" | Take-Part -Part 2
    return $azcopyVersion
}

function Get-ZstdVersion {
    $zstdVersion = Run-Command "zstd --version" | Take-Part -Part 1 -Delimiter "v" | Take-Part -Part 0 -Delimiter ","
    return $zstdVersion
}

function Get-BazelVersion {
    $bazelVersion = Run-Command "bazel --version" | Take-Part -Part 0 -Delimiter "-"
    return ($bazelVersion -replace "^bazel").Trim()
}

function Get-BazeliskVersion {
    $bazeliskVersion = Run-Command "brew list bazelisk --versions"
    return ($bazeliskVersion -replace "^bazelisk").Trim()
}

function Get-HelmVersion {
    $helmVersion = Run-Command "helm version --short"
    return $helmVersion
}

function Get-MongoVersion {
    $mongo = Run-Command "mongo --version" | Select-String "MongoDB shell version" | Take-Part -Part 3
    return $mongo.TrimStart("v").Trim()
}

function Get-MongodVersion {
    $mongod = Run-Command "mongod --version" | Select-String "db version " | Take-Part -Part 2
    return $mongod.TrimStart("v").Trim()
}

function Get-7zipVersion {
    $7zip = Run-Command "7z i" | Select-String "7-Zip" | Take-Part -Part 0,2
    return ($7zip -replace "^7-Zip").Trim()
}

function Get-GnuTarVersion {
    $gnuTar = Run-Command "gtar --version" | Select-String "tar" | Take-Part -Part 3
    return "$gnuTar - available by 'gtar' alias"
}

function Get-BsdtarVersion {
    $bsdtar = Run-Command "tar --version" | Take-Part -Part 1
    return "$bsdtar - available by 'tar' alias"
}

function Get-NewmanVersion {
    $newmanVersion = Run-Command "newman --version"
    return $newmanVersion
}

function Get-VirtualBoxVersion {
    $virtualBox = Run-Command "vboxmanage -v"
    return $virtualBox
}

function Get-VagrantVersion {
    $vagrant = Run-Command "vagrant -v"
    return ($vagrant -replace "^Vagrant").Trim()
}

function Get-ParallelVersion {
    $parallelVersion = Run-Command "parallel --version" | Select-String "GNU parallel" | Select-Object -First 1
    return ($parallelVersion -replace "^GNU parallel").Trim()
}

function Get-FastlaneVersion {
    $fastlaneVersion = Run-Command "fastlane --version" | Select-String "^fastlane [0-9]" | Take-Part -Part 1
    return $fastlaneVersion
}

function Get-CmakeVersion {
    $cmakeVersion = Run-Command "cmake --version" | Select-Object -First 1 | Take-Part -Part 2
    return $cmakeVersion
}

function Get-AppCenterCLIVersion {
    $appcenterCLIVersion = Run-Command "appcenter --version" | Take-Part -Part 2
    return $appcenterCLIVersion
}

function Get-AzureCLIVersion {
    $azureCLIVersion = (az version | ConvertFrom-Json).'azure-cli'
    return $azureCLIVersion
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = (az version | ConvertFrom-Json).extensions.'azure-devops'
    return $azdevopsVersion
}

function Get-AWSCLIVersion {
    $awsVersion = Run-Command "aws --version" | Take-Part -Part 0 | Take-Part -Delimiter "/" -Part 1
    return $awsVersion
}

function Get-AWSSAMCLIVersion {
    $awsSamVersion = Run-Command "sam --version" | Take-Part -Part 3
    return $awsSamVersion
}

function Get-AWSSessionManagerCLIVersion {
    $awsSessionManagerVersion = Run-Command "session-manager-plugin --version"
    return $awsSessionManagerVersion
}

function Get-AliyunCLIVersion {
    $aliyunVersion = Run-Command "aliyun --version" | Select-String "Alibaba Cloud Command Line Interface Version " | Take-Part -Part 6
    return $aliyunVersion
}

function Get-GHCupVersion {
    $ghcUpVersion = (Run-Command "ghcup --version" | Take-Part -Part 5).Replace('v','')
    return $ghcUpVersion
}

function Get-GHCVersion {
    $ghcVersion = Run-Command "ghc --version" | Take-Part -Part 7
    return $ghcVersion
}

function Get-CabalVersion {
    $cabalVersion = Run-Command "cabal --version" | Take-Part -Part 3
    return $cabalVersion
}

function Get-SwitchAudioOsxVersion {
    $switchAudioVersion = Get-BrewPackageVersion -CommandName "SwitchAudioSource"
    return $switchAudioVersion
}

function Get-SoxVersion {
    $soxVersion = Get-BrewPackageVersion -CommandName "sox"
    return $soxVersion
}

function Get-StackVersion {
    $stackVersion = Run-Command "stack --version" | Take-Part -Part 1 | ForEach-Object {$_.replace(",","")}
    return $stackVersion
}

function Get-SwiftFormatVersion {
    $swiftFormatVersion = Run-Command "swiftformat --version"
    return $swiftFormatVersion
}

function Get-YamllintVersion {
    $yamllintVersion = Run-Command "yamllint --version"
    return ($yamllintVersion -replace "^Yamllint").Trim()
}

function Get-SwiftLintVersion {
    $swiftlintVersion = Run-Command "swiftlint version"
    return $swiftlintVersion
}

function Get-PowershellVersion {
    $powershellVersion = Run-Command "powershell --version"
    return ($powershellVersion -replace "^PowerShell").Trim()
}

function Get-SwigVersion {
    $swigVersion = Run-Command "swig -version" | Select-Object -First 2 | Take-Part -Part 2
    return $swigVersion
}

function Get-BicepVersion {
    $bicepVersion = Run-Command "bicep --version" | Take-Part -Part 3
    return $bicepVersion
}

function Get-KotlinVersion {
    $kotlinVersion = Run-Command "kotlin -version" | Take-Part -Part 2
    return $kotlinVersion
}

function Get-SbtVersion {
    $sbtVersion = Run-Command "sbt -version" | Take-Part -Part 3
    return $sbtVersion
}

function Get-JazzyVersion {
    $jazzyVersion = Run-Command "jazzy --version" | Take-Part -Part 2
    return $jazzyVersion
}

function Get-ZlibVersion {
	$zlibVersion = brew info --json zlib | jq -r '.[].installed[].version'
	return $zlibVersion
}

function Get-LibXftVersion {
    $libXftVersion = brew info --json libxft | jq -r '.[].installed[].version'
    return $libXftVersion
}

function Get-LibXextVersion {
    $libXextVersion = brew info --json libxext | jq -r '.[].installed[].version'
    return $libXextVersion
}

function Get-TclTkVersion {
    $tcltkVersion = brew info --json tcl-tk | jq -r '.[].installed[].version'
    return $tcltkVersion
}

function Get-YqVersion {
    $yqVersion = Run-Command "yq --version"
    $yqVersion -match "\d{1,2}\.\d{1,2}\.\d{1,2}" | Out-Null
    return ($Matches[0])
}

function Get-ImageMagickVersion {
    $imagemagickVersion = Run-Command "magick --version" | Select-Object -First 1 | Take-Part -Part 1,2
    return ($imagemagickVersion -replace "^ImageMagick").Trim()
}

function Build-PackageManagementEnvironmentTable {
    $node = [HeaderNode]::new("Environment variables")

    $table = @(
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

    $node.AddTable($table)

    return $node
}

function Build-MiscellaneousEnvironmentTable {
    return @(
        @{
            "Name" = "PARALLELS_DMG_URL"
            "Value" = $env:PARALLELS_DMG_URL
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}

function Get-CodeQLBundleVersions {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
    $CodeQLVersionPaths = Get-ChildItem $CodeQLVersionsWildcard 
    $CodeQlVersions=@()
    foreach ($CodeQLVersionPath in $CodeQLVersionPaths) {
        $FullCodeQLVersionPath = $CodeQLVersionPath | Select-Object -Expand FullName
        $CodeQLPath = Join-Path $FullCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        $CodeQLVersion = & $CodeQLPath version --quiet
        $CodeQLVersions += $CodeQLVersion
    }
    return $CodeQLVersions
}

function Get-ColimaVersion {
    $colimaVersion = Run-Command "colima version" | Select-String "colima version" | Take-Part -Part 2
    return $colimaVersion
}

function Get-PKGConfigVersion {
    $pkgconfigVersion = Run-Command "pkg-config --version"
    return $pkgconfigVersion
}