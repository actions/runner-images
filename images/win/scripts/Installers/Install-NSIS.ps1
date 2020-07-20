################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
################################################################################

Choco-Install -PackageName nsis

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"