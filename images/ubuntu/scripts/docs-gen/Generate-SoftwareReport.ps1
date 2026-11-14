using module ./software-report-base/SoftwareReport.psm1
using module ./software-report-base/SoftwareReport.Nodes.psm1

param (
    [Parameter(Mandatory)]
    [string] $OutputDirectory
)

$global:ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"
Set-StrictMode -Version Latest

Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Rust.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking

function Get-ToolsetConfig {
    if ($script:ToolsetConfig) {
        return $script:ToolsetConfig
    }

    $candidatePaths = @()
    if ($env:TOOLSET_PATH) {
        $candidatePaths += $env:TOOLSET_PATH
    }

    if ($env:TOOLSET_FILE) {
        $candidatePaths += $env:TOOLSET_FILE
    }

    if ($env:IMAGE_FOLDER) {
        $candidatePaths += Join-Path $env:IMAGE_FOLDER "toolset.json"
    }

    if ($env:INSTALLER_SCRIPT_FOLDER) {
        $candidatePaths += Join-Path $env:INSTALLER_SCRIPT_FOLDER "toolset.json"
    }

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

function Add-ToolVersionsListIfAvailable {
    param(
        [Parameter(Mandatory = $true)]
        [object] $Node,

        [Parameter(Mandatory = $true)]
        [string] $ToolName,

        [Parameter(Mandatory = $false)]
        [object[]] $Versions,

        [Parameter(Mandatory = $true)]
        [string] $MajorVersionRegex
    )

    if ($null -eq $Versions) {
        return
    }

    $versionList = @($Versions)
    if ($versionList.Count -eq 0) {
        return
    }

    $Node.AddToolVersionsListInline($ToolName, $versionList, $MajorVersionRegex)
}

# Restore file owner in user profile
sudo chown -R ${env:USER}: $env:HOME

# Software report
$softwareReport = [SoftwareReport]::new("Ubuntu $(Get-OSVersionShort)")
$softwareReport.Root.AddToolVersion("OS Version:", $(Get-OSVersionFull))
$softwareReport.Root.AddToolVersion("Kernel Version:", $(Get-KernelVersion))
$softwareReport.Root.AddToolVersion("Image Version:", $env:IMAGE_VERSION)
$softwareReport.Root.AddToolVersion("Systemd version:", $(Get-SystemdVersion))

$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
$languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion))
$languageAndRuntime.AddToolVersion("Dash", $(Get-DashVersion))
if (Test-ToolsetModuleEnabled "clang") {
    Add-ToolVersionsListIfAvailable -Node $languageAndRuntime -ToolName "Clang" -Versions $(Get-ClangToolVersions -ToolName "clang") -MajorVersionRegex "^\d+"
    Add-ToolVersionsListIfAvailable -Node $languageAndRuntime -ToolName "Clang-format" -Versions $(Get-ClangToolVersions -ToolName "clang-format") -MajorVersionRegex "^\d+"
    Add-ToolVersionsListIfAvailable -Node $languageAndRuntime -ToolName "Clang-tidy" -Versions $(Get-ClangTidyVersions) -MajorVersionRegex "^\d+"
}
if (Test-ToolsetModuleEnabled "gcc") {
    Add-ToolVersionsListIfAvailable -Node $languageAndRuntime -ToolName "GNU C++" -Versions $(Get-CPPVersions) -MajorVersionRegex "^\d+"
}
if (Test-ToolsetModuleEnabled "gfortran") {
    Add-ToolVersionsListIfAvailable -Node $languageAndRuntime -ToolName "GNU Fortran" -Versions $(Get-FortranVersions) -MajorVersionRegex "^\d+"
}
if ((Test-IsUbuntu22-X64) -or (Test-IsUbuntu24-X64)) {
    $languageAndRuntime.AddToolVersion("Julia", $(Get-JuliaVersion))
}
$languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion))
if (Test-IsUbuntu22) {
    $languageAndRuntime.AddToolVersion("Mono", $(Get-MonoVersion))
    $languageAndRuntime.AddToolVersion("MSBuild", $(Get-MsbuildVersion))
}
if (Test-ToolsetModuleEnabled "node") {
    $languageAndRuntime.AddToolVersion("Node.js", $(Get-NodeVersion))
}
$languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion))
if (Test-ToolsetModuleEnabled "python") {
    $languageAndRuntime.AddToolVersion("Python", $(Get-PythonVersion))
}
if (Test-ToolsetModuleEnabled "ruby") {
    $languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion))
}
$languageAndRuntime.AddToolVersion("Swift", $(Get-SwiftVersion))


# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
$packageManagement.AddToolVersion("cpan", $(Get-CpanVersion))
$packageManagement.AddToolVersion("Helm", $(Get-HelmVersion))
$packageManagement.AddToolVersion("Homebrew", $(Get-HomebrewVersion))
if ((Test-IsUbuntu22-X64) -or (Test-IsUbuntu24-X64)) {
    $packageManagement.AddToolVersion("Miniconda", $(Get-MinicondaVersion))
}
$packageManagement.AddToolVersion("Npm", $(Get-NpmVersion))
if (Test-IsUbuntu22) {
    $packageManagement.AddToolVersion("NuGet", $(Get-NuGetVersion))
}
$packageManagement.AddToolVersion("Pip", $(Get-PipVersion))
$packageManagement.AddToolVersion("Pip3", $(Get-Pip3Version))
$packageManagement.AddToolVersion("Pipx", $(Get-PipxVersion))
$packageManagement.AddToolVersion("RubyGems", $(Get-GemVersion))
$packageManagement.AddToolVersion("Vcpkg", $(Get-VcpkgVersion))
$packageManagement.AddToolVersion("Yarn", $(Get-YarnVersion))
$packageManagement.AddHeader("Environment variables").AddTable($(Build-PackageManagementEnvironmentTable))
$packageManagement.AddHeader("Homebrew note").AddNote(@'
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
'@)

# Project Management
$projectManagement = $installedSoftware.AddHeader("Project Management")
$projectManagement.AddToolVersion("Ant", $(Get-AntVersion))
$projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $projectManagement.AddToolVersion("Lerna", $(Get-LernaVersion))
}
$projectManagement.AddToolVersion("Maven", $(Get-MavenVersion))
if (Test-IsUbuntu22-X64) {
    $projectManagement.AddToolVersion("Sbt", $(Get-SbtVersion))
}

