################################################################################
##  File:  Install-Mercurial.ps1
##  Desc:  Install Mercurial
################################################################################

Install-ChocoPackage hg -ArgumentList "--version", "5.0.0"

Add-MachinePathItem "${env:ProgramFiles}\Mercurial\"
Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "Mercurial"
