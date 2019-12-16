################################################################################
##  File:  Validate-Chrome.ps1
##  Desc:  Validate Google Chrome installation.
################################################################################

if(Test-Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe")
{
	(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
	
	$SoftwareName = "Google Chrome"
	$fileVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo.FileVersion
	$Description = @"
_version:_
$fileVersion
"@
	
	Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
	
	exit 0
}
else
{
	Write-Host "Google Chrome is not installed."
    exit 1
}
