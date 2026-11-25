function ConvertFrom-JavaFullVersion {
    param (
        [Parameter(Mandatory)]
        [string] $Output
    )

    if ($Output -notmatch '^openjdk full version "([0-9][0-9A-Za-z._+-]*)"$') {
        throw "Unable to parse Java full version: $Output"
    }

    $version = $Matches[1] -replace '-LTS$', ''
    if ($version -match '^1\.8\.0_(\d+)-b(\d+)$') {
        return "8.0.$($Matches[1])+$([int]$Matches[2])"
    }
    return $version
}

function Get-InstalledJavaVersion {
    param (
        [Parameter(Mandatory)]
        [string] $JavaHome
    )

    $isWindows = [Environment]::OSVersion.Platform -eq [PlatformID]::Win32NT
    $java = Join-Path $JavaHome "bin/java"
    if ($isWindows) {
        $java += ".exe"
    }
    if (-not (Test-Path $java -PathType Leaf)) {
        throw "Java executable not found: $java"
    }

    if ($isWindows) {
        $output = & $env:comspec /c "`"$java`" -fullversion 2>&1"
    } else {
        $output = & $java -fullversion 2>&1
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to get Java version from ${java}: $output (exit code $LASTEXITCODE)"
    }
    return ConvertFrom-JavaFullVersion -Output "$output"
}
