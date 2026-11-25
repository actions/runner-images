Import-Module "$PSScriptRoot/software-report-base/JavaVersion.psm1" -DisableNameChecking

function Get-JavaVersions {
    $defaultJavaPath = (Get-Item env:JAVA_HOME).value

    $os = Get-OSVersion
    if ($os.IsArm64) {
        $javaVersions = Get-Item env:JAVA_HOME_*_arm64
    } else {
        $javaVersions = Get-Item env:JAVA_HOME_*_X64
    }

    $sortRules = @{
        Expression = { [Int32]$_.Name.Split("_")[2] }
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        $fullVersion = Get-InstalledJavaVersion -JavaHome $javaPath
        $defaultPostfix = ($javaPath -eq $defaultJavaPath) ? " (default)" : ""

        [PSCustomObject] @{
            "Version"              = $fullVersion + $defaultPostfix
            "Environment Variable" = $_.Name
        }
    }
}
