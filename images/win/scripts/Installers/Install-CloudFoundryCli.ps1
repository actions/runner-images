################################################################################
##  File:  Install-CloudFoundryCli.ps1
##  Desc:  Install Cloud Foundry CLI
################################################################################

Import-Module -Name ImageHelpers

# Download the latest cf cli exe
$CloudFoundryCliName = "cf-cli.zip"
$CloudFoundryCliUrl = "https://packages.cloudfoundry.org/stable?release=windows64-exe&source=github"

$CloudFoundryArchPath = Start-DownloadWithRetry -Url $CloudFoundryCliUrl -Name $CloudFoundryCliName

# Create directory for cf cli
$CloudFoundryCliPath = "C:\cf-cli"
New-Item -Path $CloudFoundryCliPath -ItemType Directory -Force

# Extract the zip archive
Write-Host "Extracting cf cli..."
Expand-Archive -Path $CloudFoundryArchPath -DestinationPath $CloudFoundryCliPath -Force

# Add cf to path
Add-MachinePathItem $CloudFoundryCliPath