using module ./software-report-base/SoftwareReport.psm1
using module ./software-report-base/SoftwareReport.Nodes.psm1

$global:ErrorActionPreference = "Stop"
$global:ProgressPreference = "SilentlyContinue"
$ErrorView = "NormalView"
Set-StrictMode -Version Latest

Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.VisualStudio.psm1") -DisableNameChecking

# Software report
$softwareReport = [SoftwareReport]::new($(Build-OSInfoSection))
$optionalFeatures = $softwareReport.Root.AddHeader("Windows features")
$optionalFeatures.AddToolVersion("Windows Subsystem for Linux (WSLv1):", "Enabled")
if (Test-IsWin25) {
    $optionalFeatures.AddToolVersion("Windows Subsystem for Linux (Default, WSLv2):", $(Get-WSL2Version))
}
$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
$languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion))
$languageAndRuntime.AddToolVersion("Go", $(Get-GoVersion))
$languageAndRuntime.AddToolVersion("Julia", $(Get-JuliaVersion))
$languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion))
$languageAndRuntime.AddToolVersion("LLVM", $(Get-LLVMVersion))
$languageAndRuntime.AddToolVersion("Node", $(Get-NodeVersion))
$languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion))
$languageAndRuntime.AddToolVersion("PHP", $(Get-PHPVersion))
$languageAndRuntime.AddToolVersion("Python", $(Get-PythonVersion))
$languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion))

# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
$packageManagement.AddToolVersion("Chocolatey", $(Get-ChocoVersion))
$packageManagement.AddToolVersion("Composer", $(Get-ComposerVersion))
$packageManagement.AddToolVersion("Helm", $(Get-HelmVersion))
$packageManagement.AddToolVersion("Miniconda", $(Get-CondaVersion))
$packageManagement.AddToolVersion("NPM", $(Get-NPMVersion))
$packageManagement.AddToolVersion("NuGet", $(Get-NugetVersion))
$packageManagement.AddToolVersion("pip", $(Get-PipVersion))
$packageManagement.AddToolVersion("Pipx", $(Get-PipxVersion))
$packageManagement.AddToolVersion("RubyGems", $(Get-RubyGemsVersion))
$packageManagement.AddToolVersion("Vcpkg", $(Get-VcpkgVersion))
$packageManagement.AddToolVersion("Yarn", $(Get-YarnVersion))

$packageManagement.AddHeader("Environment variables").AddTable($(Build-PackageManagementEnvironmentTable))

# Project Management
$projectManagement = $installedSoftware.AddHeader("Project Management")
$projectManagement.AddToolVersion("Ant", $(Get-AntVersion))
$projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion))
$projectManagement.AddToolVersion("Maven", $(Get-MavenVersion))
$projectManagement.AddToolVersion("sbt", $(Get-SbtVersion))

