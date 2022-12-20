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
$softwareReport.Root.AddToolVersion("Image Version:", "20221212.2") # $env:IMAGE_VERSION)

$installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

# Language and Runtime
$languageAndRuntime = $installedSoftware.AddHeader("Language and Runtime")
$languageAndRuntime.AddToolVersion("Bash", $(Get-BashVersion))
$languageAndRuntime.AddToolVersionsList("Clang", $(Get-ClangToolVersions -ToolName "clang"), "^\d+", $true)
$languageAndRuntime.AddToolVersionsList("Clang-format", $(Get-ClangToolVersions -ToolName "clang-format"), "^\d+", $true)
$languageAndRuntime.AddToolVersionsList("Clang-tidy", $(Get-ClangTidyVersions), "^\d+", $true)
$languageAndRuntime.AddToolVersion("Dash", $(Get-DashVersion))
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $languageAndRuntime.AddToolVersion("Erlang", $(Get-ErlangVersion))
    $languageAndRuntime.AddToolVersion("Erlang rebar3", $(Get-ErlangRebar3Version))
}
$languageAndRuntime.AddToolVersionsList("GNU C++", $(Get-CPPVersions), "^\d+", $true)
$languageAndRuntime.AddToolVersionsList("GNU Fortran", $(Get-FortranVersions), "^\d+", $true)
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

$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/systeminfo.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM

<#

$markdown += New-MDHeader "CLI Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-AlibabaCloudCliVersion),
    (Get-AWSCliVersion),
    (Get-AWSCliSessionManagerPluginVersion),
    (Get-AWSSAMVersion),
    (Get-AzureCliVersion),
    (Get-AzureDevopsVersion),
    (Get-GitHubCliVersion),
    (Get-GoogleCloudSDKVersion),
    (Get-HubCliVersion),
    (Get-NetlifyCliVersion),
    (Get-OCCliVersion),
    (Get-ORASCliVersion),
    (Get-VerselCliversion)
    )
)

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $markdown += New-MDHeader "GraalVM" -Level 3
    $markdown += Build-GraalVMTable | New-MDTable
    $markdown += New-MDNewLine
}

$markdown += Build-PHPSection

$markdown += New-MDHeader "Haskell" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-GHCVersion),
    (Get-GHCupVersion),
    (Get-CabalVersion),
    (Get-StackVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Rust Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-RustVersion),
    (Get-RustupVersion),
    (Get-RustdocVersion),
    (Get-CargoVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Packages" -Level 4
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-BindgenVersion),
    (Get-CargoAuditVersion),
    (Get-CargoOutdatedVersion),
    (Get-CargoClippyVersion),
    (Get-CbindgenVersion),
    (Get-RustfmtVersion)
    ) | Sort-Object
)

$markdown += New-MDHeader "Browsers and Drivers" -Level 3

$browsersAndDriversList = @(
    (Get-ChromeVersion),
    (Get-ChromeDriverVersion),
    (Get-ChromiumVersion),
    (Get-EdgeVersion),
    (Get-EdgeDriverVersion),
    (Get-SeleniumVersion),
    (Get-FirefoxVersion),
    (Get-GeckodriverVersion)
)

$markdown += New-MDList -Style Unordered -Lines $browsersAndDriversList
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader ".NET Core Tools" -Level 3
$netCoreTools = @(
    ".NET Core SDK: $(Get-DotNetCoreSdkVersions)"
)
$netCoreTools += Get-DotnetTools
$markdown += New-MDList -Style Unordered -Lines $netCoreTools

$markdown += New-MDHeader "Databases" -Level 3
$databaseLists = @(
    (Get-SqliteVersion)
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $databaseLists += @(
        (Get-MongoDbVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ( $databaseLists | Sort-Object )

$markdown += Build-PostgreSqlSection
$markdown += Build-MySQLSection
$markdown += Build-MSSQLToolsSection

$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += Build-CachedToolsSection

$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellVersion) -Style Unordered

$markdown += New-MDHeader "PowerShell Modules" -Level 4
$markdown += New-MDList -Lines $(Get-PowerShellModules) -Style Unordered

$markdown += Build-WebServersSection

$markdown += New-MDHeader "Android" -Level 3
$markdown += Build-AndroidTable | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-AndroidEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Cached Docker images" -Level 3
$markdown += Get-CachedDockerImagesTableData | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Installed apt packages" -Level 3
$markdown += Get-AptPackages | New-MDTable

Test-BlankElement
$markdown | Out-File -FilePath "${OutputDirectory}/Ubuntu-Readme.md"
#>
