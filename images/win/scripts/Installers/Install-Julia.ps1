################################################################################
##  File:  Install-Julia.ps1
##  Desc:  Install Julia
################################################################################

Choco-Install -PackageName julia -ArgumentList "--ia","/DIR=C:\Julia"
