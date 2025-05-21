####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "E2BEB2B242FEE3C1DD444C748C1ED1DC0120566ADC0A7BC612EB8EFB8D416089"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
