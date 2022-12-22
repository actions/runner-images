using module ./software-report-base/SoftwareReport.psm1
using module ./software-report-base/SoftwareReport.Nodes.psm1

param (
    [Parameter(Mandatory)][string]
    $OutputDirectory
)

$global:ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"
Set-StrictMode -Version Latest

Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Rust.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking

# Restore file owner in user profile
Restore-UserOwner

# Software report
$softwareReport = [SoftwareReport]::new("Ubuntu $(Get-OSVersionShort)")
$softwareReport.Root.AddToolVersion("OS Version:", $(Get-OSVersionFull))
$softwareReport.Root.AddToolVersion("Kernel Version:", $(Get-KernelVersion))
$softwareReport.Root.AddToolVersion("Image Version:", $env:IMAGE_VERSION)

$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
$languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion))
$languageAndRuntime.AddToolVersionsListInline("Clang", $(Get-ClangToolVersions -ToolName "clang"), "^\d+")
$languageAndRuntime.AddToolVersionsListInline("Clang-format", $(Get-ClangToolVersions -ToolName "clang-format"), "^\d+")
$languageAndRuntime.AddToolVersionsListInline("Clang-tidy", $(Get-ClangTidyVersions), "^\d+")
$languageAndRuntime.AddToolVersion("Dash", $(Get-DashVersion))
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $languageAndRuntime.AddToolVersion("Erlang", $(Get-ErlangVersion))
    $languageAndRuntime.AddToolVersion("Erlang rebar3", $(Get-ErlangRebar3Version))
}
$languageAndRuntime.AddToolVersionsListInline("GNU C++", $(Get-CPPVersions), "^\d+")
$languageAndRuntime.AddToolVersionsListInline("GNU Fortran", $(Get-FortranVersions), "^\d+")
$languageAndRuntime.AddToolVersion("Julia", $(Get-JuliaVersion))
$languageAndRuntime.AddToolVersion("Kotlin", $(Get-KotlinVersion))
$languageAndRuntime.AddToolVersion("Mono", $(Get-MonoVersion))
$languageAndRuntime.AddToolVersion("MSBuild", $(Get-MsbuildVersion))
$languageAndRuntime.AddToolVersion("Node.js", $(Get-NodeVersion))
$languageAndRuntime.AddToolVersion("Perl", $(Get-PerlVersion))
$languageAndRuntime.AddToolVersion("Python", $(Get-PythonVersion))
$languageAndRuntime.AddToolVersion("Python3", $(Get-Python3Version))
$languageAndRuntime.AddToolVersion("Ruby", $(Get-RubyVersion))
$languageAndRuntime.AddToolVersion("Swift", $(Get-SwiftVersion))

# Package Management
$packageManagement = $installedSoftware.AddHeader("Package Management")
$packageManagement.AddToolVersion("cpan", $(Get-CpanVersion))
$packageManagement.AddToolVersion("Helm", $(Get-HelmVersion))
$packageManagement.AddToolVersion("Homebrew", $(Get-HomebrewVersion))
$packageManagement.AddToolVersion("Miniconda", $(Get-MinicondaVersion))
$packageManagement.AddToolVersion("Npm", $(Get-NpmVersion))
$packageManagement.AddToolVersion("NuGet", $(Get-NuGetVersion))
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
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $projectManagement.AddToolVersion("Ant", $(Get-AntVersion))
    $projectManagement.AddToolVersion("Gradle", $(Get-GradleVersion))
}
if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $projectManagement.AddToolVersion("Lerna", $(Get-LernaVersion))
}
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $projectManagement.AddToolVersion("Maven", $(Get-MavenVersion))
    $projectManagement.AddToolVersion("Sbt", $(Get-SbtVersion))
}

