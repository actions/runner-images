$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

#Define user and password for PostgreSQL database
$postgresusr="postgres"
$postgrespwd="root"

#Prepare environment variable for validation
Set-SystemVariable -SystemVariable PGUSER -Value $postgresusr
Set-SystemVariable -SystemVariable PGPASSWORD -Value $postgrespwd
#Install latest PostgreSQL

choco install postgresql --params '/Password:$postgrespwd'

#Get Path to pg_ctl.exe
$paths = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
#Parse output of command above to obtain pure path
$pgbin = $paths.split('"')[1].replace("\pg_ctl.exe", "")
#Added PostgreSQL bin path into PATH variable.
Add-MachinePathItem $pgbin
