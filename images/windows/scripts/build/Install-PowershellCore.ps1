################################################################################
##  File:  Install-PowershellCore.ps1
##  Desc:  Install PowerShell Core
##  Supply chain security: checksum validation
################################################################################

$ErrorActionPreference = "Stop"

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tempDir -Force -ErrorAction SilentlyContinue | Out-Null
try {
    $originalValue = [Net.ServicePointManager]::SecurityProtocol
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $metadata = Invoke-RestMethod https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json
    $pwshMajorMinor = (Get-ToolsetContent).pwsh.version

    $releases = $metadata.LTSReleaseTag -replace '^v'
    foreach ($release in $releases) {
        if ($release -like "${pwshMajorMinor}*") {
            $downloadUrl = "https://github.com/PowerShell/PowerShell/releases/download/v${release}/PowerShell-${release}-win-x64.msi"
            break
        }
    }

    $installerName = Split-Path $downloadUrl -Leaf
    $externalHash = Get-ChecksumFromUrl -Type "SHA256" `
        -Url ($downloadUrl -replace $installerName, "hashes.sha256") `
        -FileName $installerName
    Install-Binary -Url $downloadUrl -ExpectedSHA256Sum $externalHash
} finally {
    # Restore original value
    [Net.ServicePointManager]::SecurityProtocol = $originalValue
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# about_update_notifications
# While the update check happens during the first session in a given 24-hour period, for performance reasons,
# the notification will only be shown on the start of subsequent sessions.
# Also for performance reasons, the check will not start until at least 3 seconds after the session begins.
[Environment]::SetEnvironmentVariable("POWERSHELL_UPDATECHECK", "Off", "Machine")

Invoke-PesterTests -TestFile "Tools" -TestName "PowerShell Core"
