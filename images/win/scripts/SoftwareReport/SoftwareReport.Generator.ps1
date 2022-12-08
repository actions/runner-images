$global:ErrorActionPreference = "Stop"
$global:ProgressPreference = "SilentlyContinue"
$ErrorView = "NormalView"
Set-StrictMode -Version Latest

Import-Module MarkdownPS
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

$markdown = ""

$OSName = Get-OSName
$markdown += New-MDHeader "$OSName" -Level 1

$OSVersion = Get-OSVersion
$markdown += New-MDList -Style Unordered -Lines @(
    "$OSVersion"
    "Image Version: $env:IMAGE_VERSION"
)

$markdown += New-MDHeader "Enabled windows optional features" -Level 2
$markdown += New-MDList -Style Unordered -Lines @(
    "Windows Subsystem for Linux [WSLv1]"
)

$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3
$languageTools = @(
    (Get-BashVersion),
    (Get-GoVersion),
    (Get-JuliaVersion),
    (Get-LLVMVersion),
    (Get-NodeVersion),
    (Get-PerlVersion)
    (Get-PHPVersion),
    (Get-PythonVersion),
    (Get-RubyVersion),
    (Get-KotlinVersion)
)
$markdown += New-MDList -Style Unordered -Lines ($languageTools | Sort-Object)

$packageManagementList = @(
    (Get-ChocoVersion),
    (Get-CondaVersion),
    (Get-ComposerVersion),
    (Get-HelmVersion),
    (Get-NPMVersion),
    (Get-NugetVersion),
    (Get-PipxVersion),
    (Get-PipVersion),
    (Get-RubyGemsVersion),
    (Get-VcpkgVersion),
    (Get-YarnVersion)
)

$markdown += New-MDHeader "Package Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines ($packageManagementList | Sort-Object)

$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-PackageManagementEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Project Management" -Level 3
$projectManagementTools = @(
    (Get-AntVersion),
    (Get-GradleVersion),
    (Get-MavenVersion),
    (Get-SbtVersion)
)

$markdown += New-MDList -Style Unordered -Lines ($projectManagementTools | Sort-Object)

$markdown += New-MDHeader "Tools" -Level 3
$toolsList = @(
    (Get-7zipVersion),
    (Get-Aria2Version),
    (Get-AzCopyVersion),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-BicepVersion),
    (Get-CabalVersion),
    (Get-CMakeVersion),
    (Get-CodeQLBundleVersion),
    (Get-DockerVersion),
    (Get-DockerComposeVersion),
    (Get-DockerComposeVersionV2),
    (Get-DockerWincredVersion),
    (Get-GHCVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-InnoSetupVersion),
    (Get-JQVersion),
    (Get-KindVersion),
    (Get-KubectlVersion),
    (Get-MercurialVersion),
    (Get-MinGWVersion),
    (Get-NewmanVersion),
    (Get-NSISVersion),
    (Get-OpenSSLVersion),
    (Get-PackerVersion),
    (Get-PulumiVersion),
    (Get-RVersion),
    (Get-ServiceFabricSDKVersion),
    (Get-StackVersion),
    (Get-SVNVersion),
    (Get-VSWhereVersion),
    (Get-SwigVersion),
    (Get-WinAppDriver),
    (Get-WixVersion),
    (Get-ZstdVersion),
    (Get-YAMLLintVersion),
    (Get-ImageMagickVersion)
)
if (Test-IsWin19) {
    $toolsList += @(
        (Get-GoogleCloudSDKVersion),
        (Get-ParcelVersion)
    )
}
$markdown += New-MDList -Style Unordered -Lines ($toolsList | Sort-Object)

$markdown += New-MDHeader "CLI Tools" -Level 3
$cliTools = @(
    (Get-AlibabaCLIVersion),
    (Get-AWSCLIVersion),
    (Get-AWSSAMVersion),
    (Get-AWSSessionManagerVersion),
    (Get-AzureCLIVersion),
    (Get-AzureDevopsExtVersion),
    (Get-GHVersion),
    (Get-HubVersion)
)
if (Test-IsWin19) {
    $cliTools += @(
        (Get-CloudFoundryVersion)
    )
}
$markdown += New-MDList -Style Unordered -Lines ($cliTools | Sort-Object)

$markdown += New-MDHeader "Rust Tools" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    "Rust $(Get-RustVersion)",
    "Rustup $(Get-RustupVersion)",
    "Cargo $(Get-RustCargoVersion)",
    "Rustdoc $(Get-RustdocVersion)"
    ) | Sort-Object
)