# Tools
$tools = $installedSoftware.AddHeader("Tools")
$tools.AddToolVersion("Ansible", $(Get-AnsibleVersion))
if (Test-IsUbuntu22) {
    $tools.AddToolVersion("apt-fast", $(Get-AptFastVersion))
}
$tools.AddToolVersion("AzCopy", $(Get-AzCopyVersion))
$tools.AddToolVersion("Bazel", $(Get-BazelVersion))
$tools.AddToolVersion("Bazelisk", $(Get-BazeliskVersion))
if (Test-IsX64) {
    $tools.AddToolVersion("Bicep", $(Get-BicepVersion))
}
$tools.AddToolVersion("Buildah", $(Get-BuildahVersion))
$tools.AddToolVersion("CMake", $(Get-CMakeVersion))
if (Test-IsX64) {
    $tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
}
$tools.AddToolVersion("Docker Amazon ECR Credential Helper", $(Get-DockerAmazonECRCredHelperVersion))
$tools.AddToolVersion("Docker Compose", $(Get-DockerComposeVersion))
$tools.AddToolVersion("Docker-Buildx", $(Get-DockerBuildxVersion))
$tools.AddToolVersion("Docker Client", $(Get-DockerClientVersion))
$tools.AddToolVersion("Docker Server", $(Get-DockerServerVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Fastlane", $(Get-FastlaneVersion))
}
$tools.AddToolVersion("Git", $(Get-GitVersion))
$tools.AddToolVersion("Git LFS", $(Get-GitLFSVersion))
$tools.AddToolVersion("Git-ftp", $(Get-GitFTPVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Haveged", $(Get-HavegedVersion))
}
if (Test-IsUbuntu22-X64) {
    $tools.AddToolVersion("Heroku", $(Get-HerokuVersion))
}
$tools.AddToolVersion("jq", $(Get-JqVersion))
$tools.AddToolVersion("Kind", $(Get-KindVersion))
$tools.AddToolVersion("Kubectl", $(Get-KubectlVersion))
$tools.AddToolVersion("Kustomize", $(Get-KustomizeVersion))
if (Test-IsUbuntu22-X64) {
    $tools.AddToolVersion("Leiningen", $(Get-LeiningenVersion))
}
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("MediaInfo", $(Get-MediainfoVersion))
    $tools.AddToolVersion("Mercurial", $(Get-HGVersion))
}
$tools.AddToolVersion("Minikube", $(Get-MinikubeVersion))
$tools.AddToolVersion("n", $(Get-NVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Newman", $(Get-NewmanVersion))
}
$tools.AddToolVersion("nvm", $(Get-NvmVersion))
$tools.AddToolVersion("OpenSSL", $(Get-OpensslVersion))
$tools.AddToolVersion("Packer", $(Get-PackerVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Parcel", $(Get-ParcelVersion))
}
$tools.AddToolVersion("Podman", $(Get-PodManVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Pulumi", $(Get-PulumiVersion))
}
if (Test-IsUbuntu22-X64) {
    $tools.AddToolVersion("R", $(Get-RVersion))
}
$tools.AddToolVersion("Skopeo", $(Get-SkopeoVersion))
if ((Test-IsUbuntu22) -or (Test-IsUbuntu24)) {
    $tools.AddToolVersion("Sphinx Open Source Search Server", $(Get-SphinxVersion))
}
if (Test-IsUbuntu22) {
    $tools.AddToolVersion("SVN", $(Get-SVNVersion))
    $tools.AddToolVersion("Terraform", $(Get-TerraformVersion))
}
$tools.AddToolVersion("yamllint", $(Get-YamllintVersion))
$tools.AddToolVersion("yq", $(Get-YqVersion))
$tools.AddToolVersion("zstd", $(Get-ZstdVersion))
$tools.AddToolVersion("Ninja", $(Get-NinjaVersion))

# CLI Tools
$cliTools = $installedSoftware.AddHeader("CLI Tools")
if (Test-IsUbuntu22-X64) {
    $cliTools.AddToolVersion("Alibaba Cloud CLI", $(Get-AlibabaCloudCliVersion))
}
$cliTools.AddToolVersion("AWS CLI", $(Get-AWSCliVersion))
$cliTools.AddToolVersion("AWS CLI Session Manager Plugin", $(Get-AWSCliSessionManagerPluginVersion))
$cliTools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMVersion))
$cliTools.AddToolVersion("Azure CLI", $(Get-AzureCliVersion))
$cliTools.AddToolVersion("Azure CLI (azure-devops)", $(Get-AzureDevopsVersion))
$cliTools.AddToolVersion("GitHub CLI", $(Get-GitHubCliVersion))
$cliTools.AddToolVersion("Google Cloud CLI", $(Get-GoogleCloudCLIVersion))
if (Test-IsUbuntu22-X64) {
    $cliTools.AddToolVersion("ORAS CLI", $(Get-ORASCliVersion))
}
if (Test-IsUbuntu22) {
    $cliTools.AddToolVersion("Netlify CLI", $(Get-NetlifyCliVersion))
    $cliTools.AddToolVersion("OpenShift CLI", $(Get-OCCliVersion))
    $cliTools.AddToolVersion("Vercel CLI", $(Get-VerselCliversion))
}

# Java
if (Test-ToolsetModuleEnabled "java") {
    $installedSoftware.AddHeader("Java").AddTable($(Get-JavaVersionsTable))
}

# PHP Tools
if (Test-ToolsetModuleEnabled "php") {
    $phpTools = $installedSoftware.AddHeader("PHP Tools")
    $phpTools.AddToolVersionsListInline("PHP", $(Get-PHPVersions), "^\d+\.\d+")
    $phpTools.AddToolVersion("Composer", $(Get-ComposerVersion))
    $phpTools.AddToolVersion("PHPUnit", $(Get-PHPUnitVersion))
    $phpTools.AddNote("Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.")
}

# Haskell Tools
if ((Test-IsX64) -and (Test-ToolsetModuleEnabled "haskell")) {
    $haskellTools = $installedSoftware.AddHeader("Haskell Tools")
    $haskellTools.AddToolVersion("Cabal", $(Get-CabalVersion))
    $haskellTools.AddToolVersion("GHC", $(Get-GHCVersion))
    $haskellTools.AddToolVersion("GHCup", $(Get-GHCupVersion))
    $haskellTools.AddToolVersion("Stack", $(Get-StackVersion))
}

# Rust Tools
if (Test-ToolsetModuleEnabled "rust") {
    Initialize-RustEnvironment
    $rustTools = $installedSoftware.AddHeader("Rust Tools")
    $rustTools.AddToolVersion("Cargo", $(Get-CargoVersion))
    $rustTools.AddToolVersion("Rust", $(Get-RustVersion))
    $rustTools.AddToolVersion("Rustdoc", $(Get-RustdocVersion))
    $rustTools.AddToolVersion("Rustup", $(Get-RustupVersion))

    # Packages
    $rustToolsPackages = $rustTools.AddHeader("Packages")
    if (Test-IsUbuntu22) {
        $rustToolsPackages.AddToolVersion("Bindgen", $(Get-BindgenVersion))
        $rustToolsPackages.AddToolVersion("Cargo audit", $(Get-CargoAuditVersion))
        $rustToolsPackages.AddToolVersion("Cargo clippy", $(Get-CargoClippyVersion))
        $rustToolsPackages.AddToolVersion("Cargo outdated", $(Get-CargoOutdatedVersion))
        $rustToolsPackages.AddToolVersion("Cbindgen", $(Get-CbindgenVersion))
    }
    $rustToolsPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))
}

