################################################################################
##  File:  Install-PowershellCore.ps1
##  Desc:  Install PowerShell Core
################################################################################

$ErrorActionPreference = "Stop"

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
$null = New-Item -ItemType Directory -Path $tempDir -Force -ErrorAction SilentlyContinue
try {
    $originalValue = [Net.ServicePointManager]::SecurityProtocol
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $metadata = Invoke-RestMethod https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json
    $release = $metadata.LTSReleaseTag[0] -replace '^v'
    $packageName = "PowerShell-${release}-win-x64.msi"

    $downloadURL = "https://github.com/PowerShell/PowerShell/releases/download/v${release}/${packageName}"
    Write-Verbose "About to download package from '$downloadURL'" -Verbose

    $packagePath = Join-Path -Path $tempDir -ChildPath $packageName
    Invoke-WebRequest -Uri $downloadURL -OutFile $packagePath

    Write-Verbose "Performing quiet install"
    $ArgumentList=@("/i", $packagePath, "/quiet")
    $process = Start-Process msiexec -ArgumentList $ArgumentList -Wait -PassThru
    if ($process.exitcode -ne 0) {
        throw "Quiet install failed, please rerun install without -Quiet switch or ensure you have administrator rights"
    }
} finally {
    # Restore original value
    [Net.ServicePointManager]::SecurityProtocol = $originalValue
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
}

# about_update_notifications
# While the update check happens during the first session in a given 24-hour period, for performance reasons,
# the notification will only be shown on the start of subsequent sessions.
# Also for performance reasons, the check will not start until at least 3 seconds after the session begins.
[System.Environment]::SetEnvironmentVariable("POWERSHELL_UPDATECHECK", "Off", [System.EnvironmentVariableTarget]::Machine)

Invoke-PesterTests -TestFile "Tools" -TestName "PowerShell Core"
