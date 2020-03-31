$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

choco install postgresql

$paths=(Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName
$pgbin=$paths.split('"')[1].replace("\pg_ctl.exe", "")
Add-MachinePathItem $pgbin
$env:Path = Get-MachinePath