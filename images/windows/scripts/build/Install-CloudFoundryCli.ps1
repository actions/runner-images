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
$cloudFoundrySignatureThumbprint = "4C69EDD13930ED01B83DD1D17B09C434DC1F2177"
Test-FileSignature -Path "$cloudFoundryCliPath\cf.exe" -ExpectedThumbprint $cloudFoundrySignatureThumbprint

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "CloudFoundry CLI"
