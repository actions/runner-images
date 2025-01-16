using module ./software-report-base/SoftwareReport.psm1
using module ./software-report-base/SoftwareReport.Nodes.psm1

param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

$ErrorActionPreference = "Stop"

Import-Module "$PSScriptRoot/SoftwareReport.Common.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xcode.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Android.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Java.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xamarin.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.WebServers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

# OS info
$osInfo = Build-OSInfoSection $ImageName

# Software report
$softwareReport = [SoftwareReport]::new($osInfo)
$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
$languageAndRuntime.AddToolVersionsListInline(".NET Core SDK", $(Get-DotnetVersionList), '^\d+\.\d+\.\d')
$languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion))
$languageAndRuntime.AddNodes($(Get-ClangLLVMVersions))
$languageAndRuntime.AddNodes($(Get-GccVersions))
$languageAndRuntime.AddNodes($(Get-FortranVersions))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("Julia", $(Get-JuliaVersion))
}
$languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("Go", $(Get-GoVersion))
}
if ((-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("Mono", $(Get-MonoVersion))
}
$languageAndRuntime.AddToolVersion("Node.js", $(Get-NodeVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("MSBuild", $(Get-MSBuildVersion))
    $languageAndRuntime.AddToolVersion("NVM", $(Get-NVMVersion))
    $languageAndRuntime.AddToolVersionsListInline("NVM - Cached node versions", $(Get-NVMNodeVersionList), '^\d+')
}
$languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion))
if ((-not $os.IsVenturaArm64) -and (-not $os.IsSonomaArm64) -and (-not $os.IsSequoiaArm64)) {
    $languageAndRuntime.AddToolVersion("PHP", $(Get-PHPVersion))
}

if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("Python", $(Get-PythonVersion))
}

$languageAndRuntime.AddToolVersion("Python3", $(Get-Python3Version))

if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $languageAndRuntime.AddToolVersion("R", $(Get-RVersion))
}

$languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion))

# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
$packageManagement.AddToolVersion("Bundler", $(Get-BundlerVersion))
$packageManagement.AddToolVersion("Carthage", $(Get-CarthageVersion))
$packageManagement.AddToolVersion("CocoaPods", $(Get-CocoaPodsVersion))
if ((-not $os.IsVenturaArm64) -and (-not $os.IsSonomaArm64) -and (-not $os.IsSequoiaArm64)) {
    $packageManagement.AddToolVersion("Composer", $(Get-ComposerVersion))
}
$packageManagement.AddToolVersion("Homebrew", $(Get-HomebrewVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $packageManagement.AddToolVersion("Miniconda", $(Get-CondaVersion))
}
$packageManagement.AddToolVersion("NPM", $(Get-NPMVersion))
if ((-not $os.IsSequoia)) {
    $packageManagement.AddToolVersion("NuGet", $(Get-NuGetVersion))
}
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $packageManagement.AddToolVersion("Pip", $(Get-PipVersion -Version 2))
}

$packageManagement.AddToolVersion("Pip3", $(Get-PipVersion -Version 3))
$packageManagement.AddToolVersion("Pipx", $(Get-PipxVersion))

$packageManagement.AddToolVersion("RubyGems", $(Get-RubyGemsVersion))
if ((-not $os.IsVenturaArm64) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $packageManagement.AddToolVersion("Vcpkg", $(Get-VcpkgVersion))
}
$packageManagement.AddToolVersion("Yarn", $(Get-YarnVersion))

if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $packageManagement.AddNode($(Build-PackageManagementEnvironmentTable))
}
# Project Management
$projectManagement = $installedSoftware.AddHeader("Project Management")
$projectManagement.AddToolVersion("Apache Ant", $(Get-ApacheAntVersion))
$projectManagement.AddToolVersion("Apache Maven", $(Get-MavenVersion))
$projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $projectManagement.AddToolVersion("Sbt", $(Get-SbtVersion))
}

