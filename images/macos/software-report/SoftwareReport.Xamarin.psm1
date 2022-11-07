using module ./../helpers/SoftwareReport.Helpers.psm1

Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

function Build-VSMacTable {
    param (
        [ArchiveItems] $Archive
    )

    $vsMacVersions = Get-ToolsetValue "xamarin.vsmac.versions"
    $defaultVSMacVersion = Get-ToolsetValue "xamarin.vsmac.default"

    $output = $vsMacVersions | ForEach-Object {
        $isDefault = $_ -eq $defaultVSMacVersion
        $vsPath = "/Applications/Visual Studio $_.app"
        if ($isDefault) {
            $vsPath = "/Applications/Visual Studio.app"
        }

        $plistPath = "$vsPath/Contents/Info.plist"
        $build = Run-Command "/usr/libexec/PlistBuddy -c 'Print CFBundleVersion' '$plistPath'"
        $defaultPostfix = $isDefault ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $_ + $defaultPostfix
            "Build" = $build
            "Path" = $vsPath
        }
    }

    $output | ForEach-Object { $Archive.Add("$($_.Version)|$($_.Build)|$($_.Path)", "VisualStudioForMac_$($_.Version)") } | Out-Null

    return $output
}

function Get-NUnitVersion {
    $version = Run-Command "nunit3-console --version" | Select-Object -First 1 | Take-Part -Part 3
    return "NUnit ${version}"
}

function Build-XamarinTable {
    param (
        [ArchiveItems] $Archive
    )

    $xamarinBundles = Get-ToolsetValue "xamarin.bundles"
    $defaultSymlink = Get-ToolsetValue "xamarin.bundle-default"
    if ($defaultSymlink -eq "latest") {
        $defaultSymlink = $xamarinBundles[0].symlink
    }

    $output = $xamarinBundles | ForEach-Object {
        $defaultPostfix = ($_.symlink -eq $defaultSymlink ) ? " (default)" : ""
        [PSCustomObject] @{
            "symlink" = $_.symlink + $defaultPostfix 
            "Xamarin.Mono" = $_.mono
            "Xamarin.iOS" = $_.ios
            "Xamarin.Mac" = $_.mac
            "Xamarin.Android" = $_.android
        }
    }

    $output | ForEach-Object {
        $id = $_.symlink
        $title = "$($_.symlink)|Mono: $($_."Xamarin.Mono")|iOS: $($_."Xamarin.iOS")|Mac: $($_."Xamarin.Mac")|Android: $($_."Xamarin.Android")"
        if ($id -match '^\d{1,2}_\d{1,2}_\d{1,2}') {
            $id = $matches[0]
        }
        $Archive.Add($title, "XamarinBundle_$id") | Out-Null
    } | Out-Null

    return $output
}
