####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

Choco-Install -PackageName mongodb -ArgumentList @("--version","4.2.8")
$mongoPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'mongodb'").PathName
$mongoBin = Split-Path -Path $mongoPath.split('"')[1]
Add-MachinePathItem "$mongoBin"

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"