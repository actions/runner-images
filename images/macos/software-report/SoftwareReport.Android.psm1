Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

function Split-TableRowByColumns {
    param(
        [string] $Row
    )
    return $Row.Split("|") | ForEach-Object { $_.trim() }
}

function Get-AndroidSDKRoot {
    return Join-Path $env:HOME "Library" "Android" "sdk"
}

function Get-AndroidSDKManagerPath {
    $androidSDKDir = Get-AndroidSDKRoot
    return Join-Path $androidSDKDir "cmdline-tools" "latest" "bin" "sdkmanager"
}

function Get-AndroidInstalledPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = Invoke-Expression "$androidSDKManagerPath --list_installed"
    return $androidSDKManagerList
}

function Get-AndroidPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidPackages = & $androidSDKManagerPath --list --verbose
    return $androidPackages
}

function Build-AndroidTable {
    Write-Host "Build-AndroidTable"
    $packageInfo = Get-AndroidInstalledPackages
    return @(
        @{
            "Package" = "Android Command Line Tools"
            "Version" = Get-AndroidCommandLineToolsVersion
        },
        @{
            "Package" = "Android Emulator"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Android Emulator"
        },
        @{
            "Package" = "Android SDK Build-tools"
            "Version" = Get-AndroidBuildToolVersions -PackageInfo $packageInfo
        },
        @{
            "Package" = "Android SDK Platforms"
            "Version" = Get-AndroidPlatformVersions -PackageInfo $packageInfo
        },       
        @{
            "Package" = "Android SDK Platform-Tools"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Android SDK Platform-Tools"
        },
        @{
            "Package" = "Android SDK Tools"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Android SDK Tools"
        },
        @{
            "Package" = "Android Support Repository"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Android Support Repository"
        },
        @{
            "Package" = "CMake"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "cmake"
        },
        @{
            "Package" = "Google APIs"
            "Version" = Get-AndroidGoogleAPIsVersions -PackageInfo $packageInfo
        },
        @{
            "Package" = "Google Play services"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Google Play services"
        },
        @{
            "Package" = "Google Repository"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Google Repository"
        },
        @{
            "Package" = "NDK"
            "Version" = Get-AndroidNDKVersions
        },
        @{
            "Package" = "SDK Patch Applier v4"
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "SDK Patch Applier v4"
        }
    ) | Where-Object { $_.Version } | ForEach-Object {
        [PSCustomObject] @{
            "Package Name" = $_.Package
            "Version" = $_.Version
        }
    }
}

function Build-AndroidEnvironmentTable {
    $androidVersions = Get-Item env:ANDROID_*

    $shoulddResolveLink = 'ANDROID_NDK', 'ANDROID_NDK_HOME', 'ANDROID_NDK_ROOT', 'ANDROID_NDK_LATEST_HOME'
    return $androidVersions | Sort-Object -Property Name | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = if ($shoulddResolveLink.Contains($_.Name )) { Get-PathWithLink($_.Value) } else { $_.Value }
        }
    }
}

function Get-AndroidPackageVersions {
    param (
        [Parameter(Mandatory)]
        [object] $PackageInfo,
        [Parameter(Mandatory)]
        [object] $MatchedString
    )

    $versions = $packageInfo | Where-Object { $_ -Match $MatchedString } | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        return $packageInfoParts[1]
    }
    return ($versions -Join "<br>")
}

function Get-AndroidPlatformVersions {
    param (
        [Parameter(Mandatory)]
        [object] $PackageInfo
    )

    $versions = $packageInfo | Where-Object { $_ -Match "Android SDK Platform " } | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $revision = $packageInfoParts[1]
        $version = $packageInfoParts[0].split(";")[1]
        return "$version (rev $revision)"
    }
    [array]::Reverse($versions)
    return ($versions -Join "<br>")
}

function Get-AndroidCommandLineToolsVersion {
    $commandLineTools = Get-AndroidSDKManagerPath
    (& $commandLineTools --version | Out-String).Trim() -match "(?<version>^(\d+\.){1,}\d+$)" | Out-Null
    $commandLineToolsVersion = $Matches.Version
    return $commandLineToolsVersion
}

function Get-AndroidBuildToolVersions {
    param (
        [Parameter(Mandatory)]
        [object] $PackageInfo
    )

    $versions = $packageInfo | Where-Object { $_ -Match "Android SDK Build-Tools" } | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        return $packageInfoParts[1]
    }
    $groupVersions = @()
    $versions | ForEach-Object {
        $majorVersion = $_.Split(".")[0]
        $groupVersions += $versions | Where-Object { $_.StartsWith($majorVersion) } | Join-String -Separator " "
    }
    return ($groupVersions | Sort-Object -Descending -Unique | Join-String -Separator "<br>")
}

function Get-AndroidGoogleAPIsVersions {
    param (
        [Parameter(Mandatory)]
        [object] $PackageInfo
    )

    $versions = $packageInfo | Where-Object { $_ -Match "Google APIs" } | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        return $packageInfoParts[0].split(";")[1]
    }
    return ($versions -Join "<br>")
}

function Get-AndroidNDKVersions {
    $ndkFolderPath = Join-Path (Get-AndroidSDKRoot) "ndk"
    $versions += Get-ChildItem -Path $ndkFolderPath -Name
    $ndkDefaultVersion = Get-ToolsetValue "android.ndk.default"
    $ndkDefaultFullVersion = Get-ChildItem "$env:ANDROID_HOME/ndk/$ndkDefaultVersion.*" -Name | Select-Object -Last 1

    return ($versions | ForEach-Object {
        $defaultPostfix = ( $_ -eq $ndkDefaultFullVersion ) ? " (default)" : ""
        $_ + $defaultPostfix
    } | Join-String -Separator "<br>")
}

function Get-IntelHaxmVersion {
    kextstat | Where-Object { $_ -match "com.intel.kext.intelhaxm \((?<version>(\d+\.){1,}\d+)\)" } | Out-Null
    return [PSCustomObject] @{
        "Package Name" = "Intel HAXM"
        "Version" = $Matches.Version
    }
}