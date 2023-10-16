################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install SQL OLEDB Driver
################################################################################

$binaryDownloadPath = Start-DownloadWithRetry "https://go.microsoft.com/fwlink/?linkid=2242656" "msoledbsql.msi"
$binarySignatureThumbprint = "6E78B3DCE2998F6C2457C3E54DA90A01034916AE"
$ArgumentList = ("/i", "$binaryDownloadPath", "ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES", "/qn")
Install-Binary -FilePath $binaryDownloadPath -ArgumentList $ArgumentList -ExpectedSignature $binarySignatureThumbprint
