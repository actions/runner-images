Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Helpers.psm1") -DisableNameChecking

function Split-TableRowByColumns {
    param(
        [string] $Row
    )
    return $Row.Split("|") | ForEach-Object { $_.trim() }
}

function Get-AndroidSDKRoot {
    param(
        [string] $ComponentName
    )
    $path = Join-Path $env:ANDROID_HOME $ComponentName
    return "Location $path"
}

function Get-AndroidSDKManagerPath {
    return Join-Path $env:ANDROID_HOME "cmdline-tools\latest\bin\sdkmanager.bat"
}

function Get-AndroidInstalledPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = cmd /c "$androidSDKManagerPath --list_installed 2>&1"
    $androidSDKManagerList = $androidSDKManagerList -notmatch "Warning"
    return $androidSDKManagerList
}

function Build-AndroidTable {
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
            "Version" = Get-AndroidNdkVersions -PackageInfo $packageInfo
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
    (cmd /c "$commandLineTools --version 2>NUL" | Out-String).Trim() -match "(?<version>^(\d+\.){1,}\d+$)" | Out-Null
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

    $versions = $packageInfo | Where-Object { $_ -Match "addon-google_apis" } | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        return $packageInfoParts[0].split(";")[1]
    }
    return ($versions -Join "<br>")
}

function Get-AndroidNdkVersions {
    param (
        [Parameter(Mandatory)]
        [object] $PackageInfo
    )

    $ndkDefaultFullVersion = Get-ChildItem $env:ANDROID_NDK_HOME -Name

    $versions = $packageInfo | Where-Object { $_ -Match "ndk;" } | ForEach-Object {
        $version = (Split-TableRowByColumns $_)[1]
        if ($version -eq $ndkDefaultFullVersion) {
            $version += " (default)"
        }
        $version
    }
    return ($versions -Join "<br>")
}

function Build-AndroidEnvironmentTable {
    $androidVersions = Get-Item env:ANDROID_*

    $shoulddResolveLink = 'ANDROID_NDK', 'ANDROID_NDK_HOME', 'ANDROID_NDK_ROOT', 'ANDROID_NDK_LATEST_HOME'
    return $androidVersions | Sort-Object -Property Name | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = if ($shoulddResolveLink.Contains($_.Name )) { Get-PathWithLink($_.Value) } else {$_.Value}
        }
    }
}
