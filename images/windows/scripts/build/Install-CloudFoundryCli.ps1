################################################################################
##  File:  Install-CloudFoundryCli.ps1
##  Desc:  Install Cloud Foundry CLI
################################################################################

# Download the latest cf cli exe
$cloudFoundryCliUrl = "https://packages.cloudfoundry.org/stable?release=windows64-exe&source=github"

$cloudFoundryArchPath = Invoke-DownloadWithRetry $cloudFoundryCliUrl

# Create directory for cf cli
$cloudFoundryCliPath = "C:\cf-cli"
New-Item -Path $cloudFoundryCliPath -ItemType Directory -Force

# Extract the zip archive
Write-Host "Extracting cf cli..."
Expand-7ZipArchive -Path $cloudFoundryArchPath -DestinationPath $cloudFoundryCliPath

# Add cf to path
Add-MachinePathItem $cloudFoundryCliPath

# Validate cf signature
$cloudFoundrySignatureThumbprint = "2C6B2F1562698503A6E4A25F2DF058E12E23A190"
Test-FileSignature -Path "$cloudFoundryCliPath\cf.exe" -ExpectedThumbprint $cloudFoundrySignatureThumbprint

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "CloudFoundry CLI"
