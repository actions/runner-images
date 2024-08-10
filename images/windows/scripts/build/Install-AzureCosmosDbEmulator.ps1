####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "D21A0476B7F3439319BE6A1060935E7C865FEFA87C47943C9A6D595137703F49"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
