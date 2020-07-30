################################################################################
##  File:  Install-Svn.ps1
##  Desc:  Install Subversion
################################################################################

Choco-Install -PackageName svn

Invoke-PesterTests -TestFile "Tools" -TestName "Svn"
