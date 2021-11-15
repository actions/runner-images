####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

$toolsetVersion = (Get-ToolsetContent).mongodb.version
$latestChocoPackage = Get-LatestChocoPackageVersion -TargetVersion $toolsetVersion -PackageName "mongodb"
Choco-Install -PackageName mongodb -ArgumentList "--version=$latestChocoPackage"
$mongoPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'mongodb'").PathName
$mongoBin = Split-Path -Path $mongoPath.split('"')[1]
Add-MachinePathItem "$mongoBin"

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"