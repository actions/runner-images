param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

$ErrorActionPreference = "Stop"

. (Join-Path "$PSScriptRoot/SoftwareReport.ArchiveItem.ps1")
Import-Module MarkdownPS
Import-Module "$PSScriptRoot/SoftwareReport.Common.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xcode.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Android.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Java.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xamarin.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.WebServers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

$markdown = ""
$archive = [ArchiveItems]::New()

# OS info
$markdown += Build-OSInfoSection $archive
$markdown += New-MDList -Style Unordered -Lines $archive.Add(("Image Version: {0}" -f $ImageName.Split('_')[1]), "ImageVersion")
# Software report
$markdown += New-MDHeader $archive.SetHeader("Installed Software", 2) -Level 2
$markdown += New-MDHeader $archive.SetHeader("Language and Runtime", 3) -Level 3
$languageAndRuntimeList = @(
    ((Get-BashVersion), "Bash"),
    ((Get-MSBuildVersion), "MSBuild"),
    ((Get-NodeVersion), "Node"),
    ((Get-NVMVersion), "NVM"),
    ((Get-NVMNodeVersionList), "NVMNode"),
    ((Get-PerlVersion), "Perl"),
    ((Get-PythonVersion), "Python"),
    ((Get-Python3Version), "Python3"),
    ((Get-RubyVersion), "Ruby"),
    ((Get-DotnetVersionList), "DotnetList"),
    ((Get-GoVersion), "Go"),
    ((Get-JuliaVersion), "Julia"),
    ((Get-KotlinVersion), "Kotlin"),
    ((Get-PHPVersion), "PHP"),
    ((Get-ClangLLVMVersion), "ClangLLVM"),
    ((Get-GccVersion), "Gcc"),
    ((Get-FortranVersion), "Fortran"),
    ((Get-RVersion), "R")
)
$languageAndRuntimeTitlesList = $languageAndRuntimeList | ForEach-Object {$archive.Add($_)}
# To sort GCC and Gfortran correctly, we need to use natural sort https://gist.github.com/markwragg/e2a9dc05f3464103d6998298fb575d4e#file-sort-natural-ps1
$toNatural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }
$markdown += New-MDList -Style Unordered -Lines ($languageAndRuntimeTitlesList | Sort-Object $toNatural)

# Package Management
$markdown += New-MDHeader $archive.SetHeader("Package Management", 3) -Level 3
$packageManagementList = @(
    ((Get-PipVersion -Version 2), "PipV2"),
    ((Get-PipVersion -Version 3), "PipV3"),
    ((Get-PipxVersion), "Pipx"),
    ((Get-BundlerVersion), "Bundler"),
    ((Get-CocoaPodsVersion), "CocoaPods"),
    ((Get-CondaVersion), "Conda"),
    ((Get-HomebrewVersion), "Homebrew"),
    ((Get-NPMVersion), "NPM"),
    ((Get-YarnVersion), "Yarn"),
    ((Get-NuGetVersion), "NuGet"),
    ((Get-RubyGemsVersion), "RubyGems"),
    ((Get-ComposerVersion), "Composer"),
    ((Get-CarthageVersion), "Carthage"),
    ((Get-VcpkgVersion), "Vcpkg")
)

$packageManagementTitlesList = $packageManagementList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($packageManagementTitlesList | Sort-Object)
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-PackageManagementEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

# Project Management
$markdown += New-MDHeader $archive.SetHeader("Project Management", 3) -Level 3
$projectManagementList = @(
    ((Get-MavenVersion), "Maven"),
    ((Get-GradleVersion), "Gradle"),
    ((Get-ApacheAntVersion), "Apache"),
    ((Get-SbtVersion), "Sbt")
)
$projectManagementTitlesList = $projectManagementList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($projectManagementTitlesList | Sort-Object)

# Utilities
$markdown += New-MDHeader $archive.SetHeader("Utilities", 3) -Level 3
$utilitiesList = @(
    ((Get-CurlVersion), "Curl"),
    ((Get-GitVersion), "Git"),
    ((Get-GitLFSVersion), "GitLFS"),
    ((Get-GitHubCLIVersion), "GitHubCLI"),
    ((Get-HubVersion), "Hub"),
    ((Get-WgetVersion), "Wget"),
    ((Get-SVNVersion), "SVN"),
    ((Get-PackerVersion), "Packer"),
    ((Get-OpenSSLVersion), "OpenSSL"),
    ((Get-JqVersion), "Jq"),
    ((Get-PostgresClientVersion), "PostgresClient"),
    ((Get-PostgresServerVersion), "PostgresServer"),
    ((Get-Aria2Version), "Aria"),
    ((Get-AzcopyVersion), "Azcopy"),
    ((Get-ZstdVersion), "Zstd"),
    ((Get-BazelVersion), "Bazel"),
    ((Get-BazeliskVersion), "Bazelisk"),
    ((Get-MongoVersion), "Mongo"),
    ((Get-MongodVersion), "Mongod"),
    ((Get-7zipVersion), "7zip"),
    ((Get-BsdtarVersion), "Bsdtar"),
    ((Get-GnuTarVersion), "GnuTar"),
    ((Get-GPGVersion), "GPG"),
    ((Get-SwitchAudioOsxVersion), "SwitchAudioOsx"),
    ((Get-SoxVersion), "Sox"),
    ((Get-YqVersion), "Yq"),
    ((Get-ImageMagickVersion), "ImageMagick")
)

