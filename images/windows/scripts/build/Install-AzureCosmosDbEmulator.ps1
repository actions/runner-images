####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSignature "C2048FB509F1C37A8C3E9EC6648118458AA01780"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