# Tools
$tools = $installedSoftware.AddHeader("Tools")
$tools.AddToolVersion("7zip", $(Get-7zipVersion))
$tools.AddToolVersion("aria2", $(Get-Aria2Version))
$tools.AddToolVersion("azcopy", $(Get-AzCopyVersion))
$tools.AddToolVersion("Bazel", $(Get-BazelVersion))
$tools.AddToolVersion("Bazelisk", $(Get-BazeliskVersion))
$tools.AddToolVersion("Bicep", $(Get-BicepVersion))
$tools.AddToolVersion("Cabal", $(Get-CabalVersion))
$tools.AddToolVersion("CMake", $(Get-CMakeVersion))
$tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
$tools.AddToolVersion("Docker", $(Get-DockerVersion))
$tools.AddToolVersion("Docker Compose v2", $(Get-DockerComposeVersionV2))
$tools.AddToolVersion("Docker-wincred", $(Get-DockerWincredVersion))
$tools.AddToolVersion("ghc", $(Get-GHCVersion))
$tools.AddToolVersion("Git", $(Get-GitVersion))
$tools.AddToolVersion("Git LFS", $(Get-GitLFSVersion))
if (Test-IsWin19) {
    $tools.AddToolVersion("Google Cloud CLI", $(Get-GoogleCloudCLIVersion))
}
$tools.AddToolVersion("ImageMagick", $(Get-ImageMagickVersion))
if (-not (Test-IsWin25)) {
    $tools.AddToolVersion("InnoSetup", $(Get-InnoSetupVersion))
}
$tools.AddToolVersion("jq", $(Get-JQVersion))
$tools.AddToolVersion("Kind", $(Get-KindVersion))
$tools.AddToolVersion("Kubectl", $(Get-KubectlVersion))
if (-not (Test-IsWin25)) {
    $tools.AddToolVersion("Mercurial", $(Get-MercurialVersion))
}
$tools.AddToolVersion("gcc", $(Get-GCCVersion))
$tools.AddToolVersion("gdb", $(Get-GDBVersion))
$tools.AddToolVersion("GNU Binutils", $(Get-GNUBinutilsVersion))
$tools.AddToolVersion("Newman", $(Get-NewmanVersion))
if (-not (Test-IsWin25)) {
    $tools.AddToolVersion("NSIS", $(Get-NSISVersion))
}
$tools.AddToolVersion("OpenSSL", $(Get-OpenSSLVersion))
$tools.AddToolVersion("Packer", $(Get-PackerVersion))
if (Test-IsWin19) {
    $tools.AddToolVersion("Parcel", $(Get-ParcelVersion))
}
$tools.AddToolVersion("Pulumi", $(Get-PulumiVersion))
$tools.AddToolVersion("R", $(Get-RVersion))
$tools.AddToolVersion("Service Fabric SDK", $(Get-ServiceFabricSDKVersion))
$tools.AddToolVersion("Stack", $(Get-StackVersion))
if (-not (Test-IsWin25)) {
    $tools.AddToolVersion("Subversion (SVN)", $(Get-SVNVersion))
}
$tools.AddToolVersion("Swig", $(Get-SwigVersion))
$tools.AddToolVersion("VSWhere", $(Get-VSWhereVersion))
$tools.AddToolVersion("WinAppDriver", $(Get-WinAppDriver))
$tools.AddToolVersion("WiX Toolset", $(Get-WixVersion))
$tools.AddToolVersion("yamllint", $(Get-YAMLLintVersion))
$tools.AddToolVersion("zstd", $(Get-ZstdVersion))

# CLI Tools
$cliTools = $installedSoftware.AddHeader("CLI Tools")
if (-not (Test-IsWin25)) {
    $cliTools.AddToolVersion("Alibaba Cloud CLI", $(Get-AlibabaCLIVersion))
}
$cliTools.AddToolVersion("AWS CLI", $(Get-AWSCLIVersion))
$cliTools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMVersion))
$cliTools.AddToolVersion("AWS Session Manager CLI", $(Get-AWSSessionManagerVersion))
$cliTools.AddToolVersion("Azure CLI", $(Get-AzureCLIVersion))
$cliTools.AddToolVersion("Azure DevOps CLI extension", $(Get-AzureDevopsExtVersion))
if (Test-IsWin19) {
    $cliTools.AddToolVersion("Cloud Foundry CLI", $(Get-CloudFoundryVersion))
}
$cliTools.AddToolVersion("GitHub CLI", $(Get-GHVersion))

# Rust Tools
Initialize-RustEnvironment
$rustTools = $installedSoftware.AddHeader("Rust Tools")
$rustTools.AddToolVersion("Cargo", $(Get-RustCargoVersion))
$rustTools.AddToolVersion("Rust", $(Get-RustVersion))
$rustTools.AddToolVersion("Rustdoc", $(Get-RustdocVersion))
$rustTools.AddToolVersion("Rustup", $(Get-RustupVersion))

$rustToolsPackages = $rustTools.AddHeader("Packages")
if (-not (Test-IsWin25)) {
    $rustToolsPackages.AddToolVersion("bindgen", $(Get-BindgenVersion))
    $rustToolsPackages.AddToolVersion("cargo-audit", $(Get-CargoAuditVersion))
    $rustToolsPackages.AddToolVersion("cargo-outdated", $(Get-CargoOutdatedVersion))
    $rustToolsPackages.AddToolVersion("cbindgen", $(Get-CbindgenVersion))
}
$rustToolsPackages.AddToolVersion("Clippy", $(Get-RustClippyVersion))
$rustToolsPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))

# Browsers and Drivers
$browsersAndWebdrivers = $installedSoftware.AddHeader("Browsers and Drivers")
$browsersAndWebdrivers.AddNodes($(Build-BrowserSection))
$browsersAndWebdrivers.AddHeader("Environment variables").AddTable($(Build-BrowserWebdriversEnvironmentTable))

