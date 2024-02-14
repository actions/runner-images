Describe "Android SDK" {
    $androidToolset = (Get-ToolsetContent).android
    $androidInstalledPackages = Get-AndroidInstalledPackages

    $platformList = Get-AndroidPlatformPackages -minVersion $androidToolset.platform_min_version
    $platformTestCases = $platformList | ForEach-Object {
        @{ platformVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $buildToolsList = Get-AndroidBuildToolPackages -minVersion $androidToolset.build_tools_min_version
    $buildToolsTestCases = $buildToolsList | ForEach-Object {
        @{ buildToolsVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $extraPackagesTestCases = $androidToolset.extra_list | ForEach-Object {
        @{ extraPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $addonsTestCases = $androidToolset.addon_list | ForEach-Object {
        @{ addonPackage = $_; installedPackages = $androidInstalledPackages }
    }

    $additionalToolsTestCases = $androidToolset.additional_tools | ForEach-Object {
        @{ additionalToolVersion = $_; installedPackages = $androidInstalledPackages }
    }

    $ndkPackagesTestCases = $androidToolset.ndk.versions | ForEach-Object {
        @{ ndkPackage = $_; installedPackages = $androidInstalledPackages }
    }

    Context "SDKManagers" {
        $testCases = @(
            @{
                PackageName = "Command-line tools"
                Sdkmanager = "$env:ANDROID_HOME\cmdline-tools\latest\bin\sdkmanager.bat"
            }
        )

        It "Sdkmanager from <PackageName> is available" -TestCases $testCases {
            "$Sdkmanager --list" | Should -ReturnZeroExitCode
        }
    }

    Context "Packages" {
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

        It "NDK <ndkPackage> is installed" -TestCases $ndkPackagesTestCases {
            "$installedPackages" | Should -Match "ndk;$ndkPackage"
        }
    }
}
