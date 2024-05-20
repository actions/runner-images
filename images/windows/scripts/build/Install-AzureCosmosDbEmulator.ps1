####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://aka.ms/cosmosdb-emulator" `
    -ExpectedSHA256Sum "6312237EE3E06C730F8DCFB3D26F5202D9E713C0603039231A72DB56DD2605B4"

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
