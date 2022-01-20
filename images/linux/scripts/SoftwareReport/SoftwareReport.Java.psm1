function Get-JavaVersions {
    $javaToolcacheVersions = Get-ChildItem $env:AGENT_TOOLSDIRECTORY/Java*/* -Directory | Sort-Object { [int]$_.Name.Split(".")[0] }

    $existingVersions = $javaToolcacheVersions | ForEach-Object {
        $majorVersion = $_.Name.split(".")[0]
        $fullVersion = $_.Name.Replace("-", "+")
        $defaultJavaPath = $env:JAVA_HOME
        $javaPath = Get-Item env:JAVA_HOME_${majorVersion}_X64

        $defaultPostfix = ($javaPath.Value -eq $defaultJavaPath) ? " (default)" : ""
        $vendorName = ($_.FullName -like '*Java_Adopt_jdk*') ? "Adopt OpenJDK" :  "Eclipse Temurin"

        [PSCustomObject] @{
            "Version" = $fullVersion + $defaultPostfix
            "Vendor" = $vendorName
            "Environment Variable" = $javaPath.Name
        }
    }
    # Return all the vendors which are not Adopt, also look for version 12 of Adopt (Eclipse Temurin does not have this version)
    $versionsToReturn = $existingVersions | Where-Object {$_.Vendor -notlike "Adopt*" -or $_.Version.Split(".")[0] -eq 12}
    return $versionsToReturn
}
