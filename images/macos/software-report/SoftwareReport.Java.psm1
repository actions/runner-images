function Get-JavaVersions {
    $defaultJavaPath = Get-Item env:JAVA_HOME
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        # Take semver from the java path
        $javaPath -match "$env:AGENT_TOOLSDIRECTORY/Java_Adoptium_jdk/(?<version>.*)/x64/Contents/Home" | Out-Null
        $version = $Matches.version
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $version + $defaultPostfix
            "Vendor" = "Adopt OpenJDK"
            "Environment Variable" = $_.Name
        }
    }
}