# Browsers and Drivers
if ((Test-ToolsetModuleEnabled "google-chrome") -or (Test-ToolsetModuleEnabled "microsoft-edge") -or (Test-ToolsetModuleEnabled "firefox") -or (Test-ToolsetModuleEnabled "selenium")) {
    $browsersTools = $installedSoftware.AddHeader("Browsers and Drivers")
    if (Test-IsX64) {
        if (Test-ToolsetModuleEnabled "google-chrome") {
            $browsersTools.AddToolVersion("Google Chrome", $(Get-ChromeVersion))
            $browsersTools.AddToolVersion("ChromeDriver", $(Get-ChromeDriverVersion))
            $browsersTools.AddToolVersion("Chromium", $(Get-ChromiumVersion))
        }
        if (Test-ToolsetModuleEnabled "microsoft-edge") {
            $browsersTools.AddToolVersion("Microsoft Edge", $(Get-EdgeVersion))
            $browsersTools.AddToolVersion("Microsoft Edge WebDriver", $(Get-EdgeDriverVersion))
        }
    }
    if (Test-ToolsetModuleEnabled "selenium") {
        $browsersTools.AddToolVersion("Selenium server", $(Get-SeleniumVersion))
    }
    if (Test-ToolsetModuleEnabled "firefox") {
        $browsersTools.AddToolVersion("Mozilla Firefox", $(Get-FirefoxVersion))
        $browsersTools.AddToolVersion("Geckodriver", $(Get-GeckodriverVersion))
    }

    # Environment variables
    $browsersTools.AddHeader("Environment variables").AddTable($(Build-BrowserWebdriversEnvironmentTable))
}

# .NET Tools
if ((Test-ToolsetModuleEnabled "dotnet") -or (Test-ToolsetModuleEnabled "dotnetcore-sdk")) {
    $netCoreTools = $installedSoftware.AddHeader(".NET Tools")
    Add-ToolVersionsListIfAvailable -Node $netCoreTools -ToolName ".NET Core SDK" -Versions $(Get-DotNetCoreSdkVersions) -MajorVersionRegex "^\d+\.\d+\.\d"
    $netCoreTools.AddNodes($(Get-DotnetTools))
}

# Databases
$databasesTools = $installedSoftware.AddHeader("Databases")
$databasesTools.AddToolVersion("sqlite3", $(Get-SqliteVersion))
if (Test-ToolsetModuleEnabled "postgresql") {
    $databasesTools.AddNode($(Build-PostgreSqlSection))
}
if (Test-ToolsetModuleEnabled "mysql") {
    $databasesTools.AddNode($(Build-MySQLSection))
}
if ((Test-IsUbuntu22-X64) -and (Test-ToolsetModuleEnabled "mssql-tools")) {
    $databasesTools.AddNode($(Build-MSSQLToolsSection))
}

# Cached Tools
# The cached tool set differs between images and architectures, so report
# whatever is actually present in the toolcache instead of hardcoding it.
$cachedToolVersions = [ordered]@{
    "Go"      = @{ Versions = @(Get-ToolcacheGoVersions);     MajorVersionRegex = "^\d+\.\d+" }
    "Node.js" = @{ Versions = @(Get-ToolcacheNodeVersions);   MajorVersionRegex = "^\d+" }
    "Python"  = @{ Versions = @(Get-ToolcachePythonVersions); MajorVersionRegex = "^\d+\.\d+" }
    "PyPy"    = @{ Versions = @(Get-ToolcachePyPyVersions);   MajorVersionRegex = "^\d+\.\d+" }
    "Ruby"    = @{ Versions = @(Get-ToolcacheRubyVersions);   MajorVersionRegex = "^\d+\.\d+" }
}

$availableCachedTools = @($cachedToolVersions.GetEnumerator() | Where-Object { $_.Value.Versions.Count -gt 0 })
if ($availableCachedTools.Count -gt 0) {
    $cachedTools = $installedSoftware.AddHeader("Cached Tools")
    foreach ($tool in $availableCachedTools) {
        $cachedTools.AddToolVersionsList($tool.Key, $tool.Value.Versions, $tool.Value.MajorVersionRegex)
    }
}

# PowerShell Tools
$powerShellTools = $installedSoftware.AddHeader("PowerShell Tools")
$powerShellTools.AddToolVersion("PowerShell", $(Get-PowershellVersion))
$powerShellTools.AddHeader("PowerShell Modules").AddNodes($(Get-PowerShellModules))

if ((Test-ToolsetModuleEnabled "apache") -or (Test-ToolsetModuleEnabled "nginx")) {
    $installedSoftware.AddHeader("Web Servers").AddTable($(Build-WebServersTable))
}

if ((Test-IsX64) -and (Test-ToolsetModuleEnabled "android")) {
    $androidTools = $installedSoftware.AddHeader("Android")
    $androidTools.AddTable($(Build-AndroidTable))

    $androidTools.AddHeader("Environment variables").AddTable($(Build-AndroidEnvironmentTable))
}

$installedSoftware.AddHeader("Installed apt packages").AddTable($(Get-AptPackages))

$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/software-report.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/software-report.md" -Encoding UTF8NoBOM
