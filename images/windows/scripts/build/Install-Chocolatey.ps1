################################################################################
##  File:  Install-Chocolatey.ps1
##  Desc:  Install Chocolatey package manager
################################################################################

Write-Host "Set TLS1.2"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

Write-Host "Install chocolatey"

# Add to system PATH
Add-MachinePathItem 'C:\ProgramData\Chocolatey\bin'
Update-Environment

# Verify and run choco installer
$signatureThumbprint = "B009C875F4E10FFBC62B785BAF4FC4D6BC2D5711"
$installScriptPath = Invoke-DownloadWithRetry 'https://chocolatey.org/install.ps1'
Test-FileSignature -Path $installScriptPath -ExpectedThumbprint $signatureThumbprint
Invoke-Expression $installScriptPath

# Turn off confirmation
choco feature enable -n allowGlobalConfirmation

# Initialize environmental variable ChocolateyToolsLocation by invoking choco Get-ToolsLocation function
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
Get-ToolsLocation
