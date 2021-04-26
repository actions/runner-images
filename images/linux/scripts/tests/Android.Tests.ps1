Describe "Android" {
    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
    [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"
    [string]$ndkLTSVersion = Get-ToolsetValue "android.ndk.lts"
    $ndkLTSFullVersion = (Get-ChildItem "/usr/local/lib/android/sdk/ndk/$ndkLTSVersion.*" | Select-Object -Last 1).Name

    $platformVersionsList = ($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;android-', ''
    $platformNumericList = $platformVersionsList | Where-Object { $_ -match "\d+" } | Where-Object { [int]$_ -ge $platformMinVersion } | Sort-Object -Unique
    $platformLetterList = $platformVersionsList | Where-Object { $_ -match "\D+" } | Sort-Object -Unique
    $platforms = $platformNumericList + $platformLetterList | ForEach-Object { "platforms/android-${_}" }

    $buildToolsList = ($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', ''
    $buildTools = $buildToolsList | Where-Object { $_ -match "\d+(\.\d+){2,}$"} | Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object -Unique |
    ForEach-Object { "build-tools/${_}" }

    $androidPackages = @(
        $platforms,
        $buildTools,
        (Get-ToolsetValue "android.extra_list" | ForEach-Object { "extras/${_}" }),
        (Get-ToolsetValue "android.addon_list" | ForEach-Object { "add-ons/${_}" }),
        (Get-ToolsetValue "android.additional_tools" | ForEach-Object { "${_}" }),
        "ndk/$ndkLTSFullVersion"
    )

    [string]$ndkLatestVersion = Get-ToolsetValue "android.ndk.latest"
    if ($ndkLatestVersion) {
        $ndkLatestFullVersion = (Get-ChildItem "/usr/local/lib/android/sdk/ndk/$ndkLatestVersion.*" | Select-Object -Last 1).Name
        $androidPackages += @("ndk/$ndkLatestFullVersion")
    }

    $androidPackages = $androidPackages | ForEach-Object { $_ }

    BeforeAll {
        $ANDROID_SDK_DIR = "/usr/local/lib/android/sdk"

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
            $targetPath = Join-Path $ANDROID_SDK_DIR $PackageName
            $targetPath | Should -Exist
        }
    }

    Context "Packages" {
        $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }

        It "<PackageName>" -TestCases $testCases {
            param ([string] $PackageName)
            Validate-AndroidPackage $PackageName
        }
    }
}