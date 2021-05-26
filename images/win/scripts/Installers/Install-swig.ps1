################################################################################
##  File:  Install-swig.ps1
##  Desc:  Install swig
################################################################################

Choco-Install -PackageName swig

Invoke-PesterTests -TestFile "Tools" -TestName "swig"
