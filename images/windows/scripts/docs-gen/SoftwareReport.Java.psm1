Import-Module "$PSScriptRoot/software-report-base/JavaVersion.psm1" -DisableNameChecking

function Get-JavaVersions {
    $defaultJavaPath = $env:JAVA_HOME
    if (Test-IsArm64) {
        $javaVersions = Get-Item env:JAVA_HOME_*_AARCH64
    } else {
        $javaVersions = Get-Item env:JAVA_HOME_*_X64
    }
    $sortRules = @{
        Expression = { [Int32] $_.Name.Split("_")[2] }  
        Descending = $false
    }

    return $javaVersions | Sort-Object $sortRules | ForEach-Object {
        $javaPath = $_.Value
        $version = Get-InstalledJavaVersion -JavaHome $javaPath
        $defaultPostfix = if ($javaPath -eq $defaultJavaPath) { " (default)" } else { "" }

        [PSCustomObject] @{
            "Version"              = $version + $defaultPostfix
            "Environment Variable" = $_.Name
        }
    }
}
