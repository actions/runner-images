$ErrorActionPreference = "Stop"

#Define user and password for PostgreSQL database
$pgUser = "postgres"
$pgPwd = "root"

#Prepare environment variable for validation
Set-SystemVariable -SystemVariable PGUSER -Value $pgUser
Set-SystemVariable -SystemVariable PGPASSWORD -Value $pgPwd

#Install latest PostgreSQL
Choco-Install -PackageName postgresql -ArgumentList "--params", "/Password:$pgPwd", "--params-global", "--debug", "--verbose"

#Get Path to pg_ctl.exe
$pgPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
#Parse output of command above to obtain pure path
$pgBin = Split-Path -Path $pgPath.split('"')[1]
#Added PostgreSQL bin path into PATH variable
Add-MachinePathItem $pgBin
