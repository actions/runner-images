################################################################################
##  File:  Install-CloudFoundryCli.ps1
##  Desc:  Install Cloud Foundry CLI
################################################################################

# Download the latest cf cli exe
$CloudFoundryCliUrl = "https://packages.cloudfoundry.org/stable?release=windows64-exe&source=github"

$CloudFoundryArchPath = Invoke-DownloadWithRetry $CloudFoundryCliUrl

# Create directory for cf cli
$CloudFoundryCliPath = "C:\cf-cli"
New-Item -Path $CloudFoundryCliPath -ItemType Directory -Force

# Extract the zip archive
Write-Host "Extracting cf cli..."
Expand-7ZipArchive -Path $CloudFoundryArchPath -DestinationPath $CloudFoundryCliPath

# Add cf to path
Add-MachinePathItem $CloudFoundryCliPath

# Validate cf signature
$CloudFoundrySignatureThumbprint = "4C69EDD13930ED01B83DD1D17B09C434DC1F2177"
Test-FileSignature -Path "$CloudFoundryCliPath\cf.exe" -ExpectedThumbprint $CloudFoundrySignatureThumbprint

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "CloudFoundry CLI"
