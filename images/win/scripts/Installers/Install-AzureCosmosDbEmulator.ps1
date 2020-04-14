####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Import-Module -Name ImageHelpers -Force

Install-Binary -Url "https://aka.ms/cosmosdb-emulator" -Name "AzureCosmosDBEmulator.msi"
