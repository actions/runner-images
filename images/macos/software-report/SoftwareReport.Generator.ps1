param (
    [Parameter(Mandatory)][string]
    $OutputDirectory,
    $ImageName
)

$ErrorActionPreference = "Stop"

Import-Module MarkdownPS
Import-Module "$PSScriptRoot/SoftwareReport.Common.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xcode.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Android.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Java.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Xamarin.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Toolcache.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/SoftwareReport.Browsers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"

# Operating System info
$os = Get-OSVersion

$markdown = ""

# OS info
$markdown += Build-OSInfoSection
$markdown += New-MDList -Style Unordered -Lines ("Image Version: {0}" -f $ImageName.Split('_')[1])
# Software report
$markdown += New-MDHeader "Installed Software" -Level 2
$markdown += New-MDHeader "Language and Runtime" -Level 3

if ( -not $os.IsHighSierra) {
    $clangLLVMVersion = Get-ClangLLVMVersion
    $gccVersion = Get-GccVersion
    $gfortranVersion = Get-FortranVersion
    $lines = @($clangLLVMVersion, $gccVersion, $gfortranVersion) | ForEach-Object {$_}
    $markdown += New-MDList -Style Unordered -NoNewLine -Lines $lines
}

if ($os.IsLessThanBigSur) {
    $markdown += New-MDList -Style Unordered -Lines @(Get-RVersion) -NoNewLine
}

# Language and Runtime
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-BashVersion),
    (Get-NodeVersion),
    (Get-NVMVersion),
    (Get-NVMNodeVersionList),
    (Get-PythonVersion),
    (Get-Python3Version),
    (Get-RubyVersion),
    (Get-DotnetVersionList),
    (Get-GoVersion),
    (Get-PHPVersion),
    (Get-JuliaVersion)
)

# Package Management
$markdown += New-MDHeader "Package Management" -Level 3
if ($os.IsHigherThanMojave) {
    $markdown += New-MDList -Lines (Get-VcpkgVersion) -Style Unordered -NoNewLine
}

$markdown += New-MDList -Style Unordered -Lines @(
    (Get-PipVersion -Version 2),
    (Get-PipVersion -Version 3),
    (Get-PipxVersion),
    (Get-BundlerVersion),
    (Get-CarthageVersion),
    (Get-CocoaPodsVersion),
    (Get-HomebrewVersion),
    (Get-NPMVersion),
    (Get-YarnVersion),
    (Get-NuGetVersion),
    (Get-CondaVersion),
    (Get-RubyGemsVersion),
    (Get-ComposerVersion)
)

# Project Management
$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    (Get-MavenVersion),
    (Get-GradleVersion),
    (Get-ApacheAntVersion)
)

# Utilities
$markdown += New-MDHeader "Utilities" -Level 3
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    (Get-CurlVersion),
    (Get-GitVersion),
    (Get-GitLFSVersion),
    (Get-GitHubCLIVersion),
    (Get-HubVersion),
    (Get-WgetVersion),
    (Get-SVNVersion),
    (Get-PackerVersion),
    (Get-OpenSSLVersion),
    (Get-JqVersion),
    (Get-GPGVersion),
    (Get-PostgresClientVersion),
    (Get-PostgresServerVersion),
    (Get-Aria2Version),
    (Get-AzcopyVersion),
    (Get-ZstdVersion),
    (Get-BazelVersion),
    (Get-BazeliskVersion),
    (Get-HelmVersion),
    (Get-MongoVersion),
    (Get-MongodVersion),
    (Get-7zipVersion),
    (Get-BsdtarVersion),
    (Get-GnuTarVersion)
)
if ($os.IsHigherThanMojave) {
    $markdown += New-MDList -Lines (Get-NewmanVersion) -Style Unordered -NoNewLine
}
if ($os.IsLessThanBigSur) {
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-VirtualBoxVersion),
        (Get-VagrantVersion),
        (Get-ParallelVersion)
    )
}
$markdown += New-MDNewLine

# Tools
$markdown += New-MDHeader "Tools" -Level 3
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    (Get-FastlaneVersion),
    (Get-CmakeVersion),
    (Get-AppCenterCLIVersion),
    (Get-AzureCLIVersion),
    (Get-AWSCLIVersion),
    (Get-AWSSAMCLIVersion),
    (Get-AWSSessionManagerCLIVersion),
    (Get-AliyunCLIVersion),
    (Get-XcodeCommandLineToolsVersion)
)

if( -not $os.IsHighSierra) {
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-GHCupVersion),
        (Get-GHCVersion),
        (Get-CabalVersion),
        (Get-StackVersion)
    )
}

# Linters
$markdown += New-MDHeader "Linters" -Level 3
$markdown += New-MDList -Style Unordered -NoNewLine -Lines @(
    (Get-YamllintVersion)
)

if ( -not $os.IsHighSierra) {
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-SwiftLintVersion)
    )
}

$markdown += New-MDHeader "Browsers" -Level 3
$markdown += Get-BrowserSection

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable

# Toolcache
$markdown += Build-ToolcacheSection

if ( -not $os.IsHighSierra) {
    $markdown += New-MDHeader "Rust Tools" -Level 3
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-RustVersion),
        (Get-RustupVersion)
    )
    $markdown += New-MDHeader "Packages" -Level 4
    $markdown += New-MDList -Style Unordered -Lines @(
        (Get-Bindgen),
        (Get-Cbindgen),
        (Get-Cargooutdated),
        (Get-Cargoaudit)
    )
}

$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellVersion) -Style Unordered

$markdown += New-MDHeader "PowerShell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Xamarin section
$markdown += New-MDHeader "Xamarin" -Level 3
$markdown += New-MDHeader "Visual Studio for Mac" -Level 4
$markdown += New-MDList -Lines @(Get-VSMacVersion) -Style Unordered

$markdown += New-MDHeader "Mono" -Level 4
$markdown += New-MDList -Lines (Build-MonoList) -Style Unordered

$markdown += New-MDHeader "Xamarin.iOS" -Level 4
$markdown += New-MDList -Lines (Build-XamarinIOSList) -Style Unordered

$markdown += New-MDHeader "Xamarin.Mac" -Level 4
$markdown += New-MDList -Lines (Build-XamarinMacList) -Style Unordered

$markdown += New-MDHeader "Xamarin.Android" -Level 4
$markdown += New-MDList -Lines (Build-XamarinAndroidList) -Style Unordered

$markdown += New-MDHeader "Unit Test Framework" -Level 4
$markdown += New-MDList -Lines @(Get-NUnitVersion) -Style Unordered

# First run doesn't provide full data about devices and runtimes
Get-XcodeInfoList | Out-Null
# Xcode section
$xcodeInfo = Get-XcodeInfoList
$markdown += New-MDHeader "Xcode" -Level 3
$markdown += Build-XcodeTable $xcodeInfo | New-MDTable
$markdown += New-MDNewLine

$markdown += Build-XcodeSupportToolsSection

$markdown += New-MDHeader "Installed SDKs" -Level 4
$markdown += Build-XcodeSDKTable $xcodeInfo | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Installed Simulators" -Level 4
$markdown += Build-XcodeSimulatorsTable $xcodeInfo | New-MDTable
$markdown += New-MDNewLine

# Android section
$markdown += New-MDHeader "Android" -Level 3
$markdown += Build-AndroidTable | New-MDTable
$markdown += New-MDNewLine

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
$markdown | Out-File -FilePath "${OutputDirectory}/systeminfo.md" -Encoding UTF8NoBOM
