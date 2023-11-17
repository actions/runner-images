$ErrorActionPreference = "Stop"

Import-Module "$env:HOME/image-generation/helpers/Common.Helpers.psm1"
Import-Module "$env:HOME/image-generation/helpers/Xcode.Installer.psm1" -DisableNameChecking

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
}

$xcodeVersions | ForEach-Object {
    Approve-XcodeLicense -Version $_.link
}

Write-Host "Configuring Xcode versions..."
$xcodeVersions | ForEach-Object {
    Write-Host "Configuring Xcode $($_.link) ..."
    Invoke-XcodeRunFirstLaunch -Version $_.link

    if ($_.install_runtimes -eq 'true') {
        # Additional simulator runtimes are included by default for Xcode < 14
        Install-AdditionalSimulatorRuntimes -Version $_.link
    }

    ForEach($runtime in $_.runtimes) {
        Write-Host "Installing Additional runtimes for Xcode '$runtime' ..."
        $xcodebuildPath = Get-XcodeToolPath -Version $_.link -ToolName 'xcodebuild'
        Invoke-ValidateCommand "sudo $xcodebuildPath -downloadPlatform $runtime" | Out-Null
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
