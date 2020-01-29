################################################################################
##  File:  Validate-Edge.ps1
##  Desc:  Validate Microsoft Edge installation.
################################################################################

if(Test-Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe")
{
	(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo

	$SoftwareName = "Microsoft Edge"
	$FileVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe').'(Default)').VersionInfo.FileVersion
	$Description = @"
_version:_
$FileVersion
"@

	Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

	exit 0
}
else
{
	Write-Host "Microsoft Edge is not installed."
	exit 1
}
