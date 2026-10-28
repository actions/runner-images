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

function Get-ToolsetConfig {
    if ($script:ToolsetConfig) {
        return $script:ToolsetConfig
    }

    $candidatePaths = @()
    if ($env:IMAGE_FOLDER) {
        $candidatePaths += Join-Path $env:IMAGE_FOLDER "toolset.json"
    }

    if ($env:TOOLSET_PATH) {
        $candidatePaths += $env:TOOLSET_PATH
    }

    if ($env:TOOLSET_FILE) {
        $candidatePaths += $env:TOOLSET_FILE
    }

    $candidatePaths += Join-Path $PSScriptRoot "..\..\toolsets\toolset.json"

    foreach ($candidatePath in $candidatePaths) {
        if ($candidatePath -and (Test-Path $candidatePath)) {
            $script:ToolsetConfig = Get-Content -Raw -Path $candidatePath | ConvertFrom-Json
            return $script:ToolsetConfig
        }
    }

    return $null
}

function Test-ToolsetModuleEnabled {
    param(
        [Parameter(Mandatory = $true)]
        [string] $ModuleName
    )

    $toolset = Get-ToolsetConfig
    if (-not $toolset) {
        return $true
    }

    $normalizedModuleName = $ModuleName.ToLowerInvariant()

    foreach ($property in $toolset.PSObject.Properties) {
        if ($property.Name.ToLowerInvariant() -eq $normalizedModuleName) {
            return $true
        }
    }

    if ($toolset.toolcache) {
        foreach ($tool in $toolset.toolcache) {
            if ($tool.name -and $tool.name.ToLowerInvariant() -eq $normalizedModuleName) {
                return $true
            }
        }
    }

    return $false
}

function Test-CommandAvailable {
    param(
        [Parameter(Mandatory = $true)]
        [string] $CommandName
    )

    return $null -ne (Get-Command $CommandName -ErrorAction SilentlyContinue)
}

# Software report
$softwareReport = [SoftwareReport]::new($(Build-OSInfoSection))
$optionalFeatures = $softwareReport.Root.AddHeader("Windows features")
# WSL is not functional on Arm64: WSL2 needs nested virtualization (unavailable on Azure Arm64 sizes)
# and WSL1 is a legacy component that does not work on Arm64. See actions/runner-images#14076.
if (-not (Test-IsWin11-Arm64)) {
    $optionalFeatures.AddToolVersion("Windows Subsystem for Linux (WSLv1):", "Enabled")
}
if (Test-IsWin25-X64) {
    $optionalFeatures.AddToolVersion("Windows Subsystem for Linux (Default, WSLv2):", $(Get-WSL2Version))
}
$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
if (Test-CommandAvailable "bash") { $languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion)) }
if ((Test-ToolsetModuleEnabled "go") -and (Test-CommandAvailable "go")) { $languageAndRuntime.AddToolVersion("Go", $(Get-GoVersion)) }
if ((Test-ToolsetModuleEnabled "julia") -and (Test-CommandAvailable "julia")) { $languageAndRuntime.AddToolVersion("Julia", $(Get-JuliaVersion)) }
if ((Test-ToolsetModuleEnabled "kotlin") -and (Test-CommandAvailable "kotlin")) { $languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion)) }
if ((Test-ToolsetModuleEnabled "llvm") -and (Test-CommandAvailable "clang")) { $languageAndRuntime.AddToolVersion("LLVM", $(Get-LLVMVersion)) }
if ((Test-ToolsetModuleEnabled "node") -and (Test-CommandAvailable "node")) { $languageAndRuntime.AddToolVersion("Node", $(Get-NodeVersion)) }
if (Test-CommandAvailable "perl") { $languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion)) }
if ((Test-ToolsetModuleEnabled "php") -and (Test-CommandAvailable "php")) { $languageAndRuntime.AddToolVersion("PHP", $(Get-PHPVersion)) }
if ((Test-ToolsetModuleEnabled "python") -and (Test-CommandAvailable "python")) { $languageAndRuntime.AddToolVersion("Python", $(Get-PythonVersion)) }
if ((Test-ToolsetModuleEnabled "ruby") -and (Test-CommandAvailable "ruby")) { $languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion)) }

# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
if (Test-CommandAvailable "choco") { $packageManagement.AddToolVersion("Chocolatey", $(Get-ChocoVersion)) }
if ((Test-ToolsetModuleEnabled "php") -and (Test-CommandAvailable "composer")) { $packageManagement.AddToolVersion("Composer", $(Get-ComposerVersion)) }
if (Test-CommandAvailable "helm") { $packageManagement.AddToolVersion("Helm", $(Get-HelmVersion)) }
if ((Test-IsX64) -and (Test-CommandAvailable "conda")) { $packageManagement.AddToolVersion("Miniconda", $(Get-CondaVersion)) }
if (Test-CommandAvailable "npm") { $packageManagement.AddToolVersion("NPM", $(Get-NPMVersion)) }
if (Test-CommandAvailable "nuget") { $packageManagement.AddToolVersion("NuGet", $(Get-NugetVersion)) }
if (Test-ToolsetModuleEnabled "python") { $packageManagement.AddToolVersion("pip", $(Get-PipVersion)) }
if ((Test-ToolsetModuleEnabled "pipx") -and (Test-CommandAvailable "pipx")) { $packageManagement.AddToolVersion("Pipx", $(Get-PipxVersion)) }
if ((Test-ToolsetModuleEnabled "ruby") -and (Test-CommandAvailable "gem")) { $packageManagement.AddToolVersion("RubyGems", $(Get-RubyGemsVersion)) }
if (Test-CommandAvailable "vcpkg") { $packageManagement.AddToolVersion("Vcpkg", $(Get-VcpkgVersion)) }
if (Test-CommandAvailable "yarn") { $packageManagement.AddToolVersion("Yarn", $(Get-YarnVersion)) }

$packageManagement.AddHeader("Environment variables").AddTable($(Build-PackageManagementEnvironmentTable))

# Project Management
if ((Test-ToolsetModuleEnabled "java") -or (Test-CommandAvailable "ant") -or (Test-CommandAvailable "gradle") -or (Test-CommandAvailable "mvn") -or (Test-CommandAvailable "sbt")) {
    $projectManagement = $installedSoftware.AddHeader("Project Management")
    if ((Test-ToolsetModuleEnabled "java") -or (Test-CommandAvailable "ant")) { $projectManagement.AddToolVersion("Ant", $(Get-AntVersion)) }
    if ((Test-ToolsetModuleEnabled "java") -or (Test-CommandAvailable "gradle")) { $projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion)) }
    if ((Test-ToolsetModuleEnabled "java") -or (Test-CommandAvailable "mvn")) { $projectManagement.AddToolVersion("Maven", $(Get-MavenVersion)) }
    if ((Test-ToolsetModuleEnabled "java") -or (Test-CommandAvailable "sbt")) { $projectManagement.AddToolVersion("sbt", $(Get-SbtVersion)) }
}

