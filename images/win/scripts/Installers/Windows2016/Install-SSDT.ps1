################################################################################
##  File:  Install-SSDT.ps1
##  Desc:  Install SQL Server Data Tools for Windows
################################################################################

Import-Module -Name ImageHelpers -Force

#SSDT for Visual Studio 2017
#The link down below points to the latest version of SSDT for Visual Studio 2017
$InstallerURI = 'https://go.microsoft.com/fwlink/?linkid=2124518'
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
