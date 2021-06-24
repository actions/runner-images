################################################################################
##  File:  Install-Bicep.ps1
##  Desc:  Install Bicep
################################################################################

Choco-Install -PackageName Bicep

Invoke-PesterTests -TestFile "Tools" -TestName "Bicep"