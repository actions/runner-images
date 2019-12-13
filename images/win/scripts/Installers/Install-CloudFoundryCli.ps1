################################################################################
##  File:  Install-CloudFoundryCli.ps1
##  Desc:  Install Cloud Foundry CLI
################################################################################

Import-Module -Name ImageHelpers

# Download the latest cf cli exe
Invoke-WebRequest -UseBasicParsing -Uri "https://packages.cloudfoundry.org/stable?release=windows64-exe&source=github" -OutFile cf-cli.zip

# Create directory for cf cli
$cf_cli_path = "C:\cf-cli"
New-Item -Path $cf_cli_path -ItemType Directory -Force

# Extract the zip archive
Write-Host "Extracting cf cli..."
Expand-Archive -Path cf-cli.zip -DestinationPath $cf_cli_path -Force

# Add cf to path
Add-MachinePathItem $cf_cli_path

# Delete the cfl-cli zip archive
Write-Host "Deleting downloaded archive of cf cli"
Remove-Item cf-cli.zip
