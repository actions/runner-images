################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
################################################################################

# Choco-Install -PackageName nsis

Install-Binary -Url https://jztkft.dl.sourceforge.net/project/nsis/NSIS%203/3.05/nsis-3.05-setup.exe -Name nsis-3.05-setup.exe  -ArgumentList ('/S')

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"