# Tools
if ($true) {
    $tools = $installedSoftware.AddHeader("Tools")
    if ((Test-ToolsetModuleEnabled "7zip") -or (Test-CommandAvailable "7z")) { $tools.AddToolVersion("7zip", $(Get-7zipVersion)) }
    if ((Test-ToolsetModuleEnabled "aria2") -or (Test-CommandAvailable "aria2c")) { $tools.AddToolVersion("aria2", $(Get-Aria2Version)) }
    if ((Test-ToolsetModuleEnabled "azcopy") -or (Test-CommandAvailable "azcopy")) { $tools.AddToolVersion("azcopy", $(Get-AzCopyVersion)) }
    if ((Test-ToolsetModuleEnabled "bazel") -or (Test-CommandAvailable "bazel")) { $tools.AddToolVersion("Bazel", $(Get-BazelVersion)) }
    if ((Test-ToolsetModuleEnabled "bazelisk") -or (Test-CommandAvailable "bazelisk")) { $tools.AddToolVersion("Bazelisk", $(Get-BazeliskVersion)) }
    if ((Test-ToolsetModuleEnabled "bicep") -or (Test-CommandAvailable "bicep")) { $tools.AddToolVersion("Bicep", $(Get-BicepVersion)) }
    if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "cabal") -or (Test-CommandAvailable "cabal"))) { $tools.AddToolVersion("Cabal", $(Get-CabalVersion)) }
    if ((Test-ToolsetModuleEnabled "cmake") -or (Test-CommandAvailable "cmake")) { $tools.AddToolVersion("CMake", $(Get-CMakeVersion)) }
    if ((Test-ToolsetModuleEnabled "codeql") -or (Test-CommandAvailable "codeql")) { $tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion)) }
    if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "docker") -or (Test-CommandAvailable "docker"))) { $tools.AddToolVersion("Docker", $(Get-DockerVersion)); $tools.AddToolVersion("Docker Compose", $(Get-DockerComposeVersion)); $tools.AddToolVersion("Docker-wincred", $(Get-DockerWincredVersion)); }
    if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "ghc") -or (Test-CommandAvailable "ghc"))) { $tools.AddToolVersion("ghc", $(Get-GHCVersion)) }
    if ((Test-ToolsetModuleEnabled "git") -or (Test-CommandAvailable "git")) { $tools.AddToolVersion("Git", $(Get-GitVersion)); $tools.AddToolVersion("Git LFS", $(Get-GitLFSVersion)) }
    if ((Test-ToolsetModuleEnabled "imagemagick") -or (Test-CommandAvailable "magick")) { $tools.AddToolVersion("ImageMagick", $(Get-ImageMagickVersion)) }
    if ((Test-ToolsetModuleEnabled "innosetup") -or (Test-CommandAvailable "iscc")) { $tools.AddToolVersion("InnoSetup", $(Get-InnoSetupVersion)) }
    if ((Test-ToolsetModuleEnabled "jq") -or (Test-CommandAvailable "jq")) { $tools.AddToolVersion("jq", $(Get-JQVersion)) }
    if ((Test-ToolsetModuleEnabled "kind") -or (Test-CommandAvailable "kind")) { $tools.AddToolVersion("Kind", $(Get-KindVersion)) }
    if ((Test-ToolsetModuleEnabled "kubectl") -or (Test-CommandAvailable "kubectl")) { $tools.AddToolVersion("Kubectl", $(Get-KubectlVersion)) }
    if ((-not (Test-IsWin25-X64)) -and ((Test-ToolsetModuleEnabled "mercurial") -or (Test-CommandAvailable "hg"))) { $tools.AddToolVersion("Mercurial", $(Get-MercurialVersion)) }
    if ((Test-ToolsetModuleEnabled "gcc") -or (Test-CommandAvailable "gcc")) { $tools.AddToolVersion("gcc", $(Get-GCCVersion)); $tools.AddToolVersion("gdb", $(Get-GDBVersion)); $tools.AddToolVersion("GNU Binutils", $(Get-GNUBinutilsVersion)) }
    if ((Test-ToolsetModuleEnabled "newman") -or (Test-CommandAvailable "newman")) { $tools.AddToolVersion("Newman", $(Get-NewmanVersion)) }
    if ((-not (Test-IsWin25-X64)) -and ((Test-ToolsetModuleEnabled "nsis") -or (Test-CommandAvailable "makensis"))) { $tools.AddToolVersion("NSIS", $(Get-NSISVersion)) }
    if ((Test-ToolsetModuleEnabled "openssl") -or (Test-CommandAvailable "openssl")) { $tools.AddToolVersion("OpenSSL", $(Get-OpenSSLVersion)) }
    if ((Test-ToolsetModuleEnabled "packer") -or (Test-CommandAvailable "packer")) { $tools.AddToolVersion("Packer", $(Get-PackerVersion)) }
    if ((Test-ToolsetModuleEnabled "pulumi") -or (Test-CommandAvailable "pulumi")) { $tools.AddToolVersion("Pulumi", $(Get-PulumiVersion)) }
    if ((Test-ToolsetModuleEnabled "r") -or (Test-CommandAvailable "R")) {
        if (Test-IsArm64) { $tools.AddToolVersion("R", "$(Get-RVersion) (x86_64, emulated)") } else { $tools.AddToolVersion("R", $(Get-RVersion)) }
    }
    if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "servicefabric") -or (Test-CommandAvailable "sfctl"))) { $tools.AddToolVersion("Service Fabric Runtime", $(Get-ServiceFabricRuntimeVersion)); $tools.AddToolVersion("Service Fabric SDK", $(Get-ServiceFabricSDKVersion)) }
    if ((Test-ToolsetModuleEnabled "stack") -or (Test-CommandAvailable "stack")) { $tools.AddToolVersion("Stack", $(Get-StackVersion)) }
    if ((Test-IsWin22-X64) -and ((Test-ToolsetModuleEnabled "svn") -or (Test-CommandAvailable "svn"))) { $tools.AddToolVersion("Subversion (SVN)", $(Get-SVNVersion)) }
    if ((Test-ToolsetModuleEnabled "swig") -or (Test-CommandAvailable "swig")) { $tools.AddToolVersion("Swig", $(Get-SwigVersion)) }
    if ((Test-ToolsetModuleEnabled "vswhere") -or (Test-CommandAvailable "vswhere")) { $tools.AddToolVersion("VSWhere", $(Get-VSWhereVersion)) }
    if ((Test-ToolsetModuleEnabled "winappdriver") -or (Test-CommandAvailable "WinAppDriver")) { $tools.AddToolVersion("WinAppDriver", $(Get-WinAppDriver)) }
    if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "wix") -or (Test-CommandAvailable "wix"))) { $tools.AddToolVersion("WiX Toolset", $(Get-WixVersion)) }
    if ((Test-ToolsetModuleEnabled "yamllint") -or (Test-CommandAvailable "yamllint")) { $tools.AddToolVersion("yamllint", $(Get-YAMLLintVersion)) }
    if ((Test-ToolsetModuleEnabled "zstd") -or (Test-CommandAvailable "zstd")) { $tools.AddToolVersion("zstd", $(Get-ZstdVersion)) }
    if ((Test-ToolsetModuleEnabled "ninja") -or (Test-CommandAvailable "ninja")) { $tools.AddToolVersion("Ninja", $(Get-NinjaVersion)) }
}

