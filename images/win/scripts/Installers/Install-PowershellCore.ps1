################################################################################
##  File:  Install-PowershellCore.ps1
##  Desc:  Install PowerShell Core
################################################################################

Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"
