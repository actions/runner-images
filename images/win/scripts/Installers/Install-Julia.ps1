################################################################################
##  File:  Install-Julia.ps1
##  Desc:  Install Julia
################################################################################

Install-Choco -PackageName julia -ArgumentList "--ia","/DIR=C:\Julia"
