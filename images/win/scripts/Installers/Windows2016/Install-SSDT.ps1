################################################################################
##  File:  Install-SSDT.ps1
##  Desc:  Install SQL Server Data Tools for Windows
################################################################################

Import-Module -Name ImageHelpers -Force

#SSDT for Visual Studio 2017 (15.9.3)
$InstallerURI = 'https://download.microsoft.com/download/5/2/D/52DEF429-5B17-470C-82D9-654116080B15/SSDT-Setup-ENU.exe'
$InstallerName = 'SSDT-Setup-ENU.exe'
$logFilePath = "$env:TEMP\ssdtlog.txt"
$ArgumentList = ('/install', 'INSTALLALL', '/passive', '/norestart', "/log `"$logFilePath`"")

$exitCode = Install-EXE -Url $InstallerURI -Name $InstallerName -ArgumentList $ArgumentList

if($exitCode -ne 0 -and $exitCode -ne 3010)
{
    Write-Host "******** SSDT SETUP LOG START ********"
    Write-Host $(Get-Content $logFilePath | Out-String)
    Write-Host "******** SSDT SETUP LOG END ********"
}

exit $exitCode
