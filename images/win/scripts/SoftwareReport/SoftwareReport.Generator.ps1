$global:ErrorActionPreference = "Stop"
$global:ProgressPreference = "SilentlyContinue"
$ErrorView = "NormalView"
Set-StrictMode -Version Latest

. (Join-Path $PSScriptRoot "SoftwareReport.ArchiveItem.ps1")
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
$archive = [ArchiveItems]::New()

$OSName = Get-OSName
$markdown += New-MDHeader $archive.SetHeader("$OSName", 1) -Level 1

$OSVersion = Get-OSVersion
$markdown += New-MDList -Style Unordered -Lines @(
    $archive.Add("$OSVersion", "OSVersion")
    $archive.Add("Image Version: $env:IMAGE_VERSION", "ImageVersion")
)

$markdown += New-MDHeader $archive.SetHeader("Enabled windows optional features", 2) -Level 2
$markdown += New-MDList -Style Unordered -Lines @(
    $archive.Add("Windows Subsystem for Linux [WSLv1]", "WSL")
)

$markdown += New-MDHeader $archive.SetHeader("Installed Software", 2) -Level 2
$markdown += New-MDHeader $archive.SetHeader("Language and Runtime", 3) -Level 3
$languageTools = @(
    ((Get-BashVersion), "Bash"),
    ((Get-GoVersion), "Go"),
    ((Get-JuliaVersion), "Julia"),
    ((Get-LLVMVersion), "LLVM"),
    ((Get-NodeVersion), "Node"),
    ((Get-PerlVersion), "Perl"),
    ((Get-PHPVersion), "PHP"),
    ((Get-PythonVersion), "Python"),
    ((Get-RubyVersion), "Ruby"),
    ((Get-KotlinVersion), "Kotlin")
)
$laguageToolsTitles = $languageTools | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($laguageToolsTitles | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Package Management", 3) -Level 3
$packageManagementList = @(
    ((Get-ChocoVersion), "Choco"),
    ((Get-CondaVersion), "Conda"),
    ((Get-ComposerVersion), "Composer"),
    ((Get-HelmVersion), "Helm"),
    ((Get-NPMVersion), "NPM"),
    ((Get-NugetVersion), "Nuget"),
    ((Get-PipxVersion), "Pipx"),
    ((Get-PipVersion), "Pip"),
    ((Get-RubyGemsVersion), "Ruby"),
    ((Get-VcpkgVersion), "Vcpkg"),
    ((Get-YarnVersion), "Yarn")
)
$packageManagementListTitles = $packageManagementList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($packageManagementListTitles | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-PackageManagementEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Project Management", 3) -Level 3
$projectManagementTools = @(
    ((Get-AntVersion), "Ant"),
    ((Get-GradleVersion), "Gradle"),
    ((Get-MavenVersion), "Maven"),
    ((Get-SbtVersion), "Sbt")
)
$projectManagementToolsTitles = $projectManagementTools | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($projectManagementToolsTitles | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Tools", 3) -Level 3
$toolsList = @(
    ((Get-7zipVersion), "7zip"),
    ((Get-Aria2Version), "Aria2"),
    ((Get-AzCopyVersion), "AzCopy"),
    ((Get-BazelVersion), "Bazel"),
    ((Get-BazeliskVersion), "Bazelisk"),
    ((Get-BicepVersion), "Bicep"),
    ((Get-CabalVersion), "Cabal"),
    ((Get-CMakeVersion), "CMake"),
    ((Get-CodeQLBundleVersion), "CodeQLBundle"),
    ((Get-DockerVersion), "Docker"),
    ((Get-DockerComposeVersion), "DockerCompose"),
    ((Get-DockerComposeVersionV2), "DockerComposeV2"),
    ((Get-DockerWincredVersion), "DockerWincred"),
    ((Get-GHCVersion), "GHC"),
    ((Get-GitVersion), "Git"),
    ((Get-GitLFSVersion), "GitLFS"),
    ((Get-InnoSetupVersion), "InnoSetup"),
    ((Get-JQVersion), "JQ"),
    ((Get-KindVersion), "Kind"),
    ((Get-KubectlVersion), "Kubectl"),
    ((Get-MercurialVersion), "Mercurial"),
    ((Get-MinGWVersion), "MinGW"),
    ((Get-NewmanVersion), "Newman"),
    ((Get-NSISVersion), "NSIS"),
    ((Get-OpenSSLVersion), "OpenSSL"),
    ((Get-PackerVersion), "Packer"),
    ((Get-PulumiVersion), "Pulumi"),
    ((Get-RVersion), "R"),
    ((Get-ServiceFabricSDKVersion), "ServiceFabricSDK"),
    ((Get-StackVersion), "Stack"),
    ((Get-SVNVersion), "SVN"),
    ((Get-VSWhereVersion), "VSWhere"),
    ((Get-SwigVersion), "Swig"),
    ((Get-WinAppDriver), "WinApp"),
    ((Get-WixVersion), "Wix"),
    ((Get-ZstdVersion), "Zstd"),
    ((Get-YAMLLintVersion), "YAMLLint"),
    ((Get-ImageMagickVersion), "ImageMagick")
)
if (Test-IsWin19) {
    $toolsList += @(
        ((Get-GoogleCloudSDKVersion), "GoogleCloudSDK"),
        ((Get-ParcelVersion), "Parcel")
    )
}
$toolListTitles = $toolsList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($toolListTitles | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("CLI Tools", 3) -Level 3
$cliTools = @(
    ((Get-AlibabaCLIVersion), "Alibaba"),
    ((Get-AWSCLIVersion), "AWSCLI"),
    ((Get-AWSSAMVersion), "AWSSAM"),
    ((Get-AWSSessionManagerVersion), "AWSSessionManager"),
    ((Get-AzureCLIVersion), "AzureCLI"),
    ((Get-AzureDevopsExtVersion), "AzureDevopsExt"),
    ((Get-GHVersion), "GH"),
    ((Get-HubVersion), "Hub")
)
if (Test-IsWin19) {
    $cliTools += @(
        ((Get-CloudFoundryVersion), "")
    )
}
$cliToolsTitles = $cliTools | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($cliToolsTitles | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Rust Tools", 3) -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    ("Rust $(Get-RustVersion)", "Rust"),
    ("Rustup $(Get-RustupVersion)", "Rustup"),
    ("Cargo $(Get-RustCargoVersion)", "Cargo"),
    ("Rustdoc $(Get-RustdocVersion)", "Rustdoc")
    ) | Foreach-Object {$archive.Add($_)} | Sort-Object
)

$markdown += New-MDHeader $archive.SetHeader("Packages", 4) -Level 4
$markdown += New-MDList -Style Unordered -Lines (@(
    ((Get-BindgenVersion), "Bindgen"),
    ((Get-CargoAuditVersion), "CargoAudit"),
    ((Get-CargoOutdatedVersion), "CargoOutdated"),
    ((Get-CbindgenVersion), "Cbindgen"),
    ("Rustfmt $(Get-RustfmtVersion)", "Rustfmt"),
    ("Clippy $(Get-RustClippyVersion)", "Clippy")
    ) | Foreach-Object {$archive.Add($_)} | Sort-Object
)

$markdown += New-MDHeader $archive.SetHeader("Browsers and webdrivers", 3) -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    ((Get-BrowserVersion -Browser "chrome"), "GoogleChrome"),
    ((Get-SeleniumWebDriverVersion -Driver "chrome"), "ChromeDriver"),
    ((Get-BrowserVersion -Browser "edge"), "MicrosoftEdge"),
    ((Get-SeleniumWebDriverVersion -Driver "edge"), "MicrosoftEdgeDriver"),
    ((Get-BrowserVersion -Browser "firefox"), "MozillaFirefox"),
    ((Get-SeleniumWebDriverVersion -Driver "firefox"), "GeckoDriver"),
    ((Get-SeleniumWebDriverVersion -Driver "iexplorer"), "IEDriver"),
    ((Get-SeleniumVersion), "SeleniumServer") | Foreach-Object {$archive.Add($_)}
)

$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Java", 3) -Level 3
$markdown += Get-JavaVersions $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Shells", 3) -Level 3
$markdown += Get-ShellTarget $archive
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("MSYS2", 3) -Level 3
$markdown += $archive.Add($(Get-PacmanVersion), "Pacman") | New-MDList -Style Unordered
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
    $markdown += New-MDHeader $archive.SetHeader("BizTalk Server", 3) -Level 3
    $markdown += $archive.Add($(Get-BizTalkVersion), "BizTalk") | New-MDList -Style Unordered
}

$markdown += New-MDHeader $archive.SetHeader("Cached Tools", 3) -Level 3
$markdown += (Build-CachedToolsMarkdown $archive)

$markdown += New-MDHeader $archive.SetHeader("Databases", 3) -Level 3
$markdown += Build-DatabasesMarkdown $archive

$markdown += New-MDHeader $archive.SetHeader("Database tools", 3) -Level 3
$databaseTools = @(
    ((Get-AzCosmosDBEmulatorVersion), "AzCosmosDBEmulator"),
    ((Get-DacFxVersion), "DacFx"),
    ((Get-MySQLVersion), "MySQL"),
    ((Get-SQLPSVersion), "SQLPS"),
    ((Get-SQLOLEDBDriverVersion), "SQLOLEDBDriver")
)
$databaseToolsTitles = $databaseTools | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($databaseToolsTitles | Sort-Object)

$markdown += Build-WebServersSection $archive

$vs = Get-VisualStudioVersion $archive
$markdown += New-MDHeader "$($vs.Name)" -Level 3
$markdown += $vs | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Workloads, components and extensions:", 4) -Level 4
$wce = (Get-VisualStudioComponents) + (Get-VisualStudioExtensions)
$wce | ForEach-Object { $Archive.Add("$($_.Package)|$($_.Version)", "VisualStudio_" + ($_.Package).Replace(" ", "")) } | Out-Null
$markdown += $wce | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Microsoft Visual C++:", 4) -Level 4
$markdown += Get-VisualCPPComponents $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Installed Windows SDKs", 4) -Level 4
$sdk = Get-WindowsSDKs
$sdk.Versions | ForEach-Object { $archive.Add("Windows SDK $_", "Windows_SDK_$_") } | Out-Null
$markdown += "``Location $($sdk.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $sdk.Versions -Style Unordered

$markdown += New-MDHeader $archive.SetHeader(".NET Core SDK", 3) -Level 3
$sdk = Get-DotnetSdks
$archive.Add(".NET Core SDKs: $($sdk.Versions)", "NET_Core_SDK") | Out-Null
$markdown += "``Location $($sdk.Path)``"
$markdown += New-MDNewLine
$markdown += New-MDList -Lines $sdk.Versions -Style Unordered

$markdown += New-MDHeader $archive.SetHeader(".NET Core Runtime", 3) -Level 3
Get-DotnetRuntimes | Foreach-Object {
    $path = $_.Path
    $versions = $_.Versions
    $markdown += "``Location: $path``"
    $markdown += New-MDNewLine
    $markdown += New-MDList -Lines $versions -Style Unordered
    $archive.Add(".Net Core Runtime ($path): $versions", "NET_Core_Runtime_$path") | Out-Null
}

$markdown += New-MDHeader $archive.SetHeader(".NET Framework", 3) -Level 3
$markdown += "``Type: Developer Pack``"
$markdown += New-MDNewLine
Get-DotnetFrameworkTools | Foreach-Object {
    $path = $_.Path
    $versions = $_.Versions
    $markdown += "``Location: $path``"
    $markdown += New-MDNewLine
    $markdown += New-MDList -Lines $versions -Style Unordered
    $archive.Add(".NET Framework: $versions", "NET_Framework_$versions") | Out-Null
}

$markdown += New-MDHeader $archive.SetHeader(".NET tools", 3) -Level 3
$tools = Get-DotnetTools $archive
$markdown += New-MDList -Lines $tools -Style Unordered

# PowerShell Tools
$markdown += New-MDHeader $archive.SetHeader("PowerShell Tools", 3) -Level 3
$markdown += New-MDList -Lines ($archive.Add((Get-PowershellCoreVersion), "PowerShellTools")) -Style Unordered

$markdown += New-MDHeader $archive.SetHeader("Azure Powershell Modules", 4) -Level 4
$markdown += Get-PowerShellAzureModules $archive | New-MDTable
$reportAzPwsh = @'
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
'@
$markdown += New-MDParagraph -Lines $reportAzPwsh

$markdown += New-MDHeader $archive.SetHeader("Powershell Modules", 4) -Level 4
$markdown += Get-PowerShellModules $archive | New-MDTable
$markdown += New-MDNewLine

# Android section
$markdown += New-MDHeader $archive.SetHeader("Android", 3) -Level 3
$markdown += Build-AndroidTable $archive | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-AndroidEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

# Docker images section
$cachedImages = Get-CachedDockerImagesTableData
if ($cachedImages) {
    $markdown += New-MDHeader $archive.SetHeader("Cached Docker images", 3) -Level 3
    $markdown += $cachedImages | New-MDTable
    $cachedImages | ForEach-Object { $archive.Add("$($_."Repository:Tag")|$($_.Digest)", "CachedDockerImage_$($_."Repository:Tag")") } | Out-Null
}

Test-BlankElement -Markdown $markdown
$markdown | Out-File -FilePath "C:\InstalledSoftware.md"
$archive.ToJsonGrouped() | Out-File -FilePath "C:\InstalledSoftware-Archive-Grouped.json"
