####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetVersion = (Get-ToolsetContent).mongodb.version
$latestChocoPackage = Get-LatestChocoPackageVersion -TargetVersion $toolsetVersion -PackageName "mongodb"

$installDir = "c:\PROGRA~1\MongoDB"
$downloadURL = "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-$latestChocoPackage-signed.msi"
$downloadPath = "C:\temp\mongodb.msi"
Invoke-Webrequest -URI $downloadURL -OutFile ( New-Item -Path $downloadPath -Force )
cmd /c start /wait msiexec /q /i $downloadPath INSTALLLOCATION=$installDir ADDLOCAL="all"
Remove-Item $downloadPath

# Add mongodb to the PATH
$mongodbService = "mongodb"
$mongoPath = (Get-CimInstance Win32_Service -Filter "Name LIKE '$mongodbService'").PathName
$mongoBin = Split-Path -Path $mongoPath.split('"')[1]
Add-MachinePathItem "$mongoBin"

# Wait for mongodb service running
$svc = Get-Service $mongodbService
$svc.WaitForStatus('Running','00:01:00')

# Stop and disable mongodb service
Stop-Service -Name $mongodbService
Set-Service $mongodbService -StartupType Disabled

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"