# Java
$installedSoftware.AddHeader("Java").AddTable($(Get-JavaVersions))

# Shells
$installedSoftware.AddHeader("Shells").AddTable($(Get-ShellTarget))

# MSYS2
$msys2 = $installedSoftware.AddHeader("MSYS2")
$msys2.AddToolVersion("Pacman", $(Get-PacmanVersion))

$notes = @'
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
'@
$msys2.AddHeader("Notes").AddNote($notes)

# BizTalk Server
if (Test-IsWin19)
{
    $installedSoftware.AddHeader("BizTalk Server").AddNode($(Get-BizTalkVersion))
}

# Cached Tools
$installedSoftware.AddHeader("Cached Tools").AddNodes($(Build-CachedToolsSection))

# Databases
$databases = $installedSoftware.AddHeader("Databases")
$databases.AddHeader("PostgreSQL").AddTable($(Get-PostgreSQLTable))
$databases.AddHeader("MongoDB").AddTable($(Get-MongoDBTable))

# Database tools
$databaseTools = $installedSoftware.AddHeader("Database tools")
$databaseTools.AddToolVersion("Azure CosmosDb Emulator", $(Get-AzCosmosDBEmulatorVersion))
$databaseTools.AddToolVersion("DacFx", $(Get-DacFxVersion))
$databaseTools.AddToolVersion("MySQL", $(Get-MySQLVersion))
$databaseTools.AddToolVersion("SQL OLEDB Driver", $(Get-SQLOLEDBDriverVersion))
$databaseTools.AddToolVersion("SQLPS", $(Get-SQLPSVersion))
if (Test-IsWin25) {
    $databaseTools.AddToolVersion("MongoDB Shell (mongosh)", $(Get-MongoshVersion))
}

# Web Servers
$installedSoftware.AddHeader("Web Servers").AddTable($(Build-WebServersSection))

# Visual Studio
$vsTable = Get-VisualStudioVersion
$visualStudio = $installedSoftware.AddHeader($vsTable.Name)
$visualStudio.AddTable($vsTable)

$workloads = $visualStudio.AddHeader("Workloads, components and extensions")
$workloads.AddTable((Get-VisualStudioComponents) + (Get-VisualStudioExtensions))

$msVisualCpp = $visualStudio.AddHeader("Microsoft Visual C++")
$msVisualCpp.AddTable($(Get-VisualCPPComponents))

$visualStudio.AddToolVersionsList("Installed Windows SDKs", $(Get-WindowsSDKs).Versions, '^.+')

# .NET Core Tools
$netCoreTools = $installedSoftware.AddHeader(".NET Core Tools")
if (Test-IsWin19) {
    # Visual Studio 2019 brings own version of .NET Core which is different from latest official version
    $netCoreTools.AddToolVersionsListInline(".NET Core SDK", $(Get-DotnetSdks).Versions, '^\d+\.\d+\.\d{2}')
} else {
    $netCoreTools.AddToolVersionsListInline(".NET Core SDK", $(Get-DotnetSdks).Versions, '^\d+\.\d+\.\d')
}
$netCoreTools.AddToolVersionsListInline(".NET Framework", $(Get-DotnetFrameworkVersions), '^.+')
Get-DotnetRuntimes | ForEach-Object {
    $netCoreTools.AddToolVersionsListInline($_.Runtime, $_.Versions, '^.+')
}
$netCoreTools.AddNodes($(Get-DotnetTools))

# PowerShell Tools
$psTools = $installedSoftware.AddHeader("PowerShell Tools")
$psTools.AddToolVersion("PowerShell", $(Get-PowershellCoreVersion))

$psModules = $psTools.AddHeader("Powershell Modules")
$psModules.AddNodes($(Get-PowerShellModules))

$azPsNotes = @'
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
'@
if (-not (Test-IsWin25)) {
    $psModules.AddNote($azPsNotes)
}

# Android
$android = $installedSoftware.AddHeader("Android")
$android.AddTable($(Build-AndroidTable))

$android.AddHeader("Environment variables").AddTable($(Build-AndroidEnvironmentTable))

# Cached Docker images
if (-not (Test-IsWin25)) {
    $installedSoftware.AddHeader("Cached Docker images").AddTable($(Get-CachedDockerImagesTableData))
}

# Generate reports
$softwareReport.ToJson() | Out-File -FilePath "C:\software-report.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "C:\software-report.md" -Encoding UTF8NoBOM
