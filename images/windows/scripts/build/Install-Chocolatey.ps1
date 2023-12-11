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
$signatureThumbprint = "83AC7D88C66CB8680BCE802E0F0F5C179722764B"
$installScriptPath = Invoke-DownloadWithRetry 'https://chocolatey.org/install.ps1'
Test-FileSignature -Path $installScriptPath -ExpectedThumbprint $signatureThumbprint
Invoke-Expression $installScriptPath

# Turn off confirmation
choco feature enable -n allowGlobalConfirmation

# Initialize environmental variable ChocolateyToolsLocation by invoking choco Get-ToolsLocation function
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
Get-ToolsLocation
