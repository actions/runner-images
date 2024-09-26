####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "DB9D5E496C5FDAE17C12C03385D2BAC973DA61C280023D9FDC9A6020220BEE41"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
