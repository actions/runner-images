function Get-JavaVersions {
    $defaultJavaPath = (Get-Item env:JAVA_HOME).value
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        # Take semver from the java path
        $version = $javaPath.split('/')[5]
        $fullVersion = $version.Replace('-', '+')
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""
        $vendorName = ($javaPath -like '*Java_Adopt_jdk*') ? "Adopt OpenJDK" :  "Eclipse Temurin"

        [PSCustomObject] @{
            "Version" = $fullVersion + $defaultPostfix
            "Vendor" = $vendorName
            "Environment Variable" = $_.Name
        }
    }
}