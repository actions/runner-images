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
Test-FileSignature -Path "$cloudFoundryCliPath\cf.exe" -ExpectedSubject 'CN="LF Projects, LLC", O="LF Projects, LLC", L=Wilmington, S=Delaware, C=US'

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "CloudFoundry CLI"
