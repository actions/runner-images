function Get-JavaVersions {
    $toolcachePath = Join-Path $env:AGENT_TOOLSDIRECTORY "Java_Adopt_jdk"
    $javaToolcacheVersions = Get-ChildItem $toolcachePath -Name | Sort-Object -Descending

    return $javaToolcacheVersions | ForEach-Object {
        $majorVersion = $_.split(".")[0]
        $defaultJavaPath = $env:JAVA_HOME
        $javaPath = Get-Item env:JAVA_HOME_${majorVersion}_X64
        
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version" = $_ + $defaultPostfix
            "Vendor" = "Adopt OpenJDK"
            "Environment Variable" = $javaPath.Name
        }
    }
}