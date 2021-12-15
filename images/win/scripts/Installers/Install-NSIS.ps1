################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
################################################################################

Install-Binary -Url 'https://downloads.sourceforge.net/project/nsis/NSIS%203/3.08/nsis-3.08-setup.exe' -Name  nsis-3.08-setup.exe -ArgumentList ('/S')

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"
