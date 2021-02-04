Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1" -DisableNameChecking

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
    return Join-Path $androidSDKDir "tools" "bin" "sdkmanager"
}

function Get-AndroidInstalledPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = Invoke-Expression "$androidSDKManagerPath --list --include_obsolete"
    $androidInstalledPackages = @()
    foreach($packageInfo in $androidSDKManagerList) {
        if($packageInfo -Match "Available Packages:") {
            break
        }

        $androidInstalledPackages += $packageInfo
    }
    return $androidInstalledPackages
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
            "Version" = Get-AndroidPackageVersions -PackageInfo $packageInfo -MatchedString "Android SDK Command-line Tools"
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
    Write-Host "Build-AndroidEnvironmentTable"
    $androidVersions = Get-Item env:ANDROID_*	

    return $androidVersions | ForEach-Object {	
        [PSCustomObject] @{	
            "Name" = $_.Name	
            "Value" = Get-PathWithLink($_.Value)
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
    $os = Get-OSVersion

    if ($os.IsLessThanBigSur) {
        # Hardcode NDK 15 as a separate case since it is installed manually without sdk-manager (to none default location)
        $versions = @()
        $versions += "15.2.4203891"
    }

    $ndkFolderPath = Join-Path (Get-AndroidSDKRoot) "ndk"
    $versions += Get-ChildItem -Path $ndkFolderPath -Name

    return ($versions -Join "<br>")
}
