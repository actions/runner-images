function Get-AndroidComponentLocation {
    param(
        [string] $ComponentName
    )
    $path = Join-Path $env:ANDROID_HOME $ComponentName
    return "Location $path"
}

function Split-TableRowByColumns {
    param(
        [string] $Row
    )
    return $Row.Split("|") | ForEach-Object { $_.trim() }
}

function Create-AndroidTableObject {
    param(
        [string] $PackageName,
        [string] $Description
    )
    return [PSCustomObject] @{
        "Package Name" = $PackageName
        "Description" = $Description
    }
}

function Get-AndroidSDKManagerPath {
    return Join-Path $env:ANDROID_HOME "tools" "bin" "sdkmanager.bat"
}

function Get-AndroidInstalledPackages {
    $androidSDKManagerPath = Get-AndroidSDKManagerPath
    $androidSDKManagerList = & $androidSDKManagerPath --list --include_obsolete
    $androidInstalledPackages = @()
    foreach($packageInfo in $androidSDKManagerList) {
        if($packageInfo -Match "Available Packages:") {
            break
        }

        $androidInstalledPackages += $packageInfo
    }
    return $androidInstalledPackages
}

function Build-AndroidSDKToolsTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )
    
    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0]
        $packageDescription = $packageInfoParts[2] + ", Revision " + $packageInfoParts[1]
        return Create-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidSDKPlatformTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )

    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0].split(";")[1]
        $packageDescription = $packageInfoParts[2] + ", Revision " + $packageInfoParts[1]
        return Create-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidSDKBuildToolsTable {
    param (
        [Parameter(Mandatory)]
        [object] $packageInfo
    )

    return $packageInfo | ForEach-Object {
        $packageInfoParts = Split-TableRowByColumns $_
        $packageName = $packageInfoParts[0].replace(";", "-")
        $packageDescription = "Android SDK Build-Tools, Revision " + $packageInfoParts[1]
        return Create-AndroidTableObject -PackageName $packageName -Description $packageDescription
    }
}

function Build-AndroidExtraPackagesTable {
    param (
        [Parameter(Mandatory)][AllowEmptyString()]
        [string[]] $installedPackages
    )

    $extraPackages = @(
        "Android Support Repository",
        "Google Play services",
        "Google Repository"
    )

    return $extraPackages | ForEach-Object {
        $packageId = $_
        $packageInfo = $installedPackages | Where-Object { $_ -Like "*${packageId}*" } | Select-Object -First 1
        $packageInfoParts = Split-TableRowByColumns $packageInfo
        return [PSCustomObject] @{
            "Package Name" = $packageInfoParts[2]
            "Version" = $packageInfoParts[1]
        }
    }
}