# CLI Tools
if ((Test-ToolsetModuleEnabled "alibabacloud") -or (Test-CommandAvailable "aliyun") -or (-not (Test-IsWin25-X64))) {
    $cliTools = $installedSoftware.AddHeader("CLI Tools")
    if ((-not (Test-IsWin25-X64)) -and ((Test-ToolsetModuleEnabled "alibabacloud") -or (Test-CommandAvailable "aliyun"))) { $cliTools.AddToolVersion("Alibaba Cloud CLI", $(Get-AlibabaCLIVersion)) }
    if ((Test-ToolsetModuleEnabled "aws") -or (Test-CommandAvailable "aws")) { $cliTools.AddToolVersion("AWS CLI", $(Get-AWSCLIVersion)) }
    if ((Test-ToolsetModuleEnabled "aws-sam") -or (Test-CommandAvailable "sam")) { $cliTools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMVersion)) }
    if ((Test-ToolsetModuleEnabled "aws-session-manager") -or (Test-CommandAvailable "session-manager-plugin")) { $cliTools.AddToolVersion("AWS Session Manager CLI", $(Get-AWSSessionManagerVersion)) }
    if ((Test-ToolsetModuleEnabled "azure-cli") -or (Test-CommandAvailable "az")) { $cliTools.AddToolVersion("Azure CLI", $(Get-AzureCLIVersion)) }
    if ((Test-ToolsetModuleEnabled "azure-devops-cli") -or (Test-CommandAvailable "az")) { $cliTools.AddToolVersion("Azure DevOps CLI extension", $(Get-AzureDevopsExtVersion)) }
    if ((Test-ToolsetModuleEnabled "github-cli") -or (Test-CommandAvailable "gh")) { $cliTools.AddToolVersion("GitHub CLI", $(Get-GHVersion)) }
}