# Tools
$tools = $installedSoftware.AddHeader("Tools")
$tools.AddToolVersion("Ansible", $(Get-AnsibleVersion))
$tools.AddToolVersion("apt-fast", $(Get-AptFastVersion))
$tools.AddToolVersion("AzCopy", $(Get-AzCopyVersion))
$tools.AddToolVersion("Bazel", $(Get-BazelVersion))
$tools.AddToolVersion("Bazelisk", $(Get-BazeliskVersion))
$tools.AddToolVersion("Bicep", $(Get-BicepVersion))
$tools.AddToolVersion("Buildah", $(Get-BuildahVersion))
$tools.AddToolVersion("CMake", $(Get-CMakeVersion))
$tools.AddToolVersion("CodeQL Action Bundle", $(Get-CodeQLBundleVersion))
$tools.AddToolVersion("Docker Amazon ECR Credential Helper", $(Get-DockerAmazonECRCredHelperVersion))
$tools.AddToolVersion("Docker Compose v1", $(Get-DockerComposeV1Version))
$tools.AddToolVersion("Docker Compose v2", $(Get-DockerComposeV2Version))
$tools.AddToolVersion("Docker-Buildx", $(Get-DockerBuildxVersion))
$tools.AddToolVersion("Docker-Moby Client", $(Get-DockerMobyClientVersion))
$tools.AddToolVersion("Docker-Moby Server", $(Get-DockerMobyServerVersion))
if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $tools.AddToolVersion("Fastlane", $(Get-FastlaneVersion))
}
$tools.AddToolVersion("Git", $(Get-GitVersion))
$tools.AddToolVersion("Git LFS", $(Get-GitLFSVersion))
$tools.AddToolVersion("Git-ftp", $(Get-GitFTPVersion))
$tools.AddToolVersion("Haveged", $(Get-HavegedVersion))
$tools.AddToolVersion("Heroku", $(Get-HerokuVersion))
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $tools.AddToolVersion("HHVM (HipHop VM)", $(Get-HHVMVersion))
}
$tools.AddToolVersion("jq", $(Get-JqVersion))
$tools.AddToolVersion("Kind", $(Get-KindVersion))
$tools.AddToolVersion("Kubectl", $(Get-KubectlVersion))
$tools.AddToolVersion("Kustomize", $(Get-KustomizeVersion))
$tools.AddToolVersion("Leiningen", $(Get-LeiningenVersion))
$tools.AddToolVersion("MediaInfo", $(Get-MediainfoVersion))
$tools.AddToolVersion("Mercurial", $(Get-HGVersion))
$tools.AddToolVersion("Minikube", $(Get-MinikubeVersion))
$tools.AddToolVersion("n", $(Get-NVersion))
$tools.AddToolVersion("Newman", $(Get-NewmanVersion))
$tools.AddToolVersion("nvm", $(Get-NvmVersion))
$tools.AddToolVersion("OpenSSL", $(Get-OpensslVersion))
$tools.AddToolVersion("Packer", $(Get-PackerVersion))
$tools.AddToolVersion("Parcel", $(Get-ParcelVersion))
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $tools.AddToolVersion("PhantomJS", $(Get-PhantomJSVersion))
}
$tools.AddToolVersion("Podman", $(Get-PodManVersion))
$tools.AddToolVersion("Pulumi", $(Get-PulumiVersion))
$tools.AddToolVersion("R", $(Get-RVersion))
$tools.AddToolVersion("Skopeo", $(Get-SkopeoVersion))
$tools.AddToolVersion("Sphinx Open Source Search Server", $(Get-SphinxVersion))
$tools.AddToolVersion("SVN", $(Get-SVNVersion))
$tools.AddToolVersion("Terraform", $(Get-TerraformVersion))
$tools.AddToolVersion("yamllint", $(Get-YamllintVersion))
$tools.AddToolVersion("yq", $(Get-YqVersion))
$tools.AddToolVersion("zstd", $(Get-ZstdVersion))

# CLI Tools
$cliTools = $installedSoftware.AddHeader("CLI Tools")
$cliTools.AddToolVersion("Alibaba Cloud CLI", $(Get-AlibabaCloudCliVersion))
$cliTools.AddToolVersion("AWS CLI", $(Get-AWSCliVersion))
$cliTools.AddToolVersion("AWS CLI Session Manager Plugin", $(Get-AWSCliSessionManagerPluginVersion))
$cliTools.AddToolVersion("AWS SAM CLI", $(Get-AWSSAMVersion))
$cliTools.AddToolVersion("Azure CLI", $(Get-AzureCliVersion))
$cliTools.AddToolVersion("Azure CLI (azure-devops)", $(Get-AzureDevopsVersion))
$cliTools.AddToolVersion("GitHub CLI", $(Get-GitHubCliVersion))
$cliTools.AddToolVersion("Google Cloud SDK", $(Get-GoogleCloudSDKVersion))
$cliTools.AddToolVersion("Hub CLI", $(Get-HubCliVersion))
$cliTools.AddToolVersion("Netlify CLI", $(Get-NetlifyCliVersion))
$cliTools.AddToolVersion("OpenShift CLI", $(Get-OCCliVersion))
$cliTools.AddToolVersion("ORAS CLI", $(Get-ORASCliVersion))
$cliTools.AddToolVersion("Vercel CLI", $(Get-VerselCliversion))


$installedSoftware.AddHeader("Java").AddTable($(Get-JavaVersionsTable))
if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $installedSoftware.AddHeader("GraalVM").AddTable($(Build-GraalVMTable))
}

$phpTools = $installedSoftware.AddHeader("PHP Tools")
$phpTools.AddToolVersionsListInline("PHP", $(Get-PHPVersions), "^\d+\.\d+")
$phpTools.AddToolVersion("Composer", $(Get-ComposerVersion))
$phpTools.AddToolVersion("PHPUnit", $(Get-PHPUnitVersion))
$phpTools.AddNote("Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.")

