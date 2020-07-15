Import-Module (Join-Path $PSScriptRoot "..\SoftwareReport\SoftwareReport.Android.psm1") -DisableNameChecking

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

    It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
        "$installedPackages" | Should -Match "platforms;$platformVersion"
    }

    It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
        "$installedPackages" | Should -Match "build-tools;$buildToolsVersion"
    }
}