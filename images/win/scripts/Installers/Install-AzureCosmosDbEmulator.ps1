####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

$InstallerName = "AzureCosmosDBEmulator.msi"
$InstallerUrl = "https://aka.ms/cosmosdb-emulator"
$SignatureThumbprint = "F372C27F6E052A6BE8BAB3112B465C692196CD6F"

Install-Binary -Url $InstallerUrl -Name $InstallerName -ExpectedSignature $SignatureThumbprint

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
