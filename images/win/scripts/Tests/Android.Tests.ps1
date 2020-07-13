Import-Module (Join-Path "..\SoftwareReport" "SoftwareReport.Android.psm1") -DisableNameChecking

Describe "Android SDK" {
    $androidToolset = (Get-ToolsetContent).android
    $androidInstalledPackages = Get-AndroidInstalledPackages

    $platformTestCases = @()
    $platformList = $androidToolset.platform_list
    $platformList | ForEach-Object {
        $platformTestCases += @{ platformVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $buildToolsTestCases = @()
    $buildToolsList = $androidToolset.build_tools
    $buildToolsList | ForEach-Object {
        $buildToolsTestCases += @{ buildToolsVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $extraPackagesTestCases = @()
    $extraPackagesList = $androidToolset.extra_list
    $extraPackagesList | ForEach-Object {
        $extraPackagesTestCases += @{ extraPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $addonsTestCases = @()
    $addonsList = $androidToolset.addon_list
    $addonsList | ForEach-Object {
        $addonsTestCases += @{ addonPackage = $_; installedPackages = $androidInstalledPackages }
    }

    It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
        "$installedPackages" | Should -Match "platforms;$platformVersion"
    }

    It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
        "$installedPackages" | Should -Match "build-tools;$buildToolsVersion"
    }

    It "Extra package <extraPackage> is installed" -TestCases $extraPackagesTestCases {
        "$installedPackages" | Should -Match "extras;$extraPackage"
    }

    It "Addon package <addonPackage> is installed" -TestCases $addonsTestCases {
        "$installedPackages" | Should -Match "add-ons;$addonPackage"
    }
}