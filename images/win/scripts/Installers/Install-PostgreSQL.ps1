$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

$PGUSER="postgres"
$PGPASSWORD="root"
[Environment]::SetEnvironmentVariable
     ($PGPASSWORD, $env:PGPASSWORD, [System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable
     ($PGUSER, $env:PGUSER, [System.EnvironmentVariableTarget]::Machine)
#Install latest PostgreSQL
choco install postgresql /Password $PGPASSWORD

#Get Path to pg_ctl.exe
$paths = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
#Parse output of command above to obtain pure path
$pgbin = $paths.split('"')[1].replace("\pg_ctl.exe", "")
#Added PostgreSQL bin path into PATH variable.
Add-MachinePathItem $pgbin
