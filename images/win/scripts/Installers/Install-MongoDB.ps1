####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetVersion = (Get-ToolsetContent).mongodb.version
$latestChocoPackage = Get-LatestChocoPackageVersion -TargetVersion $toolsetVersion -PackageName "mongodb"
Choco-Install -PackageName mongodb -ArgumentList "--version=$latestChocoPackage"

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