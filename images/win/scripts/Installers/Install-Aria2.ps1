################################################################################
##  File:  Install-Aria2.ps1
##  Desc:  Install Aria2
################################################################################

Choco-Install -PackageName Aria2

Invoke-PesterTests -TestFile "Tools" -TestName "Aria2"
