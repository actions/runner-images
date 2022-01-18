################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install SQL OLEDB Driver
################################################################################

$SQLOLEDBDriverName = "msoledbsql.msi"
$binaryDownloadPath = Start-DownloadWithRetry "https://go.microsoft.com/fwlink/?linkid=2183083"
$ArgumentList = "/i $binaryDownloadPath ADDLOCAL=ALL IACCEPTMSOLEDBSQLLICENSETERMS=YES /qn"
Install-Binary -FilePath $binaryDownloadPath -ArgumentList $ArgumentList