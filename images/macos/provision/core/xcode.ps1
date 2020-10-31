# The script currently requires 2 external variables to be set: XCODE_INSTALL_USER
# and XCODE_INSTALL_PASSWORD, in order to access the Apple Developer Center

$ErrorActionPreference = "Stop"

Import-Module "$PSScriptRoot/../../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../../helpers/Xcode.Installer.psm1"

if ([string]::IsNullOrEmpty($env:XCODE_INSTALL_USER) -or [string]::IsNullOrEmpty($env:XCODE_INSTALL_PASSWORD)) {
    throw "Required environment variables XCODE_INSTALL_USER and XCODE_INSTALL_PASSWORD are not set"
}

$os = Get-OSVersion
$xcodeVersions = Get-ToolsetValue "xcode.versions"
$defaultXcode = Get-ToolsetValue "xcode.default"

& xcversion update

Write-Host "Installing Xcode versions..."
foreach ($xcode in $xcodeVersions) {
    Install-XcodeVersion -Version $xcode.version -LocalLink $xcode.localLink
    Build-XcodeSymlinks -Version $xcode.localLink -Symlinks $xcode.symlinks
    Build-ProvisionatorSymlink -Version $xcode.version
}

Write-Host "Configuring Xcode versions..."
if ($os.IsLessThanCatalina) {
    Install-XcodeAdditionalPackages -Version $xcodeVersions[0].localLink
}
$xcodeVersions | ForEach-Object { Invoke-XcodeRunFirstLaunch -Version $_.localLink }
Invoke-XcodeRunFirstLaunch -Version $defaultXcode

Write-Host "Setting default Xcode to $defaultXcode"
Switch-Xcode -Version $defaultXcode
New-Item -Path "/Applications/Xcode.app" -ItemType SymbolicLink -Value (Get-XcodeRootPath -Version $defaultXcode)

Write-Host "Setting environment variables 'XCODE_<VERSION>_DEVELOPER_DIR'"
Set-XcodeDeveloperDirEnvironmentVariables