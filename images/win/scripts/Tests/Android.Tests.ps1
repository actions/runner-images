Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Android.psm1") -DisableNameChecking

Describe "Android SDK" {
    $androidToolset = (Get-ToolsetContent).android
    $androidPackages = Get-AndroidPackages
    $androidInstalledPackages = Get-AndroidInstalledPackages

    $platformTestCases = @()
    [int]$platformMinVersion = $androidToolset.platform_min_version
    $platformList = $androidPackages | Where-Object { "$_".StartsWith("platforms;") } |
        Where-Object { [int]$_.Split("-")[1] -ge $platformMinVersion } | Sort-Object { [int]$_.Split("-")[1] } -Unique
    $platformList | ForEach-Object {
        $platformTestCases += @{ platformVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $buildToolsTestCases = @()
    [version]$buildToolsMinVersion = $androidToolset.build_tools_min_version
    $buildToolsList = $androidPackages | Where-Object { "$_".StartsWith("build-tools;") } |
        Where-Object { [version]$_.Split(";")[1] -ge $buildToolsMinVersion } | Sort-Object { [version]$_.Split(";")[1] } -Unique
    $buildToolsList | ForEach-Object {
        $buildToolsTestCases += @{ buildToolsVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $extraPackagesTestCases = @()
    $extraPackageList = $androidToolset.extra_list
    $extraPackageList | ForEach-Object {
        $extraPackagesTestCases += @{ extraPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $addonsTestCases = @()
    $addonsPackageList = $androidToolset.addon_list
    $addonsPackageList | ForEach-Object {
        $addonsTestCases += @{ addonPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $additionalToolsTestCases = @()
    $additionalToolsList = $androidToolset.additional_tools
    $additionalToolsList | ForEach-Object {
        $additionalToolsTestCases += @{ additionalToolVersion = $_; installedPackages = $androidInstalledPackages }
    }

    It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
        "$installedPackages" | Should -Match "$platformVersion"
    }

    It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
        "$installedPackages" | Should -Match "$buildToolsVersion"
    }

    if (Test-IsWin19) {
        It "Extra package <extraPackage> is installed" -TestCases $extraPackagesTestCases {
            "$installedPackages" | Should -Match "extras;$extraPackage"
        }

        It "Addon package <addonPackage> is installed" -TestCases $addonsTestCases {
            "$installedPackages" | Should -Match "add-ons;$addonPackage"
        }
    }

    It "Additional tool <additionalToolVersion> is installed" -TestCases $additionalToolsTestCases {
        "$installedPackages" | Should -Match $additionalToolVersion
    }
}