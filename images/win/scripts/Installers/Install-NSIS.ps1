################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
##  Supply chain security: NSIS - managed by package manager
################################################################################

$NsisVersion = (Get-ToolsetContent).nsis.version

Choco-Install -PackageName nsis -ArgumentList "--version", "$NsisVersion"

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"
