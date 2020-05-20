################################################################################
##  File:  Install-GitHub-CLI.ps1
##  Desc:  Install GitHub CLI
################################################################################

Import-Module -Name ImageHelpers -Force

Choco-Install -PackageName gh

Add-MachinePathItem "C:\Program Files (x86)\GitHub CLI"