# Utilities
$utilities = $installedSoftware.AddHeader("Utilities")
$utilities.AddToolVersion("7-Zip", $(Get-7zipVersion))
$utilities.AddToolVersion("aria2", $(Get-Aria2Version))
$utilities.AddToolVersion("azcopy", $(Get-AzcopyVersion))
$utilities.AddToolVersion("bazel", $(Get-BazelVersion))
$utilities.AddToolVersion("bazelisk", $(Get-BazeliskVersion))
$utilities.AddToolVersion("bsdtar", $(Get-BsdtarVersion))
$utilities.AddToolVersion("Curl", $(Get-CurlVersion))
$utilities.AddToolVersion("Git", $(Get-GitVersion))
$utilities.AddToolVersion("Git LFS", $(Get-GitLFSVersion))
$utilities.AddToolVersion("GitHub CLI", $(Get-GitHubCLIVersion))
$utilities.AddToolVersion("GNU Tar", $(Get-GnuTarVersion))
$utilities.AddToolVersion("GNU Wget", $(Get-WgetVersion))
$utilities.AddToolVersion("gpg (GnuPG)", $(Get-GPGVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $utilities.AddToolVersion("ImageMagick", $(Get-ImageMagickVersion))
}
$utilities.AddToolVersion("jq", $(Get-JqVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $utilities.AddToolVersion("mongo", $(Get-MongoVersion))
    $utilities.AddToolVersion("mongod", $(Get-MongodVersion))
}
$utilities.AddToolVersion("OpenSSL", $(Get-OpenSSLVersion))
$utilities.AddToolVersion("Packer", $(Get-PackerVersion))
$utilities.AddToolVersion("pkgconf", $(Get-PKGConfVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $utilities.AddToolVersion("PostgreSQL", $(Get-PostgresServerVersion))
    $utilities.AddToolVersion("psql (PostgreSQL)", $(Get-PostgresClientVersion))
    $utilities.AddToolVersion("Sox", $(Get-SoxVersion))
    $utilities.AddToolVersion("Subversion (SVN)", $(Get-SVNVersion))
    $utilities.AddToolVersion("Switchaudio-osx", $(Get-SwitchAudioOsxVersion))
}
if ($os.IsMonterey) {
    $utilities.AddToolVersion("Vagrant", $(Get-VagrantVersion))
    $utilities.AddToolVersion("VirtualBox", $(Get-VirtualBoxVersion))
}
$utilities.AddToolVersion("Unxip", $(Get-UnxipVersion))
$utilities.AddToolVersion("yq", $(Get-YqVersion))
$utilities.AddToolVersion("zstd", $(Get-ZstdVersion))

# Tools
$tools = $installedSoftware.AddHeader("Tools")
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $tools.AddToolVersion("App Center CLI", $(Get-AppCenterCLIVersion))
}
$tools.AddToolVersion("AWS CLI", $(Get-AWSCLIVersion))
$tools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMCLIVersion))
$tools.AddToolVersion("AWS Session Manager CLI", $(Get-AWSSessionManagerCLIVersion))
$tools.AddToolVersion("Azure CLI", $(Get-AzureCLIVersion))
$tools.AddToolVersion("Azure CLI (azure-devops)", $(Get-AzureDevopsVersion))
$tools.AddToolVersion("Bicep CLI", $(Get-BicepVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $tools.AddToolVersion("Cabal", $(Get-CabalVersion))
}
$tools.AddToolVersion("Cmake", $(Get-CmakeVersion))
$tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
if ($os.IsMonterey) {
    $tools.AddToolVersion("Colima", $(Get-ColimaVersion))
}
$tools.AddToolVersion("Fastlane", $(Get-FastlaneVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $tools.AddToolVersion("GHC", $(Get-GHCVersion))
    $tools.AddToolVersion("GHCup", $(Get-GHCupVersion))
    $tools.AddToolVersion("Jazzy", $(Get-JazzyVersion))
    $tools.AddToolVersion("Stack", $(Get-StackVersion))
}
$tools.AddToolVersion("SwiftFormat", $(Get-SwiftFormatVersion))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $tools.AddToolVersion("Swig", $(Get-SwigVersion))
}
$tools.AddToolVersion("Xcbeautify", $(Get-XcbeautifyVersion))
$tools.AddToolVersion("Xcode Command Line Tools", $(Get-XcodeCommandLineToolsVersion))
$tools.AddToolVersion("Xcodes", $(Get-XcodesVersion))

# Linters
$linters = $installedSoftware.AddHeader("Linters")
if ((-not $os.IsVenturaArm64) -and (-not $os.IsSonomaArm64) -and (-not $os.IsSequoiaArm64)) {
    $linters.AddToolVersion("SwiftLint", $(Get-SwiftLintVersion))
}
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $linters.AddToolVersion("Yamllint", $(Get-YamllintVersion))
}

# Browsers
$browsers = $installedSoftware.AddHeader("Browsers")
$browsers.AddNodes($(Build-BrowserSection))
$browsers.AddNode($(Build-BrowserWebdriversEnvironmentTable))

# Java
$java = $installedSoftware.AddHeader("Java")
$java.AddTable($(Get-JavaVersions))

# Toolcache
$toolcache = $installedSoftware.AddHeader("Cached Tools")
$toolcache.AddNodes($(Build-ToolcacheSection))

