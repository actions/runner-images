$ErrorActionPreference = "Stop"

Import-Module "$env:HOME/image-generation/helpers/Common.Helpers.psm1"
Import-Module "$env:HOME/image-generation/helpers/Xcode.Installer.psm1" -DisableNameChecking

# Spaceship Apple ID login fails due to Apple ID prompting to be upgraded to 2FA.
# https://github.com/fastlane/fastlane/pull/18116
$env:SPACESHIP_SKIP_2FA_UPGRADE = 1

$ARCH = Get-Architecture
[Array]$xcodeVersions = Get-ToolsetValue "xcode.$ARCH.versions"
write-host $xcodeVersions
$defaultXcode = Get-ToolsetValue "xcode.default"
[Array]::Reverse($xcodeVersions)
$threadCount = "5"

Write-Host "Installing Xcode versions..."
$xcodeVersions | ForEach-Object -ThrottleLimit $threadCount -Parallel {
    $ErrorActionPreference = "Stop"
    Import-Module "$env:HOME/image-generation/helpers/Common.Helpers.psm1"
    Import-Module "$env:HOME/image-generation/helpers/Xcode.Installer.psm1" -DisableNameChecking

    Install-XcodeVersion -Version $_.version -LinkTo $_.link
    Confirm-XcodeIntegrity -Version $_.link
    Approve-XcodeLicense -Version $_.link
}

Write-Host "Configuring Xcode versions..."
$xcodeVersions | ForEach-Object {
    Write-Host "Configuring Xcode $($_.link) ..."
    Invoke-XcodeRunFirstLaunch -Version $_.link

    if ($_.link.Split(".")[0] -ge 14) {
        # Additional simulator runtimes are included by default for Xcode < 14
        Install-AdditionalSimulatorRuntimes -Version $_.link
    }

}

Invoke-XcodeRunFirstLaunch -Version $defaultXcode

Write-Host "Configuring Xcode symlinks..."
$xcodeVersions | ForEach-Object {
    Build-XcodeSymlinks -Version $_.link -Symlinks $_.symlinks

    # Skip creating symlink to install multiple releases of the same Xcode version side-by-side
    if ($_."skip-symlink" -ne "true") {
        Build-ProvisionatorSymlink -Version $_.link
    }
}

Write-Host "Rebuilding Launch Services database ..."
$xcodeVersions | ForEach-Object {
    Rebuild-XcodeLaunchServicesDb -Version $_.link
}

Write-Host "Setting default Xcode to $defaultXcode"
Switch-Xcode -Version $defaultXcode
New-Item -Path "/Applications/Xcode.app" -ItemType SymbolicLink -Value (Get-XcodeRootPath -Version $defaultXcode) | Out-Null

Write-Host "Setting environment variables 'XCODE_<VERSION>_DEVELOPER_DIR'"
Set-XcodeDeveloperDirEnvironmentVariables -XcodeList $xcodeVersions.link
