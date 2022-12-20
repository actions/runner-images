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
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```
'@)


$softwareReport.ToJson() | Out-File -FilePath "${OutputDirectory}/systeminfo.json" -Encoding UTF8NoBOM
$softwareReport.ToMarkdown() | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM

<#

$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-PackageManagementEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Homebrew note" -Level 4

$markdown += New-MDParagraph -Lines $reportHomebrew

$markdown += New-MDHeader "Project Management" -Level 3
$projectManagementList = @()
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $projectManagementList += @(
        (Get-AntVersion),
        (Get-GradleVersion),
        (Get-MavenVersion),
        (Get-SbtVersion)
    )
}

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $projectManagementList += @(
        (Get-LernaVersion)
    )
}
$markdown += New-MDList -Style Unordered -Lines ($projectManagementList | Sort-Object)

$markdown += New-MDHeader "Tools" -Level 3
$toolsList = @(
    (Get-AnsibleVersion),
    (Get-AptFastVersion),
    (Get-AzCopyVersion),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-BicepVersion),
    (Get-CodeQLBundleVersion),
    (Get-CMakeVersion),
    (Get-DockerMobyClientVersion),
    (Get-DockerMobyServerVersion),
    (Get-DockerComposeV1Version),
    (Get-DockerComposeV2Version),
    (Get-DockerBuildxVersion),
    (Get-DockerAmazonECRCredHelperVersion),
    (Get-BuildahVersion),
    (Get-PodManVersion),
    (Get-SkopeoVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-GitFTPVersion),
    (Get-HavegedVersion),
    (Get-HerokuVersion),
    (Get-LeiningenVersion),
    (Get-SVNVersion),
    (Get-JqVersion),
    (Get-YqVersion),
    (Get-KindVersion),
    (Get-KubectlVersion),
    (Get-KustomizeVersion),
    (Get-MediainfoVersion),
    (Get-HGVersion),
    (Get-MinikubeVersion),
    (Get-NewmanVersion),
    (Get-NVersion),
    (Get-NvmVersion),
    (Get-OpensslVersion),
    (Get-PackerVersion),
    (Get-ParcelVersion),
    (Get-PulumiVersion),
    (Get-RVersion),
    (Get-SphinxVersion),
    (Get-TerraformVersion),
    (Get-YamllintVersion),
    (Get-ZstdVersion)
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $toolsList += @(
        (Get-PhantomJSVersion),
        (Get-HHVMVersion)
    )
}

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $toolsList += (Get-FastlaneVersion)
}

$markdown += New-MDList -Style Unordered -Lines ($toolsList | Sort-Object)

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