# Rust
$rust = $installedSoftware.AddHeader("Rust Tools")
$rust.AddToolVersion("Cargo", $(Get-RustCargoVersion))
$rust.AddToolVersion("Rust", $(Get-RustVersion))
$rust.AddToolVersion("Rustdoc", $(Get-RustdocVersion))
$rust.AddToolVersion("Rustup", $(Get-RustupVersion))

$rustPackages = $rust.AddHeader("Packages")
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $rustPackages.AddToolVersion("Bindgen", $(Get-Bindgen))
    $rustPackages.AddToolVersion("Cargo-audit", $(Get-Cargoaudit))
    $rustPackages.AddToolVersion("Cargo-outdated", $(Get-Cargooutdated))
    $rustPackages.AddToolVersion("Cbindgen", $(Get-Cbindgen))
}
$rustPackages.AddToolVersion("Clippy", $(Get-RustClippyVersion))
$rustPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))

# PowerShell
$powerShell = $installedSoftware.AddHeader("PowerShell Tools")
$powerShell.AddToolVersion("PowerShell", $(Get-PowershellVersion))

$powerShellModules = $powerShell.AddHeader("PowerShell Modules")
$powerShellModules.AddNodes($(Get-PowerShellModules))

# Web Servers
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $webServers = $installedSoftware.AddHeader("Web Servers")
    $webServers.AddTable($(Build-WebServersSection))
}

# Xamarin section
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $xamarin = $installedSoftware.AddHeader("Xamarin")
    $vsForMac = $xamarin.AddHeader("Visual Studio for Mac")
    $vsForMac.AddTable($(Build-VSMacTable))
    $note =
    @'
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
'@
    $vsForMacNotes = $vsForMac.AddHeader("Notes")
    $vsForMacNotes.AddNote($note)

    $xamarinBundles = $xamarin.AddHeader("Xamarin bundles")
    $xamarinBundles.AddTable($(Build-XamarinTable))

    $unitTestFramework = $xamarin.AddHeader("Unit Test Framework")
    $unitTestFramework.AddToolVersion("NUnit", $(Get-NUnitVersion))
}

# Xcode section
$xcode = $installedSoftware.AddHeader("Xcode")
# First run doesn't provide full data about devices and runtimes
Get-XcodeInfoList | Out-Null

$xcodeInfo = Get-XcodeInfoList
$xcode.AddTable($(Build-XcodeTable $xcodeInfo))
if ((-not $os.IsVentura) -and (-not $os.IsSonoma) -and (-not $os.IsSequoia)) {
    $xcodeTools = $xcode.AddHeader("Xcode Support Tools")
    $xcodeTools.AddNodes($(Build-XcodeSupportToolsSection))
}

$installedSdks = $xcode.AddHeader("Installed SDKs")
$installedSdks.AddTable($(Build-XcodeSDKTable $xcodeInfo))

$installedSimulators = $xcode.AddHeader("Installed Simulators")
$installedSimulators.AddTable($(Build-XcodeSimulatorsTable $xcodeInfo))

# Android section
$android = $installedSoftware.AddHeader("Android")
$androidTable = Build-AndroidTable
$android.AddTable($androidTable)

$androidEnv = $android.AddHeader("Environment variables")
$androidEnv.AddTable($(Build-AndroidEnvironmentTable))

if ($os.IsMonterey) {
    $miscellaneous = $installedSoftware.AddHeader("Miscellaneous")
    $miscellaneous.AddToolVersion("libXext", $(Get-LibXextVersion))
    $miscellaneous.AddToolVersion("libXft", $(Get-LibXftVersion))
    $miscellaneous.AddToolVersion("Tcl/Tk", $(Get-TclTkVersion))
    $miscellaneous.AddToolVersion("Zlib", $(Get-ZlibVersion))
}

if ($os.IsSonoma -or $os.IsVentura) {
    $miscellaneous = $installedSoftware.AddHeader("Miscellaneous")
    $miscellaneous.AddToolVersion("Tcl/Tk", $(Get-TclTkVersion))
}

if ($os.IsMonterey -or $os.IsSonomaX64 -or $os.IsVenturaX64) {

    Write-Host "Adding environment variables for parallels"

    $miscellaneousEnv = $miscellaneous.AddHeader("Environment variables")
    $miscellaneousEnv.AddTable($(Build-MiscellaneousEnvironmentTable))

    $notes = @'
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
'@
    $miscellaneousEnvNotes = $miscellaneousEnv.AddHeader("Notes")
    $miscellaneousEnvNotes.AddNote($notes)
}

if (-not (Test-Path $OutputDirectory)) { New-Item -Path $OutputDirectory -ItemType Directory | Out-Null }

#
# Write final reports
#
Write-Host $markdownExtended
$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/systeminfo.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM
