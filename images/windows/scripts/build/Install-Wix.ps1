################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Choco-Install -PackageName wixtoolset -ArgumentList "--force"

Invoke-PesterTests -TestFile "Wix"