$markdown += New-MDHeader "Packages" -Level 4
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-BindgenVersion),
    (Get-CargoAuditVersion),
    (Get-CargoOutdatedVersion),
    (Get-CbindgenVersion),
    "Rustfmt $(Get-RustfmtVersion)",
    "Clippy $(Get-RustClippyVersion)"
    ) | Sort-Object
)

$markdown += New-MDHeader "Browsers and webdrivers" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-BrowserVersion -Browser "chrome"),
    (Get-SeleniumWebDriverVersion -Driver "chrome"),
    (Get-BrowserVersion -Browser "edge"),
    (Get-SeleniumWebDriverVersion -Driver "edge"),
    (Get-BrowserVersion -Browser "firefox"),
    (Get-SeleniumWebDriverVersion -Driver "firefox"),
    (Get-SeleniumWebDriverVersion -Driver "iexplorer"),
    (Get-SeleniumVersion)
)

$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Shells" -Level 3
$markdown += Get-ShellTarget
$markdown += New-MDNewLine

$markdown += New-MDHeader "MSYS2" -Level 3
$markdown += "$(Get-PacmanVersion)" | New-MDList -Style Unordered
$markdown += New-MDHeader "Notes:" -Level 5
$reportMsys64 = @'
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
'@
$markdown += New-MDParagraph -Lines $reportMsys64

if (Test-IsWin19)
{
    $markdown += New-MDHeader "BizTalk Server" -Level 3
    $markdown += "$(Get-BizTalkVersion)" | New-MDList -Style Unordered
}

$markdown += New-MDHeader "Cached Tools" -Level 3
$markdown += (Build-CachedToolsMarkdown)

$markdown += New-MDHeader "Databases" -Level 3
$markdown += Build-DatabasesMarkdown

$markdown += New-MDHeader "Database tools" -Level 3
$databaseTools = @(
    (Get-AzCosmosDBEmulatorVersion),
    (Get-DacFxVersion),
    (Get-MySQLVersion),
    (Get-SQLPSVersion),
    (Get-SQLOLEDBDriverVersion)
)

$markdown += New-MDList -Style Unordered -Lines ($databaseTools | Sort-Object)

$markdown += Build-WebServersSection

$vs = Get-VisualStudioVersion
$markdown += New-MDHeader "$($vs.Name)" -Level 3
$markdown += $vs | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Workloads, components and extensions:" -Level 4
$markdown += ((Get-VisualStudioComponents) + (Get-VisualStudioExtensions)) | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Microsoft Visual C++:" -Level 4
$markdown += Get-VisualCPPComponents | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Installed Windows SDKs" -Level 4
$sdk = Get-WindowsSDKs
$markdown += "``Location $($sdk.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $sdk.Versions -Style Unordered

$markdown += New-MDHeader ".NET Core SDK" -Level 3
$sdk = Get-DotnetSdks
$markdown += "``Location $($sdk.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $sdk.Versions -Style Unordered

$markdown += New-MDHeader ".NET Core Runtime" -Level 3
Get-DotnetRuntimes | Foreach-Object {
    $path = $_.Path
    $versions = $_.Versions
    $markdown += "``Location: $path``"
    $markdown += New-MDNewLine
    $markdown += New-MDList -Lines $versions -Style Unordered
}

$markdown += New-MDHeader ".NET Framework" -Level 3
$markdown += "``Type: Developer Pack``"
$markdown += New-MDNewLine
Get-DotnetFrameworkTools | Foreach-Object {
    $path = $_.Path
    $versions = $_.Versions
    $markdown += "``Location: $path``"
    $markdown += New-MDNewLine
    $markdown += New-MDList -Lines $versions -Style Unordered
}

$markdown += New-MDHeader ".NET tools" -Level 3
$tools = Get-DotnetTools
$markdown += New-MDList -Lines $tools -Style Unordered

# PowerShell Tools
$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellCoreVersion) -Style Unordered

$markdown += New-MDHeader "Azure Powershell Modules" -Level 4
$markdown += Get-PowerShellAzureModules | New-MDTable
$reportAzPwsh = @'
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
'@
$markdown += New-MDParagraph -Lines $reportAzPwsh

$markdown += New-MDHeader "Powershell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Android section
$markdown += New-MDHeader "Android" -Level 3
$markdown += Build-AndroidTable | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-AndroidEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

# Docker images section
$cachedImages = Get-CachedDockerImagesTableData
if ($cachedImages) {
    $markdown += New-MDHeader "Cached Docker images" -Level 3
    $markdown += $cachedImages | New-MDTable
}

Test-BlankElement -Markdown $markdown
$markdown | Out-File -FilePath "C:\InstalledSoftware.md"
