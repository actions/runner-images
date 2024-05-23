####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "34D8E1968A868CEBBC31D1484C473FC61D3174D6C3B9AB71D4CE94F6618D7670"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
