################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
################################################################################

Install-Choco -PackageName nsis

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath
