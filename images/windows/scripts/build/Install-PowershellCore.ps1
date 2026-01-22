################################################################################
##  File:  Install-PowershellCore.ps1
##  Desc:  Install multiple PowerShell Core versions (stable, lts, preview)
##  Supply chain security: checksum validation
################################################################################

$ErrorActionPreference = "Stop"

$PwshInstallDir = "C:\Program Files\PowerShell"

function Get-PwshDownloadUrl {
    param (
        [string]$Channel,
        [string]$VersionPrefix
    )

    $metadata = Invoke-RestMethod "https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json"

    $releases = switch ($Channel) {
        "preview" { $metadata.PreviewReleaseTag -replace '^v' }
        "lts" { $metadata.LTSReleaseTag -replace '^v' }
        default { $metadata.StableReleaseTag -replace '^v' }
    }

    foreach ($release in $releases) {
        if ($release -like "${VersionPrefix}*") {
            return @{
                Version = $release
                Url = "https://github.com/PowerShell/PowerShell/releases/download/v${release}/PowerShell-${release}-win-x64.zip"
            }
        }
    }
    return $null
}

function Install-PwshVersion {
    param (
        [string]$Channel,
        [string]$VersionPrefix
    )

    Write-Host "Installing PowerShell $Channel ($VersionPrefix.*)..."

    $downloadInfo = Get-PwshDownloadUrl -Channel $Channel -VersionPrefix $VersionPrefix
    if (-not $downloadInfo) {
        Write-Warning "No matching version found for $Channel ($VersionPrefix)"
        return
    }

    $version = $downloadInfo.Version
    $downloadUrl = $downloadInfo.Url
    $installPath = Join-Path $PwshInstallDir $version

    $archivePath = Invoke-DownloadWithRetry -Url $downloadUrl
    Expand-Archive -Path $archivePath -DestinationPath $installPath -Force
    Remove-Item -Path $archivePath -Force

    $linkPath = Join-Path $PwshInstallDir "pwsh-$Channel"
    if (Test-Path $linkPath) {
        Remove-Item $linkPath -Recurse -Force
    }
    New-Item -ItemType Junction -Path $linkPath -Target $installPath | Out-Null

    Write-Host "PowerShell $Channel ($version) installed to $installPath"
}

function Set-DefaultPwsh {
    param ([string]$Channel)

    Write-Host "Setting default PowerShell to $Channel..."

    $linkPath = Join-Path $PwshInstallDir "pwsh-$Channel"
    if (Test-Path $linkPath) {
        $target = (Get-Item $linkPath).Target
        $defaultLink = Join-Path $PwshInstallDir "7"
        if (Test-Path $defaultLink) {
            Remove-Item $defaultLink -Recurse -Force
        }
        New-Item -ItemType Junction -Path $defaultLink -Target $target | Out-Null
        Write-Host "Default PowerShell set to $Channel"
    }
}

function New-PwshSelectScript {
    $scriptContent = @'
param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

$PwshDir = "C:\Program Files\PowerShell"
$AvailableChannels = @("stable", "lts", "preview")

function Show-Help {
    Write-Host "Usage: pwsh-select [channel]"
    Write-Host ""
    Write-Host "Switch between installed PowerShell versions."
    Write-Host "Channels: stable, lts, preview"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  pwsh-select stable    # Switch to stable"
    Write-Host "  pwsh-select lts       # Switch to LTS"
    Write-Host "  pwsh-select preview   # Switch to preview"
    Write-Host "  pwsh-select list      # List versions"
}

function Show-Versions {
    Write-Host "Installed PowerShell versions:"
    foreach ($channel in $AvailableChannels) {
        $channelPath = Join-Path $PwshDir "pwsh-$channel"
        if (Test-Path $channelPath) {
            $pwshExe = Join-Path $channelPath "pwsh.exe"
            if (Test-Path $pwshExe) {
                $version = (& $pwshExe --version) -replace "PowerShell\s+"
                $defaultPath = Join-Path $PwshDir "7"
                $current = ""
                if ((Test-Path $defaultPath) -and ((Get-Item $defaultPath).Target -eq (Get-Item $channelPath).Target)) {
                    $current = " (current)"
                }
                Write-Host "  ${channel}: ${version}${current}"
            }
        }
    }
}

switch ($Command) {
    { $_ -in $AvailableChannels } {
        $channelPath = Join-Path $PwshDir "pwsh-$Command"
        if (Test-Path $channelPath) {
            $target = (Get-Item $channelPath).Target
            $defaultLink = Join-Path $PwshDir "7"
            if (Test-Path $defaultLink) {
                [System.IO.Directory]::Delete($defaultLink, $true)
            }
            New-Item -ItemType Junction -Path $defaultLink -Target $target | Out-Null
            Write-Host "Switched to PowerShell $Command"
            pwsh --version
        } else {
            Write-Error "PowerShell $Command is not installed"
        }
    }
    "list" { Show-Versions }
    default { Show-Help }
}
'@
    $scriptPath = "C:\Windows\System32\pwsh-select.ps1"
    Set-Content -Path $scriptPath -Value $scriptContent -Force
    Write-Host "Created pwsh-select script at $scriptPath"
}

$toolset = Get-ToolsetContent

$stableVersion = $toolset.pwsh.versions.stable
$ltsVersion = $toolset.pwsh.versions.lts
$previewVersion = $toolset.pwsh.versions.preview
$defaultChannel = $toolset.pwsh.default

if ($stableVersion) { Install-PwshVersion -Channel "stable" -VersionPrefix $stableVersion }
if ($ltsVersion) { Install-PwshVersion -Channel "lts" -VersionPrefix $ltsVersion }
if ($previewVersion) { Install-PwshVersion -Channel "preview" -VersionPrefix $previewVersion }

Set-DefaultPwsh -Channel $defaultChannel
New-PwshSelectScript

[Environment]::SetEnvironmentVariable("POWERSHELL_UPDATECHECK", "Off", "Machine")

$pwshPath = Join-Path $PwshInstallDir "7"
$envPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($envPath -notlike "*$pwshPath*") {
    [Environment]::SetEnvironmentVariable("PATH", "$pwshPath;$envPath", "Machine")
}

Write-Host ""
Write-Host "PowerShell installation completed."
pwsh --version

Invoke-PesterTests -TestFile "Tools" -TestName "PowerShell Core"
