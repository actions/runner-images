################################################################################
##  File:  Install-Swig.ps1
##  Desc:  Install Swig
################################################################################

Choco-Install -PackageName swig

Invoke-PesterTests -TestFile "Tools" -TestName "Swig"
