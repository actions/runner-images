####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "7BAFEE9F90272C01F7924A1D8E62EE0954F555E229C7166B815253E526E666C4"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
