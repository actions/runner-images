################################################################################
##  File:  Install-swig.ps1
##  Desc:  Install swig
################################################################################

Choco-Install -PackageName swig.install

Invoke-PesterTests -TestFile "Tools" -TestName "swig"
