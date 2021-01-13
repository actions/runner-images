################################################################################
##  File:  Install-Mingw64.ps1
##  Desc:  Install GNU tools for Windows
################################################################################

Choco-Install -PackageName mingw

Invoke-PesterTests -TestFile "Tools" -TestName "Mingw64"