# Rust Tools
if (Test-ToolsetModuleEnabled "rust") {
    Initialize-RustEnvironment
    $rustTools = $installedSoftware.AddHeader("Rust Tools")
    $rustTools.AddToolVersion("Cargo", $(Get-RustCargoVersion))
    $rustTools.AddToolVersion("Rust", $(Get-RustVersion))
    $rustTools.AddToolVersion("Rustdoc", $(Get-RustdocVersion))
    $rustTools.AddToolVersion("Rustup", $(Get-RustupVersion))

    $rustToolsPackages = $rustTools.AddHeader("Packages")
    if (-not (Test-IsWin25-X64)) {
        $rustToolsPackages.AddToolVersion("bindgen", $(Get-BindgenVersion))
        $rustToolsPackages.AddToolVersion("cargo-audit", $(Get-CargoAuditVersion))
        $rustToolsPackages.AddToolVersion("cargo-outdated", $(Get-CargoOutdatedVersion))
        $rustToolsPackages.AddToolVersion("cbindgen", $(Get-CbindgenVersion))
    }
    $rustToolsPackages.AddToolVersion("Clippy", $(Get-RustClippyVersion))
    $rustToolsPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))
}

# Browsers and Drivers
if (Test-ToolsetModuleEnabled "browsers") {
    $browsersAndWebdrivers = $installedSoftware.AddHeader("Browsers and Drivers")
    $browsersAndWebdrivers.AddNodes($(Build-BrowserSection))
    $browsersAndWebdrivers.AddHeader("Environment variables").AddTable($(Build-BrowserWebdriversEnvironmentTable))
}

# Java
if (Test-ToolsetModuleEnabled "java") {
    $installedSoftware.AddHeader("Java").AddTable($(Get-JavaVersions))
}

# Shells
$installedSoftware.AddHeader("Shells").AddTable($(Get-ShellTarget))

# MSYS2
if (Test-ToolsetModuleEnabled "MsysPackages") {
    $msys2 = $installedSoftware.AddHeader("MSYS2")
    $msys2.AddToolVersion("Pacman", $(Get-PacmanVersion))

    $notes = @'
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
'@
    $msys2.AddHeader("Notes").AddNote($notes)
}

# Cached Tools
$installedSoftware.AddHeader("Cached Tools").AddNodes($(Build-CachedToolsSection))

# Databases
if ((Test-IsX64) -and ((Test-ToolsetModuleEnabled "postgresql") -or (Test-ToolsetModuleEnabled "mongodb"))) {
    $databases = $installedSoftware.AddHeader("Databases")
    if (Test-ToolsetModuleEnabled "postgresql") {
        $databases.AddHeader("PostgreSQL").AddTable($(Get-PostgreSQLTable))
    }
    if (Test-ToolsetModuleEnabled "mongodb") {
        $databases.AddHeader("MongoDB").AddTable($(Get-MongoDBTable))
    }
}

