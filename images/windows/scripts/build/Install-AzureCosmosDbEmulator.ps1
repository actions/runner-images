####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "BFBA892C3B9E27093A6AA36CD3C447D812CA32D6A4361DB64E753A63C90C2766"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