if ($os.IsLessThanMonterey) {
    $utilitiesList += @(
        ,((Get-HelmVersion), "Helm")
    )
}

if ($os.IsLessThanMonterey) {
    $utilitiesList += @(
        ,((Get-NewmanVersion), "Newman")
    )
}

if ($os.IsCatalina) {
    $utilitiesList += @(
        ,((Get-ParallelVersion), "Parallel")
    )
}

if (-not $os.IsBigSur) {
    $utilitiesList += @(
        ((Get-VagrantVersion), "Vagrant"),
        ((Get-VirtualBoxVersion), "VirtualBox")
    )
}

$utilitiesTitlesList = $utilitiesList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($utilitiesTitlesList | Sort-Object)

# Tools
$markdown += New-MDHeader $archive.SetHeader("Tools", 3) -Level 3
$toolsList = @(
    ((Get-JazzyVersion), "Jazzy"),
    ((Get-FastlaneVersion), "Fastlane"),
    ((Get-CmakeVersion), "Cmake"),
    ((Get-AppCenterCLIVersion), "AppCenterCLI"),
    ((Get-AzureCLIVersion), "AzureCLI"),
    ((Get-AzureDevopsVersion), "AzureDevops"),
    ((Get-AWSCLIVersion), "AWSCLI"),
    ((Get-AWSSAMCLIVersion), "AWSSAMCLI"),
    ((Get-AWSSessionManagerCLIVersion), "AWSSessionManagerCLI")
)

if (-not $os.IsCatalina) {
    $toolsList += @(
        ,((Get-CodeQLBundleVersion), "CodeQLBundle")
    )
}

if ($os.IsLessThanMonterey) {
    $toolsList += @(
        ,((Get-AliyunCLIVersion), "AliyunCLI")
    )
}

$toolsList += @(
    ((Get-XcodeCommandLineToolsVersion), "XcodeCommandLineTools"),
    ((Get-SwigVersion), "Swig"),
    ((Get-BicepVersion), "Bicep"),
    ((Get-GHCupVersion), "GHCup"),
    ((Get-GHCVersion), "GHC"),
    ((Get-CabalVersion), "Cabal"),
    ((Get-StackVersion), "Stack"),
    ((Get-SwiftFormatVersion), "SwiftFormat")
)

if (-not $os.IsCatalina) {
    $toolsList += @(
        ,((Get-ColimaVersion), "Colima")
    )
}

$toolsTitlesList = $toolsList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($toolsTitlesList | Sort-Object)

# Linters
$markdown += New-MDHeader $archive.SetHeader("Linters", 3) -Level 3
$lintersList = @(
    ((Get-YamllintVersion), "Yamllint"),
    ((Get-SwiftLintVersion), "Swift")
)

