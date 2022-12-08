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
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

# OS info
$osInfo = Build-OSInfoSection $ImageName

# Software report
$softwareReport = [SoftwareReport]::new($osInfo)
$installedSoftware = $softwareReport.Root.AddHeaderNode("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeaderNode("Language and Runtime")
$languageAndRuntime.AddToolNode(".NET SDK", $(Get-DotnetVersionList))
$languageAndRuntime.AddToolNode("Bash", $(Get-BashVersion))
$languageAndRuntime.AddNodes($(Get-ClangLLVMVersions))
$languageAndRuntime.AddNodes($(Get-GccVersions))
$languageAndRuntime.AddNodes($(Get-FortranVersions))
$languageAndRuntime.AddToolNode("Go", $(Get-GoVersion))
$languageAndRuntime.AddToolNode("Julia", $(Get-JuliaVersion))
$languageAndRuntime.AddToolNode("Kotlin", $(Get-KotlinVersion))
$languageAndRuntime.AddToolNode("MSBuild", $(Get-MSBuildVersion))
$languageAndRuntime.AddToolNode("Node.js", $(Get-NodeVersion))
$languageAndRuntime.AddToolNode("NVM", $(Get-NVMVersion))
$languageAndRuntime.AddToolNode("NVM - Cached node versions:", $(Get-NVMNodeVersionList))
$languageAndRuntime.AddToolNode("Perl", $(Get-PerlVersion))
$languageAndRuntime.AddToolNode("PHP", $(Get-PHPVersion))
$languageAndRuntime.AddToolNode("Python", $(Get-PythonVersion))
$languageAndRuntime.AddToolNode("Python3", $(Get-Python3Version))
$languageAndRuntime.AddToolNode("R", $(Get-RVersion))
$languageAndRuntime.AddToolNode("Ruby", $(Get-RubyVersion))

# Package Management
$packageManagement = $installedSoftware.AddHeaderNode("Package Management")
$packageManagement.AddToolNode("Bundler", $(Get-BundlerVersion))
$packageManagement.AddToolNode("Carthage", $(Get-CarthageVersion))
$packageManagement.AddToolNode("CocoaPods", $(Get-CocoaPodsVersion))
$packageManagement.AddToolNode("Composer", $(Get-ComposerVersion))
$packageManagement.AddToolNode("Homebrew", $(Get-HomebrewVersion))
$packageManagement.AddToolNode("Miniconda", $(Get-CondaVersion))
$packageManagement.AddToolNode("NPM", $(Get-NPMVersion))
$packageManagement.AddToolNode("NuGet", $(Get-NuGetVersion))
$packageManagement.AddToolNode("Pip", $(Get-PipVersion -Version 2))
$packageManagement.AddToolNode("Pip3", $(Get-PipVersion -Version 3))
$packageManagement.AddToolNode("Pipx", $(Get-PipxVersion))
$packageManagement.AddToolNode("RubyGems", $(Get-RubyGemsVersion))
$packageManagement.AddToolNode("Vcpkg", $(Get-VcpkgVersion))
$packageManagement.AddToolNode("Yarn", $(Get-YarnVersion))

$packageManagement.AddNode($(Build-PackageManagementEnvironmentTable))

# Project Management
$projectanagement = $installedSoftware.AddHeaderNode("Project Management")
$projectanagement.AddToolNode("Apache Ant", $(Get-ApacheAntVersion))
$projectanagement.AddToolNode("Apache Maven", $(Get-MavenVersion))
$projectanagement.AddToolNode("Gradle", $(Get-GradleVersion))
$projectanagement.AddToolNode("Sbt", $(Get-SbtVersion))

# Utilities
$utilities = $installedSoftware.AddHeaderNode("Utilities")
$utilities.AddToolNode("7-Zip", $(Get-7zipVersion))
$utilities.AddToolNode("aria2", $(Get-Aria2Version))
$utilities.AddToolNode("azcopy", $(Get-AzcopyVersion))
$utilities.AddToolNode("bazel", $(Get-BazelVersion))
$utilities.AddToolNode("bazelisk", $(Get-BazeliskVersion))
$utilities.AddToolNode("bsdtar", $(Get-BsdtarVersion))
$utilities.AddToolNode("Curl", $(Get-CurlVersion))
$utilities.AddToolNode("Git", $(Get-GitVersion))
$utilities.AddToolNode("Git LFS", $(Get-GitLFSVersion))
$utilities.AddToolNode("GitHub CLI", $(Get-GitHubCLIVersion))
if ($os.IsCatalina) {
    $utilities.AddToolNode("GNU parallel", $(Get-ParallelVersion))
}
$utilities.AddToolNode("GNU Tar", $(Get-GnuTarVersion))
$utilities.AddToolNode("GNU Wget", $(Get-WgetVersion))
$utilities.AddToolNode("gpg (GnuPG)", $(Get-GPGVersion))
if ($os.IsLessThanMonterey) {
    $utilities.AddToolNode("helm", $(Get-HelmVersion))
}
$utilities.AddToolNode("Hub CLI", $(Get-HubVersion))
$utilities.AddToolNode("ImageMagick", $(Get-ImageMagickVersion))
$utilities.AddToolNode("jq", $(Get-JqVersion))
$utilities.AddToolNode("mongo", $(Get-MongoVersion))
$utilities.AddToolNode("mongod", $(Get-MongodVersion))
if ($os.IsLessThanMonterey) {
    $utilities.AddToolNode("Newman", $(Get-NewmanVersion))
}
$utilities.AddToolNode("OpenSSL", $(Get-OpenSSLVersion))
$utilities.AddToolNode("Packer", $(Get-PackerVersion))
$utilities.AddToolNode("PostgreSQL", $(Get-PostgresServerVersion))
$utilities.AddToolNode("psql (PostgreSQL)", $(Get-PostgresClientVersion))
$utilities.AddToolNode("Sox", $(Get-SoxVersion))
$utilities.AddToolNode("Subversion (SVN)", $(Get-SVNVersion))
$utilities.AddToolNode("Switchaudio-osx", $(Get-SwitchAudioOsxVersion))
if (-not $os.IsBigSur) {
    $utilities.AddToolNode("Vagrant", $(Get-VagrantVersion))
    $utilities.AddToolNode("VirtualBox", $(Get-VirtualBoxVersion))
}
$utilities.AddToolNode("yq", $(Get-YqVersion))
$utilities.AddToolNode("zstd", $(Get-ZstdVersion))

# Tools
$tools = $installedSoftware.AddHeaderNode("Tools")
if ($os.IsLessThanMonterey) {
    $tools.AddToolNode("Aliyun CLI", $(Get-AliyunCLIVersion))
}
$tools.AddToolNode("App Center CLI", $(Get-AppCenterCLIVersion))
$tools.AddToolNode("AWS CLI", $(Get-AWSCLIVersion))
$tools.AddToolNode("AWS SAM CLI", $(Get-AWSSAMCLIVersion))
$tools.AddToolNode("AWS Session Manager CLI", $(Get-AWSSessionManagerCLIVersion))
$tools.AddToolNode("Azure CLI (azure-devops)", $(Get-AzureDevopsVersion))
$tools.AddToolNode("Azure CLI", $(Get-AzureCLIVersion))
$tools.AddToolNode("Bicep CLI", $(Get-BicepVersion))
$tools.AddToolNode("Cabal", $(Get-CabalVersion))
$tools.AddToolNode("Cmake", $(Get-CmakeVersion))
if (-not $os.IsCatalina) {
    $tools.AddToolNode("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
}
if (-not $os.IsCatalina) {
    $tools.AddToolNode("Colima", $(Get-ColimaVersion))
}
$tools.AddToolNode("Fastlane", $(Get-FastlaneVersion))
$tools.AddToolNode("GHC", $(Get-GHCVersion))
$tools.AddToolNode("GHCup", $(Get-GHCupVersion))
$tools.AddToolNode("Jazzy", $(Get-JazzyVersion))
$tools.AddToolNode("Stack", $(Get-StackVersion))
$tools.AddToolNode("SwiftFormat", $(Get-SwiftFormatVersion))
$tools.AddToolNode("Swig", $(Get-SwigVersion))
$tools.AddToolNode("Xcode Command Line Tools", $(Get-XcodeCommandLineToolsVersion))

# Linters
$linters = $installedSoftware.AddHeaderNode("Linters")
$linters.AddToolNode("Swift", $(Get-SwiftLintVersion))
$linters.AddToolNode("Yamllint", $(Get-YamllintVersion))

# Browsers
$browsers = $installedSoftware.AddHeaderNode("Browsers")
$browsers.AddNodes($(Build-BrowserSection))
$browsers.AddNode($(Build-BrowserWebdriversEnvironmentTable))

# Java
$java = $installedSoftware.AddHeaderNode("Java")
$java.AddTableNode($(Get-JavaVersions))

# Graal
$graalvm = $installedSoftware.AddHeaderNode("GraalVM")
$graalvm.AddTableNode($(Build-GraalVMTable))

# Toolcache
$toolcache = $installedSoftware.AddHeaderNode("Cached Tools")
$toolcache.AddNodes($(Build-ToolcacheSection))

# Rust
$rust = $installedSoftware.AddHeaderNode("Rust Tools")
$rust.AddToolNode("Cargo", $(Get-RustCargoVersion))
$rust.AddToolNode("Rust", $(Get-RustVersion))
$rust.AddToolNode("Rustdoc", $(Get-RustdocVersion))
$rust.AddToolNode("Rustup", $(Get-RustupVersion))

$rustPackages = $rust.AddHeaderNode("Packages")
$rustPackages.AddToolNode("Bindgen", $(Get-Bindgen))
$rustPackages.AddToolNode("Cargo-audit", $(Get-Cargoaudit))
$rustPackages.AddToolNode("Cargo-outdated", $(Get-Cargooutdated))
$rustPackages.AddToolNode("Cbindgen", $(Get-Cbindgen))
$rustPackages.AddToolNode("Clippy", $(Get-RustClippyVersion))
$rustPackages.AddToolNode("Rustfmt", $(Get-RustfmtVersion))

# PowerShell
$powerShell = $installedSoftware.AddHeaderNode("PowerShell Tools")
$powerShell.AddToolNode("PowerShell", $(Get-PowershellVersion))

$powerShellModules = $powerShell.AddHeaderNode("PowerShell Modules")
$powerShellModules.AddTableNode($(Get-PowerShellModules))

# Web Servers
$webServers = $installedSoftware.AddHeaderNode("Web Servers")
$webServers.AddTableNode($(Build-WebServersSection))

# Xamarin section
$xamarin = $installedSoftware.AddHeaderNode("Xamarin")
$vsForMac = $xamarin.AddHeaderNode("Visual Studio for Mac")
$vsForMac.AddTableNode($(Build-VSMacTable))

if (-not $os.IsCatalina) {
    $note = 
    @'
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
'@
    $vsForMacNotes = $vsForMac.AddHeaderNode("Notes")
    $vsForMacNotes.AddNoteNode($note)
}

$xamarinBundles = $xamarin.AddHeaderNode("Xamarin bundles")
$xamarinBundles.AddTableNode($(Build-XamarinTable))

$unitTestFramework = $xamarin.AddHeaderNode("Unit Test Framework")
$unitTestFramework.AddToolNode("NUnit", $(Get-NUnitVersion))

# Xcode section
$xcode = $installedSoftware.AddHeaderNode("Xcode")
# First run doesn't provide full data about devices and runtimes
Get-XcodeInfoList | Out-Null

$xcodeInfo = Get-XcodeInfoList
$xcode.AddTableNode($(Build-XcodeTable $xcodeInfo))

$xcodeTools = $xcode.AddHeaderNode("Xcode Support Tools")
$xcodeTools.AddNodes($(Build-XcodeSupportToolsSection))

$installedSdks = $xcode.AddHeaderNode("Installed SDKs")
$installedSdks.AddTableNode($(Build-XcodeSDKTable $xcodeInfo))

$installedSimulators = $xcode.AddHeaderNode("Installed Simulators")
$installedSimulators.AddTableNode($(Build-XcodeSimulatorsTable $xcodeInfo))

# Android section
$android = $installedSoftware.AddHeaderNode("Android")
$androidTable = Build-AndroidTable
if ($os.IsCatalina) {
    $androidTable += Get-IntelHaxmVersion
}
$android.AddTableNode($androidTable)

$androidEnv = $android.AddHeaderNode("Environment variables")
$androidEnv.AddTableNode($(Build-AndroidEnvironmentTable))

$miscellaneous = $installedSoftware.AddHeaderNode("Miscellaneous")
$miscellaneous.AddToolNode("libXext", $(Get-LibXextVersion))
$miscellaneous.AddToolNode("libXft", $(Get-LibXftVersion))
$miscellaneous.AddToolNode("Tcl/Tk", $(Get-TclTkVersion))
$miscellaneous.AddToolNode("Zlib", $(Get-ZlibVersion))

if ($os.IsMonterey) {
    $miscellaneousEnv = $miscellaneous.AddHeaderNode("Environment variables")
    $miscellaneousEnv.AddTableNode($(Build-MiscellaneousEnvironmentTable))

    $notes = @'
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
'@
    $miscellaneousEnvNotes = $miscellaneousEnv.AddHeaderNode("Notes")
    $miscellaneousEnvNotes.AddNoteNode($notes)
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
$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/systeminfo.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM

