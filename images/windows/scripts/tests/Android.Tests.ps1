Describe "Android SDK" -Skip:(Test-IsArm64) {
    BeforeDiscovery {
        if (Test-IsArm64) {
            return
        }

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

    # The Android CLI ships with command-line tools 22.0 and later, the first revision that also writes
    # valid AVD targets for Major.Minor packages; windows-2022 stays behind because 22.0 requires Java 17
    Context "Command-line tools" -Skip:(Test-IsWin22) {
        It "Android CLI is available" {
            "$env:ANDROID_HOME\cmdline-tools\latest\bin\android.exe" | Should -Exist
        }
    }

    Context "Packages" {
        if (-not (Test-IsArm64)) {
            It "Platform version <platformVersion> is installed" -TestCases $platformTestCases {
                "$installedPackages" | Should -Match "$platformVersion"
            }

            It "Platform build tools <buildToolsVersion> is installed" -TestCases $buildToolsTestCases {
                "$installedPackages" | Should -Match "$buildToolsVersion"
            }

            It "Additional tool <additionalToolVersion> is installed" -TestCases $additionalToolsTestCases {
                "$installedPackages" | Should -Match $additionalToolVersion
            }

            It "NDK <ndkPackage> is installed" -TestCases $ndkPackagesTestCases {
                "$installedPackages" | Should -Match "ndk;$ndkPackage"
            }
        }
    }
}
