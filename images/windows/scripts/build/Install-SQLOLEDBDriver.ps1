################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install OLE DB Driver for SQL Server
################################################################################

Install-Binary -Type MSI `
    -Url "https://go.microsoft.com/fwlink/?linkid=2242656" `
    -ExtraInstallArgs @("ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES") `
    -ExpectedSignature '6E78B3DCE2998F6C2457C3E54DA90A01034916AE'
