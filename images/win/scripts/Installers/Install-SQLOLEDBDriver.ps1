################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install SQL OLEDB Driver
################################################################################

$SQLOLEDBDriverName = "msoledbsql.msi"
$SQLOLEDBDriverUrl = "https://go.microsoft.com/fwlink/?linkid=2183083"
Install-Binary -Url $SQLOLEDBDriverUrl -Name $SQLOLEDBDriverName -ArgumentList ("ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES", "/qn")