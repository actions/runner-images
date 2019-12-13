################################################################################
##  File:  Validate-Firefox.ps1
##  Desc:  Validate Mozilla Firefox installation.
################################################################################

if(Test-Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe")
{
	(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo
	
	$fileVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe').'(Default)').VersionInfo.FileVersion
	$SoftwareName = "Mozilla Firefox"
	$Description = @"
_version:_
$fileVersion
"@
	
	Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
	
	exit 0
}
else
{
	Write-Host "Mozilla Firefox is not installed."
    exit 1
}
