####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSignature "1226440E939A24EB202C2A517CE13F8326EFDE60"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
