####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "97F88D4CDE762DF334CC0D372BDC7A2A1F20E1904731ECE6C0CD1C46581D5DD0"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
