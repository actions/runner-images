function Get-JavaVersions {
    param (
        [ArchiveItems] $Archive
    )

    $defaultJavaPath = $env:JAVA_HOME
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    $output = $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        # Take semver from the java path
        # The path contains '-' sign in the version number instead of '+' due to the following issue, need to substitute it back https://github.com/actions/runner-images/issues/3014
        $versionInPath = (Split-Path $javaPath) -replace "\w:\\.*\\"
        $version = $versionInPath -replace '-', '+'
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""
        $VendorName = ($javaPath -like '*Java_Adopt_jdk*') ? "Adopt OpenJDK" :  "Eclipse Temurin"

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = $VendorName
            "Environment Variable" = $_.Name
        }
    }

    $output | ForEach-Object { $Archive.Add("$($_.Version)|$($_.Vendor)|$($_."Environment Variable")", "Java_$($_."Environment Variable")") } | Out-Null

    return $output
}