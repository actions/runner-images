################################################################################
##  File:  Validate-Edge.ps1
##  Desc:  Validate Microsoft Edge installation.
################################################################################

$RegistryKey = "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
if (Test-Path $RegistryKey)
{
	$SoftwareName = "Microsoft Edge"
	$VersionInfo = (Get-Item (Get-ItemProperty $RegistryKey).'(Default)').VersionInfo
	$VersionInfo
	$Description = @"
_version:_
$($VersionInfo.FileVersion)
"@

	Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

	exit 0
}
else
{
	Write-Host "Microsoft Edge is not installed."
	exit 1
}
