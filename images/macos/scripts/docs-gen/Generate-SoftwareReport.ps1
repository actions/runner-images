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
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
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
$languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion))
if (($os.IsVentura -or $os.IsSonoma)) {
    $languageAndRuntime.AddToolVersion("Mono", $(Get-MonoVersion))
}
$languageAndRuntime.AddToolVersion("Node.js", $(Get-NodeVersion))
$languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion))
if ((-not $os.IsArm64)) {
    $languageAndRuntime.AddToolVersion("PHP", $(Get-PHPVersion))
}
$languageAndRuntime.AddToolVersion("Python3", $(Get-Python3Version))
$languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion))

# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
$packageManagement.AddToolVersion("Bundler", $(Get-BundlerVersion))
$packageManagement.AddToolVersion("Carthage", $(Get-CarthageVersion))
$packageManagement.AddToolVersion("CocoaPods", $(Get-CocoaPodsVersion))
if ((-not $os.IsArm64)) {
    $packageManagement.AddToolVersion("Composer", $(Get-ComposerVersion))
}
$packageManagement.AddToolVersion("Homebrew", $(Get-HomebrewVersion))
$packageManagement.AddToolVersion("NPM", $(Get-NPMVersion))
if (($os.IsVentura -or $os.IsSonoma)) {
    $packageManagement.AddToolVersion("NuGet", $(Get-NuGetVersion))
}
$packageManagement.AddToolVersion("Pip3", $(Get-Pip3Version))
$packageManagement.AddToolVersion("Pipx", $(Get-PipxVersion))
$packageManagement.AddToolVersion("RubyGems", $(Get-RubyGemsVersion))
if (-not $os.IsVenturaArm64) {
    $packageManagement.AddToolVersion("Vcpkg", $(Get-VcpkgVersion))
}
$packageManagement.AddToolVersion("Yarn", $(Get-YarnVersion))

# Project Management
$projectManagement = $installedSoftware.AddHeader("Project Management")
$projectManagement.AddToolVersion("Apache Ant", $(Get-ApacheAntVersion))
$projectManagement.AddToolVersion("Apache Maven", $(Get-MavenVersion))
$projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion))

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
$utilities.AddToolVersion("jq", $(Get-JqVersion))
$utilities.AddToolVersion("OpenSSL", $(Get-OpenSSLVersion))
$utilities.AddToolVersion("Packer", $(Get-PackerVersion))
$utilities.AddToolVersion("pkgconf", $(Get-PKGConfVersion))
$utilities.AddToolVersion("Unxip", $(Get-UnxipVersion))
$utilities.AddToolVersion("yq", $(Get-YqVersion))
$utilities.AddToolVersion("zstd", $(Get-ZstdVersion))
$utilities.AddToolVersion("Ninja", $(Get-NinjaVersion))

# Tools
$tools = $installedSoftware.AddHeader("Tools")
$tools.AddToolVersion("AWS CLI", $(Get-AWSCLIVersion))
$tools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMCLIVersion))
$tools.AddToolVersion("AWS Session Manager CLI", $(Get-AWSSessionManagerCLIVersion))
$tools.AddToolVersion("Azure CLI", $(Get-AzureCLIVersion))
$tools.AddToolVersion("Azure CLI (azure-devops)", $(Get-AzureDevopsVersion))
$tools.AddToolVersion("Bicep CLI", $(Get-BicepVersion))
$tools.AddToolVersion("Cmake", $(Get-CmakeVersion))
$tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
$tools.AddToolVersion("Fastlane", $(Get-FastlaneVersion))
$tools.AddToolVersion("SwiftFormat", $(Get-SwiftFormatVersion))
$tools.AddToolVersion("Xcbeautify", $(Get-XcbeautifyVersion))
$tools.AddToolVersion("Xcode Command Line Tools", $(Get-XcodeCommandLineToolsVersion))
$tools.AddToolVersion("Xcodes", $(Get-XcodesVersion))

# Linters
if ((-not $os.IsArm64)) {
    $linters = $installedSoftware.AddHeader("Linters")
    $linters.AddToolVersion("SwiftLint", $(Get-SwiftLintVersion))
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
$rustPackages.AddToolVersion("Clippy", $(Get-RustClippyVersion))
$rustPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))

# PowerShell
$powerShell = $installedSoftware.AddHeader("PowerShell Tools")
$powerShell.AddToolVersion("PowerShell", $(Get-PowershellVersion))

$powerShellModules = $powerShell.AddHeader("PowerShell Modules")
$powerShellModules.AddNodes($(Get-PowerShellModules))

# Xcode section
$xcode = $installedSoftware.AddHeader("Xcode")
# First run doesn't provide full data about devices and runtimes
Get-XcodeInfoList | Out-Null

$xcodeInfo = Get-XcodeInfoList
$xcode.AddTable($(Build-XcodeTable $xcodeInfo))

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

if ($os.IsSonoma -or $os.IsVentura -or (-not $os.IsArm64)) {
    $miscellaneous = $installedSoftware.AddHeader("Miscellaneous")
}

if ($os.IsSonoma -or $os.IsVentura) {
    $miscellaneous.AddToolVersion("Tcl/Tk", $(Get-TclTkVersion))
}

if ((-not $os.IsArm64)) {

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
