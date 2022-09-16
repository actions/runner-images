function Get-BashVersion {
    $version = bash -c 'echo ${BASH_VERSION}'
    return "Bash $version"
}

function Get-DotnetVersionList {
    $sdkRawList = Run-Command "dotnet --list-sdks"
    $sdkVersionList = $sdkRawList | ForEach-Object { Take-Part $_ -Part 0 }
    return ".NET SDK " + [string]::Join(" ", $sdkVersionList)
}

function Get-GoVersion {
    $goOutput = Run-Command "go version" | Take-Part -Part 2
    if ($goOutput.StartsWith("go")) {
        $goOutput = $goOutput.Substring(2)
    }

    return "Go $goOutput"
}

function Get-RVersion {
    $rVersion = Run-Command "R --version | grep 'R version'" | Take-Part -Part 2
    return "R $rVersion"
}

function Get-RustVersion {
    $rustVersion = Run-Command "rustc --version" | Take-Part -Part 1
    return "Rust $rustVersion"
}

function Get-RustfmtVersion {
    $version = Run-Command "rustfmt --version" | Take-Part -Part 1
    return "Rustfmt $version"
}

function Get-RustdocVersion {
    $version = Run-Command "rustdoc --version" | Take-Part -Part 1
    return "Rustdoc $version"
}

function Get-RustCargoVersion {
    $version = Run-Command "cargo --version" | Take-Part -Part 1
    return "Cargo $version"
}

function Get-RustClippyVersion {
    $version = Run-Command "cargo clippy --version" | Take-Part -Part 1
    return "Clippy $version"
}

function Get-Bindgen {
    $bindgenVersion = Run-Command "bindgen --version" | Take-Part -Part 1
    return "Bindgen $bindgenVersion"
}

function Get-Cbindgen {
    $cbindgenVersion = Run-Command "cbindgen --version" | Take-Part -Part 1
    return "Cbindgen $cbindgenVersion"
}

function Get-Cargooutdated {
    $cargoOutdatedVersion = Run-Command "cargo outdated --version" | Take-Part -Part 1
    return "Cargo-outdated $cargoOutdatedVersion"
}

function Get-Cargoaudit {
    $cargoAuditVersion = Run-Command "cargo-audit --version" | Take-Part -Part 1
    return "Cargo-audit $cargoAuditVersion"
}

function Get-RustupVersion {
    $rustupVersion = Run-Command "rustup --version" | Select-Object -First 1 | Take-Part -Part 1
    return "Rustup ${rustupVersion}"
}

function Get-VcpkgVersion {
    $vcpkgVersion = Run-Command "vcpkg version" | Select-Object -First 1 | Take-Part -Part 5 | Take-Part -Part 0 -Delimiter "-"
    $commitId = git -C "/usr/local/share/vcpkg" rev-parse --short HEAD
    return "Vcpkg $vcpkgVersion (build from master \<$commitId>)"
}

function Get-GccVersion {
    $versionList = Get-ToolsetValue -KeyPath gcc.versions
    $versionList | Foreach-Object {
        $version = Run-Command "gcc-${_} --version" | Select-Object -First 1
        "$version - available by ``gcc-${_}`` alias"
    }
}

function Get-FortranVersion {
    $versionList = Get-ToolsetValue -KeyPath gcc.versions
    $versionList | Foreach-Object {
        $version = Run-Command "gfortran-${_} --version" | Select-Object -First 1
        "$version - available by ``gfortran-${_}`` alias"
    }
}

function Get-ClangLLVMVersion {
    $toolsetVersion = '$(brew --prefix llvm@{0})/bin/clang' -f (Get-ToolsetValue 'llvm.version')
    $locationsList = @("$((Get-Command clang).Source)", $toolsetVersion)
    $locationsList | Foreach-Object {
        (Run-Command "${_} --version" | Out-String) -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
        $version = $Matches.version
        "Clang/LLVM $version " + $(if(${_} -Match "brew") {"is available on ```'${_}`'``"} else {"is default"})
    }
}

function Get-NVMVersion {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersion = Run-Command "${nvmInitCommand} && nvm --version"
    return "NVM $nodejsVersion"
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
    return "Pip ${versionPart1} ${versionPart2} ${versionPart3}"
}

function Get-PipxVersion {
    $pipxVersion = Run-Command "pipx --version" -SuppressStderr
    return "Pipx $pipxVersion"
}

function Get-NVMNodeVersionList {
    $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
    $nvmInitCommand = ". ${nvmPath} > /dev/null 2>&1 || true"
    $nodejsVersionsRaw = Run-Command "${nvmInitCommand} && nvm ls"
    $nodeVersions = $nodejsVersionsRaw | ForEach-Object { $_.TrimStart(" ").TrimEnd(" *") } | Where-Object { $_.StartsWith("v") }
    $result = [string]::Join(" ", $nodeVersions)
    return "NVM - Cached node versions: $result"
}

function Build-OSInfoSection {
    $fieldsToInclude = @("System Version:", "Kernel Version:")
    $rawSystemInfo = Invoke-Expression "system_profiler SPSoftwareDataType"
    $parsedSystemInfo = $rawSystemInfo | Where-Object { -not ($_ | Select-String -NotMatch $fieldsToInclude) } | ForEach-Object { $_.Trim() }
    $output = ""
    $parsedSystemInfo[0] -match "System Version: macOS (?<version>\d+\.\d+)" | Out-Null
    $version = $Matches.Version
    $output += New-MDHeader "macOS $version info" -Level 1
    $output += New-MDList -Style Unordered -Lines $parsedSystemInfo -NoNewLine
    return $output
}

function Get-MSBuildVersion {
    $msbuildVersion = msbuild -version | Select-Object -Last 1
    $result = Select-String -Path (Get-Command msbuild).Source -Pattern "msbuild"
    $result -match "(?<path>\/\S*\.dll)" | Out-Null
    $msbuildPath = $Matches.path
    return "MSBuild $msbuildVersion (from $msbuildPath)"
}

function Get-NodeVersion {
    $nodeVersion = Run-Command "node --version"
    return "Node.js $nodeVersion"
}

function Get-PerlVersion {
    $version = Run-Command "perl -e 'print substr(`$^V,1)'"
    return "Perl $version"
}

function Get-PythonVersion {
    $pythonVersion = Run-Command "python --version"
    return $pythonVersion
}

function Get-Python3Version {
    $python3Version = Run-Command "python3 --version"
    return $python3Version
}

function Get-RubyVersion {
    $rubyVersion = Run-Command "ruby --version" | Take-Part -Part 1
    return "Ruby $rubyVersion"
}

function Get-PHPVersion {
    $PHPVersion = Run-Command "php --version" | Select-Object -First 1 | Take-Part -Part 0,1
    return $PHPVersion
}

function Get-JuliaVersion {
    $juliaVersion = Run-Command "julia --version" | Take-Part -Part 0,2
    return $juliaVersion
}

function Get-BundlerVersion {
    $bundlerVersion = Run-Command "bundle --version"
    return $bundlerVersion
}

function Get-CarthageVersion {
    $carthageVersion = Run-Command "carthage version" -SuppressStderr
    return "Carthage $carthageVersion"
}

function Get-CocoaPodsVersion {
    $cocoaPodsVersion = Run-Command "pod --version"
    return "CocoaPods $cocoaPodsVersion"
}

function Get-HomebrewVersion {
    $homebrewVersion = Run-Command "brew --version" | Select-Object -First 1
    return $homebrewVersion
}

function Get-NPMVersion {
    $NPMVersion = Run-Command "npm --version"
    return "NPM $NPMVersion"
}

function Get-YarnVersion {
    $yarmVersion = Run-Command "yarn --version"
    return "Yarn $yarmVersion"
}

function Get-NuGetVersion {
    $nugetVersion = Run-Command "nuget help" | Select-Object -First 1 | Take-Part -Part 2
    return "NuGet $nugetVersion"
}

function Get-CondaVersion {
    $condaVersion = Invoke-Expression "conda --version"
    return "Mini$condaVersion"
}

function Get-RubyGemsVersion {
    $rubyGemsVersion = Run-Command "gem --version"
    return "RubyGems $rubyGemsVersion"
}

function Get-ComposerVersion {
    $composerVersion = Run-Command "composer --version" | Take-Part -Part 2
    return "Composer $composerVersion"
}

function Get-MavenVersion {
    $mavenVersion = Run-Command "mvn -version" | Select-Object -First 1 | Take-Part -Part 2
    return "Apache Maven $mavenVersion"
}

#gradle output differs on the first launch – a welcome message, that we don't need is rendered. The solution is to take the last "Gradle" occurrence from the output
function Get-GradleVersion {
    $gradleVersion = (Run-Command "gradle --version" | Select-String "Gradle")[-1]
    return $gradleVersion
}

function Get-ApacheAntVersion {
    $apacheAntVersion = Run-Command "ant -version"  | Take-Part -Part 0,1,3
    return $apacheAntVersion
}

function Get-CurlVersion {
    $curlVersion = Run-Command "curl --version" | Select-Object -First 1 | Take-Part -Part 1
    return "Curl $curlVersion"
}

function Get-GitVersion {
    $gitVersion = Run-Command "git --version" | Take-Part -Part -1
    return "Git $gitVersion"
}

function Get-GitLFSVersion {
    $gitLFSVersion = Run-Command "git-lfs version" | Take-Part -Part 0 | Take-Part -Part 1 -Delimiter "/"
    return "Git LFS: $gitLFSVersion"
}

function Get-GitHubCLIVersion {
    $ghVersion = Run-Command "gh --version" | Select-String "gh version" | Select-Object -First 1 | Take-Part -Part 2
    return "GitHub CLI: $ghVersion"
}

function Get-HubVersion {
    $hubVersion = Run-Command "brew list --versions hub" | Take-Part -Part 1
    return "Hub CLI: $hubVersion"
}

function Get-WgetVersion {
    $wgetVersion = Run-Command "wget --version" | Select-String "GNU Wget" | Take-Part -Part 2
    return "GNU Wget $wgetVersion"
}

function Get-SVNVersion {
    $svnVersion = Run-Command "svn --version --quiet"
    return "Subversion (SVN) $svnVersion"
}

function Get-PackerVersion {
    # Packer 1.7.1 has a bug and outputs version to stderr instead of stdout https://github.com/hashicorp/packer/issues/10855
    $result = Run-Command -Command "packer --version"
    $packerVersion = [regex]::matches($result, "(\d+.){2}\d+").Value
    return "Packer $packerVersion"
}

function Get-OpenSSLVersion {
    $opensslVersion = Get-Item /usr/local/opt/openssl@1.1 | ForEach-Object {"{0} ``({1} -> {2})``" -f (Run-Command "openssl version"), $_.FullName, $_.Target}
    return $opensslVersion
}

function Get-JqVersion {
    $jqVersion = Run-Command "jq --version" | Take-Part -Part 1 -Delimiter "-"
    return "jq $jqVersion"
}

function Get-GPGVersion {
    $gpgVersion = Run-Command "gpg --version" | Select-String 'gpg (GnuPG)' -SimpleMatch
    return $gpgVersion
}

function Get-PostgresClientVersion {
    $postgresClientVersion = Run-Command "psql --version"
    return $postgresClientVersion
}

function Get-PostgresServerVersion {
    $postgresServerVersion = Run-Command "pg_config --version"
    return $postgresServerVersion
}

function Get-Aria2Version {
    $aria2Version = Run-Command "aria2c --version" | Select-Object -First 1 | Take-Part -Part 2
    return "aria2 $aria2Version"
}

function Get-AzcopyVersion {
    $azcopyVersion = Run-Command "azcopy --version" | Take-Part -Part 2
    return "azcopy $azcopyVersion"
}

function Get-ZstdVersion {
    $zstdVersion = Run-Command "zstd --version" | Take-Part -Part 1 -Delimiter "v" | Take-Part -Part 0 -Delimiter ","
    return "zstd $zstdVersion"
}

function Get-BazelVersion {
    $bazelVersion = Run-Command "bazel --version" | Take-Part -Part 0 -Delimiter "-"
    return $bazelVersion
}

function Get-BazeliskVersion {
    $bazeliskVersion = Run-Command "brew list bazelisk --versions"
    return $bazeliskVersion
}

function Get-HelmVersion {
    $helmVersion = Run-Command "helm version --short"
    return "helm $helmVersion"
}

function Get-MongoVersion {
    $mongo = Run-Command "mongo --version" | Select-String "MongoDB shell version" | Take-Part -Part 3
    return "mongo $mongo"
}

function Get-MongodVersion {
    $mongod = Run-Command "mongod --version" | Select-String "db version " | Take-Part -Part 2
    return "mongod $mongod"
}

function Get-7zipVersion {
    $7zip = Run-Command "7z i" | Select-String "7-Zip" | Take-Part -Part 0,2
    return $7zip
}

function Get-GnuTarVersion {
    $gnuTar = Run-Command "gtar --version" | Select-String "tar" | Take-Part -Part 3
    return "GNU Tar $gnuTar - available by 'gtar' alias"
}

function Get-BsdtarVersion {
    $bsdtar = Run-Command "tar --version" | Take-Part -Part 1
    return "bsdtar $bsdtar - available by 'tar' alias"
}

function Get-NewmanVersion {
    $newmanVersion = Run-Command "newman --version"
    return "Newman $newmanVersion"
}

function Get-VirtualBoxVersion {
    $virtualBox = Run-Command "vboxmanage -v"
    return "VirtualBox $virtualBox"
}

function Get-VagrantVersion {
    $vagrant = Run-Command "vagrant -v"
    return $vagrant
}

function Get-ParallelVersion {
    $parallelVersion = Run-Command "parallel --version" | Select-String "GNU parallel" | Select-Object -First 1
    return $parallelVersion
}

function Get-FastlaneVersion {
    $fastlaneVersion = Run-Command "fastlane --version" | Select-String "^fastlane [0-9]" | Take-Part -Part 1
    return "Fastlane $fastlaneVersion"
}

function Get-CmakeVersion {
    $cmakeVersion = Run-Command "cmake --version" | Select-Object -First 1 | Take-Part -Part 2
    return "Cmake $cmakeVersion"
}

function Get-AppCenterCLIVersion {
    $appcenterCLIVersion = Run-Command "appcenter --version" | Take-Part -Part 2
    return "App Center CLI $appcenterCLIVersion"
}

function Get-AzureCLIVersion {
    $azureCLIVersion = (az version | ConvertFrom-Json).'azure-cli'
    return "Azure CLI $azureCLIVersion"
}

function Get-AzureDevopsVersion {
    $azdevopsVersion = (az version | ConvertFrom-Json).extensions.'azure-devops'
    return "Azure CLI (azure-devops) $azdevopsVersion"
}

function Get-AWSCLIVersion {
    $awsVersion = Run-Command "aws --version" | Take-Part -Part 0 | Take-Part -Delimiter "/" -Part 1
    return "AWS CLI $awsVersion"
}

function Get-AWSSAMCLIVersion {
    $awsSamVersion = Run-Command "sam --version" | Take-Part -Part 3
    return "AWS SAM CLI $awsSamVersion"
}

function Get-AWSSessionManagerCLIVersion {
    $awsSessionManagerVersion = Run-Command "session-manager-plugin --version"
    return "AWS Session Manager CLI $awsSessionManagerVersion"
}

function Get-AliyunCLIVersion {
    $aliyunVersion = Run-Command "aliyun --version" | Select-String "Alibaba Cloud Command Line Interface Version " | Take-Part -Part 6
    return "Aliyun CLI $aliyunVersion"
}

