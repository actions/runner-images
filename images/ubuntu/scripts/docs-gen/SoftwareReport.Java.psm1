Import-Module "$PSScriptRoot/software-report-base/JavaVersion.psm1" -DisableNameChecking

function Get-JavaVersionsTable {
    $javaToolcacheVersions = Get-ChildItem $env:AGENT_TOOLSDIRECTORY/Java*/* -Directory | Sort-Object { [int] $_.Name.Split(".")[0] }

    return $javaToolcacheVersions | ForEach-Object {
        $majorVersion = $_.Name.split(".")[0]
        $defaultJavaPath = $env:JAVA_HOME
        $javaPath = Get-Item env:JAVA_HOME_${majorVersion}_X64
        $fullVersion = Get-InstalledJavaVersion -JavaHome $javaPath.Value

        $defaultPostfix = ($javaPath.Value -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version"              = $fullVersion + $defaultPostfix
            "Environment Variable" = $javaPath.Name
        }
    }
}
