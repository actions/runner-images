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
        $version = (Split-Path $javaPath) -replace "\w:\\.*\\"
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = "AdoptOpenJDK"
            "Environment Variable" = $_.Name
        }
    }
}