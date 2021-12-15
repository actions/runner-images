################################################################################
##  File:  Install-NSIS.ps1
##  Desc:  Install NSIS
################################################################################

$NsisVersion = (Get-ToolsetContent).nsis.version
Install-Binary -Url "https://downloads.sourceforge.net/project/nsis/NSIS%203/${NsisVersion}/nsis-${NsisVersion}-setup.exe" -Name  "nsis-${NsisVersion}-setup.exe" -ArgumentList ('/S')

$NsisPath = "${env:ProgramFiles(x86)}\NSIS\"
Add-MachinePathItem $NsisPath
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "NSIS"