# Database tools
if ((Test-ToolsetModuleEnabled "postgresql") -or (Test-ToolsetModuleEnabled "mongodb")) {
    $databaseTools = $installedSoftware.AddHeader("Database tools")
    $databaseTools.AddToolVersion("Azure CosmosDb Emulator", $(Get-AzCosmosDBEmulatorVersion))
    $databaseTools.AddToolVersion("DacFx", $(Get-DacFxVersion))
    $databaseTools.AddToolVersion("MySQL", $(Get-MySQLVersion))
    $databaseTools.AddToolVersion("SQL OLEDB Driver 18", $(Get-SQLOLEDBDriver18Version))
    $databaseTools.AddToolVersion("SQL OLEDB Driver 19", $(Get-SQLOLEDBDriver19Version))
    if (Test-IsX64) {
        $databaseTools.AddToolVersion("SQLPS", $(Get-SQLPSVersion))
        if (Test-ToolsetModuleEnabled "mongodb") {
            $databaseTools.AddToolVersion("MongoDB Shell (mongosh)", $(Get-MongoshVersion))
        }
    }
}

# Web Servers
$installedSoftware.AddHeader("Web Servers").AddTable($(Build-WebServersSection))

# Visual Studio
if (Test-ToolsetModuleEnabled "visualStudio") {
    $vsTable = Get-VisualStudioVersion
    $visualStudio = $installedSoftware.AddHeader($vsTable.Name)
    $visualStudio.AddTable($vsTable)

    $workloads = $visualStudio.AddHeader("Workloads, components and extensions")
    $workloads.AddTable((Get-VisualStudioComponents) + (Get-VisualStudioExtensions))

    $msVisualCpp = $visualStudio.AddHeader("Microsoft Visual C++")
    $msVisualCpp.AddTable($(Get-VisualCPPComponents))

    $visualStudio.AddToolVersionsList("Installed Windows SDKs", $(Get-WindowsSDKs).Versions, '^.+')
}

# .NET Core Tools
if ((Test-ToolsetModuleEnabled "dotnet") -or (Test-ToolsetModuleEnabled "dotnetcore-sdk")) {
    $netCoreTools = $installedSoftware.AddHeader(".NET Core Tools")
    $dotnetSdks = Get-DotnetSdks
    if ($dotnetSdks -and $dotnetSdks.Versions) {
        $netCoreTools.AddToolVersionsListInline(".NET Core SDK", $dotnetSdks.Versions, '^\d+\.\d+\.\d{3}')
    }
    $dotnetFrameworkVersions = Get-DotnetFrameworkVersions
    if ($dotnetFrameworkVersions) {
        $netCoreTools.AddToolVersionsListInline(".NET Framework", $dotnetFrameworkVersions, '^.+')
    }
    Get-DotnetRuntimes | ForEach-Object {
        if ($_.Versions) {
            $netCoreTools.AddToolVersionsListInline($_.Runtime, $_.Versions, '^.+')
        }
    }
    $netCoreTools.AddNodes($(Get-DotnetTools))
}

# PowerShell Tools
$psTools = $installedSoftware.AddHeader("PowerShell Tools")
$psTools.AddToolVersion("PowerShell", $(Get-PowershellCoreVersion))

$psModules = $psTools.AddHeader("Powershell Modules")
$psModules.AddNodes($(Get-PowerShellModules))


# Android
if ((Test-IsX64) -and (Test-ToolsetModuleEnabled "android")) {
    $android = $installedSoftware.AddHeader("Android")
    $android.AddTable($(Build-AndroidTable))

    $android.AddHeader("Environment variables").AddTable($(Build-AndroidEnvironmentTable))
}

# Cached Docker images
if (Test-IsWin22-X64) {
    $installedSoftware.AddHeader("Cached Docker images").AddTable($(Get-CachedDockerImagesTableData))
}

# Notes (Windows 11 Arm64 only): Defender can't be disabled here, Tamper Protection blocks it. See issue #14326
if (Test-IsWin11-Arm64) {
    $defenderNote = @'
Microsoft Defender is not disabled on this image. Tamper Protection is enabled by default on Windows 11 and prevents the image build from disabling it. See https://github.com/actions/runner-images/issues/14326 for details.
'@
    $softwareReport.Root.AddHeader("Notes").AddNote($defenderNote)
}

# Generate reports
$softwareReport.ToJson() | Out-File -FilePath "C:\software-report.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "C:\software-report.md" -Encoding UTF8NoBOM
