####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "1EF64CF9CD13C611AAC394113A703AF6F525C7C39BFB6B4C3F884D57F6F1D1CF"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