function Get-GHCupVersion {
    $ghcUpVersion = (Run-Command "ghcup --version" | Take-Part -Part 5).Replace('v','')
    return "GHCup $ghcUpVersion"
}

function Get-GHCVersion {
    $ghcVersion = Run-Command "ghc --version" | Take-Part -Part 7
    return "GHC $ghcVersion"
}

function Get-CabalVersion {
    $cabalVersion = Run-Command "cabal --version" | Take-Part -Part 3
    return "Cabal $cabalVersion"
}

function Get-SwitchAudioOsxVersion {
    $switchAudioVersion = Get-BrewPackageVersion -CommandName "SwitchAudioSource"
    return "Switchaudio-osx $switchAudioVersion"
}

function Get-SoxVersion {
    $soxVersion = Get-BrewPackageVersion -CommandName "sox"
    return "Sox $soxVersion"
}

function Get-StackVersion {
    $stackVersion = Run-Command "stack --version" | Take-Part -Part 1 | ForEach-Object {$_.replace(",","")}
    return "Stack $stackVersion"
}

function Get-SwiftFormatVersion {
    $swiftFormatVersion = Run-Command "swiftformat --version"
    return "SwiftFormat $swiftFormatVersion"
}

function Get-YamllintVersion {
    $yamllintVersion = Run-Command "yamllint --version"
    return $yamllintVersion
}

function Get-SwiftLintVersion {
    $swiftlintVersion = Run-Command "swiftlint version"
    return "SwiftLint $swiftlintVersion"
}

function Get-PowershellVersion {
    $powershellVersion = Run-Command "powershell --version"
    return $powershellVersion
}

function Get-SwigVersion {
    $swigVersion = Run-Command "swig -version" | Select-Object -First 2 | Take-Part -Part 2
    return "Swig $swigVersion"
}

function Get-BicepVersion {
    $bicepVersion = Run-Command "bicep --version" | Take-Part -Part 3
    return "Bicep CLI $bicepVersion"
}

function Get-KotlinVersion {
    $kotlinVersion = Run-Command "kotlin -version" | Take-Part -Part 2
    return "Kotlin $kotlinVersion"
}

function Get-SbtVersion {
    $sbtVersion = Run-Command "sbt -version" | Take-Part -Part 3
    return "Sbt $sbtVersion"
}

function Get-JazzyVersion {
    $jazzyVersion = Run-Command "jazzy --version" | Take-Part -Part 2
    return "Jazzy $jazzyVersion"
}

function Get-ZlibVersion {
	$zlibVersion = brew info --json zlib | jq -r '.[].installed[].version'
	return "Zlib $zlibVersion"
}

function Get-LibXftVersion {
    $libXftVersion = brew info --json libxft | jq -r '.[].installed[].version'
    return "libXft $libXftVersion"
}

function Get-LibXextVersion {
    $libXextVersion = brew info --json libxext | jq -r '.[].installed[].version'
    return "libXext $libXextVersion"
}

function Get-TclTkVersion {
    $tcltkVersion = brew info --json tcl-tk | jq -r '.[].installed[].version'
    return "Tcl/Tk $tcltkVersion"
}

function Get-YqVersion {
    $yqVersion = Run-Command "yq --version"
    return "$yqVersion"
}

function Get-ImageMagickVersion {
    $imagemagickVersion = Run-Command "magick --version" | Select-Object -First 1 | Take-Part -Part 1,2
    return "$imagemagickVersion"
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
        },
        @{
            "Name" = "VCPKG_ROOT"
            "Value" = $env:VCPKG_ROOT
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}

function Get-GraalVMVersion {
    $version = & "$env:GRAALVM_11_ROOT\java" --version | Select-String -Pattern "GraalVM" | Take-Part -Part 5,6
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

function Get-CodeQLBundleVersion {
    $CodeQLVersionWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
    $CodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcard | Select-Object -First 1 -Expand FullName
    $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
    $CodeQLVersion = & $CodeQLPath version --quiet
    return "CodeQL Action Bundle $CodeQLVersion"
}