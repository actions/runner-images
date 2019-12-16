####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Import-Module -Name ImageHelpers -Force

Install-MSI -MsiUrl "https://aka.ms/cosmosdb-emulator" -MsiName "AzureCosmosDBEmulator.msi"
