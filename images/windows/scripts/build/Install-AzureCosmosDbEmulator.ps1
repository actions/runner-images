####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSignature "F372C27F6E052A6BE8BAB3112B465C692196CD6F"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
