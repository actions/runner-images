function Get-JavaVersions {
    param (
        [ArchiveItems] $Archive
    )

    $defaultJavaPath = (Get-Item env:JAVA_HOME).value
    $javaVersions = Get-Item env:JAVA_HOME_*_X64
    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }  
        Descending = $false
    }

    $output = $javaVersions | Sort-Object $sortRules | ForEach-Object {
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

    $output | ForEach-Object { $Archive.Add("$($_.Version)|$($_.Vendor)|$($_."Environment Variable")", "Java_$($_."Environment Variable")") } | Out-Null

    return $output
}