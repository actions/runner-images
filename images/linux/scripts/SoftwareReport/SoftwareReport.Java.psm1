function Get-JavaVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Java_Adopt_jdk"
    $javaToolcacheVersions = Get-ChildItem $toolcachePath -Name | Sort-Object { [int]$_.Split(".")[0] }

    return $javaToolcacheVersions | ForEach-Object {
        $majorVersion = $_.split(".")[0]
        $fullVersion = $_.Replace("-", "+")
        $defaultJavaPath = $env:JAVA_HOME
        $javaPath = Get-Item env:JAVA_HOME_${majorVersion}_X64

        $defaultPostfix = ($javaPath.Value -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $fullVersion + $defaultPostfix
            "Vendor" = "Adopt OpenJDK"
            "Environment Variable" = $javaPath.Name
        }
    }
}