$haskellTools = $installedSoftware.AddHeader("Haskell Tools")
$haskellTools.AddToolVersion("Cabal", $(Get-CabalVersion))
$haskellTools.AddToolVersion("GHC", $(Get-GHCVersion))
$haskellTools.AddToolVersion("GHCup", $(Get-GHCupVersion))
$haskellTools.AddToolVersion("Stack", $(Get-StackVersion))

Initialize-RustEnvironment
$rustTools = $installedSoftware.AddHeader("Rust Tools")
$rustTools.AddToolVersion("Cargo", $(Get-CargoVersion))
$rustTools.AddToolVersion("Rust", $(Get-RustVersion))
$rustTools.AddToolVersion("Rustdoc", $(Get-RustdocVersion))
$rustTools.AddToolVersion("Rustup", $(Get-RustupVersion))
$rustToolsPackages = $rustTools.AddHeader("Packages")
$rustToolsPackages.AddToolVersion("Bindgen", $(Get-BindgenVersion))
$rustToolsPackages.AddToolVersion("Cargo audit", $(Get-CargoAuditVersion))
$rustToolsPackages.AddToolVersion("Cargo clippy", $(Get-CargoClippyVersion))
$rustToolsPackages.AddToolVersion("Cargo outdated", $(Get-CargoOutdatedVersion))
$rustToolsPackages.AddToolVersion("Cbindgen", $(Get-CbindgenVersion))
$rustToolsPackages.AddToolVersion("Rustfmt", $(Get-RustfmtVersion))

$browsersTools = $installedSoftware.AddHeader("Browsers and Drivers")
$browsersTools.AddToolVersion("Google Chrome", $(Get-ChromeVersion))
$browsersTools.AddToolVersion("ChromeDriver", $(Get-ChromeDriverVersion))
$browsersTools.AddToolVersion("Chromium", $(Get-ChromiumVersion))
$browsersTools.AddToolVersion("Microsoft Edge", $(Get-EdgeVersion))
$browsersTools.AddToolVersion("Microsoft Edge WebDriver", $(Get-EdgeDriverVersion))
$browsersTools.AddToolVersion("Selenium server", $(Get-SeleniumVersion))
$browsersTools.AddToolVersion("Mozilla Firefox", $(Get-FirefoxVersion))
$browsersTools.AddToolVersion("Geckodriver", $(Get-GeckodriverVersion))
$browsersTools.AddHeader("Environment variables").AddTable($(Build-BrowserWebdriversEnvironmentTable))

$netCoreTools = $installedSoftware.AddHeader(".NET Tools")
$netCoreTools.AddToolVersionsListInline(".NET Core SDK", $(Get-DotNetCoreSdkVersions), "^\d+\.\d+\.\d")
$netCoreTools.AddNodes($(Get-DotnetTools))

$databasesTools = $installedSoftware.AddHeader("Databases")
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $databasesTools.AddToolVersion("MongoDB", $(Get-MongoDbVersion))
}
$databasesTools.AddToolVersion("sqlite3", $(Get-SqliteVersion))
$databasesTools.AddNode($(Build-PostgreSqlSection))
$databasesTools.AddNode($(Build-MySQLSection))
$databasesTools.AddNode($(Build-MSSQLToolsSection))

$cachedTools = $installedSoftware.AddHeader("Cached Tools")
$cachedTools.AddToolVersionsList("Go", $(Get-ToolcacheGoVersions), "^\d+\.\d+")
$cachedTools.AddToolVersionsList("Node.js", $(Get-ToolcacheNodeVersions), "^\d+")
$cachedTools.AddToolVersionsList("Python", $(Get-ToolcachePythonVersions), "^\d+\.\d+")
$cachedTools.AddToolVersionsList("PyPy", $(Get-ToolcachePyPyVersions), "^\d+\.\d+")
$cachedTools.AddToolVersionsList("Ruby", $(Get-ToolcacheRubyVersions), "^\d+\.\d+")

$powerShellTools = $installedSoftware.AddHeader("PowerShell Tools")
$powerShellTools.AddToolVersion("PowerShell", $(Get-PowershellVersion))
$powerShellTools.AddHeader("PowerShell Modules").AddNodes($(Get-PowerShellModules))

$installedSoftware.AddHeader("Web Servers").AddTable($(Build-WebServersTable))

$androidTools = $installedSoftware.AddHeader("Android")
$androidTools.AddTable($(Build-AndroidTable))
$androidTools.AddHeader("Environment variables").AddTable($(Build-AndroidEnvironmentTable))

$installedSoftware.AddHeader("Cached Docker images").AddTable($(Get-CachedDockerImagesTableData))
$installedSoftware.AddHeader("Installed apt packages").AddTable($(Get-AptPackages))

$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/software-report.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/software-report.md" -Encoding UTF8NoBOM
