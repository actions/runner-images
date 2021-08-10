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
Import-Module "$PSScriptRoot/SoftwareReport.WebServers.psm1" -DisableNameChecking
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
$languageAndRuntimeList = @(
    (Get-BashVersion),
    (Get-MSBuildVersion),
    (Get-NodeVersion),
    (Get-NVMVersion),
    (Get-NVMNodeVersionList),
    (Get-PerlVersion),
    (Get-PythonVersion),
    (Get-Python3Version),
    (Get-RubyVersion),
    (Get-DotnetVersionList),
    (Get-GoVersion),
    (Get-PHPVersion),
    (Get-JuliaVersion),
    (Get-KotlinVersion)
)

if ( -not $os.IsHighSierra) {
    $languageAndRuntimeList += @(
        (Get-GccVersion)
        (Get-FortranVersion)
        (Get-ClangLLVMVersion)
    )
}

if ($os.IsLessThanBigSur) {
    $languageAndRuntimeList += @(
        (Get-RVersion)
    )
}

# To sort GCC and Gfortran correctly, we need to use natural sort https://gist.github.com/markwragg/e2a9dc05f3464103d6998298fb575d4e#file-sort-natural-ps1
$toNatural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20) }) }
$markdown += New-MDList -Style Unordered -Lines ($languageAndRuntimeList | Sort-Object $toNatural)

# Package Management
$markdown += New-MDHeader "Package Management" -Level 3
$packageManagementList = @(
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

if ($os.IsHigherThanMojave) {
    $packageManagementList += @(
        (Get-VcpkgVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($packageManagementList | Sort-Object)
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-PackageManagementEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

# Project Management
$markdown += New-MDHeader "Project Management" -Level 3
$markdown += New-MDList -Style Unordered -Lines (@(
    (Get-MavenVersion),
    (Get-GradleVersion),
    (Get-ApacheAntVersion)
    ) | Sort-Object
)

# Utilities
$markdown += New-MDHeader "Utilities" -Level 3
$utilitiesList = @(
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
    $utilitiesList += @(
        (Get-NewmanVersion)
    )
}

if ($os.IsLessThanBigSur) {
    $utilitiesList += @(
        (Get-VirtualBoxVersion),
        (Get-VagrantVersion),
        (Get-ParallelVersion)
    )
}

if (-not $os.IsHighSierra) {
    $utilitiesList += @(
        (Get-SwitchAudioOsxVersion),
        (Get-SoxVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($utilitiesList | Sort-Object)
$markdown += New-MDNewLine

# Tools
$markdown += New-MDHeader "Tools" -Level 3
$toolsList = @(
    (Get-FastlaneVersion),
    (Get-CmakeVersion),
    (Get-AppCenterCLIVersion),
    (Get-AzureCLIVersion),
    (Get-AWSCLIVersion),
    (Get-AWSSAMCLIVersion),
    (Get-AWSSessionManagerCLIVersion),
    (Get-AliyunCLIVersion),
    (Get-XcodeCommandLineToolsVersion),
    (Get-SwigVersion),
    (Get-BicepVersion)
)

if( -not $os.IsHighSierra) {
    $toolsList += @(
        (Get-GHCupVersion),
        (Get-GHCVersion),
        (Get-CabalVersion),
        (Get-StackVersion),
        (Get-SwiftFormatVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($toolsList | Sort-Object)

# Linters
$markdown += New-MDHeader "Linters" -Level 3
$lintersList = @(
    (Get-YamllintVersion)
)

if ( -not $os.IsHighSierra) {
    $lintersList += @(
        (Get-SwiftLintVersion)
    )
}

$markdown += New-MDList -Style Unordered -Lines ($lintersList | Sort-Object)

$markdown += New-MDHeader "Browsers" -Level 3
$markdown += Get-BrowserSection
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader "Java" -Level 3
$markdown += Get-JavaVersions | New-MDTable
$markdown += New-MDNewLine

# Toolcache
$markdown += Build-ToolcacheSection

if ( -not $os.IsHighSierra) {
    $markdown += New-MDHeader "Rust Tools" -Level 3
    $markdown += New-MDList -Style Unordered -Lines (@(
        (Get-RustVersion),
        (Get-RustupVersion),
        (Get-RustdocVersion),
        (Get-RustCargoVersion)
        ) | Sort-Object
    )
    
    $markdown += New-MDHeader "Packages" -Level 4
    $markdown += New-MDList -Style Unordered -Lines (@(
        (Get-Bindgen),
        (Get-Cbindgen),
        (Get-Cargooutdated),
        (Get-Cargoaudit),
        (Get-RustfmtVersion),
        (Get-RustClippyVersion)
        ) | Sort-Object
    )
}

$markdown += New-MDHeader "PowerShell Tools" -Level 3
$markdown += New-MDList -Lines (Get-PowershellVersion) -Style Unordered

$markdown += New-MDHeader "PowerShell Modules" -Level 4
$markdown += Get-PowerShellModules | New-MDTable
$markdown += New-MDNewLine

# Web Servers
if ($os.IsHigherThanMojave) {
    $markdown += Build-WebServersSection
}

# Xamarin section
$markdown += New-MDHeader "Xamarin" -Level 3
$markdown += New-MDHeader "Visual Studio for Mac" -Level 4
$markdown += New-MDList -Lines @(Get-VSMacVersion) -Style Unordered

$markdown += New-MDHeader "Xamarin bundles" -Level 4
$markdown += Build-XamarinTable | New-MDTable
$markdown += New-MDNewLine

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
$androidTable = Build-AndroidTable
if ($os.IsLessThanBigSur) {
    $androidTable += Get-IntelHaxmVersion
}
$markdown += $androidTable | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader "Environment variables" -Level 4
$markdown += Build-AndroidEnvironmentTable | New-MDTable
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
