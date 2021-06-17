function Get-JavaVersions {
    $defaultJavaPath = $env:JAVA_HOME
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        # Take semver from the java path
        # The path contains '-' sign in the version number instead of '+' due to the following issue, need to substitute it back https://github.com/actions/virtual-environments/issues/3014
        $versionInPath = (Split-Path $javaPath) -replace "\w:\\.*\\"
        $version = $versionInPath -replace '-', '+'
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = "Adopt OpenJDK"
            "Environment Variable" = $_.Name
        }
    }
}