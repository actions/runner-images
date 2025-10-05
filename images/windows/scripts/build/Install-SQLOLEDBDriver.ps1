################################################################################
##  File:  Install-SQLOLEDBDriver.ps1
##  Desc:  Install OLE DB Driver for SQL Server
################################################################################

# Install OLE DB Driver 18
Install-Binary -Type MSI `
    -Url "https://go.microsoft.com/fwlink/?linkid=2242656" `
    -ExtraInstallArgs @("ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES") `
    -ExpectedSubject $(Get-MicrosoftPublisher)

# Install OLE DB Driver 19
Install-Binary -Type MSI `
    -Url "https://go.microsoft.com/fwlink/?linkid=2318101" `
    -ExtraInstallArgs @("ADDLOCAL=ALL", "IACCEPTMSOLEDBSQLLICENSETERMS=YES") `
    -ExpectedSubject $(Get-MicrosoftPublisher)
