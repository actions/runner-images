Import-Module (Join-Path "..\SoftwareReport" "SoftwareReport.Android.psm1") -DisableNameChecking

Describe "Android SDK" {
    $android = (Get-ToolsetContent).android
    $androidInstalledPackages = Get-AndroidInstalledPackages

    $platformTestCases = @()
    $platformList = $android.platform_list
    $platformList | ForEach-Object {
        $platformTestCases += @{ platformVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $buildToolsTestCases = @()
    $buildToolsList = $android.build_tools
    $buildToolsList | ForEach-Object {
        $buildToolsTestCases += @{ buildToolsVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $extraPackagesTestCases = @()
    $extraPackagesList = $android.extra_list
    $extraPackagesList | ForEach-Object {
        $extraPackagesTestCases += @{ extraPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $addonsTestCases = @()
    $addonsList = $android.addon_list
    $addonsList | ForEach-Object {
        $addonsTestCases += @{ addonPackage = $_; installedPackages = $androidInstalledPackages }
    }

    It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
        $regex = "platforms;$platformVersion"
        [boolean]($installedPackages | Where-Object { $_ -match $regex }) | Should -BeTrue
    }

    It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
        $regex = "build-tools;$buildToolsVersion"
        [boolean]($installedPackages | Where-Object { $_ -match $regex }) | Should -BeTrue
    }

    It "Extra package <extraPackage> is installed" -TestCases $extraPackagesTestCases {
        $regex = "extras;$extraPackage"
        [boolean]($installedPackages | Where-Object { $_ -match $regex }) | Should -BeTrue
    }

    It "Addon package <addonPackage> is installed" -TestCases $addonsTestCases {
        $regex = "add-ons;$addonPackage"
        [boolean]($installedPackages | Where-Object { $_ -match $regex }) | Should -BeTrue
    }
}