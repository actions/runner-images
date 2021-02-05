Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../software-report/SoftwareReport.Android.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Android" {
    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = Get-ToolsetValue "android.platform_min_version"
    [version]$buildToolsMinVersion = Get-ToolsetValue "android.build_tools_min_version"
    [string]$ndkLatestVersion = Get-ToolsetValue "android.ndk.latest"
    [string]$ndkLtsVersion = Get-ToolsetValue "android.ndk.lts"
    $ndkLatestFullVersion = (Get-ChildItem "$env:ANDROID_HOME/ndk/$ndkLatestVersion.*" | Select-Object -Last 1).Name
    $ndkLtsFullVersion = (Get-ChildItem "$env:ANDROID_HOME/ndk/$ndkLtsVersion.*" | Select-Object -Last 1).Name

    $platforms = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;', '' |
    Where-Object { [int]$_.Split("-")[1] -ge $platformMinVersion } | Sort-Object { [int]$_.Split("-")[1] } -Unique |
    ForEach-Object { "platforms/${_}" })

    $buildTools = (($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', '' |
    Where-Object { [version]$_ -ge $buildToolsMinVersion } | Sort-Object { [version]$_ } -Unique |
    ForEach-Object { "build-tools/${_}" })

    $androidPackages = @(
        "tools",
        "platform-tools",
        "tools/proguard",
        "ndk-bundle",
        "cmake",
        "ndk/$ndkLatestFullVersion",
        "ndk/$ndkLtsFullVersion",
        $platforms,
        $buildTools,
        (Get-ToolsetValue "android.extra-list" | ForEach-Object { "extras/${_}" }),
        (Get-ToolsetValue "android.addon-list" | ForEach-Object { "add-ons/${_}" }),
        (Get-ToolsetValue "android.additional-tools")
    ) | ForEach-Object { $_ }

    # Remove empty strings from array to avoid possible issues
    $androidPackages = $androidPackages | Where-Object {$_}

    BeforeAll {
        $ANDROID_SDK_DIR = Join-Path $env:HOME "Library" "Android" "sdk"

        function Validate-AndroidPackage {
            param (
                [Parameter(Mandatory=$true)]
                [string]$PackageName
            )

            # Convert 'm2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1' ->
            #         'm2repository/com/android/support/constraint/constraint-layout-solver/1.0.0-beta1'
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

    It "HAXM is installed" {
        $haxmPath = Join-Path $ANDROID_SDK_DIR "extras" "intel" "Hardware_Accelerated_Execution_Manager" "silent_install.sh"
        "$haxmPath -v" | Should -ReturnZeroExitCode
    }
}