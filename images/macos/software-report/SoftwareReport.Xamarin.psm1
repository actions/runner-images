Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

function Build-VSMacTable {
    $vsMacVersions = Get-ToolsetValue "xamarin.vsmac.versions"
    $defaultVSMacVersion = Get-ToolsetValue "xamarin.vsmac.default"

    return $vsMacVersions | ForEach-Object {
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
}

function Get-NUnitVersion {
    $version = Run-Command "nunit3-console --version" | Select-Object -First 1 | Take-Part -Part 3
    return $version
}

function Build-XamarinTable {
    $xamarinBundles = Get-ToolsetValue "xamarin.bundles"
    $defaultSymlink = Get-ToolsetValue "xamarin.bundle-default"
    if ($defaultSymlink -eq "latest") {
        $defaultSymlink = $xamarinBundles[0].symlink
    }

    return $xamarinBundles | ForEach-Object {
        $defaultPostfix = ($_.symlink -eq $defaultSymlink ) ? " (default)" : ""
        [PSCustomObject] @{
            "symlink" = $_.symlink + $defaultPostfix 
            "Xamarin.Mono" = $_.mono
            "Xamarin.iOS" = $_.ios
            "Xamarin.Mac" = $_.mac
            "Xamarin.Android" = $_.android
        }
    }
}
