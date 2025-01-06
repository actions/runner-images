################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
##  Supply chain security: NSIS - managed by package manager
################################################################################

$nsisVersion = (Get-ToolsetContent).nsis.version

Install-ChocoPackage nsis -ArgumentList "--version", "$nsisVersion"

Add-MachinePathItem "${env:ProgramFiles(x86)}\NSIS\"
Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"