$lintersTitlesList = $lintersList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($lintersTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Browsers", 3) -Level 3
$markdown += Get-BrowserSection $archive
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Java", 3) -Level 3
$markdown += Get-JavaVersions $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("GraalVM", 3) -Level 3
$markdown += Build-GraalVMTable $archive | New-MDTable
$markdown += New-MDNewLine

# Toolcache
$markdown += Build-ToolcacheSection $archive
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Rust Tools", 3) -Level 3
$rustToolsList = @(
    ((Get-RustVersion), "Rust"),
    ((Get-RustupVersion), "Rustup"),
    ((Get-RustdocVersion), "Rustdoc"),
    ((Get-RustCargoVersion), "RustCargo")
)
$rustToolsTitlesList = $rustToolsList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($rustToolsTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Packages", 4) -Level 4
$packagesList = @(
    ((Get-Bindgen), "Bindgen"),
    ((Get-Cbindgen), "Cbindgen"),
    ((Get-Cargooutdated), "CargoOutdated"),
    ((Get-Cargoaudit), "CargoAudit"),
    ((Get-RustfmtVersion), "Rustfmt"),
    ((Get-RustClippyVersion), "RustClippy")
)
$packagesTitlesList = $packagesList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($packagesTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("PowerShell Tools", 3) -Level 3
$markdown += New-MDList -Lines $archive.Add((Get-PowershellVersion), "PowerShell") -Style Unordered

$markdown += New-MDHeader $archive.SetHeader("PowerShell Modules", 4) -Level 4
$markdown += Get-PowerShellModules $archive | New-MDTable
$markdown += New-MDNewLine

# Web Servers
$markdown += Build-WebServersSection $archive


# Xamarin section
$markdown += New-MDHeader $archive.SetHeader("Xamarin", 3) -Level 3
$markdown += New-MDHeader $archive.SetHeader("Visual Studio for Mac", 4) -Level 4
$markdown += Build-VSMacTable $archive | New-MDTable
$markdown += New-MDNewLine
if (-not $os.IsCatalina) {
$markdown += New-MDHeader "Notes:" -Level 5
$reportVS = @'
```
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
```
'@
$markdown += New-MDParagraph -Lines $reportVS
}

$markdown += New-MDHeader $archive.SetHeader("Xamarin bundles", 4) -Level 4
$markdown += Build-XamarinTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Unit Test Framework", 4) -Level 4
$markdown += New-MDList -Lines @($archive.Add((Get-NUnitVersion), "NUnit")) -Style Unordered

# First run doesn't provide full data about devices and runtimes
Get-XcodeInfoList | Out-Null
# Xcode section
$xcodeInfo = Get-XcodeInfoList
$markdown += New-MDHeader $archive.SetHeader("Xcode", 3) -Level 3
$markdown += Build-XcodeTable $xcodeInfo | New-MDTable
Build-XcodeTable $xcodeInfo | ForEach-Object { 
    $id = $_.Version
    if ($id -match '^\d{1,2}\.\d{1,2}') {
        $id = $matches[0]
    }
    $archive.Add("$($_.Version)|$($_.Build)|$($_.Path)", $id)
} | Out-Null
$markdown += New-MDNewLine

$markdown += Build-XcodeSupportToolsSection $archive

$markdown += New-MDHeader $archive.SetHeader("Installed SDKs", 4) -Level 4
$markdown += Build-XcodeSDKTable $xcodeInfo | New-MDTable
Build-XcodeSDKTable $xcodeInfo | ForEach-Object { $archive.Add("$($_.SDK)|$($_."SDK Name")|$($_."Xcode Version")", "InstalledSDK_$($_."SDK Name")") } | Out-Null
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Installed Simulators", 4) -Level 4
$markdown += Build-XcodeSimulatorsTable $xcodeInfo | New-MDTable
Build-XcodeSimulatorsTable $xcodeInfo | ForEach-Object { $archive.Add("$($_.OS)|$($_."Xcode Version")|$($_.Simulators)", "InstalledSimulators_$($_.OS)".Replace(" ", "_")) } | Out-Null
$markdown += New-MDNewLine

# Android section
$markdown += New-MDHeader $archive.SetHeader("Android", 3) -Level 3
$androidTable = Build-AndroidTable
if ($os.IsCatalina) {
    $androidTable += Get-IntelHaxmVersion
}
$markdown += $androidTable | New-MDTable
$androidTable | ForEach-Object { $archive.Add("$($_."Package Name")|$($_.Version)", "Android_$($_."Package Name")".Replace(" ", "_")) } | Out-Null
$markdown += New-MDNewLine
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-AndroidEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Miscellaneous", 3) -Level 3
$miscellaneousList = @(
    ((Get-ZlibVersion), "Zlib"),
    ((Get-LibXextVersion), "LibXext"),
    ((Get-LibXftVersion), "LibXft"),
    ((Get-TclTkVersion), "TclTk")
)
$miscellaneousTitlesList = $miscellaneousList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines $miscellaneousTitlesList

if ($os.IsMonterey) {
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-MiscellaneousEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Notes:" -Level 5
$misc = @'
```
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
```
'@
$markdown += New-MDParagraph -Lines $misc
}

#
# Generate systeminfo.txt with information about image (for debug purpose)
#
$dateTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$systemInfo = [string]::Join([System.Environment]::NewLine, @(
    "Date: ${dateTime}",
    "Image name: ${ImageName}"
))


if (-not (Test-Path $OutputDirectory)) { New-Item -Path $OutputDirectory -ItemType Directory | Out-Null }

#
# Write final reports
#
Write-Host $markdownExtended
$systemInfo | Out-File -FilePath "${OutputDirectory}/systeminfo.txt" -Encoding UTF8NoBOM
$markdown | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM
$archive.ToJsonGrouped() | Out-File -FilePath "${OutputDirectory}/systeminfo-archive-grouped.json" -Encoding UTF8NoBOM
