################################################################################
##  File:  Install-Cmake.ps1
##  Desc:  Install Cmake
################################################################################

Install-Choco -PackageName cmake.install -ArgumentList "--installargs",'ADD_CMAKE_TO_PATH=""System""'
