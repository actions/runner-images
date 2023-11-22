################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Install-ChocoPackage wixtoolset -ArgumentList "--force"

Invoke-PesterTests -TestFile "Wix"
