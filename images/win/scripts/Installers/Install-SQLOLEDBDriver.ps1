################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install SQL OLEDB Driver
################################################################################

$binaryDownloadPath = Start-DownloadWithRetry "https://go.microsoft.com/fwlink/?linkid=2238602" "msoledbsql.msi"
$ArgumentList = ("/i", "$binaryDownloadPath", "ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES", "/qn")
Install-Binary -FilePath msiexec.exe -ArgumentList $ArgumentList
