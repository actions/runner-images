Describe "Android" {
    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
    [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"
    [string]$ndkDefaultVersion = Get-ToolsetValue "android.ndk.default"
    [array]$ndkVersions = Get-ToolsetValue "android.ndk.versions"
    $ndkDefaultFullVersion = Get-ChildItem "$env:ANDROID_HOME/ndk/$ndkDefaultVersion.*" -Name | Select-Object -Last 1
    $ndkFullVersions = $ndkVersions | ForEach-Object { (Get-ChildItem "/usr/local/lib/android/sdk/ndk/${_}.*" | Select-Object -Last 1).Name } | ForEach-Object { "ndk/${_}" }
    # Platforms starting with a letter are the preview versions, which is not installed on the image
    $platformVersionsList = ($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;android-', '' | Where-Object { $_ -match "^\d+$" } | Sort-Object -Unique
    $platformsInstalled = $platformVersionsList | Where-Object { [int]$_ -ge $platformMinVersion } | ForEach-Object { "platforms/android-${_}" }

    $buildToolsList = ($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', ''
    $buildTools = $buildToolsList | Where-Object { $_ -match "\d+(\.\d+){2,}$"} | Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object -Unique |
    ForEach-Object { "build-tools/${_}" }

    $androidPackages = @(
        $platformsInstalled,
        $buildTools,
        $ndkFullVersions,
        (Get-ToolsetValue "android.extra_list" | ForEach-Object { "extras/${_}" }),
        (Get-ToolsetValue "android.addon_list" | ForEach-Object { "add-ons/${_}" }),
        (Get-ToolsetValue "android.additional_tools" | ForEach-Object { "${_}" })
    )

    $androidPackages = $androidPackages | ForEach-Object { $_ }

    BeforeAll {
        function Validate-AndroidPackage {
            param (
                [Parameter(Mandatory=$true)]
                [string]$PackageName
            )

            # Convert 'm2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1' ->
            #         'm2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta1'
            #         'cmake;3.6.4111459' -> 'cmake/3.6.4111459'
            #         'patcher;v4' -> 'patcher/v4'
            $PackageName = $PackageName.Replace(";", "/")
            $targetPath = Join-Path $env:ANDROID_HOME $PackageName
            $targetPath | Should -Exist
        }
    }

    Context "SDKManagers" {
        $testCases = @(
            @{
                PackageName = "SDK tools"
                Sdkmanager = "$env:ANDROID_HOME/tools/bin/sdkmanager"
            },
            @{
                PackageName = "Command-line tools"
                Sdkmanager = "$env:ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
            }
        )

        It "Sdkmanager from <PackageName> is available" -TestCases $testCases {
            "$Sdkmanager --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Packages" {
        $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }
        $defaultNdkTestCase = @{ NdkDefaultFullVersion = $ndkDefaultFullVersion }

        It "<PackageName>" -TestCases $testCases {
            param ([string] $PackageName)
            Validate-AndroidPackage $PackageName
        }

        It "ndk-bundle points to the default NDK version" -TestCases $defaultNdkTestCase {
            $ndkLinkTarget = (Get-Item $env:ANDROID_NDK_HOME).Target
            $ndkVersion = Split-Path -Path $ndkLinkTarget -Leaf
            $ndkVersion | Should -BeExactly $NdkDefaultFullVersion
        }
    }
}