####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "e2915c766a02d0c0703ae12b28ef992c4f62fe33e65eb482abeeaaaf0ea85237"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
