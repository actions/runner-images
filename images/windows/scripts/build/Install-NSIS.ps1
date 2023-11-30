################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
##  Supply chain security: NSIS - managed by package manager
################################################################################

$NsisVersion = (Get-ToolsetContent).nsis.version

Install-ChocoPackage nsis -ArgumentList "--version", "$NsisVersion"

Add-MachinePathItem "${env:ProgramFiles(x86)}\NSIS\"
Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"
